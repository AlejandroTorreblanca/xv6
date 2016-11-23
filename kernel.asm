
kernel:     formato del fichero elf32-i386


Desensamblado de la sección .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

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
8010002d:	b8 09 39 10 80       	mov    $0x80103909,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 f4 85 10 80       	push   $0x801085f4
80100042:	68 60 c6 10 80       	push   $0x8010c660
80100047:	e8 6e 50 00 00       	call   801050ba <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 ac 0d 11 80 5c 	movl   $0x80110d5c,0x80110dac
80100056:	0d 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 b0 0d 11 80 5c 	movl   $0x80110d5c,0x80110db0
80100060:	0d 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
8010006a:	eb 47                	jmp    801000b3 <binit+0x7f>
    b->next = bcache.head.next;
8010006c:	8b 15 b0 0d 11 80    	mov    0x80110db0,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 50 5c 0d 11 80 	movl   $0x80110d5c,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	83 c0 0c             	add    $0xc,%eax
80100088:	83 ec 08             	sub    $0x8,%esp
8010008b:	68 fb 85 10 80       	push   $0x801085fb
80100090:	50                   	push   %eax
80100091:	e8 c6 4e 00 00       	call   80104f5c <initsleeplock>
80100096:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
80100099:	a1 b0 0d 11 80       	mov    0x80110db0,%eax
8010009e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000a1:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a7:	a3 b0 0d 11 80       	mov    %eax,0x80110db0

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ac:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b3:	b8 5c 0d 11 80       	mov    $0x80110d5c,%eax
801000b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000bb:	72 af                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	90                   	nop
801000be:	c9                   	leave  
801000bf:	c3                   	ret    

801000c0 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000c6:	83 ec 0c             	sub    $0xc,%esp
801000c9:	68 60 c6 10 80       	push   $0x8010c660
801000ce:	e8 09 50 00 00       	call   801050dc <acquire>
801000d3:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000d6:	a1 b0 0d 11 80       	mov    0x80110db0,%eax
801000db:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000de:	eb 58                	jmp    80100138 <bget+0x78>
    if(b->dev == dev && b->blockno == blockno){
801000e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e3:	8b 40 04             	mov    0x4(%eax),%eax
801000e6:	3b 45 08             	cmp    0x8(%ebp),%eax
801000e9:	75 44                	jne    8010012f <bget+0x6f>
801000eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ee:	8b 40 08             	mov    0x8(%eax),%eax
801000f1:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000f4:	75 39                	jne    8010012f <bget+0x6f>
      b->refcnt++;
801000f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f9:	8b 40 4c             	mov    0x4c(%eax),%eax
801000fc:	8d 50 01             	lea    0x1(%eax),%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 50 4c             	mov    %edx,0x4c(%eax)
      release(&bcache.lock);
80100105:	83 ec 0c             	sub    $0xc,%esp
80100108:	68 60 c6 10 80       	push   $0x8010c660
8010010d:	e8 36 50 00 00       	call   80105148 <release>
80100112:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100115:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100118:	83 c0 0c             	add    $0xc,%eax
8010011b:	83 ec 0c             	sub    $0xc,%esp
8010011e:	50                   	push   %eax
8010011f:	e8 74 4e 00 00       	call   80104f98 <acquiresleep>
80100124:	83 c4 10             	add    $0x10,%esp
      return b;
80100127:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012a:	e9 9d 00 00 00       	jmp    801001cc <bget+0x10c>
  struct buf *b;

  acquire(&bcache.lock);

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010012f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100132:	8b 40 54             	mov    0x54(%eax),%eax
80100135:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100138:	81 7d f4 5c 0d 11 80 	cmpl   $0x80110d5c,-0xc(%ebp)
8010013f:	75 9f                	jne    801000e0 <bget+0x20>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 ac 0d 11 80       	mov    0x80110dac,%eax
80100146:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100149:	eb 6b                	jmp    801001b6 <bget+0xf6>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010014b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014e:	8b 40 4c             	mov    0x4c(%eax),%eax
80100151:	85 c0                	test   %eax,%eax
80100153:	75 58                	jne    801001ad <bget+0xed>
80100155:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100158:	8b 00                	mov    (%eax),%eax
8010015a:	83 e0 04             	and    $0x4,%eax
8010015d:	85 c0                	test   %eax,%eax
8010015f:	75 4c                	jne    801001ad <bget+0xed>
      b->dev = dev;
80100161:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100164:	8b 55 08             	mov    0x8(%ebp),%edx
80100167:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010016a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016d:	8b 55 0c             	mov    0xc(%ebp),%edx
80100170:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
80100173:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100176:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
8010017c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017f:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      release(&bcache.lock);
80100186:	83 ec 0c             	sub    $0xc,%esp
80100189:	68 60 c6 10 80       	push   $0x8010c660
8010018e:	e8 b5 4f 00 00       	call   80105148 <release>
80100193:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100199:	83 c0 0c             	add    $0xc,%eax
8010019c:	83 ec 0c             	sub    $0xc,%esp
8010019f:	50                   	push   %eax
801001a0:	e8 f3 4d 00 00       	call   80104f98 <acquiresleep>
801001a5:	83 c4 10             	add    $0x10,%esp
      return b;
801001a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ab:	eb 1f                	jmp    801001cc <bget+0x10c>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801001ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b0:	8b 40 50             	mov    0x50(%eax),%eax
801001b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001b6:	81 7d f4 5c 0d 11 80 	cmpl   $0x80110d5c,-0xc(%ebp)
801001bd:	75 8c                	jne    8010014b <bget+0x8b>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001bf:	83 ec 0c             	sub    $0xc,%esp
801001c2:	68 02 86 10 80       	push   $0x80108602
801001c7:	e8 d4 03 00 00       	call   801005a0 <panic>
}
801001cc:	c9                   	leave  
801001cd:	c3                   	ret    

801001ce <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001ce:	55                   	push   %ebp
801001cf:	89 e5                	mov    %esp,%ebp
801001d1:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001d4:	83 ec 08             	sub    $0x8,%esp
801001d7:	ff 75 0c             	pushl  0xc(%ebp)
801001da:	ff 75 08             	pushl  0x8(%ebp)
801001dd:	e8 de fe ff ff       	call   801000c0 <bget>
801001e2:	83 c4 10             	add    $0x10,%esp
801001e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001eb:	8b 00                	mov    (%eax),%eax
801001ed:	83 e0 02             	and    $0x2,%eax
801001f0:	85 c0                	test   %eax,%eax
801001f2:	75 0e                	jne    80100202 <bread+0x34>
    iderw(b);
801001f4:	83 ec 0c             	sub    $0xc,%esp
801001f7:	ff 75 f4             	pushl  -0xc(%ebp)
801001fa:	e8 63 27 00 00       	call   80102962 <iderw>
801001ff:	83 c4 10             	add    $0x10,%esp
  }
  return b;
80100202:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100205:	c9                   	leave  
80100206:	c3                   	ret    

80100207 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100207:	55                   	push   %ebp
80100208:	89 e5                	mov    %esp,%ebp
8010020a:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
8010020d:	8b 45 08             	mov    0x8(%ebp),%eax
80100210:	83 c0 0c             	add    $0xc,%eax
80100213:	83 ec 0c             	sub    $0xc,%esp
80100216:	50                   	push   %eax
80100217:	e8 2f 4e 00 00       	call   8010504b <holdingsleep>
8010021c:	83 c4 10             	add    $0x10,%esp
8010021f:	85 c0                	test   %eax,%eax
80100221:	75 0d                	jne    80100230 <bwrite+0x29>
    panic("bwrite");
80100223:	83 ec 0c             	sub    $0xc,%esp
80100226:	68 13 86 10 80       	push   $0x80108613
8010022b:	e8 70 03 00 00       	call   801005a0 <panic>
  b->flags |= B_DIRTY;
80100230:	8b 45 08             	mov    0x8(%ebp),%eax
80100233:	8b 00                	mov    (%eax),%eax
80100235:	83 c8 04             	or     $0x4,%eax
80100238:	89 c2                	mov    %eax,%edx
8010023a:	8b 45 08             	mov    0x8(%ebp),%eax
8010023d:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010023f:	83 ec 0c             	sub    $0xc,%esp
80100242:	ff 75 08             	pushl  0x8(%ebp)
80100245:	e8 18 27 00 00       	call   80102962 <iderw>
8010024a:	83 c4 10             	add    $0x10,%esp
}
8010024d:	90                   	nop
8010024e:	c9                   	leave  
8010024f:	c3                   	ret    

80100250 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100250:	55                   	push   %ebp
80100251:	89 e5                	mov    %esp,%ebp
80100253:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
80100256:	8b 45 08             	mov    0x8(%ebp),%eax
80100259:	83 c0 0c             	add    $0xc,%eax
8010025c:	83 ec 0c             	sub    $0xc,%esp
8010025f:	50                   	push   %eax
80100260:	e8 e6 4d 00 00       	call   8010504b <holdingsleep>
80100265:	83 c4 10             	add    $0x10,%esp
80100268:	85 c0                	test   %eax,%eax
8010026a:	75 0d                	jne    80100279 <brelse+0x29>
    panic("brelse");
8010026c:	83 ec 0c             	sub    $0xc,%esp
8010026f:	68 1a 86 10 80       	push   $0x8010861a
80100274:	e8 27 03 00 00       	call   801005a0 <panic>

  releasesleep(&b->lock);
80100279:	8b 45 08             	mov    0x8(%ebp),%eax
8010027c:	83 c0 0c             	add    $0xc,%eax
8010027f:	83 ec 0c             	sub    $0xc,%esp
80100282:	50                   	push   %eax
80100283:	e8 75 4d 00 00       	call   80104ffd <releasesleep>
80100288:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
8010028b:	83 ec 0c             	sub    $0xc,%esp
8010028e:	68 60 c6 10 80       	push   $0x8010c660
80100293:	e8 44 4e 00 00       	call   801050dc <acquire>
80100298:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010029b:	8b 45 08             	mov    0x8(%ebp),%eax
8010029e:	8b 40 4c             	mov    0x4c(%eax),%eax
801002a1:	8d 50 ff             	lea    -0x1(%eax),%edx
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	89 50 4c             	mov    %edx,0x4c(%eax)
  if (b->refcnt == 0) {
801002aa:	8b 45 08             	mov    0x8(%ebp),%eax
801002ad:	8b 40 4c             	mov    0x4c(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 47                	jne    801002fb <brelse+0xab>
    // no one is waiting for it.
    b->next->prev = b->prev;
801002b4:	8b 45 08             	mov    0x8(%ebp),%eax
801002b7:	8b 40 54             	mov    0x54(%eax),%eax
801002ba:	8b 55 08             	mov    0x8(%ebp),%edx
801002bd:	8b 52 50             	mov    0x50(%edx),%edx
801002c0:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801002c3:	8b 45 08             	mov    0x8(%ebp),%eax
801002c6:	8b 40 50             	mov    0x50(%eax),%eax
801002c9:	8b 55 08             	mov    0x8(%ebp),%edx
801002cc:	8b 52 54             	mov    0x54(%edx),%edx
801002cf:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
801002d2:	8b 15 b0 0d 11 80    	mov    0x80110db0,%edx
801002d8:	8b 45 08             	mov    0x8(%ebp),%eax
801002db:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801002de:	8b 45 08             	mov    0x8(%ebp),%eax
801002e1:	c7 40 50 5c 0d 11 80 	movl   $0x80110d5c,0x50(%eax)
    bcache.head.next->prev = b;
801002e8:	a1 b0 0d 11 80       	mov    0x80110db0,%eax
801002ed:	8b 55 08             	mov    0x8(%ebp),%edx
801002f0:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801002f3:	8b 45 08             	mov    0x8(%ebp),%eax
801002f6:	a3 b0 0d 11 80       	mov    %eax,0x80110db0
  }
  
  release(&bcache.lock);
801002fb:	83 ec 0c             	sub    $0xc,%esp
801002fe:	68 60 c6 10 80       	push   $0x8010c660
80100303:	e8 40 4e 00 00       	call   80105148 <release>
80100308:	83 c4 10             	add    $0x10,%esp
}
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
80100347:	90                   	nop
80100348:	c9                   	leave  
80100349:	c3                   	ret    

8010034a <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
8010034a:	55                   	push   %ebp
8010034b:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010034d:	fa                   	cli    
}
8010034e:	90                   	nop
8010034f:	5d                   	pop    %ebp
80100350:	c3                   	ret    

80100351 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100351:	55                   	push   %ebp
80100352:	89 e5                	mov    %esp,%ebp
80100354:	53                   	push   %ebx
80100355:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100358:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010035c:	74 1c                	je     8010037a <printint+0x29>
8010035e:	8b 45 08             	mov    0x8(%ebp),%eax
80100361:	c1 e8 1f             	shr    $0x1f,%eax
80100364:	0f b6 c0             	movzbl %al,%eax
80100367:	89 45 10             	mov    %eax,0x10(%ebp)
8010036a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010036e:	74 0a                	je     8010037a <printint+0x29>
    x = -xx;
80100370:	8b 45 08             	mov    0x8(%ebp),%eax
80100373:	f7 d8                	neg    %eax
80100375:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100378:	eb 06                	jmp    80100380 <printint+0x2f>
  else
    x = xx;
8010037a:	8b 45 08             	mov    0x8(%ebp),%eax
8010037d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100380:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100387:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010038a:	8d 41 01             	lea    0x1(%ecx),%eax
8010038d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100390:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100393:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100396:	ba 00 00 00 00       	mov    $0x0,%edx
8010039b:	f7 f3                	div    %ebx
8010039d:	89 d0                	mov    %edx,%eax
8010039f:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
801003a6:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
801003aa:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801003ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801003b0:	ba 00 00 00 00       	mov    $0x0,%edx
801003b5:	f7 f3                	div    %ebx
801003b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801003ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801003be:	75 c7                	jne    80100387 <printint+0x36>

  if(sign)
801003c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003c4:	74 2a                	je     801003f0 <printint+0x9f>
    buf[i++] = '-';
801003c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003c9:	8d 50 01             	lea    0x1(%eax),%edx
801003cc:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003cf:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003d4:	eb 1a                	jmp    801003f0 <printint+0x9f>
    consputc(buf[i]);
801003d6:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003dc:	01 d0                	add    %edx,%eax
801003de:	0f b6 00             	movzbl (%eax),%eax
801003e1:	0f be c0             	movsbl %al,%eax
801003e4:	83 ec 0c             	sub    $0xc,%esp
801003e7:	50                   	push   %eax
801003e8:	e8 df 03 00 00       	call   801007cc <consputc>
801003ed:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003f0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003f8:	79 dc                	jns    801003d6 <printint+0x85>
    consputc(buf[i]);
}
801003fa:	90                   	nop
801003fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003fe:	c9                   	leave  
801003ff:	c3                   	ret    

80100400 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100406:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
8010040b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
8010040e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100412:	74 10                	je     80100424 <cprintf+0x24>
    acquire(&cons.lock);
80100414:	83 ec 0c             	sub    $0xc,%esp
80100417:	68 c0 b5 10 80       	push   $0x8010b5c0
8010041c:	e8 bb 4c 00 00       	call   801050dc <acquire>
80100421:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100424:	8b 45 08             	mov    0x8(%ebp),%eax
80100427:	85 c0                	test   %eax,%eax
80100429:	75 0d                	jne    80100438 <cprintf+0x38>
    panic("null fmt");
8010042b:	83 ec 0c             	sub    $0xc,%esp
8010042e:	68 21 86 10 80       	push   $0x80108621
80100433:	e8 68 01 00 00       	call   801005a0 <panic>

  argp = (uint*)(void*)(&fmt + 1);
80100438:	8d 45 0c             	lea    0xc(%ebp),%eax
8010043b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010043e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100445:	e9 1a 01 00 00       	jmp    80100564 <cprintf+0x164>
    if(c != '%'){
8010044a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010044e:	74 13                	je     80100463 <cprintf+0x63>
      consputc(c);
80100450:	83 ec 0c             	sub    $0xc,%esp
80100453:	ff 75 e4             	pushl  -0x1c(%ebp)
80100456:	e8 71 03 00 00       	call   801007cc <consputc>
8010045b:	83 c4 10             	add    $0x10,%esp
      continue;
8010045e:	e9 fd 00 00 00       	jmp    80100560 <cprintf+0x160>
    }
    c = fmt[++i] & 0xff;
80100463:	8b 55 08             	mov    0x8(%ebp),%edx
80100466:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010046a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010046d:	01 d0                	add    %edx,%eax
8010046f:	0f b6 00             	movzbl (%eax),%eax
80100472:	0f be c0             	movsbl %al,%eax
80100475:	25 ff 00 00 00       	and    $0xff,%eax
8010047a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010047d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100481:	0f 84 ff 00 00 00    	je     80100586 <cprintf+0x186>
      break;
    switch(c){
80100487:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010048a:	83 f8 70             	cmp    $0x70,%eax
8010048d:	74 47                	je     801004d6 <cprintf+0xd6>
8010048f:	83 f8 70             	cmp    $0x70,%eax
80100492:	7f 13                	jg     801004a7 <cprintf+0xa7>
80100494:	83 f8 25             	cmp    $0x25,%eax
80100497:	0f 84 98 00 00 00    	je     80100535 <cprintf+0x135>
8010049d:	83 f8 64             	cmp    $0x64,%eax
801004a0:	74 14                	je     801004b6 <cprintf+0xb6>
801004a2:	e9 9d 00 00 00       	jmp    80100544 <cprintf+0x144>
801004a7:	83 f8 73             	cmp    $0x73,%eax
801004aa:	74 47                	je     801004f3 <cprintf+0xf3>
801004ac:	83 f8 78             	cmp    $0x78,%eax
801004af:	74 25                	je     801004d6 <cprintf+0xd6>
801004b1:	e9 8e 00 00 00       	jmp    80100544 <cprintf+0x144>
    case 'd':
      printint(*argp++, 10, 1);
801004b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b9:	8d 50 04             	lea    0x4(%eax),%edx
801004bc:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004bf:	8b 00                	mov    (%eax),%eax
801004c1:	83 ec 04             	sub    $0x4,%esp
801004c4:	6a 01                	push   $0x1
801004c6:	6a 0a                	push   $0xa
801004c8:	50                   	push   %eax
801004c9:	e8 83 fe ff ff       	call   80100351 <printint>
801004ce:	83 c4 10             	add    $0x10,%esp
      break;
801004d1:	e9 8a 00 00 00       	jmp    80100560 <cprintf+0x160>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004d9:	8d 50 04             	lea    0x4(%eax),%edx
801004dc:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004df:	8b 00                	mov    (%eax),%eax
801004e1:	83 ec 04             	sub    $0x4,%esp
801004e4:	6a 00                	push   $0x0
801004e6:	6a 10                	push   $0x10
801004e8:	50                   	push   %eax
801004e9:	e8 63 fe ff ff       	call   80100351 <printint>
801004ee:	83 c4 10             	add    $0x10,%esp
      break;
801004f1:	eb 6d                	jmp    80100560 <cprintf+0x160>
    case 's':
      if((s = (char*)*argp++) == 0)
801004f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004f6:	8d 50 04             	lea    0x4(%eax),%edx
801004f9:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004fc:	8b 00                	mov    (%eax),%eax
801004fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100501:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100505:	75 22                	jne    80100529 <cprintf+0x129>
        s = "(null)";
80100507:	c7 45 ec 2a 86 10 80 	movl   $0x8010862a,-0x14(%ebp)
      for(; *s; s++)
8010050e:	eb 19                	jmp    80100529 <cprintf+0x129>
        consputc(*s);
80100510:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100513:	0f b6 00             	movzbl (%eax),%eax
80100516:	0f be c0             	movsbl %al,%eax
80100519:	83 ec 0c             	sub    $0xc,%esp
8010051c:	50                   	push   %eax
8010051d:	e8 aa 02 00 00       	call   801007cc <consputc>
80100522:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100525:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100529:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010052c:	0f b6 00             	movzbl (%eax),%eax
8010052f:	84 c0                	test   %al,%al
80100531:	75 dd                	jne    80100510 <cprintf+0x110>
        consputc(*s);
      break;
80100533:	eb 2b                	jmp    80100560 <cprintf+0x160>
    case '%':
      consputc('%');
80100535:	83 ec 0c             	sub    $0xc,%esp
80100538:	6a 25                	push   $0x25
8010053a:	e8 8d 02 00 00       	call   801007cc <consputc>
8010053f:	83 c4 10             	add    $0x10,%esp
      break;
80100542:	eb 1c                	jmp    80100560 <cprintf+0x160>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100544:	83 ec 0c             	sub    $0xc,%esp
80100547:	6a 25                	push   $0x25
80100549:	e8 7e 02 00 00       	call   801007cc <consputc>
8010054e:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100551:	83 ec 0c             	sub    $0xc,%esp
80100554:	ff 75 e4             	pushl  -0x1c(%ebp)
80100557:	e8 70 02 00 00       	call   801007cc <consputc>
8010055c:	83 c4 10             	add    $0x10,%esp
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
8010057e:	0f 85 c6 fe ff ff    	jne    8010044a <cprintf+0x4a>
80100584:	eb 01                	jmp    80100587 <cprintf+0x187>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100586:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100587:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010058b:	74 10                	je     8010059d <cprintf+0x19d>
    release(&cons.lock);
8010058d:	83 ec 0c             	sub    $0xc,%esp
80100590:	68 c0 b5 10 80       	push   $0x8010b5c0
80100595:	e8 ae 4b 00 00       	call   80105148 <release>
8010059a:	83 c4 10             	add    $0x10,%esp
}
8010059d:	90                   	nop
8010059e:	c9                   	leave  
8010059f:	c3                   	ret    

801005a0 <panic>:

void
panic(char *s)
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];

  cli();
801005a6:	e8 9f fd ff ff       	call   8010034a <cli>
  cons.locking = 0;
801005ab:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
801005b2:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801005b5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801005bb:	0f b6 00             	movzbl (%eax),%eax
801005be:	0f b6 c0             	movzbl %al,%eax
801005c1:	83 ec 08             	sub    $0x8,%esp
801005c4:	50                   	push   %eax
801005c5:	68 31 86 10 80       	push   $0x80108631
801005ca:	e8 31 fe ff ff       	call   80100400 <cprintf>
801005cf:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801005d2:	8b 45 08             	mov    0x8(%ebp),%eax
801005d5:	83 ec 0c             	sub    $0xc,%esp
801005d8:	50                   	push   %eax
801005d9:	e8 22 fe ff ff       	call   80100400 <cprintf>
801005de:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005e1:	83 ec 0c             	sub    $0xc,%esp
801005e4:	68 4d 86 10 80       	push   $0x8010864d
801005e9:	e8 12 fe ff ff       	call   80100400 <cprintf>
801005ee:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005f1:	83 ec 08             	sub    $0x8,%esp
801005f4:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005f7:	50                   	push   %eax
801005f8:	8d 45 08             	lea    0x8(%ebp),%eax
801005fb:	50                   	push   %eax
801005fc:	e8 99 4b 00 00       	call   8010519a <getcallerpcs>
80100601:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100604:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010060b:	eb 1c                	jmp    80100629 <panic+0x89>
    cprintf(" %p", pcs[i]);
8010060d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100610:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100614:	83 ec 08             	sub    $0x8,%esp
80100617:	50                   	push   %eax
80100618:	68 4f 86 10 80       	push   $0x8010864f
8010061d:	e8 de fd ff ff       	call   80100400 <cprintf>
80100622:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
80100625:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100629:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010062d:	7e de                	jle    8010060d <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
8010062f:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
80100636:	00 00 00 
  for(;;)
    ;
80100639:	eb fe                	jmp    80100639 <panic+0x99>

8010063b <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
8010063b:	55                   	push   %ebp
8010063c:	89 e5                	mov    %esp,%ebp
8010063e:	83 ec 18             	sub    $0x18,%esp
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100641:	6a 0e                	push   $0xe
80100643:	68 d4 03 00 00       	push   $0x3d4
80100648:	e8 de fc ff ff       	call   8010032b <outb>
8010064d:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100650:	68 d5 03 00 00       	push   $0x3d5
80100655:	e8 b4 fc ff ff       	call   8010030e <inb>
8010065a:	83 c4 04             	add    $0x4,%esp
8010065d:	0f b6 c0             	movzbl %al,%eax
80100660:	c1 e0 08             	shl    $0x8,%eax
80100663:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100666:	6a 0f                	push   $0xf
80100668:	68 d4 03 00 00       	push   $0x3d4
8010066d:	e8 b9 fc ff ff       	call   8010032b <outb>
80100672:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100675:	68 d5 03 00 00       	push   $0x3d5
8010067a:	e8 8f fc ff ff       	call   8010030e <inb>
8010067f:	83 c4 04             	add    $0x4,%esp
80100682:	0f b6 c0             	movzbl %al,%eax
80100685:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100688:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010068c:	75 30                	jne    801006be <cgaputc+0x83>
    pos += 80 - pos%80;
8010068e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100691:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100696:	89 c8                	mov    %ecx,%eax
80100698:	f7 ea                	imul   %edx
8010069a:	c1 fa 05             	sar    $0x5,%edx
8010069d:	89 c8                	mov    %ecx,%eax
8010069f:	c1 f8 1f             	sar    $0x1f,%eax
801006a2:	29 c2                	sub    %eax,%edx
801006a4:	89 d0                	mov    %edx,%eax
801006a6:	c1 e0 02             	shl    $0x2,%eax
801006a9:	01 d0                	add    %edx,%eax
801006ab:	c1 e0 04             	shl    $0x4,%eax
801006ae:	29 c1                	sub    %eax,%ecx
801006b0:	89 ca                	mov    %ecx,%edx
801006b2:	b8 50 00 00 00       	mov    $0x50,%eax
801006b7:	29 d0                	sub    %edx,%eax
801006b9:	01 45 f4             	add    %eax,-0xc(%ebp)
801006bc:	eb 34                	jmp    801006f2 <cgaputc+0xb7>
  else if(c == BACKSPACE){
801006be:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801006c5:	75 0c                	jne    801006d3 <cgaputc+0x98>
    if(pos > 0) --pos;
801006c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006cb:	7e 25                	jle    801006f2 <cgaputc+0xb7>
801006cd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801006d1:	eb 1f                	jmp    801006f2 <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801006d3:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
801006d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006dc:	8d 50 01             	lea    0x1(%eax),%edx
801006df:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006e2:	01 c0                	add    %eax,%eax
801006e4:	01 c8                	add    %ecx,%eax
801006e6:	8b 55 08             	mov    0x8(%ebp),%edx
801006e9:	0f b6 d2             	movzbl %dl,%edx
801006ec:	80 ce 07             	or     $0x7,%dh
801006ef:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
801006f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006f6:	78 09                	js     80100701 <cgaputc+0xc6>
801006f8:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
801006ff:	7e 0d                	jle    8010070e <cgaputc+0xd3>
    panic("pos under/overflow");
80100701:	83 ec 0c             	sub    $0xc,%esp
80100704:	68 53 86 10 80       	push   $0x80108653
80100709:	e8 92 fe ff ff       	call   801005a0 <panic>

  if((pos/80) >= 24){  // Scroll up.
8010070e:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100715:	7e 4c                	jle    80100763 <cgaputc+0x128>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100717:	a1 00 90 10 80       	mov    0x80109000,%eax
8010071c:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100722:	a1 00 90 10 80       	mov    0x80109000,%eax
80100727:	83 ec 04             	sub    $0x4,%esp
8010072a:	68 60 0e 00 00       	push   $0xe60
8010072f:	52                   	push   %edx
80100730:	50                   	push   %eax
80100731:	e8 df 4c 00 00       	call   80105415 <memmove>
80100736:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100739:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010073d:	b8 80 07 00 00       	mov    $0x780,%eax
80100742:	2b 45 f4             	sub    -0xc(%ebp),%eax
80100745:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100748:	a1 00 90 10 80       	mov    0x80109000,%eax
8010074d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100750:	01 c9                	add    %ecx,%ecx
80100752:	01 c8                	add    %ecx,%eax
80100754:	83 ec 04             	sub    $0x4,%esp
80100757:	52                   	push   %edx
80100758:	6a 00                	push   $0x0
8010075a:	50                   	push   %eax
8010075b:	e8 f6 4b 00 00       	call   80105356 <memset>
80100760:	83 c4 10             	add    $0x10,%esp
  }

  outb(CRTPORT, 14);
80100763:	83 ec 08             	sub    $0x8,%esp
80100766:	6a 0e                	push   $0xe
80100768:	68 d4 03 00 00       	push   $0x3d4
8010076d:	e8 b9 fb ff ff       	call   8010032b <outb>
80100772:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100775:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100778:	c1 f8 08             	sar    $0x8,%eax
8010077b:	0f b6 c0             	movzbl %al,%eax
8010077e:	83 ec 08             	sub    $0x8,%esp
80100781:	50                   	push   %eax
80100782:	68 d5 03 00 00       	push   $0x3d5
80100787:	e8 9f fb ff ff       	call   8010032b <outb>
8010078c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
8010078f:	83 ec 08             	sub    $0x8,%esp
80100792:	6a 0f                	push   $0xf
80100794:	68 d4 03 00 00       	push   $0x3d4
80100799:	e8 8d fb ff ff       	call   8010032b <outb>
8010079e:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
801007a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007a4:	0f b6 c0             	movzbl %al,%eax
801007a7:	83 ec 08             	sub    $0x8,%esp
801007aa:	50                   	push   %eax
801007ab:	68 d5 03 00 00       	push   $0x3d5
801007b0:	e8 76 fb ff ff       	call   8010032b <outb>
801007b5:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801007b8:	a1 00 90 10 80       	mov    0x80109000,%eax
801007bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801007c0:	01 d2                	add    %edx,%edx
801007c2:	01 d0                	add    %edx,%eax
801007c4:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801007c9:	90                   	nop
801007ca:	c9                   	leave  
801007cb:	c3                   	ret    

801007cc <consputc>:

void
consputc(int c)
{
801007cc:	55                   	push   %ebp
801007cd:	89 e5                	mov    %esp,%ebp
801007cf:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
801007d2:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
801007d7:	85 c0                	test   %eax,%eax
801007d9:	74 07                	je     801007e2 <consputc+0x16>
    cli();
801007db:	e8 6a fb ff ff       	call   8010034a <cli>
    for(;;)
      ;
801007e0:	eb fe                	jmp    801007e0 <consputc+0x14>
  }

  if(c == BACKSPACE){
801007e2:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007e9:	75 29                	jne    80100814 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007eb:	83 ec 0c             	sub    $0xc,%esp
801007ee:	6a 08                	push   $0x8
801007f0:	e8 cb 64 00 00       	call   80106cc0 <uartputc>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	83 ec 0c             	sub    $0xc,%esp
801007fb:	6a 20                	push   $0x20
801007fd:	e8 be 64 00 00       	call   80106cc0 <uartputc>
80100802:	83 c4 10             	add    $0x10,%esp
80100805:	83 ec 0c             	sub    $0xc,%esp
80100808:	6a 08                	push   $0x8
8010080a:	e8 b1 64 00 00       	call   80106cc0 <uartputc>
8010080f:	83 c4 10             	add    $0x10,%esp
80100812:	eb 0e                	jmp    80100822 <consputc+0x56>
  } else
    uartputc(c);
80100814:	83 ec 0c             	sub    $0xc,%esp
80100817:	ff 75 08             	pushl  0x8(%ebp)
8010081a:	e8 a1 64 00 00       	call   80106cc0 <uartputc>
8010081f:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
80100822:	83 ec 0c             	sub    $0xc,%esp
80100825:	ff 75 08             	pushl  0x8(%ebp)
80100828:	e8 0e fe ff ff       	call   8010063b <cgaputc>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	90                   	nop
80100831:	c9                   	leave  
80100832:	c3                   	ret    

80100833 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100833:	55                   	push   %ebp
80100834:	89 e5                	mov    %esp,%ebp
80100836:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
80100839:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
80100840:	83 ec 0c             	sub    $0xc,%esp
80100843:	68 c0 b5 10 80       	push   $0x8010b5c0
80100848:	e8 8f 48 00 00       	call   801050dc <acquire>
8010084d:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
80100850:	e9 44 01 00 00       	jmp    80100999 <consoleintr+0x166>
    switch(c){
80100855:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100858:	83 f8 10             	cmp    $0x10,%eax
8010085b:	74 1e                	je     8010087b <consoleintr+0x48>
8010085d:	83 f8 10             	cmp    $0x10,%eax
80100860:	7f 0a                	jg     8010086c <consoleintr+0x39>
80100862:	83 f8 08             	cmp    $0x8,%eax
80100865:	74 6b                	je     801008d2 <consoleintr+0x9f>
80100867:	e9 9b 00 00 00       	jmp    80100907 <consoleintr+0xd4>
8010086c:	83 f8 15             	cmp    $0x15,%eax
8010086f:	74 33                	je     801008a4 <consoleintr+0x71>
80100871:	83 f8 7f             	cmp    $0x7f,%eax
80100874:	74 5c                	je     801008d2 <consoleintr+0x9f>
80100876:	e9 8c 00 00 00       	jmp    80100907 <consoleintr+0xd4>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
8010087b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
80100882:	e9 12 01 00 00       	jmp    80100999 <consoleintr+0x166>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100887:	a1 48 10 11 80       	mov    0x80111048,%eax
8010088c:	83 e8 01             	sub    $0x1,%eax
8010088f:	a3 48 10 11 80       	mov    %eax,0x80111048
        consputc(BACKSPACE);
80100894:	83 ec 0c             	sub    $0xc,%esp
80100897:	68 00 01 00 00       	push   $0x100
8010089c:	e8 2b ff ff ff       	call   801007cc <consputc>
801008a1:	83 c4 10             	add    $0x10,%esp
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008a4:	8b 15 48 10 11 80    	mov    0x80111048,%edx
801008aa:	a1 44 10 11 80       	mov    0x80111044,%eax
801008af:	39 c2                	cmp    %eax,%edx
801008b1:	0f 84 e2 00 00 00    	je     80100999 <consoleintr+0x166>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008b7:	a1 48 10 11 80       	mov    0x80111048,%eax
801008bc:	83 e8 01             	sub    $0x1,%eax
801008bf:	83 e0 7f             	and    $0x7f,%eax
801008c2:	0f b6 80 c0 0f 11 80 	movzbl -0x7feef040(%eax),%eax
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008c9:	3c 0a                	cmp    $0xa,%al
801008cb:	75 ba                	jne    80100887 <consoleintr+0x54>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
801008cd:	e9 c7 00 00 00       	jmp    80100999 <consoleintr+0x166>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008d2:	8b 15 48 10 11 80    	mov    0x80111048,%edx
801008d8:	a1 44 10 11 80       	mov    0x80111044,%eax
801008dd:	39 c2                	cmp    %eax,%edx
801008df:	0f 84 b4 00 00 00    	je     80100999 <consoleintr+0x166>
        input.e--;
801008e5:	a1 48 10 11 80       	mov    0x80111048,%eax
801008ea:	83 e8 01             	sub    $0x1,%eax
801008ed:	a3 48 10 11 80       	mov    %eax,0x80111048
        consputc(BACKSPACE);
801008f2:	83 ec 0c             	sub    $0xc,%esp
801008f5:	68 00 01 00 00       	push   $0x100
801008fa:	e8 cd fe ff ff       	call   801007cc <consputc>
801008ff:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100902:	e9 92 00 00 00       	jmp    80100999 <consoleintr+0x166>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100907:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010090b:	0f 84 87 00 00 00    	je     80100998 <consoleintr+0x165>
80100911:	8b 15 48 10 11 80    	mov    0x80111048,%edx
80100917:	a1 40 10 11 80       	mov    0x80111040,%eax
8010091c:	29 c2                	sub    %eax,%edx
8010091e:	89 d0                	mov    %edx,%eax
80100920:	83 f8 7f             	cmp    $0x7f,%eax
80100923:	77 73                	ja     80100998 <consoleintr+0x165>
        c = (c == '\r') ? '\n' : c;
80100925:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80100929:	74 05                	je     80100930 <consoleintr+0xfd>
8010092b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010092e:	eb 05                	jmp    80100935 <consoleintr+0x102>
80100930:	b8 0a 00 00 00       	mov    $0xa,%eax
80100935:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100938:	a1 48 10 11 80       	mov    0x80111048,%eax
8010093d:	8d 50 01             	lea    0x1(%eax),%edx
80100940:	89 15 48 10 11 80    	mov    %edx,0x80111048
80100946:	83 e0 7f             	and    $0x7f,%eax
80100949:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010094c:	88 90 c0 0f 11 80    	mov    %dl,-0x7feef040(%eax)
        consputc(c);
80100952:	83 ec 0c             	sub    $0xc,%esp
80100955:	ff 75 f0             	pushl  -0x10(%ebp)
80100958:	e8 6f fe ff ff       	call   801007cc <consputc>
8010095d:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100960:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100964:	74 18                	je     8010097e <consoleintr+0x14b>
80100966:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
8010096a:	74 12                	je     8010097e <consoleintr+0x14b>
8010096c:	a1 48 10 11 80       	mov    0x80111048,%eax
80100971:	8b 15 40 10 11 80    	mov    0x80111040,%edx
80100977:	83 ea 80             	sub    $0xffffff80,%edx
8010097a:	39 d0                	cmp    %edx,%eax
8010097c:	75 1a                	jne    80100998 <consoleintr+0x165>
          input.w = input.e;
8010097e:	a1 48 10 11 80       	mov    0x80111048,%eax
80100983:	a3 44 10 11 80       	mov    %eax,0x80111044
          wakeup(&input.r);
80100988:	83 ec 0c             	sub    $0xc,%esp
8010098b:	68 40 10 11 80       	push   $0x80111040
80100990:	e8 13 44 00 00       	call   80104da8 <wakeup>
80100995:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100998:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100999:	8b 45 08             	mov    0x8(%ebp),%eax
8010099c:	ff d0                	call   *%eax
8010099e:	89 45 f0             	mov    %eax,-0x10(%ebp)
801009a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801009a5:	0f 89 aa fe ff ff    	jns    80100855 <consoleintr+0x22>
        }
      }
      break;
    }
  }
  release(&cons.lock);
801009ab:	83 ec 0c             	sub    $0xc,%esp
801009ae:	68 c0 b5 10 80       	push   $0x8010b5c0
801009b3:	e8 90 47 00 00       	call   80105148 <release>
801009b8:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
801009bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801009bf:	74 05                	je     801009c6 <consoleintr+0x193>
    procdump();  // now call procdump() wo. cons.lock held
801009c1:	e8 9d 44 00 00       	call   80104e63 <procdump>
  }
}
801009c6:	90                   	nop
801009c7:	c9                   	leave  
801009c8:	c3                   	ret    

801009c9 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
801009c9:	55                   	push   %ebp
801009ca:	89 e5                	mov    %esp,%ebp
801009cc:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
801009cf:	83 ec 0c             	sub    $0xc,%esp
801009d2:	ff 75 08             	pushl  0x8(%ebp)
801009d5:	e8 66 11 00 00       	call   80101b40 <iunlock>
801009da:	83 c4 10             	add    $0x10,%esp
  target = n;
801009dd:	8b 45 10             	mov    0x10(%ebp),%eax
801009e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
801009e3:	83 ec 0c             	sub    $0xc,%esp
801009e6:	68 c0 b5 10 80       	push   $0x8010b5c0
801009eb:	e8 ec 46 00 00       	call   801050dc <acquire>
801009f0:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
801009f3:	e9 ac 00 00 00       	jmp    80100aa4 <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
801009f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009fe:	8b 40 24             	mov    0x24(%eax),%eax
80100a01:	85 c0                	test   %eax,%eax
80100a03:	74 28                	je     80100a2d <consoleread+0x64>
        release(&cons.lock);
80100a05:	83 ec 0c             	sub    $0xc,%esp
80100a08:	68 c0 b5 10 80       	push   $0x8010b5c0
80100a0d:	e8 36 47 00 00       	call   80105148 <release>
80100a12:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100a15:	83 ec 0c             	sub    $0xc,%esp
80100a18:	ff 75 08             	pushl  0x8(%ebp)
80100a1b:	e8 03 10 00 00       	call   80101a23 <ilock>
80100a20:	83 c4 10             	add    $0x10,%esp
        return -1;
80100a23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a28:	e9 ab 00 00 00       	jmp    80100ad8 <consoleread+0x10f>
      }
      sleep(&input.r, &cons.lock);
80100a2d:	83 ec 08             	sub    $0x8,%esp
80100a30:	68 c0 b5 10 80       	push   $0x8010b5c0
80100a35:	68 40 10 11 80       	push   $0x80111040
80100a3a:	e8 7e 42 00 00       	call   80104cbd <sleep>
80100a3f:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100a42:	8b 15 40 10 11 80    	mov    0x80111040,%edx
80100a48:	a1 44 10 11 80       	mov    0x80111044,%eax
80100a4d:	39 c2                	cmp    %eax,%edx
80100a4f:	74 a7                	je     801009f8 <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a51:	a1 40 10 11 80       	mov    0x80111040,%eax
80100a56:	8d 50 01             	lea    0x1(%eax),%edx
80100a59:	89 15 40 10 11 80    	mov    %edx,0x80111040
80100a5f:	83 e0 7f             	and    $0x7f,%eax
80100a62:	0f b6 80 c0 0f 11 80 	movzbl -0x7feef040(%eax),%eax
80100a69:	0f be c0             	movsbl %al,%eax
80100a6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a6f:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a73:	75 17                	jne    80100a8c <consoleread+0xc3>
      if(n < target){
80100a75:	8b 45 10             	mov    0x10(%ebp),%eax
80100a78:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a7b:	73 2f                	jae    80100aac <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a7d:	a1 40 10 11 80       	mov    0x80111040,%eax
80100a82:	83 e8 01             	sub    $0x1,%eax
80100a85:	a3 40 10 11 80       	mov    %eax,0x80111040
      }
      break;
80100a8a:	eb 20                	jmp    80100aac <consoleread+0xe3>
    }
    *dst++ = c;
80100a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a8f:	8d 50 01             	lea    0x1(%eax),%edx
80100a92:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a95:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a98:	88 10                	mov    %dl,(%eax)
    --n;
80100a9a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a9e:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100aa2:	74 0b                	je     80100aaf <consoleread+0xe6>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100aa4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100aa8:	7f 98                	jg     80100a42 <consoleread+0x79>
80100aaa:	eb 04                	jmp    80100ab0 <consoleread+0xe7>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100aac:	90                   	nop
80100aad:	eb 01                	jmp    80100ab0 <consoleread+0xe7>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100aaf:	90                   	nop
  }
  release(&cons.lock);
80100ab0:	83 ec 0c             	sub    $0xc,%esp
80100ab3:	68 c0 b5 10 80       	push   $0x8010b5c0
80100ab8:	e8 8b 46 00 00       	call   80105148 <release>
80100abd:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	ff 75 08             	pushl  0x8(%ebp)
80100ac6:	e8 58 0f 00 00       	call   80101a23 <ilock>
80100acb:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100ace:	8b 45 10             	mov    0x10(%ebp),%eax
80100ad1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100ad4:	29 c2                	sub    %eax,%edx
80100ad6:	89 d0                	mov    %edx,%eax
}
80100ad8:	c9                   	leave  
80100ad9:	c3                   	ret    

80100ada <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100ada:	55                   	push   %ebp
80100adb:	89 e5                	mov    %esp,%ebp
80100add:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100ae0:	83 ec 0c             	sub    $0xc,%esp
80100ae3:	ff 75 08             	pushl  0x8(%ebp)
80100ae6:	e8 55 10 00 00       	call   80101b40 <iunlock>
80100aeb:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100aee:	83 ec 0c             	sub    $0xc,%esp
80100af1:	68 c0 b5 10 80       	push   $0x8010b5c0
80100af6:	e8 e1 45 00 00       	call   801050dc <acquire>
80100afb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100afe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100b05:	eb 21                	jmp    80100b28 <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100b07:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b0d:	01 d0                	add    %edx,%eax
80100b0f:	0f b6 00             	movzbl (%eax),%eax
80100b12:	0f be c0             	movsbl %al,%eax
80100b15:	0f b6 c0             	movzbl %al,%eax
80100b18:	83 ec 0c             	sub    $0xc,%esp
80100b1b:	50                   	push   %eax
80100b1c:	e8 ab fc ff ff       	call   801007cc <consputc>
80100b21:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100b24:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b2b:	3b 45 10             	cmp    0x10(%ebp),%eax
80100b2e:	7c d7                	jl     80100b07 <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100b30:	83 ec 0c             	sub    $0xc,%esp
80100b33:	68 c0 b5 10 80       	push   $0x8010b5c0
80100b38:	e8 0b 46 00 00       	call   80105148 <release>
80100b3d:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b40:	83 ec 0c             	sub    $0xc,%esp
80100b43:	ff 75 08             	pushl  0x8(%ebp)
80100b46:	e8 d8 0e 00 00       	call   80101a23 <ilock>
80100b4b:	83 c4 10             	add    $0x10,%esp

  return n;
80100b4e:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100b51:	c9                   	leave  
80100b52:	c3                   	ret    

80100b53 <consoleinit>:

void
consoleinit(void)
{
80100b53:	55                   	push   %ebp
80100b54:	89 e5                	mov    %esp,%ebp
80100b56:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100b59:	83 ec 08             	sub    $0x8,%esp
80100b5c:	68 66 86 10 80       	push   $0x80108666
80100b61:	68 c0 b5 10 80       	push   $0x8010b5c0
80100b66:	e8 4f 45 00 00       	call   801050ba <initlock>
80100b6b:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b6e:	c7 05 0c 1a 11 80 da 	movl   $0x80100ada,0x80111a0c
80100b75:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b78:	c7 05 08 1a 11 80 c9 	movl   $0x801009c9,0x80111a08
80100b7f:	09 10 80 
  cons.locking = 1;
80100b82:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100b89:	00 00 00 

  picenable(IRQ_KBD);
80100b8c:	83 ec 0c             	sub    $0xc,%esp
80100b8f:	6a 01                	push   $0x1
80100b91:	e8 2f 33 00 00       	call   80103ec5 <picenable>
80100b96:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b99:	83 ec 08             	sub    $0x8,%esp
80100b9c:	6a 00                	push   $0x0
80100b9e:	6a 01                	push   $0x1
80100ba0:	e8 94 1f 00 00       	call   80102b39 <ioapicenable>
80100ba5:	83 c4 10             	add    $0x10,%esp
}
80100ba8:	90                   	nop
80100ba9:	c9                   	leave  
80100baa:	c3                   	ret    

80100bab <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bab:	55                   	push   %ebp
80100bac:	89 e5                	mov    %esp,%ebp
80100bae:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100bb4:	e8 28 2a 00 00       	call   801035e1 <begin_op>

  if((ip = namei(path)) == 0){
80100bb9:	83 ec 0c             	sub    $0xc,%esp
80100bbc:	ff 75 08             	pushl  0x8(%ebp)
80100bbf:	e8 85 19 00 00       	call   80102549 <namei>
80100bc4:	83 c4 10             	add    $0x10,%esp
80100bc7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100bca:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100bce:	75 0f                	jne    80100bdf <exec+0x34>
    end_op();
80100bd0:	e8 98 2a 00 00       	call   8010366d <end_op>
    return -1;
80100bd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bda:	e9 07 04 00 00       	jmp    80100fe6 <exec+0x43b>
  }
  ilock(ip);
80100bdf:	83 ec 0c             	sub    $0xc,%esp
80100be2:	ff 75 d8             	pushl  -0x28(%ebp)
80100be5:	e8 39 0e 00 00       	call   80101a23 <ilock>
80100bea:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100bed:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100bf4:	6a 34                	push   $0x34
80100bf6:	6a 00                	push   $0x0
80100bf8:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100bfe:	50                   	push   %eax
80100bff:	ff 75 d8             	pushl  -0x28(%ebp)
80100c02:	e8 f2 12 00 00       	call   80101ef9 <readi>
80100c07:	83 c4 10             	add    $0x10,%esp
80100c0a:	83 f8 33             	cmp    $0x33,%eax
80100c0d:	0f 86 7c 03 00 00    	jbe    80100f8f <exec+0x3e4>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c13:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c19:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100c1e:	0f 85 6e 03 00 00    	jne    80100f92 <exec+0x3e7>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c24:	e8 c8 71 00 00       	call   80107df1 <setupkvm>
80100c29:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100c2c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100c30:	0f 84 5f 03 00 00    	je     80100f95 <exec+0x3ea>
    goto bad;

  // Load program into memory.
  sz = 0;
80100c36:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c3d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c44:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100c4a:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c4d:	e9 de 00 00 00       	jmp    80100d30 <exec+0x185>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c52:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c55:	6a 20                	push   $0x20
80100c57:	50                   	push   %eax
80100c58:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100c5e:	50                   	push   %eax
80100c5f:	ff 75 d8             	pushl  -0x28(%ebp)
80100c62:	e8 92 12 00 00       	call   80101ef9 <readi>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	83 f8 20             	cmp    $0x20,%eax
80100c6d:	0f 85 25 03 00 00    	jne    80100f98 <exec+0x3ed>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c73:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c79:	83 f8 01             	cmp    $0x1,%eax
80100c7c:	0f 85 a0 00 00 00    	jne    80100d22 <exec+0x177>
      continue;
    if(ph.memsz < ph.filesz)
80100c82:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c88:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c8e:	39 c2                	cmp    %eax,%edx
80100c90:	0f 82 05 03 00 00    	jb     80100f9b <exec+0x3f0>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c96:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c9c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100ca2:	01 c2                	add    %eax,%edx
80100ca4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100caa:	39 c2                	cmp    %eax,%edx
80100cac:	0f 82 ec 02 00 00    	jb     80100f9e <exec+0x3f3>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100cb2:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100cb8:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100cbe:	01 d0                	add    %edx,%eax
80100cc0:	83 ec 04             	sub    $0x4,%esp
80100cc3:	50                   	push   %eax
80100cc4:	ff 75 e0             	pushl  -0x20(%ebp)
80100cc7:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cca:	e8 93 74 00 00       	call   80108162 <allocuvm>
80100ccf:	83 c4 10             	add    $0x10,%esp
80100cd2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cd5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cd9:	0f 84 c2 02 00 00    	je     80100fa1 <exec+0x3f6>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100cdf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100ce5:	25 ff 0f 00 00       	and    $0xfff,%eax
80100cea:	85 c0                	test   %eax,%eax
80100cec:	0f 85 b2 02 00 00    	jne    80100fa4 <exec+0x3f9>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cf2:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100cf8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100cfe:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100d04:	83 ec 0c             	sub    $0xc,%esp
80100d07:	52                   	push   %edx
80100d08:	50                   	push   %eax
80100d09:	ff 75 d8             	pushl  -0x28(%ebp)
80100d0c:	51                   	push   %ecx
80100d0d:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d10:	e8 80 73 00 00       	call   80108095 <loaduvm>
80100d15:	83 c4 20             	add    $0x20,%esp
80100d18:	85 c0                	test   %eax,%eax
80100d1a:	0f 88 87 02 00 00    	js     80100fa7 <exec+0x3fc>
80100d20:	eb 01                	jmp    80100d23 <exec+0x178>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100d22:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d23:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100d27:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d2a:	83 c0 20             	add    $0x20,%eax
80100d2d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100d30:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100d37:	0f b7 c0             	movzwl %ax,%eax
80100d3a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100d3d:	0f 8f 0f ff ff ff    	jg     80100c52 <exec+0xa7>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100d43:	83 ec 0c             	sub    $0xc,%esp
80100d46:	ff 75 d8             	pushl  -0x28(%ebp)
80100d49:	e8 eb 0e 00 00       	call   80101c39 <iunlockput>
80100d4e:	83 c4 10             	add    $0x10,%esp
  end_op();
80100d51:	e8 17 29 00 00       	call   8010366d <end_op>
  ip = 0;
80100d56:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d60:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d65:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d6a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d70:	05 00 20 00 00       	add    $0x2000,%eax
80100d75:	83 ec 04             	sub    $0x4,%esp
80100d78:	50                   	push   %eax
80100d79:	ff 75 e0             	pushl  -0x20(%ebp)
80100d7c:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d7f:	e8 de 73 00 00       	call   80108162 <allocuvm>
80100d84:	83 c4 10             	add    $0x10,%esp
80100d87:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d8a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d8e:	0f 84 16 02 00 00    	je     80100faa <exec+0x3ff>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d97:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d9c:	83 ec 08             	sub    $0x8,%esp
80100d9f:	50                   	push   %eax
80100da0:	ff 75 d4             	pushl  -0x2c(%ebp)
80100da3:	e8 0c 76 00 00       	call   801083b4 <clearpteu>
80100da8:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100dab:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dae:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100db1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100db8:	e9 96 00 00 00       	jmp    80100e53 <exec+0x2a8>
    if(argc >= MAXARG)
80100dbd:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100dc1:	0f 87 e6 01 00 00    	ja     80100fad <exec+0x402>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100dc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dd4:	01 d0                	add    %edx,%eax
80100dd6:	8b 00                	mov    (%eax),%eax
80100dd8:	83 ec 0c             	sub    $0xc,%esp
80100ddb:	50                   	push   %eax
80100ddc:	e8 c2 47 00 00       	call   801055a3 <strlen>
80100de1:	83 c4 10             	add    $0x10,%esp
80100de4:	89 c2                	mov    %eax,%edx
80100de6:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100de9:	29 d0                	sub    %edx,%eax
80100deb:	83 e8 01             	sub    $0x1,%eax
80100dee:	83 e0 fc             	and    $0xfffffffc,%eax
80100df1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100df4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dfe:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e01:	01 d0                	add    %edx,%eax
80100e03:	8b 00                	mov    (%eax),%eax
80100e05:	83 ec 0c             	sub    $0xc,%esp
80100e08:	50                   	push   %eax
80100e09:	e8 95 47 00 00       	call   801055a3 <strlen>
80100e0e:	83 c4 10             	add    $0x10,%esp
80100e11:	83 c0 01             	add    $0x1,%eax
80100e14:	89 c1                	mov    %eax,%ecx
80100e16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e19:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e20:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e23:	01 d0                	add    %edx,%eax
80100e25:	8b 00                	mov    (%eax),%eax
80100e27:	51                   	push   %ecx
80100e28:	50                   	push   %eax
80100e29:	ff 75 dc             	pushl  -0x24(%ebp)
80100e2c:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e2f:	e8 1f 77 00 00       	call   80108553 <copyout>
80100e34:	83 c4 10             	add    $0x10,%esp
80100e37:	85 c0                	test   %eax,%eax
80100e39:	0f 88 71 01 00 00    	js     80100fb0 <exec+0x405>
      goto bad;
    ustack[3+argc] = sp;
80100e3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e42:	8d 50 03             	lea    0x3(%eax),%edx
80100e45:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e48:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e4f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100e53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e56:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e60:	01 d0                	add    %edx,%eax
80100e62:	8b 00                	mov    (%eax),%eax
80100e64:	85 c0                	test   %eax,%eax
80100e66:	0f 85 51 ff ff ff    	jne    80100dbd <exec+0x212>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100e6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e6f:	83 c0 03             	add    $0x3,%eax
80100e72:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100e79:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100e7d:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100e84:	ff ff ff 
  ustack[1] = argc;
80100e87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e8a:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e90:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e93:	83 c0 01             	add    $0x1,%eax
80100e96:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e9d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ea0:	29 d0                	sub    %edx,%eax
80100ea2:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100ea8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eab:	83 c0 04             	add    $0x4,%eax
80100eae:	c1 e0 02             	shl    $0x2,%eax
80100eb1:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100eb4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eb7:	83 c0 04             	add    $0x4,%eax
80100eba:	c1 e0 02             	shl    $0x2,%eax
80100ebd:	50                   	push   %eax
80100ebe:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100ec4:	50                   	push   %eax
80100ec5:	ff 75 dc             	pushl  -0x24(%ebp)
80100ec8:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ecb:	e8 83 76 00 00       	call   80108553 <copyout>
80100ed0:	83 c4 10             	add    $0x10,%esp
80100ed3:	85 c0                	test   %eax,%eax
80100ed5:	0f 88 d8 00 00 00    	js     80100fb3 <exec+0x408>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100edb:	8b 45 08             	mov    0x8(%ebp),%eax
80100ede:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100ee1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ee4:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100ee7:	eb 17                	jmp    80100f00 <exec+0x355>
    if(*s == '/')
80100ee9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eec:	0f b6 00             	movzbl (%eax),%eax
80100eef:	3c 2f                	cmp    $0x2f,%al
80100ef1:	75 09                	jne    80100efc <exec+0x351>
      last = s+1;
80100ef3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ef6:	83 c0 01             	add    $0x1,%eax
80100ef9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100efc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100f00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f03:	0f b6 00             	movzbl (%eax),%eax
80100f06:	84 c0                	test   %al,%al
80100f08:	75 df                	jne    80100ee9 <exec+0x33e>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100f0a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f10:	83 c0 6c             	add    $0x6c,%eax
80100f13:	83 ec 04             	sub    $0x4,%esp
80100f16:	6a 10                	push   $0x10
80100f18:	ff 75 f0             	pushl  -0x10(%ebp)
80100f1b:	50                   	push   %eax
80100f1c:	e8 38 46 00 00       	call   80105559 <safestrcpy>
80100f21:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100f24:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f2a:	8b 40 04             	mov    0x4(%eax),%eax
80100f2d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100f30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f36:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100f39:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100f3c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f42:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f45:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100f47:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f4d:	8b 40 18             	mov    0x18(%eax),%eax
80100f50:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100f56:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100f59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f5f:	8b 40 18             	mov    0x18(%eax),%eax
80100f62:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f65:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100f68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f6e:	83 ec 0c             	sub    $0xc,%esp
80100f71:	50                   	push   %eax
80100f72:	e8 36 6f 00 00       	call   80107ead <switchuvm>
80100f77:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f7a:	83 ec 0c             	sub    $0xc,%esp
80100f7d:	ff 75 d0             	pushl  -0x30(%ebp)
80100f80:	e8 96 73 00 00       	call   8010831b <freevm>
80100f85:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f88:	b8 00 00 00 00       	mov    $0x0,%eax
80100f8d:	eb 57                	jmp    80100fe6 <exec+0x43b>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100f8f:	90                   	nop
80100f90:	eb 22                	jmp    80100fb4 <exec+0x409>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100f92:	90                   	nop
80100f93:	eb 1f                	jmp    80100fb4 <exec+0x409>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100f95:	90                   	nop
80100f96:	eb 1c                	jmp    80100fb4 <exec+0x409>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100f98:	90                   	nop
80100f99:	eb 19                	jmp    80100fb4 <exec+0x409>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100f9b:	90                   	nop
80100f9c:	eb 16                	jmp    80100fb4 <exec+0x409>
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
80100f9e:	90                   	nop
80100f9f:	eb 13                	jmp    80100fb4 <exec+0x409>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100fa1:	90                   	nop
80100fa2:	eb 10                	jmp    80100fb4 <exec+0x409>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
80100fa4:	90                   	nop
80100fa5:	eb 0d                	jmp    80100fb4 <exec+0x409>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100fa7:	90                   	nop
80100fa8:	eb 0a                	jmp    80100fb4 <exec+0x409>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100faa:	90                   	nop
80100fab:	eb 07                	jmp    80100fb4 <exec+0x409>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100fad:	90                   	nop
80100fae:	eb 04                	jmp    80100fb4 <exec+0x409>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100fb0:	90                   	nop
80100fb1:	eb 01                	jmp    80100fb4 <exec+0x409>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100fb3:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100fb4:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100fb8:	74 0e                	je     80100fc8 <exec+0x41d>
    freevm(pgdir);
80100fba:	83 ec 0c             	sub    $0xc,%esp
80100fbd:	ff 75 d4             	pushl  -0x2c(%ebp)
80100fc0:	e8 56 73 00 00       	call   8010831b <freevm>
80100fc5:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100fc8:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100fcc:	74 13                	je     80100fe1 <exec+0x436>
    iunlockput(ip);
80100fce:	83 ec 0c             	sub    $0xc,%esp
80100fd1:	ff 75 d8             	pushl  -0x28(%ebp)
80100fd4:	e8 60 0c 00 00       	call   80101c39 <iunlockput>
80100fd9:	83 c4 10             	add    $0x10,%esp
    end_op();
80100fdc:	e8 8c 26 00 00       	call   8010366d <end_op>
  }
  return -1;
80100fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fe6:	c9                   	leave  
80100fe7:	c3                   	ret    

80100fe8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100fe8:	55                   	push   %ebp
80100fe9:	89 e5                	mov    %esp,%ebp
80100feb:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100fee:	83 ec 08             	sub    $0x8,%esp
80100ff1:	68 6e 86 10 80       	push   $0x8010866e
80100ff6:	68 60 10 11 80       	push   $0x80111060
80100ffb:	e8 ba 40 00 00       	call   801050ba <initlock>
80101000:	83 c4 10             	add    $0x10,%esp
}
80101003:	90                   	nop
80101004:	c9                   	leave  
80101005:	c3                   	ret    

80101006 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101006:	55                   	push   %ebp
80101007:	89 e5                	mov    %esp,%ebp
80101009:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
8010100c:	83 ec 0c             	sub    $0xc,%esp
8010100f:	68 60 10 11 80       	push   $0x80111060
80101014:	e8 c3 40 00 00       	call   801050dc <acquire>
80101019:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
8010101c:	c7 45 f4 94 10 11 80 	movl   $0x80111094,-0xc(%ebp)
80101023:	eb 2d                	jmp    80101052 <filealloc+0x4c>
    if(f->ref == 0){
80101025:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101028:	8b 40 04             	mov    0x4(%eax),%eax
8010102b:	85 c0                	test   %eax,%eax
8010102d:	75 1f                	jne    8010104e <filealloc+0x48>
      f->ref = 1;
8010102f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101032:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80101039:	83 ec 0c             	sub    $0xc,%esp
8010103c:	68 60 10 11 80       	push   $0x80111060
80101041:	e8 02 41 00 00       	call   80105148 <release>
80101046:	83 c4 10             	add    $0x10,%esp
      return f;
80101049:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010104c:	eb 23                	jmp    80101071 <filealloc+0x6b>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
8010104e:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101052:	b8 f4 19 11 80       	mov    $0x801119f4,%eax
80101057:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010105a:	72 c9                	jb     80101025 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
8010105c:	83 ec 0c             	sub    $0xc,%esp
8010105f:	68 60 10 11 80       	push   $0x80111060
80101064:	e8 df 40 00 00       	call   80105148 <release>
80101069:	83 c4 10             	add    $0x10,%esp
  return 0;
8010106c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101071:	c9                   	leave  
80101072:	c3                   	ret    

80101073 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101073:	55                   	push   %ebp
80101074:	89 e5                	mov    %esp,%ebp
80101076:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101079:	83 ec 0c             	sub    $0xc,%esp
8010107c:	68 60 10 11 80       	push   $0x80111060
80101081:	e8 56 40 00 00       	call   801050dc <acquire>
80101086:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101089:	8b 45 08             	mov    0x8(%ebp),%eax
8010108c:	8b 40 04             	mov    0x4(%eax),%eax
8010108f:	85 c0                	test   %eax,%eax
80101091:	7f 0d                	jg     801010a0 <filedup+0x2d>
    panic("filedup");
80101093:	83 ec 0c             	sub    $0xc,%esp
80101096:	68 75 86 10 80       	push   $0x80108675
8010109b:	e8 00 f5 ff ff       	call   801005a0 <panic>
  f->ref++;
801010a0:	8b 45 08             	mov    0x8(%ebp),%eax
801010a3:	8b 40 04             	mov    0x4(%eax),%eax
801010a6:	8d 50 01             	lea    0x1(%eax),%edx
801010a9:	8b 45 08             	mov    0x8(%ebp),%eax
801010ac:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801010af:	83 ec 0c             	sub    $0xc,%esp
801010b2:	68 60 10 11 80       	push   $0x80111060
801010b7:	e8 8c 40 00 00       	call   80105148 <release>
801010bc:	83 c4 10             	add    $0x10,%esp
  return f;
801010bf:	8b 45 08             	mov    0x8(%ebp),%eax
}
801010c2:	c9                   	leave  
801010c3:	c3                   	ret    

801010c4 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801010c4:	55                   	push   %ebp
801010c5:	89 e5                	mov    %esp,%ebp
801010c7:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
801010ca:	83 ec 0c             	sub    $0xc,%esp
801010cd:	68 60 10 11 80       	push   $0x80111060
801010d2:	e8 05 40 00 00       	call   801050dc <acquire>
801010d7:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010da:	8b 45 08             	mov    0x8(%ebp),%eax
801010dd:	8b 40 04             	mov    0x4(%eax),%eax
801010e0:	85 c0                	test   %eax,%eax
801010e2:	7f 0d                	jg     801010f1 <fileclose+0x2d>
    panic("fileclose");
801010e4:	83 ec 0c             	sub    $0xc,%esp
801010e7:	68 7d 86 10 80       	push   $0x8010867d
801010ec:	e8 af f4 ff ff       	call   801005a0 <panic>
  if(--f->ref > 0){
801010f1:	8b 45 08             	mov    0x8(%ebp),%eax
801010f4:	8b 40 04             	mov    0x4(%eax),%eax
801010f7:	8d 50 ff             	lea    -0x1(%eax),%edx
801010fa:	8b 45 08             	mov    0x8(%ebp),%eax
801010fd:	89 50 04             	mov    %edx,0x4(%eax)
80101100:	8b 45 08             	mov    0x8(%ebp),%eax
80101103:	8b 40 04             	mov    0x4(%eax),%eax
80101106:	85 c0                	test   %eax,%eax
80101108:	7e 15                	jle    8010111f <fileclose+0x5b>
    release(&ftable.lock);
8010110a:	83 ec 0c             	sub    $0xc,%esp
8010110d:	68 60 10 11 80       	push   $0x80111060
80101112:	e8 31 40 00 00       	call   80105148 <release>
80101117:	83 c4 10             	add    $0x10,%esp
8010111a:	e9 8b 00 00 00       	jmp    801011aa <fileclose+0xe6>
    return;
  }
  ff = *f;
8010111f:	8b 45 08             	mov    0x8(%ebp),%eax
80101122:	8b 10                	mov    (%eax),%edx
80101124:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101127:	8b 50 04             	mov    0x4(%eax),%edx
8010112a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010112d:	8b 50 08             	mov    0x8(%eax),%edx
80101130:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101133:	8b 50 0c             	mov    0xc(%eax),%edx
80101136:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101139:	8b 50 10             	mov    0x10(%eax),%edx
8010113c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010113f:	8b 40 14             	mov    0x14(%eax),%eax
80101142:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101145:	8b 45 08             	mov    0x8(%ebp),%eax
80101148:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010114f:	8b 45 08             	mov    0x8(%ebp),%eax
80101152:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101158:	83 ec 0c             	sub    $0xc,%esp
8010115b:	68 60 10 11 80       	push   $0x80111060
80101160:	e8 e3 3f 00 00       	call   80105148 <release>
80101165:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
80101168:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010116b:	83 f8 01             	cmp    $0x1,%eax
8010116e:	75 19                	jne    80101189 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
80101170:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101174:	0f be d0             	movsbl %al,%edx
80101177:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010117a:	83 ec 08             	sub    $0x8,%esp
8010117d:	52                   	push   %edx
8010117e:	50                   	push   %eax
8010117f:	e8 aa 2f 00 00       	call   8010412e <pipeclose>
80101184:	83 c4 10             	add    $0x10,%esp
80101187:	eb 21                	jmp    801011aa <fileclose+0xe6>
  else if(ff.type == FD_INODE){
80101189:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010118c:	83 f8 02             	cmp    $0x2,%eax
8010118f:	75 19                	jne    801011aa <fileclose+0xe6>
    begin_op();
80101191:	e8 4b 24 00 00       	call   801035e1 <begin_op>
    iput(ff.ip);
80101196:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101199:	83 ec 0c             	sub    $0xc,%esp
8010119c:	50                   	push   %eax
8010119d:	e8 ec 09 00 00       	call   80101b8e <iput>
801011a2:	83 c4 10             	add    $0x10,%esp
    end_op();
801011a5:	e8 c3 24 00 00       	call   8010366d <end_op>
  }
}
801011aa:	c9                   	leave  
801011ab:	c3                   	ret    

801011ac <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801011ac:	55                   	push   %ebp
801011ad:	89 e5                	mov    %esp,%ebp
801011af:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
801011b2:	8b 45 08             	mov    0x8(%ebp),%eax
801011b5:	8b 00                	mov    (%eax),%eax
801011b7:	83 f8 02             	cmp    $0x2,%eax
801011ba:	75 40                	jne    801011fc <filestat+0x50>
    ilock(f->ip);
801011bc:	8b 45 08             	mov    0x8(%ebp),%eax
801011bf:	8b 40 10             	mov    0x10(%eax),%eax
801011c2:	83 ec 0c             	sub    $0xc,%esp
801011c5:	50                   	push   %eax
801011c6:	e8 58 08 00 00       	call   80101a23 <ilock>
801011cb:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801011ce:	8b 45 08             	mov    0x8(%ebp),%eax
801011d1:	8b 40 10             	mov    0x10(%eax),%eax
801011d4:	83 ec 08             	sub    $0x8,%esp
801011d7:	ff 75 0c             	pushl  0xc(%ebp)
801011da:	50                   	push   %eax
801011db:	e8 d3 0c 00 00       	call   80101eb3 <stati>
801011e0:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
801011e3:	8b 45 08             	mov    0x8(%ebp),%eax
801011e6:	8b 40 10             	mov    0x10(%eax),%eax
801011e9:	83 ec 0c             	sub    $0xc,%esp
801011ec:	50                   	push   %eax
801011ed:	e8 4e 09 00 00       	call   80101b40 <iunlock>
801011f2:	83 c4 10             	add    $0x10,%esp
    return 0;
801011f5:	b8 00 00 00 00       	mov    $0x0,%eax
801011fa:	eb 05                	jmp    80101201 <filestat+0x55>
  }
  return -1;
801011fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101201:	c9                   	leave  
80101202:	c3                   	ret    

80101203 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101203:	55                   	push   %ebp
80101204:	89 e5                	mov    %esp,%ebp
80101206:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101209:	8b 45 08             	mov    0x8(%ebp),%eax
8010120c:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101210:	84 c0                	test   %al,%al
80101212:	75 0a                	jne    8010121e <fileread+0x1b>
    return -1;
80101214:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101219:	e9 9b 00 00 00       	jmp    801012b9 <fileread+0xb6>
  if(f->type == FD_PIPE)
8010121e:	8b 45 08             	mov    0x8(%ebp),%eax
80101221:	8b 00                	mov    (%eax),%eax
80101223:	83 f8 01             	cmp    $0x1,%eax
80101226:	75 1a                	jne    80101242 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101228:	8b 45 08             	mov    0x8(%ebp),%eax
8010122b:	8b 40 0c             	mov    0xc(%eax),%eax
8010122e:	83 ec 04             	sub    $0x4,%esp
80101231:	ff 75 10             	pushl  0x10(%ebp)
80101234:	ff 75 0c             	pushl  0xc(%ebp)
80101237:	50                   	push   %eax
80101238:	e8 99 30 00 00       	call   801042d6 <piperead>
8010123d:	83 c4 10             	add    $0x10,%esp
80101240:	eb 77                	jmp    801012b9 <fileread+0xb6>
  if(f->type == FD_INODE){
80101242:	8b 45 08             	mov    0x8(%ebp),%eax
80101245:	8b 00                	mov    (%eax),%eax
80101247:	83 f8 02             	cmp    $0x2,%eax
8010124a:	75 60                	jne    801012ac <fileread+0xa9>
    ilock(f->ip);
8010124c:	8b 45 08             	mov    0x8(%ebp),%eax
8010124f:	8b 40 10             	mov    0x10(%eax),%eax
80101252:	83 ec 0c             	sub    $0xc,%esp
80101255:	50                   	push   %eax
80101256:	e8 c8 07 00 00       	call   80101a23 <ilock>
8010125b:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010125e:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101261:	8b 45 08             	mov    0x8(%ebp),%eax
80101264:	8b 50 14             	mov    0x14(%eax),%edx
80101267:	8b 45 08             	mov    0x8(%ebp),%eax
8010126a:	8b 40 10             	mov    0x10(%eax),%eax
8010126d:	51                   	push   %ecx
8010126e:	52                   	push   %edx
8010126f:	ff 75 0c             	pushl  0xc(%ebp)
80101272:	50                   	push   %eax
80101273:	e8 81 0c 00 00       	call   80101ef9 <readi>
80101278:	83 c4 10             	add    $0x10,%esp
8010127b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010127e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101282:	7e 11                	jle    80101295 <fileread+0x92>
      f->off += r;
80101284:	8b 45 08             	mov    0x8(%ebp),%eax
80101287:	8b 50 14             	mov    0x14(%eax),%edx
8010128a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010128d:	01 c2                	add    %eax,%edx
8010128f:	8b 45 08             	mov    0x8(%ebp),%eax
80101292:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
80101295:	8b 45 08             	mov    0x8(%ebp),%eax
80101298:	8b 40 10             	mov    0x10(%eax),%eax
8010129b:	83 ec 0c             	sub    $0xc,%esp
8010129e:	50                   	push   %eax
8010129f:	e8 9c 08 00 00       	call   80101b40 <iunlock>
801012a4:	83 c4 10             	add    $0x10,%esp
    return r;
801012a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012aa:	eb 0d                	jmp    801012b9 <fileread+0xb6>
  }
  panic("fileread");
801012ac:	83 ec 0c             	sub    $0xc,%esp
801012af:	68 87 86 10 80       	push   $0x80108687
801012b4:	e8 e7 f2 ff ff       	call   801005a0 <panic>
}
801012b9:	c9                   	leave  
801012ba:	c3                   	ret    

801012bb <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801012bb:	55                   	push   %ebp
801012bc:	89 e5                	mov    %esp,%ebp
801012be:	53                   	push   %ebx
801012bf:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
801012c2:	8b 45 08             	mov    0x8(%ebp),%eax
801012c5:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801012c9:	84 c0                	test   %al,%al
801012cb:	75 0a                	jne    801012d7 <filewrite+0x1c>
    return -1;
801012cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012d2:	e9 1b 01 00 00       	jmp    801013f2 <filewrite+0x137>
  if(f->type == FD_PIPE)
801012d7:	8b 45 08             	mov    0x8(%ebp),%eax
801012da:	8b 00                	mov    (%eax),%eax
801012dc:	83 f8 01             	cmp    $0x1,%eax
801012df:	75 1d                	jne    801012fe <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
801012e1:	8b 45 08             	mov    0x8(%ebp),%eax
801012e4:	8b 40 0c             	mov    0xc(%eax),%eax
801012e7:	83 ec 04             	sub    $0x4,%esp
801012ea:	ff 75 10             	pushl  0x10(%ebp)
801012ed:	ff 75 0c             	pushl  0xc(%ebp)
801012f0:	50                   	push   %eax
801012f1:	e8 e2 2e 00 00       	call   801041d8 <pipewrite>
801012f6:	83 c4 10             	add    $0x10,%esp
801012f9:	e9 f4 00 00 00       	jmp    801013f2 <filewrite+0x137>
  if(f->type == FD_INODE){
801012fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101301:	8b 00                	mov    (%eax),%eax
80101303:	83 f8 02             	cmp    $0x2,%eax
80101306:	0f 85 d9 00 00 00    	jne    801013e5 <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010130c:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
80101313:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010131a:	e9 a3 00 00 00       	jmp    801013c2 <filewrite+0x107>
      int n1 = n - i;
8010131f:	8b 45 10             	mov    0x10(%ebp),%eax
80101322:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101325:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101328:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010132b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010132e:	7e 06                	jle    80101336 <filewrite+0x7b>
        n1 = max;
80101330:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101333:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
80101336:	e8 a6 22 00 00       	call   801035e1 <begin_op>
      ilock(f->ip);
8010133b:	8b 45 08             	mov    0x8(%ebp),%eax
8010133e:	8b 40 10             	mov    0x10(%eax),%eax
80101341:	83 ec 0c             	sub    $0xc,%esp
80101344:	50                   	push   %eax
80101345:	e8 d9 06 00 00       	call   80101a23 <ilock>
8010134a:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010134d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101350:	8b 45 08             	mov    0x8(%ebp),%eax
80101353:	8b 50 14             	mov    0x14(%eax),%edx
80101356:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101359:	8b 45 0c             	mov    0xc(%ebp),%eax
8010135c:	01 c3                	add    %eax,%ebx
8010135e:	8b 45 08             	mov    0x8(%ebp),%eax
80101361:	8b 40 10             	mov    0x10(%eax),%eax
80101364:	51                   	push   %ecx
80101365:	52                   	push   %edx
80101366:	53                   	push   %ebx
80101367:	50                   	push   %eax
80101368:	e8 e3 0c 00 00       	call   80102050 <writei>
8010136d:	83 c4 10             	add    $0x10,%esp
80101370:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101373:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101377:	7e 11                	jle    8010138a <filewrite+0xcf>
        f->off += r;
80101379:	8b 45 08             	mov    0x8(%ebp),%eax
8010137c:	8b 50 14             	mov    0x14(%eax),%edx
8010137f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101382:	01 c2                	add    %eax,%edx
80101384:	8b 45 08             	mov    0x8(%ebp),%eax
80101387:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
8010138a:	8b 45 08             	mov    0x8(%ebp),%eax
8010138d:	8b 40 10             	mov    0x10(%eax),%eax
80101390:	83 ec 0c             	sub    $0xc,%esp
80101393:	50                   	push   %eax
80101394:	e8 a7 07 00 00       	call   80101b40 <iunlock>
80101399:	83 c4 10             	add    $0x10,%esp
      end_op();
8010139c:	e8 cc 22 00 00       	call   8010366d <end_op>

      if(r < 0)
801013a1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801013a5:	78 29                	js     801013d0 <filewrite+0x115>
        break;
      if(r != n1)
801013a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801013ad:	74 0d                	je     801013bc <filewrite+0x101>
        panic("short filewrite");
801013af:	83 ec 0c             	sub    $0xc,%esp
801013b2:	68 90 86 10 80       	push   $0x80108690
801013b7:	e8 e4 f1 ff ff       	call   801005a0 <panic>
      i += r;
801013bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013bf:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801013c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013c5:	3b 45 10             	cmp    0x10(%ebp),%eax
801013c8:	0f 8c 51 ff ff ff    	jl     8010131f <filewrite+0x64>
801013ce:	eb 01                	jmp    801013d1 <filewrite+0x116>
        f->off += r;
      iunlock(f->ip);
      end_op();

      if(r < 0)
        break;
801013d0:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801013d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013d4:	3b 45 10             	cmp    0x10(%ebp),%eax
801013d7:	75 05                	jne    801013de <filewrite+0x123>
801013d9:	8b 45 10             	mov    0x10(%ebp),%eax
801013dc:	eb 14                	jmp    801013f2 <filewrite+0x137>
801013de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013e3:	eb 0d                	jmp    801013f2 <filewrite+0x137>
  }
  panic("filewrite");
801013e5:	83 ec 0c             	sub    $0xc,%esp
801013e8:	68 a0 86 10 80       	push   $0x801086a0
801013ed:	e8 ae f1 ff ff       	call   801005a0 <panic>
}
801013f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801013f5:	c9                   	leave  
801013f6:	c3                   	ret    

801013f7 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013f7:	55                   	push   %ebp
801013f8:	89 e5                	mov    %esp,%ebp
801013fa:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
801013fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101400:	83 ec 08             	sub    $0x8,%esp
80101403:	6a 01                	push   $0x1
80101405:	50                   	push   %eax
80101406:	e8 c3 ed ff ff       	call   801001ce <bread>
8010140b:	83 c4 10             	add    $0x10,%esp
8010140e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101411:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101414:	83 c0 5c             	add    $0x5c,%eax
80101417:	83 ec 04             	sub    $0x4,%esp
8010141a:	6a 1c                	push   $0x1c
8010141c:	50                   	push   %eax
8010141d:	ff 75 0c             	pushl  0xc(%ebp)
80101420:	e8 f0 3f 00 00       	call   80105415 <memmove>
80101425:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101428:	83 ec 0c             	sub    $0xc,%esp
8010142b:	ff 75 f4             	pushl  -0xc(%ebp)
8010142e:	e8 1d ee ff ff       	call   80100250 <brelse>
80101433:	83 c4 10             	add    $0x10,%esp
}
80101436:	90                   	nop
80101437:	c9                   	leave  
80101438:	c3                   	ret    

80101439 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101439:	55                   	push   %ebp
8010143a:	89 e5                	mov    %esp,%ebp
8010143c:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
8010143f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101442:	8b 45 08             	mov    0x8(%ebp),%eax
80101445:	83 ec 08             	sub    $0x8,%esp
80101448:	52                   	push   %edx
80101449:	50                   	push   %eax
8010144a:	e8 7f ed ff ff       	call   801001ce <bread>
8010144f:	83 c4 10             	add    $0x10,%esp
80101452:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101455:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101458:	83 c0 5c             	add    $0x5c,%eax
8010145b:	83 ec 04             	sub    $0x4,%esp
8010145e:	68 00 02 00 00       	push   $0x200
80101463:	6a 00                	push   $0x0
80101465:	50                   	push   %eax
80101466:	e8 eb 3e 00 00       	call   80105356 <memset>
8010146b:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
8010146e:	83 ec 0c             	sub    $0xc,%esp
80101471:	ff 75 f4             	pushl  -0xc(%ebp)
80101474:	e8 a0 23 00 00       	call   80103819 <log_write>
80101479:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010147c:	83 ec 0c             	sub    $0xc,%esp
8010147f:	ff 75 f4             	pushl  -0xc(%ebp)
80101482:	e8 c9 ed ff ff       	call   80100250 <brelse>
80101487:	83 c4 10             	add    $0x10,%esp
}
8010148a:	90                   	nop
8010148b:	c9                   	leave  
8010148c:	c3                   	ret    

8010148d <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010148d:	55                   	push   %ebp
8010148e:	89 e5                	mov    %esp,%ebp
80101490:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
80101493:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010149a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801014a1:	e9 13 01 00 00       	jmp    801015b9 <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
801014a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014a9:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801014af:	85 c0                	test   %eax,%eax
801014b1:	0f 48 c2             	cmovs  %edx,%eax
801014b4:	c1 f8 0c             	sar    $0xc,%eax
801014b7:	89 c2                	mov    %eax,%edx
801014b9:	a1 78 1a 11 80       	mov    0x80111a78,%eax
801014be:	01 d0                	add    %edx,%eax
801014c0:	83 ec 08             	sub    $0x8,%esp
801014c3:	50                   	push   %eax
801014c4:	ff 75 08             	pushl  0x8(%ebp)
801014c7:	e8 02 ed ff ff       	call   801001ce <bread>
801014cc:	83 c4 10             	add    $0x10,%esp
801014cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014d2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801014d9:	e9 a6 00 00 00       	jmp    80101584 <balloc+0xf7>
      m = 1 << (bi % 8);
801014de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014e1:	99                   	cltd   
801014e2:	c1 ea 1d             	shr    $0x1d,%edx
801014e5:	01 d0                	add    %edx,%eax
801014e7:	83 e0 07             	and    $0x7,%eax
801014ea:	29 d0                	sub    %edx,%eax
801014ec:	ba 01 00 00 00       	mov    $0x1,%edx
801014f1:	89 c1                	mov    %eax,%ecx
801014f3:	d3 e2                	shl    %cl,%edx
801014f5:	89 d0                	mov    %edx,%eax
801014f7:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fd:	8d 50 07             	lea    0x7(%eax),%edx
80101500:	85 c0                	test   %eax,%eax
80101502:	0f 48 c2             	cmovs  %edx,%eax
80101505:	c1 f8 03             	sar    $0x3,%eax
80101508:	89 c2                	mov    %eax,%edx
8010150a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010150d:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101512:	0f b6 c0             	movzbl %al,%eax
80101515:	23 45 e8             	and    -0x18(%ebp),%eax
80101518:	85 c0                	test   %eax,%eax
8010151a:	75 64                	jne    80101580 <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
8010151c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010151f:	8d 50 07             	lea    0x7(%eax),%edx
80101522:	85 c0                	test   %eax,%eax
80101524:	0f 48 c2             	cmovs  %edx,%eax
80101527:	c1 f8 03             	sar    $0x3,%eax
8010152a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010152d:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
80101532:	89 d1                	mov    %edx,%ecx
80101534:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101537:	09 ca                	or     %ecx,%edx
80101539:	89 d1                	mov    %edx,%ecx
8010153b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010153e:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
80101542:	83 ec 0c             	sub    $0xc,%esp
80101545:	ff 75 ec             	pushl  -0x14(%ebp)
80101548:	e8 cc 22 00 00       	call   80103819 <log_write>
8010154d:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
80101553:	ff 75 ec             	pushl  -0x14(%ebp)
80101556:	e8 f5 ec ff ff       	call   80100250 <brelse>
8010155b:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
8010155e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101561:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101564:	01 c2                	add    %eax,%edx
80101566:	8b 45 08             	mov    0x8(%ebp),%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	52                   	push   %edx
8010156d:	50                   	push   %eax
8010156e:	e8 c6 fe ff ff       	call   80101439 <bzero>
80101573:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101576:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101579:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010157c:	01 d0                	add    %edx,%eax
8010157e:	eb 57                	jmp    801015d7 <balloc+0x14a>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101580:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101584:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010158b:	7f 17                	jg     801015a4 <balloc+0x117>
8010158d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101590:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101593:	01 d0                	add    %edx,%eax
80101595:	89 c2                	mov    %eax,%edx
80101597:	a1 60 1a 11 80       	mov    0x80111a60,%eax
8010159c:	39 c2                	cmp    %eax,%edx
8010159e:	0f 82 3a ff ff ff    	jb     801014de <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801015a4:	83 ec 0c             	sub    $0xc,%esp
801015a7:	ff 75 ec             	pushl  -0x14(%ebp)
801015aa:	e8 a1 ec ff ff       	call   80100250 <brelse>
801015af:	83 c4 10             	add    $0x10,%esp
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801015b2:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801015b9:	8b 15 60 1a 11 80    	mov    0x80111a60,%edx
801015bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015c2:	39 c2                	cmp    %eax,%edx
801015c4:	0f 87 dc fe ff ff    	ja     801014a6 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801015ca:	83 ec 0c             	sub    $0xc,%esp
801015cd:	68 ac 86 10 80       	push   $0x801086ac
801015d2:	e8 c9 ef ff ff       	call   801005a0 <panic>
}
801015d7:	c9                   	leave  
801015d8:	c3                   	ret    

801015d9 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015d9:	55                   	push   %ebp
801015da:	89 e5                	mov    %esp,%ebp
801015dc:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015df:	83 ec 08             	sub    $0x8,%esp
801015e2:	68 60 1a 11 80       	push   $0x80111a60
801015e7:	ff 75 08             	pushl  0x8(%ebp)
801015ea:	e8 08 fe ff ff       	call   801013f7 <readsb>
801015ef:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801015f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801015f5:	c1 e8 0c             	shr    $0xc,%eax
801015f8:	89 c2                	mov    %eax,%edx
801015fa:	a1 78 1a 11 80       	mov    0x80111a78,%eax
801015ff:	01 c2                	add    %eax,%edx
80101601:	8b 45 08             	mov    0x8(%ebp),%eax
80101604:	83 ec 08             	sub    $0x8,%esp
80101607:	52                   	push   %edx
80101608:	50                   	push   %eax
80101609:	e8 c0 eb ff ff       	call   801001ce <bread>
8010160e:	83 c4 10             	add    $0x10,%esp
80101611:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101614:	8b 45 0c             	mov    0xc(%ebp),%eax
80101617:	25 ff 0f 00 00       	and    $0xfff,%eax
8010161c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010161f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101622:	99                   	cltd   
80101623:	c1 ea 1d             	shr    $0x1d,%edx
80101626:	01 d0                	add    %edx,%eax
80101628:	83 e0 07             	and    $0x7,%eax
8010162b:	29 d0                	sub    %edx,%eax
8010162d:	ba 01 00 00 00       	mov    $0x1,%edx
80101632:	89 c1                	mov    %eax,%ecx
80101634:	d3 e2                	shl    %cl,%edx
80101636:	89 d0                	mov    %edx,%eax
80101638:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010163b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010163e:	8d 50 07             	lea    0x7(%eax),%edx
80101641:	85 c0                	test   %eax,%eax
80101643:	0f 48 c2             	cmovs  %edx,%eax
80101646:	c1 f8 03             	sar    $0x3,%eax
80101649:	89 c2                	mov    %eax,%edx
8010164b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010164e:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101653:	0f b6 c0             	movzbl %al,%eax
80101656:	23 45 ec             	and    -0x14(%ebp),%eax
80101659:	85 c0                	test   %eax,%eax
8010165b:	75 0d                	jne    8010166a <bfree+0x91>
    panic("freeing free block");
8010165d:	83 ec 0c             	sub    $0xc,%esp
80101660:	68 c2 86 10 80       	push   $0x801086c2
80101665:	e8 36 ef ff ff       	call   801005a0 <panic>
  bp->data[bi/8] &= ~m;
8010166a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010166d:	8d 50 07             	lea    0x7(%eax),%edx
80101670:	85 c0                	test   %eax,%eax
80101672:	0f 48 c2             	cmovs  %edx,%eax
80101675:	c1 f8 03             	sar    $0x3,%eax
80101678:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010167b:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
80101680:	89 d1                	mov    %edx,%ecx
80101682:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101685:	f7 d2                	not    %edx
80101687:	21 ca                	and    %ecx,%edx
80101689:	89 d1                	mov    %edx,%ecx
8010168b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010168e:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
80101692:	83 ec 0c             	sub    $0xc,%esp
80101695:	ff 75 f4             	pushl  -0xc(%ebp)
80101698:	e8 7c 21 00 00       	call   80103819 <log_write>
8010169d:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801016a0:	83 ec 0c             	sub    $0xc,%esp
801016a3:	ff 75 f4             	pushl  -0xc(%ebp)
801016a6:	e8 a5 eb ff ff       	call   80100250 <brelse>
801016ab:	83 c4 10             	add    $0x10,%esp
}
801016ae:	90                   	nop
801016af:	c9                   	leave  
801016b0:	c3                   	ret    

801016b1 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801016b1:	55                   	push   %ebp
801016b2:	89 e5                	mov    %esp,%ebp
801016b4:	57                   	push   %edi
801016b5:	56                   	push   %esi
801016b6:	53                   	push   %ebx
801016b7:	83 ec 2c             	sub    $0x2c,%esp
  int i = 0;
801016ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
801016c1:	83 ec 08             	sub    $0x8,%esp
801016c4:	68 d5 86 10 80       	push   $0x801086d5
801016c9:	68 80 1a 11 80       	push   $0x80111a80
801016ce:	e8 e7 39 00 00       	call   801050ba <initlock>
801016d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
801016d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801016dd:	eb 2d                	jmp    8010170c <iinit+0x5b>
    initsleeplock(&icache.inode[i].lock, "inode");
801016df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016e2:	89 d0                	mov    %edx,%eax
801016e4:	c1 e0 03             	shl    $0x3,%eax
801016e7:	01 d0                	add    %edx,%eax
801016e9:	c1 e0 04             	shl    $0x4,%eax
801016ec:	83 c0 30             	add    $0x30,%eax
801016ef:	05 80 1a 11 80       	add    $0x80111a80,%eax
801016f4:	83 c0 10             	add    $0x10,%eax
801016f7:	83 ec 08             	sub    $0x8,%esp
801016fa:	68 dc 86 10 80       	push   $0x801086dc
801016ff:	50                   	push   %eax
80101700:	e8 57 38 00 00       	call   80104f5c <initsleeplock>
80101705:	83 c4 10             	add    $0x10,%esp
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101708:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010170c:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101710:	7e cd                	jle    801016df <iinit+0x2e>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
80101712:	83 ec 08             	sub    $0x8,%esp
80101715:	68 60 1a 11 80       	push   $0x80111a60
8010171a:	ff 75 08             	pushl  0x8(%ebp)
8010171d:	e8 d5 fc ff ff       	call   801013f7 <readsb>
80101722:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101725:	a1 78 1a 11 80       	mov    0x80111a78,%eax
8010172a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010172d:	8b 3d 74 1a 11 80    	mov    0x80111a74,%edi
80101733:	8b 35 70 1a 11 80    	mov    0x80111a70,%esi
80101739:	8b 1d 6c 1a 11 80    	mov    0x80111a6c,%ebx
8010173f:	8b 0d 68 1a 11 80    	mov    0x80111a68,%ecx
80101745:	8b 15 64 1a 11 80    	mov    0x80111a64,%edx
8010174b:	a1 60 1a 11 80       	mov    0x80111a60,%eax
80101750:	ff 75 d4             	pushl  -0x2c(%ebp)
80101753:	57                   	push   %edi
80101754:	56                   	push   %esi
80101755:	53                   	push   %ebx
80101756:	51                   	push   %ecx
80101757:	52                   	push   %edx
80101758:	50                   	push   %eax
80101759:	68 e4 86 10 80       	push   $0x801086e4
8010175e:	e8 9d ec ff ff       	call   80100400 <cprintf>
80101763:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101766:	90                   	nop
80101767:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010176a:	5b                   	pop    %ebx
8010176b:	5e                   	pop    %esi
8010176c:	5f                   	pop    %edi
8010176d:	5d                   	pop    %ebp
8010176e:	c3                   	ret    

8010176f <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
8010176f:	55                   	push   %ebp
80101770:	89 e5                	mov    %esp,%ebp
80101772:	83 ec 28             	sub    $0x28,%esp
80101775:	8b 45 0c             	mov    0xc(%ebp),%eax
80101778:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010177c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101783:	e9 9e 00 00 00       	jmp    80101826 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
80101788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010178b:	c1 e8 03             	shr    $0x3,%eax
8010178e:	89 c2                	mov    %eax,%edx
80101790:	a1 74 1a 11 80       	mov    0x80111a74,%eax
80101795:	01 d0                	add    %edx,%eax
80101797:	83 ec 08             	sub    $0x8,%esp
8010179a:	50                   	push   %eax
8010179b:	ff 75 08             	pushl  0x8(%ebp)
8010179e:	e8 2b ea ff ff       	call   801001ce <bread>
801017a3:	83 c4 10             	add    $0x10,%esp
801017a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801017a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ac:	8d 50 5c             	lea    0x5c(%eax),%edx
801017af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017b2:	83 e0 07             	and    $0x7,%eax
801017b5:	c1 e0 06             	shl    $0x6,%eax
801017b8:	01 d0                	add    %edx,%eax
801017ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801017bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017c0:	0f b7 00             	movzwl (%eax),%eax
801017c3:	66 85 c0             	test   %ax,%ax
801017c6:	75 4c                	jne    80101814 <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
801017c8:	83 ec 04             	sub    $0x4,%esp
801017cb:	6a 40                	push   $0x40
801017cd:	6a 00                	push   $0x0
801017cf:	ff 75 ec             	pushl  -0x14(%ebp)
801017d2:	e8 7f 3b 00 00       	call   80105356 <memset>
801017d7:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801017da:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017dd:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801017e1:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801017e4:	83 ec 0c             	sub    $0xc,%esp
801017e7:	ff 75 f0             	pushl  -0x10(%ebp)
801017ea:	e8 2a 20 00 00       	call   80103819 <log_write>
801017ef:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801017f2:	83 ec 0c             	sub    $0xc,%esp
801017f5:	ff 75 f0             	pushl  -0x10(%ebp)
801017f8:	e8 53 ea ff ff       	call   80100250 <brelse>
801017fd:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101800:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101803:	83 ec 08             	sub    $0x8,%esp
80101806:	50                   	push   %eax
80101807:	ff 75 08             	pushl  0x8(%ebp)
8010180a:	e8 f8 00 00 00       	call   80101907 <iget>
8010180f:	83 c4 10             	add    $0x10,%esp
80101812:	eb 30                	jmp    80101844 <ialloc+0xd5>
    }
    brelse(bp);
80101814:	83 ec 0c             	sub    $0xc,%esp
80101817:	ff 75 f0             	pushl  -0x10(%ebp)
8010181a:	e8 31 ea ff ff       	call   80100250 <brelse>
8010181f:	83 c4 10             	add    $0x10,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101822:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101826:	8b 15 68 1a 11 80    	mov    0x80111a68,%edx
8010182c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010182f:	39 c2                	cmp    %eax,%edx
80101831:	0f 87 51 ff ff ff    	ja     80101788 <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101837:	83 ec 0c             	sub    $0xc,%esp
8010183a:	68 37 87 10 80       	push   $0x80108737
8010183f:	e8 5c ed ff ff       	call   801005a0 <panic>
}
80101844:	c9                   	leave  
80101845:	c3                   	ret    

80101846 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101846:	55                   	push   %ebp
80101847:	89 e5                	mov    %esp,%ebp
80101849:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010184c:	8b 45 08             	mov    0x8(%ebp),%eax
8010184f:	8b 40 04             	mov    0x4(%eax),%eax
80101852:	c1 e8 03             	shr    $0x3,%eax
80101855:	89 c2                	mov    %eax,%edx
80101857:	a1 74 1a 11 80       	mov    0x80111a74,%eax
8010185c:	01 c2                	add    %eax,%edx
8010185e:	8b 45 08             	mov    0x8(%ebp),%eax
80101861:	8b 00                	mov    (%eax),%eax
80101863:	83 ec 08             	sub    $0x8,%esp
80101866:	52                   	push   %edx
80101867:	50                   	push   %eax
80101868:	e8 61 e9 ff ff       	call   801001ce <bread>
8010186d:	83 c4 10             	add    $0x10,%esp
80101870:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101873:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101876:	8d 50 5c             	lea    0x5c(%eax),%edx
80101879:	8b 45 08             	mov    0x8(%ebp),%eax
8010187c:	8b 40 04             	mov    0x4(%eax),%eax
8010187f:	83 e0 07             	and    $0x7,%eax
80101882:	c1 e0 06             	shl    $0x6,%eax
80101885:	01 d0                	add    %edx,%eax
80101887:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
8010188a:	8b 45 08             	mov    0x8(%ebp),%eax
8010188d:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101891:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101894:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101897:	8b 45 08             	mov    0x8(%ebp),%eax
8010189a:	0f b7 50 52          	movzwl 0x52(%eax),%edx
8010189e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018a1:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801018a5:	8b 45 08             	mov    0x8(%ebp),%eax
801018a8:	0f b7 50 54          	movzwl 0x54(%eax),%edx
801018ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018af:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801018b3:	8b 45 08             	mov    0x8(%ebp),%eax
801018b6:	0f b7 50 56          	movzwl 0x56(%eax),%edx
801018ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018bd:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801018c1:	8b 45 08             	mov    0x8(%ebp),%eax
801018c4:	8b 50 58             	mov    0x58(%eax),%edx
801018c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018ca:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018cd:	8b 45 08             	mov    0x8(%ebp),%eax
801018d0:	8d 50 5c             	lea    0x5c(%eax),%edx
801018d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018d6:	83 c0 0c             	add    $0xc,%eax
801018d9:	83 ec 04             	sub    $0x4,%esp
801018dc:	6a 34                	push   $0x34
801018de:	52                   	push   %edx
801018df:	50                   	push   %eax
801018e0:	e8 30 3b 00 00       	call   80105415 <memmove>
801018e5:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801018e8:	83 ec 0c             	sub    $0xc,%esp
801018eb:	ff 75 f4             	pushl  -0xc(%ebp)
801018ee:	e8 26 1f 00 00       	call   80103819 <log_write>
801018f3:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801018f6:	83 ec 0c             	sub    $0xc,%esp
801018f9:	ff 75 f4             	pushl  -0xc(%ebp)
801018fc:	e8 4f e9 ff ff       	call   80100250 <brelse>
80101901:	83 c4 10             	add    $0x10,%esp
}
80101904:	90                   	nop
80101905:	c9                   	leave  
80101906:	c3                   	ret    

80101907 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101907:	55                   	push   %ebp
80101908:	89 e5                	mov    %esp,%ebp
8010190a:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010190d:	83 ec 0c             	sub    $0xc,%esp
80101910:	68 80 1a 11 80       	push   $0x80111a80
80101915:	e8 c2 37 00 00       	call   801050dc <acquire>
8010191a:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
8010191d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101924:	c7 45 f4 b4 1a 11 80 	movl   $0x80111ab4,-0xc(%ebp)
8010192b:	eb 60                	jmp    8010198d <iget+0x86>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010192d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101930:	8b 40 08             	mov    0x8(%eax),%eax
80101933:	85 c0                	test   %eax,%eax
80101935:	7e 39                	jle    80101970 <iget+0x69>
80101937:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010193a:	8b 00                	mov    (%eax),%eax
8010193c:	3b 45 08             	cmp    0x8(%ebp),%eax
8010193f:	75 2f                	jne    80101970 <iget+0x69>
80101941:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101944:	8b 40 04             	mov    0x4(%eax),%eax
80101947:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010194a:	75 24                	jne    80101970 <iget+0x69>
      ip->ref++;
8010194c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010194f:	8b 40 08             	mov    0x8(%eax),%eax
80101952:	8d 50 01             	lea    0x1(%eax),%edx
80101955:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101958:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
8010195b:	83 ec 0c             	sub    $0xc,%esp
8010195e:	68 80 1a 11 80       	push   $0x80111a80
80101963:	e8 e0 37 00 00       	call   80105148 <release>
80101968:	83 c4 10             	add    $0x10,%esp
      return ip;
8010196b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010196e:	eb 77                	jmp    801019e7 <iget+0xe0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101970:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101974:	75 10                	jne    80101986 <iget+0x7f>
80101976:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101979:	8b 40 08             	mov    0x8(%eax),%eax
8010197c:	85 c0                	test   %eax,%eax
8010197e:	75 06                	jne    80101986 <iget+0x7f>
      empty = ip;
80101980:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101983:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101986:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
8010198d:	81 7d f4 d4 36 11 80 	cmpl   $0x801136d4,-0xc(%ebp)
80101994:	72 97                	jb     8010192d <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101996:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010199a:	75 0d                	jne    801019a9 <iget+0xa2>
    panic("iget: no inodes");
8010199c:	83 ec 0c             	sub    $0xc,%esp
8010199f:	68 49 87 10 80       	push   $0x80108749
801019a4:	e8 f7 eb ff ff       	call   801005a0 <panic>

  ip = empty;
801019a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801019af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019b2:	8b 55 08             	mov    0x8(%ebp),%edx
801019b5:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801019b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019ba:	8b 55 0c             	mov    0xc(%ebp),%edx
801019bd:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801019c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019c3:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801019ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019cd:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
801019d4:	83 ec 0c             	sub    $0xc,%esp
801019d7:	68 80 1a 11 80       	push   $0x80111a80
801019dc:	e8 67 37 00 00       	call   80105148 <release>
801019e1:	83 c4 10             	add    $0x10,%esp

  return ip;
801019e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801019e7:	c9                   	leave  
801019e8:	c3                   	ret    

801019e9 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801019e9:	55                   	push   %ebp
801019ea:	89 e5                	mov    %esp,%ebp
801019ec:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801019ef:	83 ec 0c             	sub    $0xc,%esp
801019f2:	68 80 1a 11 80       	push   $0x80111a80
801019f7:	e8 e0 36 00 00       	call   801050dc <acquire>
801019fc:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801019ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101a02:	8b 40 08             	mov    0x8(%eax),%eax
80101a05:	8d 50 01             	lea    0x1(%eax),%edx
80101a08:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0b:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101a0e:	83 ec 0c             	sub    $0xc,%esp
80101a11:	68 80 1a 11 80       	push   $0x80111a80
80101a16:	e8 2d 37 00 00       	call   80105148 <release>
80101a1b:	83 c4 10             	add    $0x10,%esp
  return ip;
80101a1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101a21:	c9                   	leave  
80101a22:	c3                   	ret    

80101a23 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101a23:	55                   	push   %ebp
80101a24:	89 e5                	mov    %esp,%ebp
80101a26:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101a29:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a2d:	74 0a                	je     80101a39 <ilock+0x16>
80101a2f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a32:	8b 40 08             	mov    0x8(%eax),%eax
80101a35:	85 c0                	test   %eax,%eax
80101a37:	7f 0d                	jg     80101a46 <ilock+0x23>
    panic("ilock");
80101a39:	83 ec 0c             	sub    $0xc,%esp
80101a3c:	68 59 87 10 80       	push   $0x80108759
80101a41:	e8 5a eb ff ff       	call   801005a0 <panic>

  acquiresleep(&ip->lock);
80101a46:	8b 45 08             	mov    0x8(%ebp),%eax
80101a49:	83 c0 0c             	add    $0xc,%eax
80101a4c:	83 ec 0c             	sub    $0xc,%esp
80101a4f:	50                   	push   %eax
80101a50:	e8 43 35 00 00       	call   80104f98 <acquiresleep>
80101a55:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101a58:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5b:	8b 40 4c             	mov    0x4c(%eax),%eax
80101a5e:	83 e0 02             	and    $0x2,%eax
80101a61:	85 c0                	test   %eax,%eax
80101a63:	0f 85 d4 00 00 00    	jne    80101b3d <ilock+0x11a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 40 04             	mov    0x4(%eax),%eax
80101a6f:	c1 e8 03             	shr    $0x3,%eax
80101a72:	89 c2                	mov    %eax,%edx
80101a74:	a1 74 1a 11 80       	mov    0x80111a74,%eax
80101a79:	01 c2                	add    %eax,%edx
80101a7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7e:	8b 00                	mov    (%eax),%eax
80101a80:	83 ec 08             	sub    $0x8,%esp
80101a83:	52                   	push   %edx
80101a84:	50                   	push   %eax
80101a85:	e8 44 e7 ff ff       	call   801001ce <bread>
80101a8a:	83 c4 10             	add    $0x10,%esp
80101a8d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a93:	8d 50 5c             	lea    0x5c(%eax),%edx
80101a96:	8b 45 08             	mov    0x8(%ebp),%eax
80101a99:	8b 40 04             	mov    0x4(%eax),%eax
80101a9c:	83 e0 07             	and    $0x7,%eax
80101a9f:	c1 e0 06             	shl    $0x6,%eax
80101aa2:	01 d0                	add    %edx,%eax
80101aa4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101aa7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aaa:	0f b7 10             	movzwl (%eax),%edx
80101aad:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab0:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
80101ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ab7:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101abb:	8b 45 08             	mov    0x8(%ebp),%eax
80101abe:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ac5:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101ac9:	8b 45 08             	mov    0x8(%ebp),%eax
80101acc:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101ad0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ad3:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ada:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101ade:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ae1:	8b 50 08             	mov    0x8(%eax),%edx
80101ae4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae7:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101aea:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aed:	8d 50 0c             	lea    0xc(%eax),%edx
80101af0:	8b 45 08             	mov    0x8(%ebp),%eax
80101af3:	83 c0 5c             	add    $0x5c,%eax
80101af6:	83 ec 04             	sub    $0x4,%esp
80101af9:	6a 34                	push   $0x34
80101afb:	52                   	push   %edx
80101afc:	50                   	push   %eax
80101afd:	e8 13 39 00 00       	call   80105415 <memmove>
80101b02:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101b05:	83 ec 0c             	sub    $0xc,%esp
80101b08:	ff 75 f4             	pushl  -0xc(%ebp)
80101b0b:	e8 40 e7 ff ff       	call   80100250 <brelse>
80101b10:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101b13:	8b 45 08             	mov    0x8(%ebp),%eax
80101b16:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b19:	83 c8 02             	or     $0x2,%eax
80101b1c:	89 c2                	mov    %eax,%edx
80101b1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b21:	89 50 4c             	mov    %edx,0x4c(%eax)
    if(ip->type == 0)
80101b24:	8b 45 08             	mov    0x8(%ebp),%eax
80101b27:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101b2b:	66 85 c0             	test   %ax,%ax
80101b2e:	75 0d                	jne    80101b3d <ilock+0x11a>
      panic("ilock: no type");
80101b30:	83 ec 0c             	sub    $0xc,%esp
80101b33:	68 5f 87 10 80       	push   $0x8010875f
80101b38:	e8 63 ea ff ff       	call   801005a0 <panic>
  }
}
80101b3d:	90                   	nop
80101b3e:	c9                   	leave  
80101b3f:	c3                   	ret    

80101b40 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101b4a:	74 20                	je     80101b6c <iunlock+0x2c>
80101b4c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b4f:	83 c0 0c             	add    $0xc,%eax
80101b52:	83 ec 0c             	sub    $0xc,%esp
80101b55:	50                   	push   %eax
80101b56:	e8 f0 34 00 00       	call   8010504b <holdingsleep>
80101b5b:	83 c4 10             	add    $0x10,%esp
80101b5e:	85 c0                	test   %eax,%eax
80101b60:	74 0a                	je     80101b6c <iunlock+0x2c>
80101b62:	8b 45 08             	mov    0x8(%ebp),%eax
80101b65:	8b 40 08             	mov    0x8(%eax),%eax
80101b68:	85 c0                	test   %eax,%eax
80101b6a:	7f 0d                	jg     80101b79 <iunlock+0x39>
    panic("iunlock");
80101b6c:	83 ec 0c             	sub    $0xc,%esp
80101b6f:	68 6e 87 10 80       	push   $0x8010876e
80101b74:	e8 27 ea ff ff       	call   801005a0 <panic>

  releasesleep(&ip->lock);
80101b79:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7c:	83 c0 0c             	add    $0xc,%eax
80101b7f:	83 ec 0c             	sub    $0xc,%esp
80101b82:	50                   	push   %eax
80101b83:	e8 75 34 00 00       	call   80104ffd <releasesleep>
80101b88:	83 c4 10             	add    $0x10,%esp
}
80101b8b:	90                   	nop
80101b8c:	c9                   	leave  
80101b8d:	c3                   	ret    

80101b8e <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101b8e:	55                   	push   %ebp
80101b8f:	89 e5                	mov    %esp,%ebp
80101b91:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101b94:	83 ec 0c             	sub    $0xc,%esp
80101b97:	68 80 1a 11 80       	push   $0x80111a80
80101b9c:	e8 3b 35 00 00       	call   801050dc <acquire>
80101ba1:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101ba4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba7:	8b 40 08             	mov    0x8(%eax),%eax
80101baa:	83 f8 01             	cmp    $0x1,%eax
80101bad:	75 68                	jne    80101c17 <iput+0x89>
80101baf:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb2:	8b 40 4c             	mov    0x4c(%eax),%eax
80101bb5:	83 e0 02             	and    $0x2,%eax
80101bb8:	85 c0                	test   %eax,%eax
80101bba:	74 5b                	je     80101c17 <iput+0x89>
80101bbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbf:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101bc3:	66 85 c0             	test   %ax,%ax
80101bc6:	75 4f                	jne    80101c17 <iput+0x89>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
80101bc8:	83 ec 0c             	sub    $0xc,%esp
80101bcb:	68 80 1a 11 80       	push   $0x80111a80
80101bd0:	e8 73 35 00 00       	call   80105148 <release>
80101bd5:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101bd8:	83 ec 0c             	sub    $0xc,%esp
80101bdb:	ff 75 08             	pushl  0x8(%ebp)
80101bde:	e8 a0 01 00 00       	call   80101d83 <itrunc>
80101be3:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101be6:	8b 45 08             	mov    0x8(%ebp),%eax
80101be9:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
    iupdate(ip);
80101bef:	83 ec 0c             	sub    $0xc,%esp
80101bf2:	ff 75 08             	pushl  0x8(%ebp)
80101bf5:	e8 4c fc ff ff       	call   80101846 <iupdate>
80101bfa:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101bfd:	83 ec 0c             	sub    $0xc,%esp
80101c00:	68 80 1a 11 80       	push   $0x80111a80
80101c05:	e8 d2 34 00 00       	call   801050dc <acquire>
80101c0a:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c10:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }
  ip->ref--;
80101c17:	8b 45 08             	mov    0x8(%ebp),%eax
80101c1a:	8b 40 08             	mov    0x8(%eax),%eax
80101c1d:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c20:	8b 45 08             	mov    0x8(%ebp),%eax
80101c23:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c26:	83 ec 0c             	sub    $0xc,%esp
80101c29:	68 80 1a 11 80       	push   $0x80111a80
80101c2e:	e8 15 35 00 00       	call   80105148 <release>
80101c33:	83 c4 10             	add    $0x10,%esp
}
80101c36:	90                   	nop
80101c37:	c9                   	leave  
80101c38:	c3                   	ret    

80101c39 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c39:	55                   	push   %ebp
80101c3a:	89 e5                	mov    %esp,%ebp
80101c3c:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	ff 75 08             	pushl  0x8(%ebp)
80101c45:	e8 f6 fe ff ff       	call   80101b40 <iunlock>
80101c4a:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c4d:	83 ec 0c             	sub    $0xc,%esp
80101c50:	ff 75 08             	pushl  0x8(%ebp)
80101c53:	e8 36 ff ff ff       	call   80101b8e <iput>
80101c58:	83 c4 10             	add    $0x10,%esp
}
80101c5b:	90                   	nop
80101c5c:	c9                   	leave  
80101c5d:	c3                   	ret    

80101c5e <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c5e:	55                   	push   %ebp
80101c5f:	89 e5                	mov    %esp,%ebp
80101c61:	53                   	push   %ebx
80101c62:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c65:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c69:	77 42                	ja     80101cad <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101c6b:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c71:	83 c2 14             	add    $0x14,%edx
80101c74:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c78:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c7b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c7f:	75 24                	jne    80101ca5 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c81:	8b 45 08             	mov    0x8(%ebp),%eax
80101c84:	8b 00                	mov    (%eax),%eax
80101c86:	83 ec 0c             	sub    $0xc,%esp
80101c89:	50                   	push   %eax
80101c8a:	e8 fe f7 ff ff       	call   8010148d <balloc>
80101c8f:	83 c4 10             	add    $0x10,%esp
80101c92:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c95:	8b 45 08             	mov    0x8(%ebp),%eax
80101c98:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c9b:	8d 4a 14             	lea    0x14(%edx),%ecx
80101c9e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ca1:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ca8:	e9 d1 00 00 00       	jmp    80101d7e <bmap+0x120>
  }
  bn -= NDIRECT;
80101cad:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101cb1:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101cb5:	0f 87 b6 00 00 00    	ja     80101d71 <bmap+0x113>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101cbb:	8b 45 08             	mov    0x8(%ebp),%eax
80101cbe:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101cc4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cc7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ccb:	75 20                	jne    80101ced <bmap+0x8f>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101ccd:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd0:	8b 00                	mov    (%eax),%eax
80101cd2:	83 ec 0c             	sub    $0xc,%esp
80101cd5:	50                   	push   %eax
80101cd6:	e8 b2 f7 ff ff       	call   8010148d <balloc>
80101cdb:	83 c4 10             	add    $0x10,%esp
80101cde:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ce1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ce7:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101ced:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf0:	8b 00                	mov    (%eax),%eax
80101cf2:	83 ec 08             	sub    $0x8,%esp
80101cf5:	ff 75 f4             	pushl  -0xc(%ebp)
80101cf8:	50                   	push   %eax
80101cf9:	e8 d0 e4 ff ff       	call   801001ce <bread>
80101cfe:	83 c4 10             	add    $0x10,%esp
80101d01:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101d04:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d07:	83 c0 5c             	add    $0x5c,%eax
80101d0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101d0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d10:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d17:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d1a:	01 d0                	add    %edx,%eax
80101d1c:	8b 00                	mov    (%eax),%eax
80101d1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d21:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d25:	75 37                	jne    80101d5e <bmap+0x100>
      a[bn] = addr = balloc(ip->dev);
80101d27:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d31:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d34:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101d37:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3a:	8b 00                	mov    (%eax),%eax
80101d3c:	83 ec 0c             	sub    $0xc,%esp
80101d3f:	50                   	push   %eax
80101d40:	e8 48 f7 ff ff       	call   8010148d <balloc>
80101d45:	83 c4 10             	add    $0x10,%esp
80101d48:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d4e:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101d50:	83 ec 0c             	sub    $0xc,%esp
80101d53:	ff 75 f0             	pushl  -0x10(%ebp)
80101d56:	e8 be 1a 00 00       	call   80103819 <log_write>
80101d5b:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d5e:	83 ec 0c             	sub    $0xc,%esp
80101d61:	ff 75 f0             	pushl  -0x10(%ebp)
80101d64:	e8 e7 e4 ff ff       	call   80100250 <brelse>
80101d69:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d6f:	eb 0d                	jmp    80101d7e <bmap+0x120>
  }

  panic("bmap: out of range");
80101d71:	83 ec 0c             	sub    $0xc,%esp
80101d74:	68 76 87 10 80       	push   $0x80108776
80101d79:	e8 22 e8 ff ff       	call   801005a0 <panic>
}
80101d7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d81:	c9                   	leave  
80101d82:	c3                   	ret    

80101d83 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d83:	55                   	push   %ebp
80101d84:	89 e5                	mov    %esp,%ebp
80101d86:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d90:	eb 45                	jmp    80101dd7 <itrunc+0x54>
    if(ip->addrs[i]){
80101d92:	8b 45 08             	mov    0x8(%ebp),%eax
80101d95:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d98:	83 c2 14             	add    $0x14,%edx
80101d9b:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d9f:	85 c0                	test   %eax,%eax
80101da1:	74 30                	je     80101dd3 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101da3:	8b 45 08             	mov    0x8(%ebp),%eax
80101da6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101da9:	83 c2 14             	add    $0x14,%edx
80101dac:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101db0:	8b 55 08             	mov    0x8(%ebp),%edx
80101db3:	8b 12                	mov    (%edx),%edx
80101db5:	83 ec 08             	sub    $0x8,%esp
80101db8:	50                   	push   %eax
80101db9:	52                   	push   %edx
80101dba:	e8 1a f8 ff ff       	call   801015d9 <bfree>
80101dbf:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101dc2:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101dc8:	83 c2 14             	add    $0x14,%edx
80101dcb:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101dd2:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101dd3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101dd7:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101ddb:	7e b5                	jle    80101d92 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
80101ddd:	8b 45 08             	mov    0x8(%ebp),%eax
80101de0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101de6:	85 c0                	test   %eax,%eax
80101de8:	0f 84 aa 00 00 00    	je     80101e98 <itrunc+0x115>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101dee:	8b 45 08             	mov    0x8(%ebp),%eax
80101df1:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101df7:	8b 45 08             	mov    0x8(%ebp),%eax
80101dfa:	8b 00                	mov    (%eax),%eax
80101dfc:	83 ec 08             	sub    $0x8,%esp
80101dff:	52                   	push   %edx
80101e00:	50                   	push   %eax
80101e01:	e8 c8 e3 ff ff       	call   801001ce <bread>
80101e06:	83 c4 10             	add    $0x10,%esp
80101e09:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101e0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e0f:	83 c0 5c             	add    $0x5c,%eax
80101e12:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e15:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101e1c:	eb 3c                	jmp    80101e5a <itrunc+0xd7>
      if(a[j])
80101e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e21:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e28:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e2b:	01 d0                	add    %edx,%eax
80101e2d:	8b 00                	mov    (%eax),%eax
80101e2f:	85 c0                	test   %eax,%eax
80101e31:	74 23                	je     80101e56 <itrunc+0xd3>
        bfree(ip->dev, a[j]);
80101e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e3d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e40:	01 d0                	add    %edx,%eax
80101e42:	8b 00                	mov    (%eax),%eax
80101e44:	8b 55 08             	mov    0x8(%ebp),%edx
80101e47:	8b 12                	mov    (%edx),%edx
80101e49:	83 ec 08             	sub    $0x8,%esp
80101e4c:	50                   	push   %eax
80101e4d:	52                   	push   %edx
80101e4e:	e8 86 f7 ff ff       	call   801015d9 <bfree>
80101e53:	83 c4 10             	add    $0x10,%esp
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101e56:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e5d:	83 f8 7f             	cmp    $0x7f,%eax
80101e60:	76 bc                	jbe    80101e1e <itrunc+0x9b>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101e62:	83 ec 0c             	sub    $0xc,%esp
80101e65:	ff 75 ec             	pushl  -0x14(%ebp)
80101e68:	e8 e3 e3 ff ff       	call   80100250 <brelse>
80101e6d:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e70:	8b 45 08             	mov    0x8(%ebp),%eax
80101e73:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101e79:	8b 55 08             	mov    0x8(%ebp),%edx
80101e7c:	8b 12                	mov    (%edx),%edx
80101e7e:	83 ec 08             	sub    $0x8,%esp
80101e81:	50                   	push   %eax
80101e82:	52                   	push   %edx
80101e83:	e8 51 f7 ff ff       	call   801015d9 <bfree>
80101e88:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e8e:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101e95:	00 00 00 
  }

  ip->size = 0;
80101e98:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9b:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101ea2:	83 ec 0c             	sub    $0xc,%esp
80101ea5:	ff 75 08             	pushl  0x8(%ebp)
80101ea8:	e8 99 f9 ff ff       	call   80101846 <iupdate>
80101ead:	83 c4 10             	add    $0x10,%esp
}
80101eb0:	90                   	nop
80101eb1:	c9                   	leave  
80101eb2:	c3                   	ret    

80101eb3 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101eb3:	55                   	push   %ebp
80101eb4:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101eb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb9:	8b 00                	mov    (%eax),%eax
80101ebb:	89 c2                	mov    %eax,%edx
80101ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ec0:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101ec3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec6:	8b 50 04             	mov    0x4(%eax),%edx
80101ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ecc:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101ecf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed2:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ed9:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101edc:	8b 45 08             	mov    0x8(%ebp),%eax
80101edf:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101ee3:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ee6:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101eea:	8b 45 08             	mov    0x8(%ebp),%eax
80101eed:	8b 50 58             	mov    0x58(%eax),%edx
80101ef0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ef3:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ef6:	90                   	nop
80101ef7:	5d                   	pop    %ebp
80101ef8:	c3                   	ret    

80101ef9 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ef9:	55                   	push   %ebp
80101efa:	89 e5                	mov    %esp,%ebp
80101efc:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101eff:	8b 45 08             	mov    0x8(%ebp),%eax
80101f02:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101f06:	66 83 f8 03          	cmp    $0x3,%ax
80101f0a:	75 5c                	jne    80101f68 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101f0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0f:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f13:	66 85 c0             	test   %ax,%ax
80101f16:	78 20                	js     80101f38 <readi+0x3f>
80101f18:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1b:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f1f:	66 83 f8 09          	cmp    $0x9,%ax
80101f23:	7f 13                	jg     80101f38 <readi+0x3f>
80101f25:	8b 45 08             	mov    0x8(%ebp),%eax
80101f28:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f2c:	98                   	cwtl   
80101f2d:	8b 04 c5 00 1a 11 80 	mov    -0x7feee600(,%eax,8),%eax
80101f34:	85 c0                	test   %eax,%eax
80101f36:	75 0a                	jne    80101f42 <readi+0x49>
      return -1;
80101f38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f3d:	e9 0c 01 00 00       	jmp    8010204e <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101f42:	8b 45 08             	mov    0x8(%ebp),%eax
80101f45:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f49:	98                   	cwtl   
80101f4a:	8b 04 c5 00 1a 11 80 	mov    -0x7feee600(,%eax,8),%eax
80101f51:	8b 55 14             	mov    0x14(%ebp),%edx
80101f54:	83 ec 04             	sub    $0x4,%esp
80101f57:	52                   	push   %edx
80101f58:	ff 75 0c             	pushl  0xc(%ebp)
80101f5b:	ff 75 08             	pushl  0x8(%ebp)
80101f5e:	ff d0                	call   *%eax
80101f60:	83 c4 10             	add    $0x10,%esp
80101f63:	e9 e6 00 00 00       	jmp    8010204e <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80101f68:	8b 45 08             	mov    0x8(%ebp),%eax
80101f6b:	8b 40 58             	mov    0x58(%eax),%eax
80101f6e:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f71:	72 0d                	jb     80101f80 <readi+0x87>
80101f73:	8b 55 10             	mov    0x10(%ebp),%edx
80101f76:	8b 45 14             	mov    0x14(%ebp),%eax
80101f79:	01 d0                	add    %edx,%eax
80101f7b:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f7e:	73 0a                	jae    80101f8a <readi+0x91>
    return -1;
80101f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f85:	e9 c4 00 00 00       	jmp    8010204e <readi+0x155>
  if(off + n > ip->size)
80101f8a:	8b 55 10             	mov    0x10(%ebp),%edx
80101f8d:	8b 45 14             	mov    0x14(%ebp),%eax
80101f90:	01 c2                	add    %eax,%edx
80101f92:	8b 45 08             	mov    0x8(%ebp),%eax
80101f95:	8b 40 58             	mov    0x58(%eax),%eax
80101f98:	39 c2                	cmp    %eax,%edx
80101f9a:	76 0c                	jbe    80101fa8 <readi+0xaf>
    n = ip->size - off;
80101f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f9f:	8b 40 58             	mov    0x58(%eax),%eax
80101fa2:	2b 45 10             	sub    0x10(%ebp),%eax
80101fa5:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fa8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101faf:	e9 8b 00 00 00       	jmp    8010203f <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fb4:	8b 45 10             	mov    0x10(%ebp),%eax
80101fb7:	c1 e8 09             	shr    $0x9,%eax
80101fba:	83 ec 08             	sub    $0x8,%esp
80101fbd:	50                   	push   %eax
80101fbe:	ff 75 08             	pushl  0x8(%ebp)
80101fc1:	e8 98 fc ff ff       	call   80101c5e <bmap>
80101fc6:	83 c4 10             	add    $0x10,%esp
80101fc9:	89 c2                	mov    %eax,%edx
80101fcb:	8b 45 08             	mov    0x8(%ebp),%eax
80101fce:	8b 00                	mov    (%eax),%eax
80101fd0:	83 ec 08             	sub    $0x8,%esp
80101fd3:	52                   	push   %edx
80101fd4:	50                   	push   %eax
80101fd5:	e8 f4 e1 ff ff       	call   801001ce <bread>
80101fda:	83 c4 10             	add    $0x10,%esp
80101fdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fe0:	8b 45 10             	mov    0x10(%ebp),%eax
80101fe3:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fe8:	ba 00 02 00 00       	mov    $0x200,%edx
80101fed:	29 c2                	sub    %eax,%edx
80101fef:	8b 45 14             	mov    0x14(%ebp),%eax
80101ff2:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101ff5:	39 c2                	cmp    %eax,%edx
80101ff7:	0f 46 c2             	cmovbe %edx,%eax
80101ffa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101ffd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102000:	8d 50 5c             	lea    0x5c(%eax),%edx
80102003:	8b 45 10             	mov    0x10(%ebp),%eax
80102006:	25 ff 01 00 00       	and    $0x1ff,%eax
8010200b:	01 d0                	add    %edx,%eax
8010200d:	83 ec 04             	sub    $0x4,%esp
80102010:	ff 75 ec             	pushl  -0x14(%ebp)
80102013:	50                   	push   %eax
80102014:	ff 75 0c             	pushl  0xc(%ebp)
80102017:	e8 f9 33 00 00       	call   80105415 <memmove>
8010201c:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010201f:	83 ec 0c             	sub    $0xc,%esp
80102022:	ff 75 f0             	pushl  -0x10(%ebp)
80102025:	e8 26 e2 ff ff       	call   80100250 <brelse>
8010202a:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010202d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102030:	01 45 f4             	add    %eax,-0xc(%ebp)
80102033:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102036:	01 45 10             	add    %eax,0x10(%ebp)
80102039:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010203c:	01 45 0c             	add    %eax,0xc(%ebp)
8010203f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102042:	3b 45 14             	cmp    0x14(%ebp),%eax
80102045:	0f 82 69 ff ff ff    	jb     80101fb4 <readi+0xbb>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
8010204b:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010204e:	c9                   	leave  
8010204f:	c3                   	ret    

80102050 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102056:	8b 45 08             	mov    0x8(%ebp),%eax
80102059:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010205d:	66 83 f8 03          	cmp    $0x3,%ax
80102061:	75 5c                	jne    801020bf <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102063:	8b 45 08             	mov    0x8(%ebp),%eax
80102066:	0f b7 40 52          	movzwl 0x52(%eax),%eax
8010206a:	66 85 c0             	test   %ax,%ax
8010206d:	78 20                	js     8010208f <writei+0x3f>
8010206f:	8b 45 08             	mov    0x8(%ebp),%eax
80102072:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102076:	66 83 f8 09          	cmp    $0x9,%ax
8010207a:	7f 13                	jg     8010208f <writei+0x3f>
8010207c:	8b 45 08             	mov    0x8(%ebp),%eax
8010207f:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102083:	98                   	cwtl   
80102084:	8b 04 c5 04 1a 11 80 	mov    -0x7feee5fc(,%eax,8),%eax
8010208b:	85 c0                	test   %eax,%eax
8010208d:	75 0a                	jne    80102099 <writei+0x49>
      return -1;
8010208f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102094:	e9 3d 01 00 00       	jmp    801021d6 <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
80102099:	8b 45 08             	mov    0x8(%ebp),%eax
8010209c:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801020a0:	98                   	cwtl   
801020a1:	8b 04 c5 04 1a 11 80 	mov    -0x7feee5fc(,%eax,8),%eax
801020a8:	8b 55 14             	mov    0x14(%ebp),%edx
801020ab:	83 ec 04             	sub    $0x4,%esp
801020ae:	52                   	push   %edx
801020af:	ff 75 0c             	pushl  0xc(%ebp)
801020b2:	ff 75 08             	pushl  0x8(%ebp)
801020b5:	ff d0                	call   *%eax
801020b7:	83 c4 10             	add    $0x10,%esp
801020ba:	e9 17 01 00 00       	jmp    801021d6 <writei+0x186>
  }

  if(off > ip->size || off + n < off)
801020bf:	8b 45 08             	mov    0x8(%ebp),%eax
801020c2:	8b 40 58             	mov    0x58(%eax),%eax
801020c5:	3b 45 10             	cmp    0x10(%ebp),%eax
801020c8:	72 0d                	jb     801020d7 <writei+0x87>
801020ca:	8b 55 10             	mov    0x10(%ebp),%edx
801020cd:	8b 45 14             	mov    0x14(%ebp),%eax
801020d0:	01 d0                	add    %edx,%eax
801020d2:	3b 45 10             	cmp    0x10(%ebp),%eax
801020d5:	73 0a                	jae    801020e1 <writei+0x91>
    return -1;
801020d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020dc:	e9 f5 00 00 00       	jmp    801021d6 <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
801020e1:	8b 55 10             	mov    0x10(%ebp),%edx
801020e4:	8b 45 14             	mov    0x14(%ebp),%eax
801020e7:	01 d0                	add    %edx,%eax
801020e9:	3d 00 18 01 00       	cmp    $0x11800,%eax
801020ee:	76 0a                	jbe    801020fa <writei+0xaa>
    return -1;
801020f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020f5:	e9 dc 00 00 00       	jmp    801021d6 <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102101:	e9 99 00 00 00       	jmp    8010219f <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102106:	8b 45 10             	mov    0x10(%ebp),%eax
80102109:	c1 e8 09             	shr    $0x9,%eax
8010210c:	83 ec 08             	sub    $0x8,%esp
8010210f:	50                   	push   %eax
80102110:	ff 75 08             	pushl  0x8(%ebp)
80102113:	e8 46 fb ff ff       	call   80101c5e <bmap>
80102118:	83 c4 10             	add    $0x10,%esp
8010211b:	89 c2                	mov    %eax,%edx
8010211d:	8b 45 08             	mov    0x8(%ebp),%eax
80102120:	8b 00                	mov    (%eax),%eax
80102122:	83 ec 08             	sub    $0x8,%esp
80102125:	52                   	push   %edx
80102126:	50                   	push   %eax
80102127:	e8 a2 e0 ff ff       	call   801001ce <bread>
8010212c:	83 c4 10             	add    $0x10,%esp
8010212f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102132:	8b 45 10             	mov    0x10(%ebp),%eax
80102135:	25 ff 01 00 00       	and    $0x1ff,%eax
8010213a:	ba 00 02 00 00       	mov    $0x200,%edx
8010213f:	29 c2                	sub    %eax,%edx
80102141:	8b 45 14             	mov    0x14(%ebp),%eax
80102144:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102147:	39 c2                	cmp    %eax,%edx
80102149:	0f 46 c2             	cmovbe %edx,%eax
8010214c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
8010214f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102152:	8d 50 5c             	lea    0x5c(%eax),%edx
80102155:	8b 45 10             	mov    0x10(%ebp),%eax
80102158:	25 ff 01 00 00       	and    $0x1ff,%eax
8010215d:	01 d0                	add    %edx,%eax
8010215f:	83 ec 04             	sub    $0x4,%esp
80102162:	ff 75 ec             	pushl  -0x14(%ebp)
80102165:	ff 75 0c             	pushl  0xc(%ebp)
80102168:	50                   	push   %eax
80102169:	e8 a7 32 00 00       	call   80105415 <memmove>
8010216e:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102171:	83 ec 0c             	sub    $0xc,%esp
80102174:	ff 75 f0             	pushl  -0x10(%ebp)
80102177:	e8 9d 16 00 00       	call   80103819 <log_write>
8010217c:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010217f:	83 ec 0c             	sub    $0xc,%esp
80102182:	ff 75 f0             	pushl  -0x10(%ebp)
80102185:	e8 c6 e0 ff ff       	call   80100250 <brelse>
8010218a:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010218d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102190:	01 45 f4             	add    %eax,-0xc(%ebp)
80102193:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102196:	01 45 10             	add    %eax,0x10(%ebp)
80102199:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010219c:	01 45 0c             	add    %eax,0xc(%ebp)
8010219f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021a2:	3b 45 14             	cmp    0x14(%ebp),%eax
801021a5:	0f 82 5b ff ff ff    	jb     80102106 <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
801021ab:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801021af:	74 22                	je     801021d3 <writei+0x183>
801021b1:	8b 45 08             	mov    0x8(%ebp),%eax
801021b4:	8b 40 58             	mov    0x58(%eax),%eax
801021b7:	3b 45 10             	cmp    0x10(%ebp),%eax
801021ba:	73 17                	jae    801021d3 <writei+0x183>
    ip->size = off;
801021bc:	8b 45 08             	mov    0x8(%ebp),%eax
801021bf:	8b 55 10             	mov    0x10(%ebp),%edx
801021c2:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
801021c5:	83 ec 0c             	sub    $0xc,%esp
801021c8:	ff 75 08             	pushl  0x8(%ebp)
801021cb:	e8 76 f6 ff ff       	call   80101846 <iupdate>
801021d0:	83 c4 10             	add    $0x10,%esp
  }
  return n;
801021d3:	8b 45 14             	mov    0x14(%ebp),%eax
}
801021d6:	c9                   	leave  
801021d7:	c3                   	ret    

801021d8 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801021d8:	55                   	push   %ebp
801021d9:	89 e5                	mov    %esp,%ebp
801021db:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
801021de:	83 ec 04             	sub    $0x4,%esp
801021e1:	6a 0e                	push   $0xe
801021e3:	ff 75 0c             	pushl  0xc(%ebp)
801021e6:	ff 75 08             	pushl  0x8(%ebp)
801021e9:	e8 bd 32 00 00       	call   801054ab <strncmp>
801021ee:	83 c4 10             	add    $0x10,%esp
}
801021f1:	c9                   	leave  
801021f2:	c3                   	ret    

801021f3 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021f3:	55                   	push   %ebp
801021f4:	89 e5                	mov    %esp,%ebp
801021f6:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801021f9:	8b 45 08             	mov    0x8(%ebp),%eax
801021fc:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102200:	66 83 f8 01          	cmp    $0x1,%ax
80102204:	74 0d                	je     80102213 <dirlookup+0x20>
    panic("dirlookup not DIR");
80102206:	83 ec 0c             	sub    $0xc,%esp
80102209:	68 89 87 10 80       	push   $0x80108789
8010220e:	e8 8d e3 ff ff       	call   801005a0 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102213:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010221a:	eb 7b                	jmp    80102297 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010221c:	6a 10                	push   $0x10
8010221e:	ff 75 f4             	pushl  -0xc(%ebp)
80102221:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102224:	50                   	push   %eax
80102225:	ff 75 08             	pushl  0x8(%ebp)
80102228:	e8 cc fc ff ff       	call   80101ef9 <readi>
8010222d:	83 c4 10             	add    $0x10,%esp
80102230:	83 f8 10             	cmp    $0x10,%eax
80102233:	74 0d                	je     80102242 <dirlookup+0x4f>
      panic("dirlink read");
80102235:	83 ec 0c             	sub    $0xc,%esp
80102238:	68 9b 87 10 80       	push   $0x8010879b
8010223d:	e8 5e e3 ff ff       	call   801005a0 <panic>
    if(de.inum == 0)
80102242:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102246:	66 85 c0             	test   %ax,%ax
80102249:	74 47                	je     80102292 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
8010224b:	83 ec 08             	sub    $0x8,%esp
8010224e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102251:	83 c0 02             	add    $0x2,%eax
80102254:	50                   	push   %eax
80102255:	ff 75 0c             	pushl  0xc(%ebp)
80102258:	e8 7b ff ff ff       	call   801021d8 <namecmp>
8010225d:	83 c4 10             	add    $0x10,%esp
80102260:	85 c0                	test   %eax,%eax
80102262:	75 2f                	jne    80102293 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102264:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102268:	74 08                	je     80102272 <dirlookup+0x7f>
        *poff = off;
8010226a:	8b 45 10             	mov    0x10(%ebp),%eax
8010226d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102270:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102272:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102276:	0f b7 c0             	movzwl %ax,%eax
80102279:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010227c:	8b 45 08             	mov    0x8(%ebp),%eax
8010227f:	8b 00                	mov    (%eax),%eax
80102281:	83 ec 08             	sub    $0x8,%esp
80102284:	ff 75 f0             	pushl  -0x10(%ebp)
80102287:	50                   	push   %eax
80102288:	e8 7a f6 ff ff       	call   80101907 <iget>
8010228d:	83 c4 10             	add    $0x10,%esp
80102290:	eb 19                	jmp    801022ab <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
80102292:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102293:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80102297:	8b 45 08             	mov    0x8(%ebp),%eax
8010229a:	8b 40 58             	mov    0x58(%eax),%eax
8010229d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801022a0:	0f 87 76 ff ff ff    	ja     8010221c <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
801022a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022ab:	c9                   	leave  
801022ac:	c3                   	ret    

801022ad <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801022ad:	55                   	push   %ebp
801022ae:	89 e5                	mov    %esp,%ebp
801022b0:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801022b3:	83 ec 04             	sub    $0x4,%esp
801022b6:	6a 00                	push   $0x0
801022b8:	ff 75 0c             	pushl  0xc(%ebp)
801022bb:	ff 75 08             	pushl  0x8(%ebp)
801022be:	e8 30 ff ff ff       	call   801021f3 <dirlookup>
801022c3:	83 c4 10             	add    $0x10,%esp
801022c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801022c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801022cd:	74 18                	je     801022e7 <dirlink+0x3a>
    iput(ip);
801022cf:	83 ec 0c             	sub    $0xc,%esp
801022d2:	ff 75 f0             	pushl  -0x10(%ebp)
801022d5:	e8 b4 f8 ff ff       	call   80101b8e <iput>
801022da:	83 c4 10             	add    $0x10,%esp
    return -1;
801022dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022e2:	e9 9c 00 00 00       	jmp    80102383 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022ee:	eb 39                	jmp    80102329 <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022f3:	6a 10                	push   $0x10
801022f5:	50                   	push   %eax
801022f6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022f9:	50                   	push   %eax
801022fa:	ff 75 08             	pushl  0x8(%ebp)
801022fd:	e8 f7 fb ff ff       	call   80101ef9 <readi>
80102302:	83 c4 10             	add    $0x10,%esp
80102305:	83 f8 10             	cmp    $0x10,%eax
80102308:	74 0d                	je     80102317 <dirlink+0x6a>
      panic("dirlink read");
8010230a:	83 ec 0c             	sub    $0xc,%esp
8010230d:	68 9b 87 10 80       	push   $0x8010879b
80102312:	e8 89 e2 ff ff       	call   801005a0 <panic>
    if(de.inum == 0)
80102317:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010231b:	66 85 c0             	test   %ax,%ax
8010231e:	74 18                	je     80102338 <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102320:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102323:	83 c0 10             	add    $0x10,%eax
80102326:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102329:	8b 45 08             	mov    0x8(%ebp),%eax
8010232c:	8b 50 58             	mov    0x58(%eax),%edx
8010232f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102332:	39 c2                	cmp    %eax,%edx
80102334:	77 ba                	ja     801022f0 <dirlink+0x43>
80102336:	eb 01                	jmp    80102339 <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
80102338:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102339:	83 ec 04             	sub    $0x4,%esp
8010233c:	6a 0e                	push   $0xe
8010233e:	ff 75 0c             	pushl  0xc(%ebp)
80102341:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102344:	83 c0 02             	add    $0x2,%eax
80102347:	50                   	push   %eax
80102348:	e8 b4 31 00 00       	call   80105501 <strncpy>
8010234d:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102350:	8b 45 10             	mov    0x10(%ebp),%eax
80102353:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102357:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010235a:	6a 10                	push   $0x10
8010235c:	50                   	push   %eax
8010235d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102360:	50                   	push   %eax
80102361:	ff 75 08             	pushl  0x8(%ebp)
80102364:	e8 e7 fc ff ff       	call   80102050 <writei>
80102369:	83 c4 10             	add    $0x10,%esp
8010236c:	83 f8 10             	cmp    $0x10,%eax
8010236f:	74 0d                	je     8010237e <dirlink+0xd1>
    panic("dirlink");
80102371:	83 ec 0c             	sub    $0xc,%esp
80102374:	68 a8 87 10 80       	push   $0x801087a8
80102379:	e8 22 e2 ff ff       	call   801005a0 <panic>

  return 0;
8010237e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102383:	c9                   	leave  
80102384:	c3                   	ret    

80102385 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102385:	55                   	push   %ebp
80102386:	89 e5                	mov    %esp,%ebp
80102388:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
8010238b:	eb 04                	jmp    80102391 <skipelem+0xc>
    path++;
8010238d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102391:	8b 45 08             	mov    0x8(%ebp),%eax
80102394:	0f b6 00             	movzbl (%eax),%eax
80102397:	3c 2f                	cmp    $0x2f,%al
80102399:	74 f2                	je     8010238d <skipelem+0x8>
    path++;
  if(*path == 0)
8010239b:	8b 45 08             	mov    0x8(%ebp),%eax
8010239e:	0f b6 00             	movzbl (%eax),%eax
801023a1:	84 c0                	test   %al,%al
801023a3:	75 07                	jne    801023ac <skipelem+0x27>
    return 0;
801023a5:	b8 00 00 00 00       	mov    $0x0,%eax
801023aa:	eb 7b                	jmp    80102427 <skipelem+0xa2>
  s = path;
801023ac:	8b 45 08             	mov    0x8(%ebp),%eax
801023af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
801023b2:	eb 04                	jmp    801023b8 <skipelem+0x33>
    path++;
801023b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
801023b8:	8b 45 08             	mov    0x8(%ebp),%eax
801023bb:	0f b6 00             	movzbl (%eax),%eax
801023be:	3c 2f                	cmp    $0x2f,%al
801023c0:	74 0a                	je     801023cc <skipelem+0x47>
801023c2:	8b 45 08             	mov    0x8(%ebp),%eax
801023c5:	0f b6 00             	movzbl (%eax),%eax
801023c8:	84 c0                	test   %al,%al
801023ca:	75 e8                	jne    801023b4 <skipelem+0x2f>
    path++;
  len = path - s;
801023cc:	8b 55 08             	mov    0x8(%ebp),%edx
801023cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023d2:	29 c2                	sub    %eax,%edx
801023d4:	89 d0                	mov    %edx,%eax
801023d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801023d9:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801023dd:	7e 15                	jle    801023f4 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
801023df:	83 ec 04             	sub    $0x4,%esp
801023e2:	6a 0e                	push   $0xe
801023e4:	ff 75 f4             	pushl  -0xc(%ebp)
801023e7:	ff 75 0c             	pushl  0xc(%ebp)
801023ea:	e8 26 30 00 00       	call   80105415 <memmove>
801023ef:	83 c4 10             	add    $0x10,%esp
801023f2:	eb 26                	jmp    8010241a <skipelem+0x95>
  else {
    memmove(name, s, len);
801023f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023f7:	83 ec 04             	sub    $0x4,%esp
801023fa:	50                   	push   %eax
801023fb:	ff 75 f4             	pushl  -0xc(%ebp)
801023fe:	ff 75 0c             	pushl  0xc(%ebp)
80102401:	e8 0f 30 00 00       	call   80105415 <memmove>
80102406:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
80102409:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010240c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010240f:	01 d0                	add    %edx,%eax
80102411:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102414:	eb 04                	jmp    8010241a <skipelem+0x95>
    path++;
80102416:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
8010241a:	8b 45 08             	mov    0x8(%ebp),%eax
8010241d:	0f b6 00             	movzbl (%eax),%eax
80102420:	3c 2f                	cmp    $0x2f,%al
80102422:	74 f2                	je     80102416 <skipelem+0x91>
    path++;
  return path;
80102424:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102427:	c9                   	leave  
80102428:	c3                   	ret    

80102429 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102429:	55                   	push   %ebp
8010242a:	89 e5                	mov    %esp,%ebp
8010242c:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010242f:	8b 45 08             	mov    0x8(%ebp),%eax
80102432:	0f b6 00             	movzbl (%eax),%eax
80102435:	3c 2f                	cmp    $0x2f,%al
80102437:	75 17                	jne    80102450 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
80102439:	83 ec 08             	sub    $0x8,%esp
8010243c:	6a 01                	push   $0x1
8010243e:	6a 01                	push   $0x1
80102440:	e8 c2 f4 ff ff       	call   80101907 <iget>
80102445:	83 c4 10             	add    $0x10,%esp
80102448:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010244b:	e9 bb 00 00 00       	jmp    8010250b <namex+0xe2>
  else
    ip = idup(proc->cwd);
80102450:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102456:	8b 40 68             	mov    0x68(%eax),%eax
80102459:	83 ec 0c             	sub    $0xc,%esp
8010245c:	50                   	push   %eax
8010245d:	e8 87 f5 ff ff       	call   801019e9 <idup>
80102462:	83 c4 10             	add    $0x10,%esp
80102465:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
80102468:	e9 9e 00 00 00       	jmp    8010250b <namex+0xe2>
    ilock(ip);
8010246d:	83 ec 0c             	sub    $0xc,%esp
80102470:	ff 75 f4             	pushl  -0xc(%ebp)
80102473:	e8 ab f5 ff ff       	call   80101a23 <ilock>
80102478:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
8010247b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010247e:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102482:	66 83 f8 01          	cmp    $0x1,%ax
80102486:	74 18                	je     801024a0 <namex+0x77>
      iunlockput(ip);
80102488:	83 ec 0c             	sub    $0xc,%esp
8010248b:	ff 75 f4             	pushl  -0xc(%ebp)
8010248e:	e8 a6 f7 ff ff       	call   80101c39 <iunlockput>
80102493:	83 c4 10             	add    $0x10,%esp
      return 0;
80102496:	b8 00 00 00 00       	mov    $0x0,%eax
8010249b:	e9 a7 00 00 00       	jmp    80102547 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
801024a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024a4:	74 20                	je     801024c6 <namex+0x9d>
801024a6:	8b 45 08             	mov    0x8(%ebp),%eax
801024a9:	0f b6 00             	movzbl (%eax),%eax
801024ac:	84 c0                	test   %al,%al
801024ae:	75 16                	jne    801024c6 <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
801024b0:	83 ec 0c             	sub    $0xc,%esp
801024b3:	ff 75 f4             	pushl  -0xc(%ebp)
801024b6:	e8 85 f6 ff ff       	call   80101b40 <iunlock>
801024bb:	83 c4 10             	add    $0x10,%esp
      return ip;
801024be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024c1:	e9 81 00 00 00       	jmp    80102547 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801024c6:	83 ec 04             	sub    $0x4,%esp
801024c9:	6a 00                	push   $0x0
801024cb:	ff 75 10             	pushl  0x10(%ebp)
801024ce:	ff 75 f4             	pushl  -0xc(%ebp)
801024d1:	e8 1d fd ff ff       	call   801021f3 <dirlookup>
801024d6:	83 c4 10             	add    $0x10,%esp
801024d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801024dc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801024e0:	75 15                	jne    801024f7 <namex+0xce>
      iunlockput(ip);
801024e2:	83 ec 0c             	sub    $0xc,%esp
801024e5:	ff 75 f4             	pushl  -0xc(%ebp)
801024e8:	e8 4c f7 ff ff       	call   80101c39 <iunlockput>
801024ed:	83 c4 10             	add    $0x10,%esp
      return 0;
801024f0:	b8 00 00 00 00       	mov    $0x0,%eax
801024f5:	eb 50                	jmp    80102547 <namex+0x11e>
    }
    iunlockput(ip);
801024f7:	83 ec 0c             	sub    $0xc,%esp
801024fa:	ff 75 f4             	pushl  -0xc(%ebp)
801024fd:	e8 37 f7 ff ff       	call   80101c39 <iunlockput>
80102502:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102505:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102508:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010250b:	83 ec 08             	sub    $0x8,%esp
8010250e:	ff 75 10             	pushl  0x10(%ebp)
80102511:	ff 75 08             	pushl  0x8(%ebp)
80102514:	e8 6c fe ff ff       	call   80102385 <skipelem>
80102519:	83 c4 10             	add    $0x10,%esp
8010251c:	89 45 08             	mov    %eax,0x8(%ebp)
8010251f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102523:	0f 85 44 ff ff ff    	jne    8010246d <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102529:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010252d:	74 15                	je     80102544 <namex+0x11b>
    iput(ip);
8010252f:	83 ec 0c             	sub    $0xc,%esp
80102532:	ff 75 f4             	pushl  -0xc(%ebp)
80102535:	e8 54 f6 ff ff       	call   80101b8e <iput>
8010253a:	83 c4 10             	add    $0x10,%esp
    return 0;
8010253d:	b8 00 00 00 00       	mov    $0x0,%eax
80102542:	eb 03                	jmp    80102547 <namex+0x11e>
  }
  return ip;
80102544:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102547:	c9                   	leave  
80102548:	c3                   	ret    

80102549 <namei>:

struct inode*
namei(char *path)
{
80102549:	55                   	push   %ebp
8010254a:	89 e5                	mov    %esp,%ebp
8010254c:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
8010254f:	83 ec 04             	sub    $0x4,%esp
80102552:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102555:	50                   	push   %eax
80102556:	6a 00                	push   $0x0
80102558:	ff 75 08             	pushl  0x8(%ebp)
8010255b:	e8 c9 fe ff ff       	call   80102429 <namex>
80102560:	83 c4 10             	add    $0x10,%esp
}
80102563:	c9                   	leave  
80102564:	c3                   	ret    

80102565 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102565:	55                   	push   %ebp
80102566:	89 e5                	mov    %esp,%ebp
80102568:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010256b:	83 ec 04             	sub    $0x4,%esp
8010256e:	ff 75 0c             	pushl  0xc(%ebp)
80102571:	6a 01                	push   $0x1
80102573:	ff 75 08             	pushl  0x8(%ebp)
80102576:	e8 ae fe ff ff       	call   80102429 <namex>
8010257b:	83 c4 10             	add    $0x10,%esp
}
8010257e:	c9                   	leave  
8010257f:	c3                   	ret    

80102580 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	83 ec 14             	sub    $0x14,%esp
80102586:	8b 45 08             	mov    0x8(%ebp),%eax
80102589:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010258d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102591:	89 c2                	mov    %eax,%edx
80102593:	ec                   	in     (%dx),%al
80102594:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102597:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010259b:	c9                   	leave  
8010259c:	c3                   	ret    

8010259d <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
8010259d:	55                   	push   %ebp
8010259e:	89 e5                	mov    %esp,%ebp
801025a0:	57                   	push   %edi
801025a1:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801025a2:	8b 55 08             	mov    0x8(%ebp),%edx
801025a5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025a8:	8b 45 10             	mov    0x10(%ebp),%eax
801025ab:	89 cb                	mov    %ecx,%ebx
801025ad:	89 df                	mov    %ebx,%edi
801025af:	89 c1                	mov    %eax,%ecx
801025b1:	fc                   	cld    
801025b2:	f3 6d                	rep insl (%dx),%es:(%edi)
801025b4:	89 c8                	mov    %ecx,%eax
801025b6:	89 fb                	mov    %edi,%ebx
801025b8:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025bb:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
801025be:	90                   	nop
801025bf:	5b                   	pop    %ebx
801025c0:	5f                   	pop    %edi
801025c1:	5d                   	pop    %ebp
801025c2:	c3                   	ret    

801025c3 <outb>:

static inline void
outb(ushort port, uchar data)
{
801025c3:	55                   	push   %ebp
801025c4:	89 e5                	mov    %esp,%ebp
801025c6:	83 ec 08             	sub    $0x8,%esp
801025c9:	8b 55 08             	mov    0x8(%ebp),%edx
801025cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801025cf:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801025d3:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025d6:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801025da:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801025de:	ee                   	out    %al,(%dx)
}
801025df:	90                   	nop
801025e0:	c9                   	leave  
801025e1:	c3                   	ret    

801025e2 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801025e2:	55                   	push   %ebp
801025e3:	89 e5                	mov    %esp,%ebp
801025e5:	56                   	push   %esi
801025e6:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025e7:	8b 55 08             	mov    0x8(%ebp),%edx
801025ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025ed:	8b 45 10             	mov    0x10(%ebp),%eax
801025f0:	89 cb                	mov    %ecx,%ebx
801025f2:	89 de                	mov    %ebx,%esi
801025f4:	89 c1                	mov    %eax,%ecx
801025f6:	fc                   	cld    
801025f7:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025f9:	89 c8                	mov    %ecx,%eax
801025fb:	89 f3                	mov    %esi,%ebx
801025fd:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102600:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102603:	90                   	nop
80102604:	5b                   	pop    %ebx
80102605:	5e                   	pop    %esi
80102606:	5d                   	pop    %ebp
80102607:	c3                   	ret    

80102608 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
80102608:	55                   	push   %ebp
80102609:	89 e5                	mov    %esp,%ebp
8010260b:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
8010260e:	90                   	nop
8010260f:	68 f7 01 00 00       	push   $0x1f7
80102614:	e8 67 ff ff ff       	call   80102580 <inb>
80102619:	83 c4 04             	add    $0x4,%esp
8010261c:	0f b6 c0             	movzbl %al,%eax
8010261f:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102622:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102625:	25 c0 00 00 00       	and    $0xc0,%eax
8010262a:	83 f8 40             	cmp    $0x40,%eax
8010262d:	75 e0                	jne    8010260f <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010262f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102633:	74 11                	je     80102646 <idewait+0x3e>
80102635:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102638:	83 e0 21             	and    $0x21,%eax
8010263b:	85 c0                	test   %eax,%eax
8010263d:	74 07                	je     80102646 <idewait+0x3e>
    return -1;
8010263f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102644:	eb 05                	jmp    8010264b <idewait+0x43>
  return 0;
80102646:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010264b:	c9                   	leave  
8010264c:	c3                   	ret    

8010264d <ideinit>:

void
ideinit(void)
{
8010264d:	55                   	push   %ebp
8010264e:	89 e5                	mov    %esp,%ebp
80102650:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102653:	83 ec 08             	sub    $0x8,%esp
80102656:	68 b0 87 10 80       	push   $0x801087b0
8010265b:	68 00 b6 10 80       	push   $0x8010b600
80102660:	e8 55 2a 00 00       	call   801050ba <initlock>
80102665:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102668:	83 ec 0c             	sub    $0xc,%esp
8010266b:	6a 0e                	push   $0xe
8010266d:	e8 53 18 00 00       	call   80103ec5 <picenable>
80102672:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102675:	a1 00 3e 11 80       	mov    0x80113e00,%eax
8010267a:	83 e8 01             	sub    $0x1,%eax
8010267d:	83 ec 08             	sub    $0x8,%esp
80102680:	50                   	push   %eax
80102681:	6a 0e                	push   $0xe
80102683:	e8 b1 04 00 00       	call   80102b39 <ioapicenable>
80102688:	83 c4 10             	add    $0x10,%esp
  idewait(0);
8010268b:	83 ec 0c             	sub    $0xc,%esp
8010268e:	6a 00                	push   $0x0
80102690:	e8 73 ff ff ff       	call   80102608 <idewait>
80102695:	83 c4 10             	add    $0x10,%esp

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102698:	83 ec 08             	sub    $0x8,%esp
8010269b:	68 f0 00 00 00       	push   $0xf0
801026a0:	68 f6 01 00 00       	push   $0x1f6
801026a5:	e8 19 ff ff ff       	call   801025c3 <outb>
801026aa:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801026ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026b4:	eb 24                	jmp    801026da <ideinit+0x8d>
    if(inb(0x1f7) != 0){
801026b6:	83 ec 0c             	sub    $0xc,%esp
801026b9:	68 f7 01 00 00       	push   $0x1f7
801026be:	e8 bd fe ff ff       	call   80102580 <inb>
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	84 c0                	test   %al,%al
801026c8:	74 0c                	je     801026d6 <ideinit+0x89>
      havedisk1 = 1;
801026ca:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
801026d1:	00 00 00 
      break;
801026d4:	eb 0d                	jmp    801026e3 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801026d6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801026da:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801026e1:	7e d3                	jle    801026b6 <ideinit+0x69>
      break;
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026e3:	83 ec 08             	sub    $0x8,%esp
801026e6:	68 e0 00 00 00       	push   $0xe0
801026eb:	68 f6 01 00 00       	push   $0x1f6
801026f0:	e8 ce fe ff ff       	call   801025c3 <outb>
801026f5:	83 c4 10             	add    $0x10,%esp
}
801026f8:	90                   	nop
801026f9:	c9                   	leave  
801026fa:	c3                   	ret    

801026fb <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026fb:	55                   	push   %ebp
801026fc:	89 e5                	mov    %esp,%ebp
801026fe:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
80102701:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102705:	75 0d                	jne    80102714 <idestart+0x19>
    panic("idestart");
80102707:	83 ec 0c             	sub    $0xc,%esp
8010270a:	68 b4 87 10 80       	push   $0x801087b4
8010270f:	e8 8c de ff ff       	call   801005a0 <panic>
  if(b->blockno >= FSSIZE)
80102714:	8b 45 08             	mov    0x8(%ebp),%eax
80102717:	8b 40 08             	mov    0x8(%eax),%eax
8010271a:	3d e7 03 00 00       	cmp    $0x3e7,%eax
8010271f:	76 0d                	jbe    8010272e <idestart+0x33>
    panic("incorrect blockno");
80102721:	83 ec 0c             	sub    $0xc,%esp
80102724:	68 bd 87 10 80       	push   $0x801087bd
80102729:	e8 72 de ff ff       	call   801005a0 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
8010272e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102735:	8b 45 08             	mov    0x8(%ebp),%eax
80102738:	8b 50 08             	mov    0x8(%eax),%edx
8010273b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010273e:	0f af c2             	imul   %edx,%eax
80102741:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80102744:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102748:	75 07                	jne    80102751 <idestart+0x56>
8010274a:	b8 20 00 00 00       	mov    $0x20,%eax
8010274f:	eb 05                	jmp    80102756 <idestart+0x5b>
80102751:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102756:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
80102759:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
8010275d:	75 07                	jne    80102766 <idestart+0x6b>
8010275f:	b8 30 00 00 00       	mov    $0x30,%eax
80102764:	eb 05                	jmp    8010276b <idestart+0x70>
80102766:	b8 c5 00 00 00       	mov    $0xc5,%eax
8010276b:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
8010276e:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102772:	7e 0d                	jle    80102781 <idestart+0x86>
80102774:	83 ec 0c             	sub    $0xc,%esp
80102777:	68 b4 87 10 80       	push   $0x801087b4
8010277c:	e8 1f de ff ff       	call   801005a0 <panic>

  idewait(0);
80102781:	83 ec 0c             	sub    $0xc,%esp
80102784:	6a 00                	push   $0x0
80102786:	e8 7d fe ff ff       	call   80102608 <idewait>
8010278b:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
8010278e:	83 ec 08             	sub    $0x8,%esp
80102791:	6a 00                	push   $0x0
80102793:	68 f6 03 00 00       	push   $0x3f6
80102798:	e8 26 fe ff ff       	call   801025c3 <outb>
8010279d:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
801027a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027a3:	0f b6 c0             	movzbl %al,%eax
801027a6:	83 ec 08             	sub    $0x8,%esp
801027a9:	50                   	push   %eax
801027aa:	68 f2 01 00 00       	push   $0x1f2
801027af:	e8 0f fe ff ff       	call   801025c3 <outb>
801027b4:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
801027b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027ba:	0f b6 c0             	movzbl %al,%eax
801027bd:	83 ec 08             	sub    $0x8,%esp
801027c0:	50                   	push   %eax
801027c1:	68 f3 01 00 00       	push   $0x1f3
801027c6:	e8 f8 fd ff ff       	call   801025c3 <outb>
801027cb:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
801027ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027d1:	c1 f8 08             	sar    $0x8,%eax
801027d4:	0f b6 c0             	movzbl %al,%eax
801027d7:	83 ec 08             	sub    $0x8,%esp
801027da:	50                   	push   %eax
801027db:	68 f4 01 00 00       	push   $0x1f4
801027e0:	e8 de fd ff ff       	call   801025c3 <outb>
801027e5:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801027e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027eb:	c1 f8 10             	sar    $0x10,%eax
801027ee:	0f b6 c0             	movzbl %al,%eax
801027f1:	83 ec 08             	sub    $0x8,%esp
801027f4:	50                   	push   %eax
801027f5:	68 f5 01 00 00       	push   $0x1f5
801027fa:	e8 c4 fd ff ff       	call   801025c3 <outb>
801027ff:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102802:	8b 45 08             	mov    0x8(%ebp),%eax
80102805:	8b 40 04             	mov    0x4(%eax),%eax
80102808:	83 e0 01             	and    $0x1,%eax
8010280b:	c1 e0 04             	shl    $0x4,%eax
8010280e:	89 c2                	mov    %eax,%edx
80102810:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102813:	c1 f8 18             	sar    $0x18,%eax
80102816:	83 e0 0f             	and    $0xf,%eax
80102819:	09 d0                	or     %edx,%eax
8010281b:	83 c8 e0             	or     $0xffffffe0,%eax
8010281e:	0f b6 c0             	movzbl %al,%eax
80102821:	83 ec 08             	sub    $0x8,%esp
80102824:	50                   	push   %eax
80102825:	68 f6 01 00 00       	push   $0x1f6
8010282a:	e8 94 fd ff ff       	call   801025c3 <outb>
8010282f:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102832:	8b 45 08             	mov    0x8(%ebp),%eax
80102835:	8b 00                	mov    (%eax),%eax
80102837:	83 e0 04             	and    $0x4,%eax
8010283a:	85 c0                	test   %eax,%eax
8010283c:	74 35                	je     80102873 <idestart+0x178>
    outb(0x1f7, write_cmd);
8010283e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102841:	0f b6 c0             	movzbl %al,%eax
80102844:	83 ec 08             	sub    $0x8,%esp
80102847:	50                   	push   %eax
80102848:	68 f7 01 00 00       	push   $0x1f7
8010284d:	e8 71 fd ff ff       	call   801025c3 <outb>
80102852:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102855:	8b 45 08             	mov    0x8(%ebp),%eax
80102858:	83 c0 5c             	add    $0x5c,%eax
8010285b:	83 ec 04             	sub    $0x4,%esp
8010285e:	68 80 00 00 00       	push   $0x80
80102863:	50                   	push   %eax
80102864:	68 f0 01 00 00       	push   $0x1f0
80102869:	e8 74 fd ff ff       	call   801025e2 <outsl>
8010286e:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102871:	eb 17                	jmp    8010288a <idestart+0x18f>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
80102873:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102876:	0f b6 c0             	movzbl %al,%eax
80102879:	83 ec 08             	sub    $0x8,%esp
8010287c:	50                   	push   %eax
8010287d:	68 f7 01 00 00       	push   $0x1f7
80102882:	e8 3c fd ff ff       	call   801025c3 <outb>
80102887:	83 c4 10             	add    $0x10,%esp
  }
}
8010288a:	90                   	nop
8010288b:	c9                   	leave  
8010288c:	c3                   	ret    

8010288d <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
8010288d:	55                   	push   %ebp
8010288e:	89 e5                	mov    %esp,%ebp
80102890:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102893:	83 ec 0c             	sub    $0xc,%esp
80102896:	68 00 b6 10 80       	push   $0x8010b600
8010289b:	e8 3c 28 00 00       	call   801050dc <acquire>
801028a0:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801028a3:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801028a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028af:	75 15                	jne    801028c6 <ideintr+0x39>
    release(&idelock);
801028b1:	83 ec 0c             	sub    $0xc,%esp
801028b4:	68 00 b6 10 80       	push   $0x8010b600
801028b9:	e8 8a 28 00 00       	call   80105148 <release>
801028be:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
801028c1:	e9 9a 00 00 00       	jmp    80102960 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801028c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c9:	8b 40 58             	mov    0x58(%eax),%eax
801028cc:	a3 34 b6 10 80       	mov    %eax,0x8010b634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801028d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028d4:	8b 00                	mov    (%eax),%eax
801028d6:	83 e0 04             	and    $0x4,%eax
801028d9:	85 c0                	test   %eax,%eax
801028db:	75 2d                	jne    8010290a <ideintr+0x7d>
801028dd:	83 ec 0c             	sub    $0xc,%esp
801028e0:	6a 01                	push   $0x1
801028e2:	e8 21 fd ff ff       	call   80102608 <idewait>
801028e7:	83 c4 10             	add    $0x10,%esp
801028ea:	85 c0                	test   %eax,%eax
801028ec:	78 1c                	js     8010290a <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
801028ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028f1:	83 c0 5c             	add    $0x5c,%eax
801028f4:	83 ec 04             	sub    $0x4,%esp
801028f7:	68 80 00 00 00       	push   $0x80
801028fc:	50                   	push   %eax
801028fd:	68 f0 01 00 00       	push   $0x1f0
80102902:	e8 96 fc ff ff       	call   8010259d <insl>
80102907:	83 c4 10             	add    $0x10,%esp

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010290a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010290d:	8b 00                	mov    (%eax),%eax
8010290f:	83 c8 02             	or     $0x2,%eax
80102912:	89 c2                	mov    %eax,%edx
80102914:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102917:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102919:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010291c:	8b 00                	mov    (%eax),%eax
8010291e:	83 e0 fb             	and    $0xfffffffb,%eax
80102921:	89 c2                	mov    %eax,%edx
80102923:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102926:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102928:	83 ec 0c             	sub    $0xc,%esp
8010292b:	ff 75 f4             	pushl  -0xc(%ebp)
8010292e:	e8 75 24 00 00       	call   80104da8 <wakeup>
80102933:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102936:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010293b:	85 c0                	test   %eax,%eax
8010293d:	74 11                	je     80102950 <ideintr+0xc3>
    idestart(idequeue);
8010293f:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102944:	83 ec 0c             	sub    $0xc,%esp
80102947:	50                   	push   %eax
80102948:	e8 ae fd ff ff       	call   801026fb <idestart>
8010294d:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102950:	83 ec 0c             	sub    $0xc,%esp
80102953:	68 00 b6 10 80       	push   $0x8010b600
80102958:	e8 eb 27 00 00       	call   80105148 <release>
8010295d:	83 c4 10             	add    $0x10,%esp
}
80102960:	c9                   	leave  
80102961:	c3                   	ret    

80102962 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102962:	55                   	push   %ebp
80102963:	89 e5                	mov    %esp,%ebp
80102965:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102968:	8b 45 08             	mov    0x8(%ebp),%eax
8010296b:	83 c0 0c             	add    $0xc,%eax
8010296e:	83 ec 0c             	sub    $0xc,%esp
80102971:	50                   	push   %eax
80102972:	e8 d4 26 00 00       	call   8010504b <holdingsleep>
80102977:	83 c4 10             	add    $0x10,%esp
8010297a:	85 c0                	test   %eax,%eax
8010297c:	75 0d                	jne    8010298b <iderw+0x29>
    panic("iderw: buf not locked");
8010297e:	83 ec 0c             	sub    $0xc,%esp
80102981:	68 cf 87 10 80       	push   $0x801087cf
80102986:	e8 15 dc ff ff       	call   801005a0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010298b:	8b 45 08             	mov    0x8(%ebp),%eax
8010298e:	8b 00                	mov    (%eax),%eax
80102990:	83 e0 06             	and    $0x6,%eax
80102993:	83 f8 02             	cmp    $0x2,%eax
80102996:	75 0d                	jne    801029a5 <iderw+0x43>
    panic("iderw: nothing to do");
80102998:	83 ec 0c             	sub    $0xc,%esp
8010299b:	68 e5 87 10 80       	push   $0x801087e5
801029a0:	e8 fb db ff ff       	call   801005a0 <panic>
  if(b->dev != 0 && !havedisk1)
801029a5:	8b 45 08             	mov    0x8(%ebp),%eax
801029a8:	8b 40 04             	mov    0x4(%eax),%eax
801029ab:	85 c0                	test   %eax,%eax
801029ad:	74 16                	je     801029c5 <iderw+0x63>
801029af:	a1 38 b6 10 80       	mov    0x8010b638,%eax
801029b4:	85 c0                	test   %eax,%eax
801029b6:	75 0d                	jne    801029c5 <iderw+0x63>
    panic("iderw: ide disk 1 not present");
801029b8:	83 ec 0c             	sub    $0xc,%esp
801029bb:	68 fa 87 10 80       	push   $0x801087fa
801029c0:	e8 db db ff ff       	call   801005a0 <panic>

  acquire(&idelock);  //DOC:acquire-lock
801029c5:	83 ec 0c             	sub    $0xc,%esp
801029c8:	68 00 b6 10 80       	push   $0x8010b600
801029cd:	e8 0a 27 00 00       	call   801050dc <acquire>
801029d2:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801029d5:	8b 45 08             	mov    0x8(%ebp),%eax
801029d8:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029df:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
801029e6:	eb 0b                	jmp    801029f3 <iderw+0x91>
801029e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029eb:	8b 00                	mov    (%eax),%eax
801029ed:	83 c0 58             	add    $0x58,%eax
801029f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801029f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029f6:	8b 00                	mov    (%eax),%eax
801029f8:	85 c0                	test   %eax,%eax
801029fa:	75 ec                	jne    801029e8 <iderw+0x86>
    ;
  *pp = b;
801029fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ff:	8b 55 08             	mov    0x8(%ebp),%edx
80102a02:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80102a04:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102a09:	3b 45 08             	cmp    0x8(%ebp),%eax
80102a0c:	75 23                	jne    80102a31 <iderw+0xcf>
    idestart(b);
80102a0e:	83 ec 0c             	sub    $0xc,%esp
80102a11:	ff 75 08             	pushl  0x8(%ebp)
80102a14:	e8 e2 fc ff ff       	call   801026fb <idestart>
80102a19:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a1c:	eb 13                	jmp    80102a31 <iderw+0xcf>
    sleep(b, &idelock);
80102a1e:	83 ec 08             	sub    $0x8,%esp
80102a21:	68 00 b6 10 80       	push   $0x8010b600
80102a26:	ff 75 08             	pushl  0x8(%ebp)
80102a29:	e8 8f 22 00 00       	call   80104cbd <sleep>
80102a2e:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a31:	8b 45 08             	mov    0x8(%ebp),%eax
80102a34:	8b 00                	mov    (%eax),%eax
80102a36:	83 e0 06             	and    $0x6,%eax
80102a39:	83 f8 02             	cmp    $0x2,%eax
80102a3c:	75 e0                	jne    80102a1e <iderw+0xbc>
    sleep(b, &idelock);
  }

  release(&idelock);
80102a3e:	83 ec 0c             	sub    $0xc,%esp
80102a41:	68 00 b6 10 80       	push   $0x8010b600
80102a46:	e8 fd 26 00 00       	call   80105148 <release>
80102a4b:	83 c4 10             	add    $0x10,%esp
}
80102a4e:	90                   	nop
80102a4f:	c9                   	leave  
80102a50:	c3                   	ret    

80102a51 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102a51:	55                   	push   %ebp
80102a52:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a54:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102a59:	8b 55 08             	mov    0x8(%ebp),%edx
80102a5c:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a5e:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102a63:	8b 40 10             	mov    0x10(%eax),%eax
}
80102a66:	5d                   	pop    %ebp
80102a67:	c3                   	ret    

80102a68 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102a68:	55                   	push   %ebp
80102a69:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a6b:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102a70:	8b 55 08             	mov    0x8(%ebp),%edx
80102a73:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102a75:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102a7a:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a7d:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a80:	90                   	nop
80102a81:	5d                   	pop    %ebp
80102a82:	c3                   	ret    

80102a83 <ioapicinit>:

void
ioapicinit(void)
{
80102a83:	55                   	push   %ebp
80102a84:	89 e5                	mov    %esp,%ebp
80102a86:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102a89:	a1 04 38 11 80       	mov    0x80113804,%eax
80102a8e:	85 c0                	test   %eax,%eax
80102a90:	0f 84 a0 00 00 00    	je     80102b36 <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102a96:	c7 05 d4 36 11 80 00 	movl   $0xfec00000,0x801136d4
80102a9d:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102aa0:	6a 01                	push   $0x1
80102aa2:	e8 aa ff ff ff       	call   80102a51 <ioapicread>
80102aa7:	83 c4 04             	add    $0x4,%esp
80102aaa:	c1 e8 10             	shr    $0x10,%eax
80102aad:	25 ff 00 00 00       	and    $0xff,%eax
80102ab2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102ab5:	6a 00                	push   $0x0
80102ab7:	e8 95 ff ff ff       	call   80102a51 <ioapicread>
80102abc:	83 c4 04             	add    $0x4,%esp
80102abf:	c1 e8 18             	shr    $0x18,%eax
80102ac2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102ac5:	0f b6 05 00 38 11 80 	movzbl 0x80113800,%eax
80102acc:	0f b6 c0             	movzbl %al,%eax
80102acf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102ad2:	74 10                	je     80102ae4 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ad4:	83 ec 0c             	sub    $0xc,%esp
80102ad7:	68 18 88 10 80       	push   $0x80108818
80102adc:	e8 1f d9 ff ff       	call   80100400 <cprintf>
80102ae1:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102ae4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102aeb:	eb 3f                	jmp    80102b2c <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102af0:	83 c0 20             	add    $0x20,%eax
80102af3:	0d 00 00 01 00       	or     $0x10000,%eax
80102af8:	89 c2                	mov    %eax,%edx
80102afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102afd:	83 c0 08             	add    $0x8,%eax
80102b00:	01 c0                	add    %eax,%eax
80102b02:	83 ec 08             	sub    $0x8,%esp
80102b05:	52                   	push   %edx
80102b06:	50                   	push   %eax
80102b07:	e8 5c ff ff ff       	call   80102a68 <ioapicwrite>
80102b0c:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b12:	83 c0 08             	add    $0x8,%eax
80102b15:	01 c0                	add    %eax,%eax
80102b17:	83 c0 01             	add    $0x1,%eax
80102b1a:	83 ec 08             	sub    $0x8,%esp
80102b1d:	6a 00                	push   $0x0
80102b1f:	50                   	push   %eax
80102b20:	e8 43 ff ff ff       	call   80102a68 <ioapicwrite>
80102b25:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102b28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b2f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102b32:	7e b9                	jle    80102aed <ioapicinit+0x6a>
80102b34:	eb 01                	jmp    80102b37 <ioapicinit+0xb4>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102b36:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102b37:	c9                   	leave  
80102b38:	c3                   	ret    

80102b39 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102b39:	55                   	push   %ebp
80102b3a:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102b3c:	a1 04 38 11 80       	mov    0x80113804,%eax
80102b41:	85 c0                	test   %eax,%eax
80102b43:	74 39                	je     80102b7e <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102b45:	8b 45 08             	mov    0x8(%ebp),%eax
80102b48:	83 c0 20             	add    $0x20,%eax
80102b4b:	89 c2                	mov    %eax,%edx
80102b4d:	8b 45 08             	mov    0x8(%ebp),%eax
80102b50:	83 c0 08             	add    $0x8,%eax
80102b53:	01 c0                	add    %eax,%eax
80102b55:	52                   	push   %edx
80102b56:	50                   	push   %eax
80102b57:	e8 0c ff ff ff       	call   80102a68 <ioapicwrite>
80102b5c:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b5f:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b62:	c1 e0 18             	shl    $0x18,%eax
80102b65:	89 c2                	mov    %eax,%edx
80102b67:	8b 45 08             	mov    0x8(%ebp),%eax
80102b6a:	83 c0 08             	add    $0x8,%eax
80102b6d:	01 c0                	add    %eax,%eax
80102b6f:	83 c0 01             	add    $0x1,%eax
80102b72:	52                   	push   %edx
80102b73:	50                   	push   %eax
80102b74:	e8 ef fe ff ff       	call   80102a68 <ioapicwrite>
80102b79:	83 c4 08             	add    $0x8,%esp
80102b7c:	eb 01                	jmp    80102b7f <ioapicenable+0x46>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102b7e:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102b7f:	c9                   	leave  
80102b80:	c3                   	ret    

80102b81 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102b81:	55                   	push   %ebp
80102b82:	89 e5                	mov    %esp,%ebp
80102b84:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102b87:	83 ec 08             	sub    $0x8,%esp
80102b8a:	68 4a 88 10 80       	push   $0x8010884a
80102b8f:	68 e0 36 11 80       	push   $0x801136e0
80102b94:	e8 21 25 00 00       	call   801050ba <initlock>
80102b99:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b9c:	c7 05 14 37 11 80 00 	movl   $0x0,0x80113714
80102ba3:	00 00 00 
  freerange(vstart, vend);
80102ba6:	83 ec 08             	sub    $0x8,%esp
80102ba9:	ff 75 0c             	pushl  0xc(%ebp)
80102bac:	ff 75 08             	pushl  0x8(%ebp)
80102baf:	e8 2a 00 00 00       	call   80102bde <freerange>
80102bb4:	83 c4 10             	add    $0x10,%esp
}
80102bb7:	90                   	nop
80102bb8:	c9                   	leave  
80102bb9:	c3                   	ret    

80102bba <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102bba:	55                   	push   %ebp
80102bbb:	89 e5                	mov    %esp,%ebp
80102bbd:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102bc0:	83 ec 08             	sub    $0x8,%esp
80102bc3:	ff 75 0c             	pushl  0xc(%ebp)
80102bc6:	ff 75 08             	pushl  0x8(%ebp)
80102bc9:	e8 10 00 00 00       	call   80102bde <freerange>
80102bce:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102bd1:	c7 05 14 37 11 80 01 	movl   $0x1,0x80113714
80102bd8:	00 00 00 
}
80102bdb:	90                   	nop
80102bdc:	c9                   	leave  
80102bdd:	c3                   	ret    

80102bde <freerange>:

void
freerange(void *vstart, void *vend)
{
80102bde:	55                   	push   %ebp
80102bdf:	89 e5                	mov    %esp,%ebp
80102be1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102be4:	8b 45 08             	mov    0x8(%ebp),%eax
80102be7:	05 ff 0f 00 00       	add    $0xfff,%eax
80102bec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102bf1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bf4:	eb 15                	jmp    80102c0b <freerange+0x2d>
    kfree(p);
80102bf6:	83 ec 0c             	sub    $0xc,%esp
80102bf9:	ff 75 f4             	pushl  -0xc(%ebp)
80102bfc:	e8 1a 00 00 00       	call   80102c1b <kfree>
80102c01:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c04:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102c0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c0e:	05 00 10 00 00       	add    $0x1000,%eax
80102c13:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102c16:	76 de                	jbe    80102bf6 <freerange+0x18>
    kfree(p);
}
80102c18:	90                   	nop
80102c19:	c9                   	leave  
80102c1a:	c3                   	ret    

80102c1b <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102c1b:	55                   	push   %ebp
80102c1c:	89 e5                	mov    %esp,%ebp
80102c1e:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102c21:	8b 45 08             	mov    0x8(%ebp),%eax
80102c24:	25 ff 0f 00 00       	and    $0xfff,%eax
80102c29:	85 c0                	test   %eax,%eax
80102c2b:	75 18                	jne    80102c45 <kfree+0x2a>
80102c2d:	81 7d 08 a8 65 11 80 	cmpl   $0x801165a8,0x8(%ebp)
80102c34:	72 0f                	jb     80102c45 <kfree+0x2a>
80102c36:	8b 45 08             	mov    0x8(%ebp),%eax
80102c39:	05 00 00 00 80       	add    $0x80000000,%eax
80102c3e:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c43:	76 0d                	jbe    80102c52 <kfree+0x37>
    panic("kfree");
80102c45:	83 ec 0c             	sub    $0xc,%esp
80102c48:	68 4f 88 10 80       	push   $0x8010884f
80102c4d:	e8 4e d9 ff ff       	call   801005a0 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c52:	83 ec 04             	sub    $0x4,%esp
80102c55:	68 00 10 00 00       	push   $0x1000
80102c5a:	6a 01                	push   $0x1
80102c5c:	ff 75 08             	pushl  0x8(%ebp)
80102c5f:	e8 f2 26 00 00       	call   80105356 <memset>
80102c64:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102c67:	a1 14 37 11 80       	mov    0x80113714,%eax
80102c6c:	85 c0                	test   %eax,%eax
80102c6e:	74 10                	je     80102c80 <kfree+0x65>
    acquire(&kmem.lock);
80102c70:	83 ec 0c             	sub    $0xc,%esp
80102c73:	68 e0 36 11 80       	push   $0x801136e0
80102c78:	e8 5f 24 00 00       	call   801050dc <acquire>
80102c7d:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102c80:	8b 45 08             	mov    0x8(%ebp),%eax
80102c83:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102c86:	8b 15 18 37 11 80    	mov    0x80113718,%edx
80102c8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c8f:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102c91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c94:	a3 18 37 11 80       	mov    %eax,0x80113718
  if(kmem.use_lock)
80102c99:	a1 14 37 11 80       	mov    0x80113714,%eax
80102c9e:	85 c0                	test   %eax,%eax
80102ca0:	74 10                	je     80102cb2 <kfree+0x97>
    release(&kmem.lock);
80102ca2:	83 ec 0c             	sub    $0xc,%esp
80102ca5:	68 e0 36 11 80       	push   $0x801136e0
80102caa:	e8 99 24 00 00       	call   80105148 <release>
80102caf:	83 c4 10             	add    $0x10,%esp
}
80102cb2:	90                   	nop
80102cb3:	c9                   	leave  
80102cb4:	c3                   	ret    

80102cb5 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102cb5:	55                   	push   %ebp
80102cb6:	89 e5                	mov    %esp,%ebp
80102cb8:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102cbb:	a1 14 37 11 80       	mov    0x80113714,%eax
80102cc0:	85 c0                	test   %eax,%eax
80102cc2:	74 10                	je     80102cd4 <kalloc+0x1f>
    acquire(&kmem.lock);
80102cc4:	83 ec 0c             	sub    $0xc,%esp
80102cc7:	68 e0 36 11 80       	push   $0x801136e0
80102ccc:	e8 0b 24 00 00       	call   801050dc <acquire>
80102cd1:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102cd4:	a1 18 37 11 80       	mov    0x80113718,%eax
80102cd9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102cdc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102ce0:	74 0a                	je     80102cec <kalloc+0x37>
    kmem.freelist = r->next;
80102ce2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ce5:	8b 00                	mov    (%eax),%eax
80102ce7:	a3 18 37 11 80       	mov    %eax,0x80113718
  if(kmem.use_lock)
80102cec:	a1 14 37 11 80       	mov    0x80113714,%eax
80102cf1:	85 c0                	test   %eax,%eax
80102cf3:	74 10                	je     80102d05 <kalloc+0x50>
    release(&kmem.lock);
80102cf5:	83 ec 0c             	sub    $0xc,%esp
80102cf8:	68 e0 36 11 80       	push   $0x801136e0
80102cfd:	e8 46 24 00 00       	call   80105148 <release>
80102d02:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102d05:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102d08:	c9                   	leave  
80102d09:	c3                   	ret    

80102d0a <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102d0a:	55                   	push   %ebp
80102d0b:	89 e5                	mov    %esp,%ebp
80102d0d:	83 ec 14             	sub    $0x14,%esp
80102d10:	8b 45 08             	mov    0x8(%ebp),%eax
80102d13:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d17:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102d1b:	89 c2                	mov    %eax,%edx
80102d1d:	ec                   	in     (%dx),%al
80102d1e:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d21:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102d25:	c9                   	leave  
80102d26:	c3                   	ret    

80102d27 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102d27:	55                   	push   %ebp
80102d28:	89 e5                	mov    %esp,%ebp
80102d2a:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102d2d:	6a 64                	push   $0x64
80102d2f:	e8 d6 ff ff ff       	call   80102d0a <inb>
80102d34:	83 c4 04             	add    $0x4,%esp
80102d37:	0f b6 c0             	movzbl %al,%eax
80102d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d40:	83 e0 01             	and    $0x1,%eax
80102d43:	85 c0                	test   %eax,%eax
80102d45:	75 0a                	jne    80102d51 <kbdgetc+0x2a>
    return -1;
80102d47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d4c:	e9 23 01 00 00       	jmp    80102e74 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102d51:	6a 60                	push   $0x60
80102d53:	e8 b2 ff ff ff       	call   80102d0a <inb>
80102d58:	83 c4 04             	add    $0x4,%esp
80102d5b:	0f b6 c0             	movzbl %al,%eax
80102d5e:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102d61:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102d68:	75 17                	jne    80102d81 <kbdgetc+0x5a>
    shift |= E0ESC;
80102d6a:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d6f:	83 c8 40             	or     $0x40,%eax
80102d72:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102d77:	b8 00 00 00 00       	mov    $0x0,%eax
80102d7c:	e9 f3 00 00 00       	jmp    80102e74 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102d81:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d84:	25 80 00 00 00       	and    $0x80,%eax
80102d89:	85 c0                	test   %eax,%eax
80102d8b:	74 45                	je     80102dd2 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102d8d:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d92:	83 e0 40             	and    $0x40,%eax
80102d95:	85 c0                	test   %eax,%eax
80102d97:	75 08                	jne    80102da1 <kbdgetc+0x7a>
80102d99:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d9c:	83 e0 7f             	and    $0x7f,%eax
80102d9f:	eb 03                	jmp    80102da4 <kbdgetc+0x7d>
80102da1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102da4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102da7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102daa:	05 20 90 10 80       	add    $0x80109020,%eax
80102daf:	0f b6 00             	movzbl (%eax),%eax
80102db2:	83 c8 40             	or     $0x40,%eax
80102db5:	0f b6 c0             	movzbl %al,%eax
80102db8:	f7 d0                	not    %eax
80102dba:	89 c2                	mov    %eax,%edx
80102dbc:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dc1:	21 d0                	and    %edx,%eax
80102dc3:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
    return 0;
80102dc8:	b8 00 00 00 00       	mov    $0x0,%eax
80102dcd:	e9 a2 00 00 00       	jmp    80102e74 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102dd2:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dd7:	83 e0 40             	and    $0x40,%eax
80102dda:	85 c0                	test   %eax,%eax
80102ddc:	74 14                	je     80102df2 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102dde:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102de5:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102dea:	83 e0 bf             	and    $0xffffffbf,%eax
80102ded:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  }

  shift |= shiftcode[data];
80102df2:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102df5:	05 20 90 10 80       	add    $0x80109020,%eax
80102dfa:	0f b6 00             	movzbl (%eax),%eax
80102dfd:	0f b6 d0             	movzbl %al,%edx
80102e00:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e05:	09 d0                	or     %edx,%eax
80102e07:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  shift ^= togglecode[data];
80102e0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e0f:	05 20 91 10 80       	add    $0x80109120,%eax
80102e14:	0f b6 00             	movzbl (%eax),%eax
80102e17:	0f b6 d0             	movzbl %al,%edx
80102e1a:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e1f:	31 d0                	xor    %edx,%eax
80102e21:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102e26:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e2b:	83 e0 03             	and    $0x3,%eax
80102e2e:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102e35:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e38:	01 d0                	add    %edx,%eax
80102e3a:	0f b6 00             	movzbl (%eax),%eax
80102e3d:	0f b6 c0             	movzbl %al,%eax
80102e40:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102e43:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102e48:	83 e0 08             	and    $0x8,%eax
80102e4b:	85 c0                	test   %eax,%eax
80102e4d:	74 22                	je     80102e71 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102e4f:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102e53:	76 0c                	jbe    80102e61 <kbdgetc+0x13a>
80102e55:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102e59:	77 06                	ja     80102e61 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102e5b:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102e5f:	eb 10                	jmp    80102e71 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102e61:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102e65:	76 0a                	jbe    80102e71 <kbdgetc+0x14a>
80102e67:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e6b:	77 04                	ja     80102e71 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102e6d:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102e71:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102e74:	c9                   	leave  
80102e75:	c3                   	ret    

80102e76 <kbdintr>:

void
kbdintr(void)
{
80102e76:	55                   	push   %ebp
80102e77:	89 e5                	mov    %esp,%ebp
80102e79:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102e7c:	83 ec 0c             	sub    $0xc,%esp
80102e7f:	68 27 2d 10 80       	push   $0x80102d27
80102e84:	e8 aa d9 ff ff       	call   80100833 <consoleintr>
80102e89:	83 c4 10             	add    $0x10,%esp
}
80102e8c:	90                   	nop
80102e8d:	c9                   	leave  
80102e8e:	c3                   	ret    

80102e8f <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102e8f:	55                   	push   %ebp
80102e90:	89 e5                	mov    %esp,%ebp
80102e92:	83 ec 14             	sub    $0x14,%esp
80102e95:	8b 45 08             	mov    0x8(%ebp),%eax
80102e98:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e9c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102ea0:	89 c2                	mov    %eax,%edx
80102ea2:	ec                   	in     (%dx),%al
80102ea3:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102ea6:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102eaa:	c9                   	leave  
80102eab:	c3                   	ret    

80102eac <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102eac:	55                   	push   %ebp
80102ead:	89 e5                	mov    %esp,%ebp
80102eaf:	83 ec 08             	sub    $0x8,%esp
80102eb2:	8b 55 08             	mov    0x8(%ebp),%edx
80102eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
80102eb8:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102ebc:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ebf:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102ec3:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102ec7:	ee                   	out    %al,(%dx)
}
80102ec8:	90                   	nop
80102ec9:	c9                   	leave  
80102eca:	c3                   	ret    

80102ecb <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102ecb:	55                   	push   %ebp
80102ecc:	89 e5                	mov    %esp,%ebp
80102ece:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102ed1:	9c                   	pushf  
80102ed2:	58                   	pop    %eax
80102ed3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102ed6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102ed9:	c9                   	leave  
80102eda:	c3                   	ret    

80102edb <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102edb:	55                   	push   %ebp
80102edc:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102ede:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102ee3:	8b 55 08             	mov    0x8(%ebp),%edx
80102ee6:	c1 e2 02             	shl    $0x2,%edx
80102ee9:	01 c2                	add    %eax,%edx
80102eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
80102eee:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102ef0:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102ef5:	83 c0 20             	add    $0x20,%eax
80102ef8:	8b 00                	mov    (%eax),%eax
}
80102efa:	90                   	nop
80102efb:	5d                   	pop    %ebp
80102efc:	c3                   	ret    

80102efd <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102efd:	55                   	push   %ebp
80102efe:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102f00:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102f05:	85 c0                	test   %eax,%eax
80102f07:	0f 84 0b 01 00 00    	je     80103018 <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102f0d:	68 3f 01 00 00       	push   $0x13f
80102f12:	6a 3c                	push   $0x3c
80102f14:	e8 c2 ff ff ff       	call   80102edb <lapicw>
80102f19:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102f1c:	6a 0b                	push   $0xb
80102f1e:	68 f8 00 00 00       	push   $0xf8
80102f23:	e8 b3 ff ff ff       	call   80102edb <lapicw>
80102f28:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102f2b:	68 20 00 02 00       	push   $0x20020
80102f30:	68 c8 00 00 00       	push   $0xc8
80102f35:	e8 a1 ff ff ff       	call   80102edb <lapicw>
80102f3a:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
80102f3d:	68 80 96 98 00       	push   $0x989680
80102f42:	68 e0 00 00 00       	push   $0xe0
80102f47:	e8 8f ff ff ff       	call   80102edb <lapicw>
80102f4c:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102f4f:	68 00 00 01 00       	push   $0x10000
80102f54:	68 d4 00 00 00       	push   $0xd4
80102f59:	e8 7d ff ff ff       	call   80102edb <lapicw>
80102f5e:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102f61:	68 00 00 01 00       	push   $0x10000
80102f66:	68 d8 00 00 00       	push   $0xd8
80102f6b:	e8 6b ff ff ff       	call   80102edb <lapicw>
80102f70:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f73:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102f78:	83 c0 30             	add    $0x30,%eax
80102f7b:	8b 00                	mov    (%eax),%eax
80102f7d:	c1 e8 10             	shr    $0x10,%eax
80102f80:	0f b6 c0             	movzbl %al,%eax
80102f83:	83 f8 03             	cmp    $0x3,%eax
80102f86:	76 12                	jbe    80102f9a <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
80102f88:	68 00 00 01 00       	push   $0x10000
80102f8d:	68 d0 00 00 00       	push   $0xd0
80102f92:	e8 44 ff ff ff       	call   80102edb <lapicw>
80102f97:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102f9a:	6a 33                	push   $0x33
80102f9c:	68 dc 00 00 00       	push   $0xdc
80102fa1:	e8 35 ff ff ff       	call   80102edb <lapicw>
80102fa6:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102fa9:	6a 00                	push   $0x0
80102fab:	68 a0 00 00 00       	push   $0xa0
80102fb0:	e8 26 ff ff ff       	call   80102edb <lapicw>
80102fb5:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102fb8:	6a 00                	push   $0x0
80102fba:	68 a0 00 00 00       	push   $0xa0
80102fbf:	e8 17 ff ff ff       	call   80102edb <lapicw>
80102fc4:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102fc7:	6a 00                	push   $0x0
80102fc9:	6a 2c                	push   $0x2c
80102fcb:	e8 0b ff ff ff       	call   80102edb <lapicw>
80102fd0:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102fd3:	6a 00                	push   $0x0
80102fd5:	68 c4 00 00 00       	push   $0xc4
80102fda:	e8 fc fe ff ff       	call   80102edb <lapicw>
80102fdf:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102fe2:	68 00 85 08 00       	push   $0x88500
80102fe7:	68 c0 00 00 00       	push   $0xc0
80102fec:	e8 ea fe ff ff       	call   80102edb <lapicw>
80102ff1:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102ff4:	90                   	nop
80102ff5:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80102ffa:	05 00 03 00 00       	add    $0x300,%eax
80102fff:	8b 00                	mov    (%eax),%eax
80103001:	25 00 10 00 00       	and    $0x1000,%eax
80103006:	85 c0                	test   %eax,%eax
80103008:	75 eb                	jne    80102ff5 <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010300a:	6a 00                	push   $0x0
8010300c:	6a 20                	push   $0x20
8010300e:	e8 c8 fe ff ff       	call   80102edb <lapicw>
80103013:	83 c4 08             	add    $0x8,%esp
80103016:	eb 01                	jmp    80103019 <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic)
    return;
80103018:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103019:	c9                   	leave  
8010301a:	c3                   	ret    

8010301b <cpunum>:

int
cpunum(void)
{
8010301b:	55                   	push   %ebp
8010301c:	89 e5                	mov    %esp,%ebp
8010301e:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103021:	e8 a5 fe ff ff       	call   80102ecb <readeflags>
80103026:	25 00 02 00 00       	and    $0x200,%eax
8010302b:	85 c0                	test   %eax,%eax
8010302d:	74 26                	je     80103055 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
8010302f:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80103034:	8d 50 01             	lea    0x1(%eax),%edx
80103037:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
8010303d:	85 c0                	test   %eax,%eax
8010303f:	75 14                	jne    80103055 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80103041:	8b 45 04             	mov    0x4(%ebp),%eax
80103044:	83 ec 08             	sub    $0x8,%esp
80103047:	50                   	push   %eax
80103048:	68 58 88 10 80       	push   $0x80108858
8010304d:	e8 ae d3 ff ff       	call   80100400 <cprintf>
80103052:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
80103055:	a1 1c 37 11 80       	mov    0x8011371c,%eax
8010305a:	85 c0                	test   %eax,%eax
8010305c:	75 07                	jne    80103065 <cpunum+0x4a>
    return 0;
8010305e:	b8 00 00 00 00       	mov    $0x0,%eax
80103063:	eb 52                	jmp    801030b7 <cpunum+0x9c>

  apicid = lapic[ID] >> 24;
80103065:	a1 1c 37 11 80       	mov    0x8011371c,%eax
8010306a:	83 c0 20             	add    $0x20,%eax
8010306d:	8b 00                	mov    (%eax),%eax
8010306f:	c1 e8 18             	shr    $0x18,%eax
80103072:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < ncpu; ++i) {
80103075:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010307c:	eb 22                	jmp    801030a0 <cpunum+0x85>
    if (cpus[i].apicid == apicid)
8010307e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103081:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103087:	05 20 38 11 80       	add    $0x80113820,%eax
8010308c:	0f b6 00             	movzbl (%eax),%eax
8010308f:	0f b6 c0             	movzbl %al,%eax
80103092:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80103095:	75 05                	jne    8010309c <cpunum+0x81>
      return i;
80103097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010309a:	eb 1b                	jmp    801030b7 <cpunum+0x9c>

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
8010309c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801030a0:	a1 00 3e 11 80       	mov    0x80113e00,%eax
801030a5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801030a8:	7c d4                	jl     8010307e <cpunum+0x63>
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
801030aa:	83 ec 0c             	sub    $0xc,%esp
801030ad:	68 84 88 10 80       	push   $0x80108884
801030b2:	e8 e9 d4 ff ff       	call   801005a0 <panic>
}
801030b7:	c9                   	leave  
801030b8:	c3                   	ret    

801030b9 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801030b9:	55                   	push   %ebp
801030ba:	89 e5                	mov    %esp,%ebp
  if(lapic)
801030bc:	a1 1c 37 11 80       	mov    0x8011371c,%eax
801030c1:	85 c0                	test   %eax,%eax
801030c3:	74 0c                	je     801030d1 <lapiceoi+0x18>
    lapicw(EOI, 0);
801030c5:	6a 00                	push   $0x0
801030c7:	6a 2c                	push   $0x2c
801030c9:	e8 0d fe ff ff       	call   80102edb <lapicw>
801030ce:	83 c4 08             	add    $0x8,%esp
}
801030d1:	90                   	nop
801030d2:	c9                   	leave  
801030d3:	c3                   	ret    

801030d4 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801030d4:	55                   	push   %ebp
801030d5:	89 e5                	mov    %esp,%ebp
}
801030d7:	90                   	nop
801030d8:	5d                   	pop    %ebp
801030d9:	c3                   	ret    

801030da <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801030da:	55                   	push   %ebp
801030db:	89 e5                	mov    %esp,%ebp
801030dd:	83 ec 14             	sub    $0x14,%esp
801030e0:	8b 45 08             	mov    0x8(%ebp),%eax
801030e3:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
801030e6:	6a 0f                	push   $0xf
801030e8:	6a 70                	push   $0x70
801030ea:	e8 bd fd ff ff       	call   80102eac <outb>
801030ef:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
801030f2:	6a 0a                	push   $0xa
801030f4:	6a 71                	push   $0x71
801030f6:	e8 b1 fd ff ff       	call   80102eac <outb>
801030fb:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
801030fe:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103105:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103108:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010310d:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103110:	83 c0 02             	add    $0x2,%eax
80103113:	8b 55 0c             	mov    0xc(%ebp),%edx
80103116:	c1 ea 04             	shr    $0x4,%edx
80103119:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010311c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103120:	c1 e0 18             	shl    $0x18,%eax
80103123:	50                   	push   %eax
80103124:	68 c4 00 00 00       	push   $0xc4
80103129:	e8 ad fd ff ff       	call   80102edb <lapicw>
8010312e:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103131:	68 00 c5 00 00       	push   $0xc500
80103136:	68 c0 00 00 00       	push   $0xc0
8010313b:	e8 9b fd ff ff       	call   80102edb <lapicw>
80103140:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103143:	68 c8 00 00 00       	push   $0xc8
80103148:	e8 87 ff ff ff       	call   801030d4 <microdelay>
8010314d:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103150:	68 00 85 00 00       	push   $0x8500
80103155:	68 c0 00 00 00       	push   $0xc0
8010315a:	e8 7c fd ff ff       	call   80102edb <lapicw>
8010315f:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103162:	6a 64                	push   $0x64
80103164:	e8 6b ff ff ff       	call   801030d4 <microdelay>
80103169:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010316c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103173:	eb 3d                	jmp    801031b2 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80103175:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103179:	c1 e0 18             	shl    $0x18,%eax
8010317c:	50                   	push   %eax
8010317d:	68 c4 00 00 00       	push   $0xc4
80103182:	e8 54 fd ff ff       	call   80102edb <lapicw>
80103187:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010318a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010318d:	c1 e8 0c             	shr    $0xc,%eax
80103190:	80 cc 06             	or     $0x6,%ah
80103193:	50                   	push   %eax
80103194:	68 c0 00 00 00       	push   $0xc0
80103199:	e8 3d fd ff ff       	call   80102edb <lapicw>
8010319e:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801031a1:	68 c8 00 00 00       	push   $0xc8
801031a6:	e8 29 ff ff ff       	call   801030d4 <microdelay>
801031ab:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801031ae:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801031b2:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801031b6:	7e bd                	jle    80103175 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801031b8:	90                   	nop
801031b9:	c9                   	leave  
801031ba:	c3                   	ret    

801031bb <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
801031bb:	55                   	push   %ebp
801031bc:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
801031be:	8b 45 08             	mov    0x8(%ebp),%eax
801031c1:	0f b6 c0             	movzbl %al,%eax
801031c4:	50                   	push   %eax
801031c5:	6a 70                	push   $0x70
801031c7:	e8 e0 fc ff ff       	call   80102eac <outb>
801031cc:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801031cf:	68 c8 00 00 00       	push   $0xc8
801031d4:	e8 fb fe ff ff       	call   801030d4 <microdelay>
801031d9:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
801031dc:	6a 71                	push   $0x71
801031de:	e8 ac fc ff ff       	call   80102e8f <inb>
801031e3:	83 c4 04             	add    $0x4,%esp
801031e6:	0f b6 c0             	movzbl %al,%eax
}
801031e9:	c9                   	leave  
801031ea:	c3                   	ret    

801031eb <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
801031eb:	55                   	push   %ebp
801031ec:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
801031ee:	6a 00                	push   $0x0
801031f0:	e8 c6 ff ff ff       	call   801031bb <cmos_read>
801031f5:	83 c4 04             	add    $0x4,%esp
801031f8:	89 c2                	mov    %eax,%edx
801031fa:	8b 45 08             	mov    0x8(%ebp),%eax
801031fd:	89 10                	mov    %edx,(%eax)
  r->minute = cmos_read(MINS);
801031ff:	6a 02                	push   $0x2
80103201:	e8 b5 ff ff ff       	call   801031bb <cmos_read>
80103206:	83 c4 04             	add    $0x4,%esp
80103209:	89 c2                	mov    %eax,%edx
8010320b:	8b 45 08             	mov    0x8(%ebp),%eax
8010320e:	89 50 04             	mov    %edx,0x4(%eax)
  r->hour   = cmos_read(HOURS);
80103211:	6a 04                	push   $0x4
80103213:	e8 a3 ff ff ff       	call   801031bb <cmos_read>
80103218:	83 c4 04             	add    $0x4,%esp
8010321b:	89 c2                	mov    %eax,%edx
8010321d:	8b 45 08             	mov    0x8(%ebp),%eax
80103220:	89 50 08             	mov    %edx,0x8(%eax)
  r->day    = cmos_read(DAY);
80103223:	6a 07                	push   $0x7
80103225:	e8 91 ff ff ff       	call   801031bb <cmos_read>
8010322a:	83 c4 04             	add    $0x4,%esp
8010322d:	89 c2                	mov    %eax,%edx
8010322f:	8b 45 08             	mov    0x8(%ebp),%eax
80103232:	89 50 0c             	mov    %edx,0xc(%eax)
  r->month  = cmos_read(MONTH);
80103235:	6a 08                	push   $0x8
80103237:	e8 7f ff ff ff       	call   801031bb <cmos_read>
8010323c:	83 c4 04             	add    $0x4,%esp
8010323f:	89 c2                	mov    %eax,%edx
80103241:	8b 45 08             	mov    0x8(%ebp),%eax
80103244:	89 50 10             	mov    %edx,0x10(%eax)
  r->year   = cmos_read(YEAR);
80103247:	6a 09                	push   $0x9
80103249:	e8 6d ff ff ff       	call   801031bb <cmos_read>
8010324e:	83 c4 04             	add    $0x4,%esp
80103251:	89 c2                	mov    %eax,%edx
80103253:	8b 45 08             	mov    0x8(%ebp),%eax
80103256:	89 50 14             	mov    %edx,0x14(%eax)
}
80103259:	90                   	nop
8010325a:	c9                   	leave  
8010325b:	c3                   	ret    

8010325c <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
8010325c:	55                   	push   %ebp
8010325d:	89 e5                	mov    %esp,%ebp
8010325f:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
80103262:	6a 0b                	push   $0xb
80103264:	e8 52 ff ff ff       	call   801031bb <cmos_read>
80103269:	83 c4 04             	add    $0x4,%esp
8010326c:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
8010326f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103272:	83 e0 04             	and    $0x4,%eax
80103275:	85 c0                	test   %eax,%eax
80103277:	0f 94 c0             	sete   %al
8010327a:	0f b6 c0             	movzbl %al,%eax
8010327d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80103280:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103283:	50                   	push   %eax
80103284:	e8 62 ff ff ff       	call   801031eb <fill_rtcdate>
80103289:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010328c:	6a 0a                	push   $0xa
8010328e:	e8 28 ff ff ff       	call   801031bb <cmos_read>
80103293:	83 c4 04             	add    $0x4,%esp
80103296:	25 80 00 00 00       	and    $0x80,%eax
8010329b:	85 c0                	test   %eax,%eax
8010329d:	75 27                	jne    801032c6 <cmostime+0x6a>
        continue;
    fill_rtcdate(&t2);
8010329f:	8d 45 c0             	lea    -0x40(%ebp),%eax
801032a2:	50                   	push   %eax
801032a3:	e8 43 ff ff ff       	call   801031eb <fill_rtcdate>
801032a8:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801032ab:	83 ec 04             	sub    $0x4,%esp
801032ae:	6a 18                	push   $0x18
801032b0:	8d 45 c0             	lea    -0x40(%ebp),%eax
801032b3:	50                   	push   %eax
801032b4:	8d 45 d8             	lea    -0x28(%ebp),%eax
801032b7:	50                   	push   %eax
801032b8:	e8 00 21 00 00       	call   801053bd <memcmp>
801032bd:	83 c4 10             	add    $0x10,%esp
801032c0:	85 c0                	test   %eax,%eax
801032c2:	74 05                	je     801032c9 <cmostime+0x6d>
801032c4:	eb ba                	jmp    80103280 <cmostime+0x24>

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
801032c6:	90                   	nop
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
801032c7:	eb b7                	jmp    80103280 <cmostime+0x24>
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
801032c9:	90                   	nop
  }

  // convert
  if(bcd) {
801032ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801032ce:	0f 84 b4 00 00 00    	je     80103388 <cmostime+0x12c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801032d4:	8b 45 d8             	mov    -0x28(%ebp),%eax
801032d7:	c1 e8 04             	shr    $0x4,%eax
801032da:	89 c2                	mov    %eax,%edx
801032dc:	89 d0                	mov    %edx,%eax
801032de:	c1 e0 02             	shl    $0x2,%eax
801032e1:	01 d0                	add    %edx,%eax
801032e3:	01 c0                	add    %eax,%eax
801032e5:	89 c2                	mov    %eax,%edx
801032e7:	8b 45 d8             	mov    -0x28(%ebp),%eax
801032ea:	83 e0 0f             	and    $0xf,%eax
801032ed:	01 d0                	add    %edx,%eax
801032ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
801032f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801032f5:	c1 e8 04             	shr    $0x4,%eax
801032f8:	89 c2                	mov    %eax,%edx
801032fa:	89 d0                	mov    %edx,%eax
801032fc:	c1 e0 02             	shl    $0x2,%eax
801032ff:	01 d0                	add    %edx,%eax
80103301:	01 c0                	add    %eax,%eax
80103303:	89 c2                	mov    %eax,%edx
80103305:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103308:	83 e0 0f             	and    $0xf,%eax
8010330b:	01 d0                	add    %edx,%eax
8010330d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103310:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103313:	c1 e8 04             	shr    $0x4,%eax
80103316:	89 c2                	mov    %eax,%edx
80103318:	89 d0                	mov    %edx,%eax
8010331a:	c1 e0 02             	shl    $0x2,%eax
8010331d:	01 d0                	add    %edx,%eax
8010331f:	01 c0                	add    %eax,%eax
80103321:	89 c2                	mov    %eax,%edx
80103323:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103326:	83 e0 0f             	and    $0xf,%eax
80103329:	01 d0                	add    %edx,%eax
8010332b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
8010332e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103331:	c1 e8 04             	shr    $0x4,%eax
80103334:	89 c2                	mov    %eax,%edx
80103336:	89 d0                	mov    %edx,%eax
80103338:	c1 e0 02             	shl    $0x2,%eax
8010333b:	01 d0                	add    %edx,%eax
8010333d:	01 c0                	add    %eax,%eax
8010333f:	89 c2                	mov    %eax,%edx
80103341:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103344:	83 e0 0f             	and    $0xf,%eax
80103347:	01 d0                	add    %edx,%eax
80103349:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
8010334c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010334f:	c1 e8 04             	shr    $0x4,%eax
80103352:	89 c2                	mov    %eax,%edx
80103354:	89 d0                	mov    %edx,%eax
80103356:	c1 e0 02             	shl    $0x2,%eax
80103359:	01 d0                	add    %edx,%eax
8010335b:	01 c0                	add    %eax,%eax
8010335d:	89 c2                	mov    %eax,%edx
8010335f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103362:	83 e0 0f             	and    $0xf,%eax
80103365:	01 d0                	add    %edx,%eax
80103367:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
8010336a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010336d:	c1 e8 04             	shr    $0x4,%eax
80103370:	89 c2                	mov    %eax,%edx
80103372:	89 d0                	mov    %edx,%eax
80103374:	c1 e0 02             	shl    $0x2,%eax
80103377:	01 d0                	add    %edx,%eax
80103379:	01 c0                	add    %eax,%eax
8010337b:	89 c2                	mov    %eax,%edx
8010337d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103380:	83 e0 0f             	and    $0xf,%eax
80103383:	01 d0                	add    %edx,%eax
80103385:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
80103388:	8b 45 08             	mov    0x8(%ebp),%eax
8010338b:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010338e:	89 10                	mov    %edx,(%eax)
80103390:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103393:	89 50 04             	mov    %edx,0x4(%eax)
80103396:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103399:	89 50 08             	mov    %edx,0x8(%eax)
8010339c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010339f:	89 50 0c             	mov    %edx,0xc(%eax)
801033a2:	8b 55 e8             	mov    -0x18(%ebp),%edx
801033a5:	89 50 10             	mov    %edx,0x10(%eax)
801033a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801033ab:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
801033ae:	8b 45 08             	mov    0x8(%ebp),%eax
801033b1:	8b 40 14             	mov    0x14(%eax),%eax
801033b4:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801033ba:	8b 45 08             	mov    0x8(%ebp),%eax
801033bd:	89 50 14             	mov    %edx,0x14(%eax)
}
801033c0:	90                   	nop
801033c1:	c9                   	leave  
801033c2:	c3                   	ret    

801033c3 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801033c3:	55                   	push   %ebp
801033c4:	89 e5                	mov    %esp,%ebp
801033c6:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801033c9:	83 ec 08             	sub    $0x8,%esp
801033cc:	68 94 88 10 80       	push   $0x80108894
801033d1:	68 20 37 11 80       	push   $0x80113720
801033d6:	e8 df 1c 00 00       	call   801050ba <initlock>
801033db:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
801033de:	83 ec 08             	sub    $0x8,%esp
801033e1:	8d 45 dc             	lea    -0x24(%ebp),%eax
801033e4:	50                   	push   %eax
801033e5:	ff 75 08             	pushl  0x8(%ebp)
801033e8:	e8 0a e0 ff ff       	call   801013f7 <readsb>
801033ed:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
801033f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033f3:	a3 54 37 11 80       	mov    %eax,0x80113754
  log.size = sb.nlog;
801033f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801033fb:	a3 58 37 11 80       	mov    %eax,0x80113758
  log.dev = dev;
80103400:	8b 45 08             	mov    0x8(%ebp),%eax
80103403:	a3 64 37 11 80       	mov    %eax,0x80113764
  recover_from_log();
80103408:	e8 b2 01 00 00       	call   801035bf <recover_from_log>
}
8010340d:	90                   	nop
8010340e:	c9                   	leave  
8010340f:	c3                   	ret    

80103410 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103416:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010341d:	e9 95 00 00 00       	jmp    801034b7 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103422:	8b 15 54 37 11 80    	mov    0x80113754,%edx
80103428:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010342b:	01 d0                	add    %edx,%eax
8010342d:	83 c0 01             	add    $0x1,%eax
80103430:	89 c2                	mov    %eax,%edx
80103432:	a1 64 37 11 80       	mov    0x80113764,%eax
80103437:	83 ec 08             	sub    $0x8,%esp
8010343a:	52                   	push   %edx
8010343b:	50                   	push   %eax
8010343c:	e8 8d cd ff ff       	call   801001ce <bread>
80103441:	83 c4 10             	add    $0x10,%esp
80103444:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103447:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010344a:	83 c0 10             	add    $0x10,%eax
8010344d:	8b 04 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%eax
80103454:	89 c2                	mov    %eax,%edx
80103456:	a1 64 37 11 80       	mov    0x80113764,%eax
8010345b:	83 ec 08             	sub    $0x8,%esp
8010345e:	52                   	push   %edx
8010345f:	50                   	push   %eax
80103460:	e8 69 cd ff ff       	call   801001ce <bread>
80103465:	83 c4 10             	add    $0x10,%esp
80103468:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
8010346b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010346e:	8d 50 5c             	lea    0x5c(%eax),%edx
80103471:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103474:	83 c0 5c             	add    $0x5c,%eax
80103477:	83 ec 04             	sub    $0x4,%esp
8010347a:	68 00 02 00 00       	push   $0x200
8010347f:	52                   	push   %edx
80103480:	50                   	push   %eax
80103481:	e8 8f 1f 00 00       	call   80105415 <memmove>
80103486:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103489:	83 ec 0c             	sub    $0xc,%esp
8010348c:	ff 75 ec             	pushl  -0x14(%ebp)
8010348f:	e8 73 cd ff ff       	call   80100207 <bwrite>
80103494:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
80103497:	83 ec 0c             	sub    $0xc,%esp
8010349a:	ff 75 f0             	pushl  -0x10(%ebp)
8010349d:	e8 ae cd ff ff       	call   80100250 <brelse>
801034a2:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801034a5:	83 ec 0c             	sub    $0xc,%esp
801034a8:	ff 75 ec             	pushl  -0x14(%ebp)
801034ab:	e8 a0 cd ff ff       	call   80100250 <brelse>
801034b0:	83 c4 10             	add    $0x10,%esp
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801034b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034b7:	a1 68 37 11 80       	mov    0x80113768,%eax
801034bc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034bf:	0f 8f 5d ff ff ff    	jg     80103422 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
801034c5:	90                   	nop
801034c6:	c9                   	leave  
801034c7:	c3                   	ret    

801034c8 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801034c8:	55                   	push   %ebp
801034c9:	89 e5                	mov    %esp,%ebp
801034cb:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801034ce:	a1 54 37 11 80       	mov    0x80113754,%eax
801034d3:	89 c2                	mov    %eax,%edx
801034d5:	a1 64 37 11 80       	mov    0x80113764,%eax
801034da:	83 ec 08             	sub    $0x8,%esp
801034dd:	52                   	push   %edx
801034de:	50                   	push   %eax
801034df:	e8 ea cc ff ff       	call   801001ce <bread>
801034e4:	83 c4 10             	add    $0x10,%esp
801034e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801034ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034ed:	83 c0 5c             	add    $0x5c,%eax
801034f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801034f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034f6:	8b 00                	mov    (%eax),%eax
801034f8:	a3 68 37 11 80       	mov    %eax,0x80113768
  for (i = 0; i < log.lh.n; i++) {
801034fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103504:	eb 1b                	jmp    80103521 <read_head+0x59>
    log.lh.block[i] = lh->block[i];
80103506:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103509:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010350c:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103510:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103513:	83 c2 10             	add    $0x10,%edx
80103516:	89 04 95 2c 37 11 80 	mov    %eax,-0x7feec8d4(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010351d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103521:	a1 68 37 11 80       	mov    0x80113768,%eax
80103526:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103529:	7f db                	jg     80103506 <read_head+0x3e>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
8010352b:	83 ec 0c             	sub    $0xc,%esp
8010352e:	ff 75 f0             	pushl  -0x10(%ebp)
80103531:	e8 1a cd ff ff       	call   80100250 <brelse>
80103536:	83 c4 10             	add    $0x10,%esp
}
80103539:	90                   	nop
8010353a:	c9                   	leave  
8010353b:	c3                   	ret    

8010353c <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010353c:	55                   	push   %ebp
8010353d:	89 e5                	mov    %esp,%ebp
8010353f:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103542:	a1 54 37 11 80       	mov    0x80113754,%eax
80103547:	89 c2                	mov    %eax,%edx
80103549:	a1 64 37 11 80       	mov    0x80113764,%eax
8010354e:	83 ec 08             	sub    $0x8,%esp
80103551:	52                   	push   %edx
80103552:	50                   	push   %eax
80103553:	e8 76 cc ff ff       	call   801001ce <bread>
80103558:	83 c4 10             	add    $0x10,%esp
8010355b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010355e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103561:	83 c0 5c             	add    $0x5c,%eax
80103564:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103567:	8b 15 68 37 11 80    	mov    0x80113768,%edx
8010356d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103570:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103572:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103579:	eb 1b                	jmp    80103596 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
8010357b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010357e:	83 c0 10             	add    $0x10,%eax
80103581:	8b 0c 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%ecx
80103588:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010358b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010358e:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103592:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103596:	a1 68 37 11 80       	mov    0x80113768,%eax
8010359b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010359e:	7f db                	jg     8010357b <write_head+0x3f>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801035a0:	83 ec 0c             	sub    $0xc,%esp
801035a3:	ff 75 f0             	pushl  -0x10(%ebp)
801035a6:	e8 5c cc ff ff       	call   80100207 <bwrite>
801035ab:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801035ae:	83 ec 0c             	sub    $0xc,%esp
801035b1:	ff 75 f0             	pushl  -0x10(%ebp)
801035b4:	e8 97 cc ff ff       	call   80100250 <brelse>
801035b9:	83 c4 10             	add    $0x10,%esp
}
801035bc:	90                   	nop
801035bd:	c9                   	leave  
801035be:	c3                   	ret    

801035bf <recover_from_log>:

static void
recover_from_log(void)
{
801035bf:	55                   	push   %ebp
801035c0:	89 e5                	mov    %esp,%ebp
801035c2:	83 ec 08             	sub    $0x8,%esp
  read_head();
801035c5:	e8 fe fe ff ff       	call   801034c8 <read_head>
  install_trans(); // if committed, copy from log to disk
801035ca:	e8 41 fe ff ff       	call   80103410 <install_trans>
  log.lh.n = 0;
801035cf:	c7 05 68 37 11 80 00 	movl   $0x0,0x80113768
801035d6:	00 00 00 
  write_head(); // clear the log
801035d9:	e8 5e ff ff ff       	call   8010353c <write_head>
}
801035de:	90                   	nop
801035df:	c9                   	leave  
801035e0:	c3                   	ret    

801035e1 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
801035e1:	55                   	push   %ebp
801035e2:	89 e5                	mov    %esp,%ebp
801035e4:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801035e7:	83 ec 0c             	sub    $0xc,%esp
801035ea:	68 20 37 11 80       	push   $0x80113720
801035ef:	e8 e8 1a 00 00       	call   801050dc <acquire>
801035f4:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
801035f7:	a1 60 37 11 80       	mov    0x80113760,%eax
801035fc:	85 c0                	test   %eax,%eax
801035fe:	74 17                	je     80103617 <begin_op+0x36>
      sleep(&log, &log.lock);
80103600:	83 ec 08             	sub    $0x8,%esp
80103603:	68 20 37 11 80       	push   $0x80113720
80103608:	68 20 37 11 80       	push   $0x80113720
8010360d:	e8 ab 16 00 00       	call   80104cbd <sleep>
80103612:	83 c4 10             	add    $0x10,%esp
80103615:	eb e0                	jmp    801035f7 <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103617:	8b 0d 68 37 11 80    	mov    0x80113768,%ecx
8010361d:	a1 5c 37 11 80       	mov    0x8011375c,%eax
80103622:	8d 50 01             	lea    0x1(%eax),%edx
80103625:	89 d0                	mov    %edx,%eax
80103627:	c1 e0 02             	shl    $0x2,%eax
8010362a:	01 d0                	add    %edx,%eax
8010362c:	01 c0                	add    %eax,%eax
8010362e:	01 c8                	add    %ecx,%eax
80103630:	83 f8 1e             	cmp    $0x1e,%eax
80103633:	7e 17                	jle    8010364c <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103635:	83 ec 08             	sub    $0x8,%esp
80103638:	68 20 37 11 80       	push   $0x80113720
8010363d:	68 20 37 11 80       	push   $0x80113720
80103642:	e8 76 16 00 00       	call   80104cbd <sleep>
80103647:	83 c4 10             	add    $0x10,%esp
8010364a:	eb ab                	jmp    801035f7 <begin_op+0x16>
    } else {
      log.outstanding += 1;
8010364c:	a1 5c 37 11 80       	mov    0x8011375c,%eax
80103651:	83 c0 01             	add    $0x1,%eax
80103654:	a3 5c 37 11 80       	mov    %eax,0x8011375c
      release(&log.lock);
80103659:	83 ec 0c             	sub    $0xc,%esp
8010365c:	68 20 37 11 80       	push   $0x80113720
80103661:	e8 e2 1a 00 00       	call   80105148 <release>
80103666:	83 c4 10             	add    $0x10,%esp
      break;
80103669:	90                   	nop
    }
  }
}
8010366a:	90                   	nop
8010366b:	c9                   	leave  
8010366c:	c3                   	ret    

8010366d <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
8010366d:	55                   	push   %ebp
8010366e:	89 e5                	mov    %esp,%ebp
80103670:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
80103673:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
8010367a:	83 ec 0c             	sub    $0xc,%esp
8010367d:	68 20 37 11 80       	push   $0x80113720
80103682:	e8 55 1a 00 00       	call   801050dc <acquire>
80103687:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
8010368a:	a1 5c 37 11 80       	mov    0x8011375c,%eax
8010368f:	83 e8 01             	sub    $0x1,%eax
80103692:	a3 5c 37 11 80       	mov    %eax,0x8011375c
  if(log.committing)
80103697:	a1 60 37 11 80       	mov    0x80113760,%eax
8010369c:	85 c0                	test   %eax,%eax
8010369e:	74 0d                	je     801036ad <end_op+0x40>
    panic("log.committing");
801036a0:	83 ec 0c             	sub    $0xc,%esp
801036a3:	68 98 88 10 80       	push   $0x80108898
801036a8:	e8 f3 ce ff ff       	call   801005a0 <panic>
  if(log.outstanding == 0){
801036ad:	a1 5c 37 11 80       	mov    0x8011375c,%eax
801036b2:	85 c0                	test   %eax,%eax
801036b4:	75 13                	jne    801036c9 <end_op+0x5c>
    do_commit = 1;
801036b6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
801036bd:	c7 05 60 37 11 80 01 	movl   $0x1,0x80113760
801036c4:	00 00 00 
801036c7:	eb 10                	jmp    801036d9 <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
801036c9:	83 ec 0c             	sub    $0xc,%esp
801036cc:	68 20 37 11 80       	push   $0x80113720
801036d1:	e8 d2 16 00 00       	call   80104da8 <wakeup>
801036d6:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
801036d9:	83 ec 0c             	sub    $0xc,%esp
801036dc:	68 20 37 11 80       	push   $0x80113720
801036e1:	e8 62 1a 00 00       	call   80105148 <release>
801036e6:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
801036e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801036ed:	74 3f                	je     8010372e <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
801036ef:	e8 f5 00 00 00       	call   801037e9 <commit>
    acquire(&log.lock);
801036f4:	83 ec 0c             	sub    $0xc,%esp
801036f7:	68 20 37 11 80       	push   $0x80113720
801036fc:	e8 db 19 00 00       	call   801050dc <acquire>
80103701:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103704:	c7 05 60 37 11 80 00 	movl   $0x0,0x80113760
8010370b:	00 00 00 
    wakeup(&log);
8010370e:	83 ec 0c             	sub    $0xc,%esp
80103711:	68 20 37 11 80       	push   $0x80113720
80103716:	e8 8d 16 00 00       	call   80104da8 <wakeup>
8010371b:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
8010371e:	83 ec 0c             	sub    $0xc,%esp
80103721:	68 20 37 11 80       	push   $0x80113720
80103726:	e8 1d 1a 00 00       	call   80105148 <release>
8010372b:	83 c4 10             	add    $0x10,%esp
  }
}
8010372e:	90                   	nop
8010372f:	c9                   	leave  
80103730:	c3                   	ret    

80103731 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80103731:	55                   	push   %ebp
80103732:	89 e5                	mov    %esp,%ebp
80103734:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103737:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010373e:	e9 95 00 00 00       	jmp    801037d8 <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103743:	8b 15 54 37 11 80    	mov    0x80113754,%edx
80103749:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010374c:	01 d0                	add    %edx,%eax
8010374e:	83 c0 01             	add    $0x1,%eax
80103751:	89 c2                	mov    %eax,%edx
80103753:	a1 64 37 11 80       	mov    0x80113764,%eax
80103758:	83 ec 08             	sub    $0x8,%esp
8010375b:	52                   	push   %edx
8010375c:	50                   	push   %eax
8010375d:	e8 6c ca ff ff       	call   801001ce <bread>
80103762:	83 c4 10             	add    $0x10,%esp
80103765:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103768:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010376b:	83 c0 10             	add    $0x10,%eax
8010376e:	8b 04 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%eax
80103775:	89 c2                	mov    %eax,%edx
80103777:	a1 64 37 11 80       	mov    0x80113764,%eax
8010377c:	83 ec 08             	sub    $0x8,%esp
8010377f:	52                   	push   %edx
80103780:	50                   	push   %eax
80103781:	e8 48 ca ff ff       	call   801001ce <bread>
80103786:	83 c4 10             	add    $0x10,%esp
80103789:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
8010378c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010378f:	8d 50 5c             	lea    0x5c(%eax),%edx
80103792:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103795:	83 c0 5c             	add    $0x5c,%eax
80103798:	83 ec 04             	sub    $0x4,%esp
8010379b:	68 00 02 00 00       	push   $0x200
801037a0:	52                   	push   %edx
801037a1:	50                   	push   %eax
801037a2:	e8 6e 1c 00 00       	call   80105415 <memmove>
801037a7:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
801037aa:	83 ec 0c             	sub    $0xc,%esp
801037ad:	ff 75 f0             	pushl  -0x10(%ebp)
801037b0:	e8 52 ca ff ff       	call   80100207 <bwrite>
801037b5:	83 c4 10             	add    $0x10,%esp
    brelse(from);
801037b8:	83 ec 0c             	sub    $0xc,%esp
801037bb:	ff 75 ec             	pushl  -0x14(%ebp)
801037be:	e8 8d ca ff ff       	call   80100250 <brelse>
801037c3:	83 c4 10             	add    $0x10,%esp
    brelse(to);
801037c6:	83 ec 0c             	sub    $0xc,%esp
801037c9:	ff 75 f0             	pushl  -0x10(%ebp)
801037cc:	e8 7f ca ff ff       	call   80100250 <brelse>
801037d1:	83 c4 10             	add    $0x10,%esp
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037d8:	a1 68 37 11 80       	mov    0x80113768,%eax
801037dd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037e0:	0f 8f 5d ff ff ff    	jg     80103743 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from);
    brelse(to);
  }
}
801037e6:	90                   	nop
801037e7:	c9                   	leave  
801037e8:	c3                   	ret    

801037e9 <commit>:

static void
commit()
{
801037e9:	55                   	push   %ebp
801037ea:	89 e5                	mov    %esp,%ebp
801037ec:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
801037ef:	a1 68 37 11 80       	mov    0x80113768,%eax
801037f4:	85 c0                	test   %eax,%eax
801037f6:	7e 1e                	jle    80103816 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
801037f8:	e8 34 ff ff ff       	call   80103731 <write_log>
    write_head();    // Write header to disk -- the real commit
801037fd:	e8 3a fd ff ff       	call   8010353c <write_head>
    install_trans(); // Now install writes to home locations
80103802:	e8 09 fc ff ff       	call   80103410 <install_trans>
    log.lh.n = 0;
80103807:	c7 05 68 37 11 80 00 	movl   $0x0,0x80113768
8010380e:	00 00 00 
    write_head();    // Erase the transaction from the log
80103811:	e8 26 fd ff ff       	call   8010353c <write_head>
  }
}
80103816:	90                   	nop
80103817:	c9                   	leave  
80103818:	c3                   	ret    

80103819 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103819:	55                   	push   %ebp
8010381a:	89 e5                	mov    %esp,%ebp
8010381c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010381f:	a1 68 37 11 80       	mov    0x80113768,%eax
80103824:	83 f8 1d             	cmp    $0x1d,%eax
80103827:	7f 12                	jg     8010383b <log_write+0x22>
80103829:	a1 68 37 11 80       	mov    0x80113768,%eax
8010382e:	8b 15 58 37 11 80    	mov    0x80113758,%edx
80103834:	83 ea 01             	sub    $0x1,%edx
80103837:	39 d0                	cmp    %edx,%eax
80103839:	7c 0d                	jl     80103848 <log_write+0x2f>
    panic("too big a transaction");
8010383b:	83 ec 0c             	sub    $0xc,%esp
8010383e:	68 a7 88 10 80       	push   $0x801088a7
80103843:	e8 58 cd ff ff       	call   801005a0 <panic>
  if (log.outstanding < 1)
80103848:	a1 5c 37 11 80       	mov    0x8011375c,%eax
8010384d:	85 c0                	test   %eax,%eax
8010384f:	7f 0d                	jg     8010385e <log_write+0x45>
    panic("log_write outside of trans");
80103851:	83 ec 0c             	sub    $0xc,%esp
80103854:	68 bd 88 10 80       	push   $0x801088bd
80103859:	e8 42 cd ff ff       	call   801005a0 <panic>

  acquire(&log.lock);
8010385e:	83 ec 0c             	sub    $0xc,%esp
80103861:	68 20 37 11 80       	push   $0x80113720
80103866:	e8 71 18 00 00       	call   801050dc <acquire>
8010386b:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
8010386e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103875:	eb 1d                	jmp    80103894 <log_write+0x7b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010387a:	83 c0 10             	add    $0x10,%eax
8010387d:	8b 04 85 2c 37 11 80 	mov    -0x7feec8d4(,%eax,4),%eax
80103884:	89 c2                	mov    %eax,%edx
80103886:	8b 45 08             	mov    0x8(%ebp),%eax
80103889:	8b 40 08             	mov    0x8(%eax),%eax
8010388c:	39 c2                	cmp    %eax,%edx
8010388e:	74 10                	je     801038a0 <log_write+0x87>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103890:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103894:	a1 68 37 11 80       	mov    0x80113768,%eax
80103899:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010389c:	7f d9                	jg     80103877 <log_write+0x5e>
8010389e:	eb 01                	jmp    801038a1 <log_write+0x88>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
801038a0:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
801038a1:	8b 45 08             	mov    0x8(%ebp),%eax
801038a4:	8b 40 08             	mov    0x8(%eax),%eax
801038a7:	89 c2                	mov    %eax,%edx
801038a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038ac:	83 c0 10             	add    $0x10,%eax
801038af:	89 14 85 2c 37 11 80 	mov    %edx,-0x7feec8d4(,%eax,4)
  if (i == log.lh.n)
801038b6:	a1 68 37 11 80       	mov    0x80113768,%eax
801038bb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038be:	75 0d                	jne    801038cd <log_write+0xb4>
    log.lh.n++;
801038c0:	a1 68 37 11 80       	mov    0x80113768,%eax
801038c5:	83 c0 01             	add    $0x1,%eax
801038c8:	a3 68 37 11 80       	mov    %eax,0x80113768
  b->flags |= B_DIRTY; // prevent eviction
801038cd:	8b 45 08             	mov    0x8(%ebp),%eax
801038d0:	8b 00                	mov    (%eax),%eax
801038d2:	83 c8 04             	or     $0x4,%eax
801038d5:	89 c2                	mov    %eax,%edx
801038d7:	8b 45 08             	mov    0x8(%ebp),%eax
801038da:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
801038dc:	83 ec 0c             	sub    $0xc,%esp
801038df:	68 20 37 11 80       	push   $0x80113720
801038e4:	e8 5f 18 00 00       	call   80105148 <release>
801038e9:	83 c4 10             	add    $0x10,%esp
}
801038ec:	90                   	nop
801038ed:	c9                   	leave  
801038ee:	c3                   	ret    

801038ef <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801038ef:	55                   	push   %ebp
801038f0:	89 e5                	mov    %esp,%ebp
801038f2:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801038f5:	8b 55 08             	mov    0x8(%ebp),%edx
801038f8:	8b 45 0c             	mov    0xc(%ebp),%eax
801038fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801038fe:	f0 87 02             	lock xchg %eax,(%edx)
80103901:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103904:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103907:	c9                   	leave  
80103908:	c3                   	ret    

80103909 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103909:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010390d:	83 e4 f0             	and    $0xfffffff0,%esp
80103910:	ff 71 fc             	pushl  -0x4(%ecx)
80103913:	55                   	push   %ebp
80103914:	89 e5                	mov    %esp,%ebp
80103916:	51                   	push   %ecx
80103917:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010391a:	83 ec 08             	sub    $0x8,%esp
8010391d:	68 00 00 40 80       	push   $0x80400000
80103922:	68 a8 65 11 80       	push   $0x801165a8
80103927:	e8 55 f2 ff ff       	call   80102b81 <kinit1>
8010392c:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
8010392f:	e8 48 45 00 00       	call   80107e7c <kvmalloc>
  mpinit();        // detect other processors
80103934:	e8 e4 03 00 00       	call   80103d1d <mpinit>
  lapicinit();     // interrupt controller
80103939:	e8 bf f5 ff ff       	call   80102efd <lapicinit>
  seginit();       // segment descriptors
8010393e:	e8 13 3f 00 00       	call   80107856 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80103943:	e8 d3 f6 ff ff       	call   8010301b <cpunum>
80103948:	83 ec 08             	sub    $0x8,%esp
8010394b:	50                   	push   %eax
8010394c:	68 d8 88 10 80       	push   $0x801088d8
80103951:	e8 aa ca ff ff       	call   80100400 <cprintf>
80103956:	83 c4 10             	add    $0x10,%esp
  picinit();       // another interrupt controller
80103959:	e8 94 05 00 00       	call   80103ef2 <picinit>
  ioapicinit();    // another interrupt controller
8010395e:	e8 20 f1 ff ff       	call   80102a83 <ioapicinit>
  consoleinit();   // console hardware
80103963:	e8 eb d1 ff ff       	call   80100b53 <consoleinit>
  uartinit();      // serial port
80103968:	e8 5f 32 00 00       	call   80106bcc <uartinit>
  pinit();         // process table
8010396d:	e8 7d 0a 00 00       	call   801043ef <pinit>
  tvinit();        // trap vectors
80103972:	e8 34 2e 00 00       	call   801067ab <tvinit>
  binit();         // buffer cache
80103977:	e8 b8 c6 ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010397c:	e8 67 d6 ff ff       	call   80100fe8 <fileinit>
  ideinit();       // disk
80103981:	e8 c7 ec ff ff       	call   8010264d <ideinit>
  if(!ismp)
80103986:	a1 04 38 11 80       	mov    0x80113804,%eax
8010398b:	85 c0                	test   %eax,%eax
8010398d:	75 05                	jne    80103994 <main+0x8b>
    timerinit();   // uniprocessor timer
8010398f:	e8 74 2d 00 00       	call   80106708 <timerinit>
  startothers();   // start other processors
80103994:	e8 78 00 00 00       	call   80103a11 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103999:	83 ec 08             	sub    $0x8,%esp
8010399c:	68 00 00 00 8e       	push   $0x8e000000
801039a1:	68 00 00 40 80       	push   $0x80400000
801039a6:	e8 0f f2 ff ff       	call   80102bba <kinit2>
801039ab:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801039ae:	e8 60 0b 00 00       	call   80104513 <userinit>
  mpmain();        // finish this processor's setup
801039b3:	e8 1a 00 00 00       	call   801039d2 <mpmain>

801039b8 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801039b8:	55                   	push   %ebp
801039b9:	89 e5                	mov    %esp,%ebp
801039bb:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801039be:	e8 d1 44 00 00       	call   80107e94 <switchkvm>
  seginit();
801039c3:	e8 8e 3e 00 00       	call   80107856 <seginit>
  lapicinit();
801039c8:	e8 30 f5 ff ff       	call   80102efd <lapicinit>
  mpmain();
801039cd:	e8 00 00 00 00       	call   801039d2 <mpmain>

801039d2 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801039d2:	55                   	push   %ebp
801039d3:	89 e5                	mov    %esp,%ebp
801039d5:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
801039d8:	e8 3e f6 ff ff       	call   8010301b <cpunum>
801039dd:	83 ec 08             	sub    $0x8,%esp
801039e0:	50                   	push   %eax
801039e1:	68 ef 88 10 80       	push   $0x801088ef
801039e6:	e8 15 ca ff ff       	call   80100400 <cprintf>
801039eb:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
801039ee:	e8 2e 2f 00 00       	call   80106921 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801039f3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801039f9:	05 a8 00 00 00       	add    $0xa8,%eax
801039fe:	83 ec 08             	sub    $0x8,%esp
80103a01:	6a 01                	push   $0x1
80103a03:	50                   	push   %eax
80103a04:	e8 e6 fe ff ff       	call   801038ef <xchg>
80103a09:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103a0c:	e8 cd 10 00 00       	call   80104ade <scheduler>

80103a11 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103a11:	55                   	push   %ebp
80103a12:	89 e5                	mov    %esp,%ebp
80103a14:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
80103a17:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103a1e:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103a23:	83 ec 04             	sub    $0x4,%esp
80103a26:	50                   	push   %eax
80103a27:	68 0c b5 10 80       	push   $0x8010b50c
80103a2c:	ff 75 f0             	pushl  -0x10(%ebp)
80103a2f:	e8 e1 19 00 00       	call   80105415 <memmove>
80103a34:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103a37:	c7 45 f4 20 38 11 80 	movl   $0x80113820,-0xc(%ebp)
80103a3e:	e9 84 00 00 00       	jmp    80103ac7 <startothers+0xb6>
    if(c == cpus+cpunum())  // We've started already.
80103a43:	e8 d3 f5 ff ff       	call   8010301b <cpunum>
80103a48:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a4e:	05 20 38 11 80       	add    $0x80113820,%eax
80103a53:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a56:	74 67                	je     80103abf <startothers+0xae>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103a58:	e8 58 f2 ff ff       	call   80102cb5 <kalloc>
80103a5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a63:	83 e8 04             	sub    $0x4,%eax
80103a66:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a69:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103a6f:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103a71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a74:	83 e8 08             	sub    $0x8,%eax
80103a77:	c7 00 b8 39 10 80    	movl   $0x801039b8,(%eax)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a80:	83 e8 0c             	sub    $0xc,%eax
80103a83:	ba 00 a0 10 80       	mov    $0x8010a000,%edx
80103a88:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80103a8e:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
80103a90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a93:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80103a99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a9c:	0f b6 00             	movzbl (%eax),%eax
80103a9f:	0f b6 c0             	movzbl %al,%eax
80103aa2:	83 ec 08             	sub    $0x8,%esp
80103aa5:	52                   	push   %edx
80103aa6:	50                   	push   %eax
80103aa7:	e8 2e f6 ff ff       	call   801030da <lapicstartap>
80103aac:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103aaf:	90                   	nop
80103ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ab3:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103ab9:	85 c0                	test   %eax,%eax
80103abb:	74 f3                	je     80103ab0 <startothers+0x9f>
80103abd:	eb 01                	jmp    80103ac0 <startothers+0xaf>
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103abf:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103ac0:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103ac7:	a1 00 3e 11 80       	mov    0x80113e00,%eax
80103acc:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103ad2:	05 20 38 11 80       	add    $0x80113820,%eax
80103ad7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103ada:	0f 87 63 ff ff ff    	ja     80103a43 <startothers+0x32>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103ae0:	90                   	nop
80103ae1:	c9                   	leave  
80103ae2:	c3                   	ret    

80103ae3 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103ae3:	55                   	push   %ebp
80103ae4:	89 e5                	mov    %esp,%ebp
80103ae6:	83 ec 14             	sub    $0x14,%esp
80103ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80103aec:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103af0:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103af4:	89 c2                	mov    %eax,%edx
80103af6:	ec                   	in     (%dx),%al
80103af7:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103afa:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103afe:	c9                   	leave  
80103aff:	c3                   	ret    

80103b00 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	83 ec 08             	sub    $0x8,%esp
80103b06:	8b 55 08             	mov    0x8(%ebp),%edx
80103b09:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b0c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103b10:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b13:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103b17:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103b1b:	ee                   	out    %al,(%dx)
}
80103b1c:	90                   	nop
80103b1d:	c9                   	leave  
80103b1e:	c3                   	ret    

80103b1f <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80103b1f:	55                   	push   %ebp
80103b20:	89 e5                	mov    %esp,%ebp
80103b22:	83 ec 10             	sub    $0x10,%esp
  int i, sum;

  sum = 0;
80103b25:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103b2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103b33:	eb 15                	jmp    80103b4a <sum+0x2b>
    sum += addr[i];
80103b35:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103b38:	8b 45 08             	mov    0x8(%ebp),%eax
80103b3b:	01 d0                	add    %edx,%eax
80103b3d:	0f b6 00             	movzbl (%eax),%eax
80103b40:	0f b6 c0             	movzbl %al,%eax
80103b43:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103b46:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103b4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b4d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103b50:	7c e3                	jl     80103b35 <sum+0x16>
    sum += addr[i];
  return sum;
80103b52:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103b55:	c9                   	leave  
80103b56:	c3                   	ret    

80103b57 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103b57:	55                   	push   %ebp
80103b58:	89 e5                	mov    %esp,%ebp
80103b5a:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80103b5d:	8b 45 08             	mov    0x8(%ebp),%eax
80103b60:	05 00 00 00 80       	add    $0x80000000,%eax
80103b65:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103b68:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b6e:	01 d0                	add    %edx,%eax
80103b70:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103b73:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b76:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b79:	eb 36                	jmp    80103bb1 <mpsearch1+0x5a>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b7b:	83 ec 04             	sub    $0x4,%esp
80103b7e:	6a 04                	push   $0x4
80103b80:	68 00 89 10 80       	push   $0x80108900
80103b85:	ff 75 f4             	pushl  -0xc(%ebp)
80103b88:	e8 30 18 00 00       	call   801053bd <memcmp>
80103b8d:	83 c4 10             	add    $0x10,%esp
80103b90:	85 c0                	test   %eax,%eax
80103b92:	75 19                	jne    80103bad <mpsearch1+0x56>
80103b94:	83 ec 08             	sub    $0x8,%esp
80103b97:	6a 10                	push   $0x10
80103b99:	ff 75 f4             	pushl  -0xc(%ebp)
80103b9c:	e8 7e ff ff ff       	call   80103b1f <sum>
80103ba1:	83 c4 10             	add    $0x10,%esp
80103ba4:	84 c0                	test   %al,%al
80103ba6:	75 05                	jne    80103bad <mpsearch1+0x56>
      return (struct mp*)p;
80103ba8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bab:	eb 11                	jmp    80103bbe <mpsearch1+0x67>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103bad:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bb4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103bb7:	72 c2                	jb     80103b7b <mpsearch1+0x24>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103bb9:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103bbe:	c9                   	leave  
80103bbf:	c3                   	ret    

80103bc0 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103bc6:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bd0:	83 c0 0f             	add    $0xf,%eax
80103bd3:	0f b6 00             	movzbl (%eax),%eax
80103bd6:	0f b6 c0             	movzbl %al,%eax
80103bd9:	c1 e0 08             	shl    $0x8,%eax
80103bdc:	89 c2                	mov    %eax,%edx
80103bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103be1:	83 c0 0e             	add    $0xe,%eax
80103be4:	0f b6 00             	movzbl (%eax),%eax
80103be7:	0f b6 c0             	movzbl %al,%eax
80103bea:	09 d0                	or     %edx,%eax
80103bec:	c1 e0 04             	shl    $0x4,%eax
80103bef:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bf2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103bf6:	74 21                	je     80103c19 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103bf8:	83 ec 08             	sub    $0x8,%esp
80103bfb:	68 00 04 00 00       	push   $0x400
80103c00:	ff 75 f0             	pushl  -0x10(%ebp)
80103c03:	e8 4f ff ff ff       	call   80103b57 <mpsearch1>
80103c08:	83 c4 10             	add    $0x10,%esp
80103c0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c0e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c12:	74 51                	je     80103c65 <mpsearch+0xa5>
      return mp;
80103c14:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c17:	eb 61                	jmp    80103c7a <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103c19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c1c:	83 c0 14             	add    $0x14,%eax
80103c1f:	0f b6 00             	movzbl (%eax),%eax
80103c22:	0f b6 c0             	movzbl %al,%eax
80103c25:	c1 e0 08             	shl    $0x8,%eax
80103c28:	89 c2                	mov    %eax,%edx
80103c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c2d:	83 c0 13             	add    $0x13,%eax
80103c30:	0f b6 00             	movzbl (%eax),%eax
80103c33:	0f b6 c0             	movzbl %al,%eax
80103c36:	09 d0                	or     %edx,%eax
80103c38:	c1 e0 0a             	shl    $0xa,%eax
80103c3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103c3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c41:	2d 00 04 00 00       	sub    $0x400,%eax
80103c46:	83 ec 08             	sub    $0x8,%esp
80103c49:	68 00 04 00 00       	push   $0x400
80103c4e:	50                   	push   %eax
80103c4f:	e8 03 ff ff ff       	call   80103b57 <mpsearch1>
80103c54:	83 c4 10             	add    $0x10,%esp
80103c57:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c5a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c5e:	74 05                	je     80103c65 <mpsearch+0xa5>
      return mp;
80103c60:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c63:	eb 15                	jmp    80103c7a <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103c65:	83 ec 08             	sub    $0x8,%esp
80103c68:	68 00 00 01 00       	push   $0x10000
80103c6d:	68 00 00 0f 00       	push   $0xf0000
80103c72:	e8 e0 fe ff ff       	call   80103b57 <mpsearch1>
80103c77:	83 c4 10             	add    $0x10,%esp
}
80103c7a:	c9                   	leave  
80103c7b:	c3                   	ret    

80103c7c <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103c7c:	55                   	push   %ebp
80103c7d:	89 e5                	mov    %esp,%ebp
80103c7f:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c82:	e8 39 ff ff ff       	call   80103bc0 <mpsearch>
80103c87:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c8a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c8e:	74 0a                	je     80103c9a <mpconfig+0x1e>
80103c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c93:	8b 40 04             	mov    0x4(%eax),%eax
80103c96:	85 c0                	test   %eax,%eax
80103c98:	75 07                	jne    80103ca1 <mpconfig+0x25>
    return 0;
80103c9a:	b8 00 00 00 00       	mov    $0x0,%eax
80103c9f:	eb 7a                	jmp    80103d1b <mpconfig+0x9f>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103ca1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca4:	8b 40 04             	mov    0x4(%eax),%eax
80103ca7:	05 00 00 00 80       	add    $0x80000000,%eax
80103cac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103caf:	83 ec 04             	sub    $0x4,%esp
80103cb2:	6a 04                	push   $0x4
80103cb4:	68 05 89 10 80       	push   $0x80108905
80103cb9:	ff 75 f0             	pushl  -0x10(%ebp)
80103cbc:	e8 fc 16 00 00       	call   801053bd <memcmp>
80103cc1:	83 c4 10             	add    $0x10,%esp
80103cc4:	85 c0                	test   %eax,%eax
80103cc6:	74 07                	je     80103ccf <mpconfig+0x53>
    return 0;
80103cc8:	b8 00 00 00 00       	mov    $0x0,%eax
80103ccd:	eb 4c                	jmp    80103d1b <mpconfig+0x9f>
  if(conf->version != 1 && conf->version != 4)
80103ccf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cd2:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cd6:	3c 01                	cmp    $0x1,%al
80103cd8:	74 12                	je     80103cec <mpconfig+0x70>
80103cda:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cdd:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103ce1:	3c 04                	cmp    $0x4,%al
80103ce3:	74 07                	je     80103cec <mpconfig+0x70>
    return 0;
80103ce5:	b8 00 00 00 00       	mov    $0x0,%eax
80103cea:	eb 2f                	jmp    80103d1b <mpconfig+0x9f>
  if(sum((uchar*)conf, conf->length) != 0)
80103cec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cef:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103cf3:	0f b7 c0             	movzwl %ax,%eax
80103cf6:	83 ec 08             	sub    $0x8,%esp
80103cf9:	50                   	push   %eax
80103cfa:	ff 75 f0             	pushl  -0x10(%ebp)
80103cfd:	e8 1d fe ff ff       	call   80103b1f <sum>
80103d02:	83 c4 10             	add    $0x10,%esp
80103d05:	84 c0                	test   %al,%al
80103d07:	74 07                	je     80103d10 <mpconfig+0x94>
    return 0;
80103d09:	b8 00 00 00 00       	mov    $0x0,%eax
80103d0e:	eb 0b                	jmp    80103d1b <mpconfig+0x9f>
  *pmp = mp;
80103d10:	8b 45 08             	mov    0x8(%ebp),%eax
80103d13:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d16:	89 10                	mov    %edx,(%eax)
  return conf;
80103d18:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103d1b:	c9                   	leave  
80103d1c:	c3                   	ret    

80103d1d <mpinit>:

void
mpinit(void)
{
80103d1d:	55                   	push   %ebp
80103d1e:	89 e5                	mov    %esp,%ebp
80103d20:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103d23:	83 ec 0c             	sub    $0xc,%esp
80103d26:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103d29:	50                   	push   %eax
80103d2a:	e8 4d ff ff ff       	call   80103c7c <mpconfig>
80103d2f:	83 c4 10             	add    $0x10,%esp
80103d32:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103d35:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d39:	0f 84 1f 01 00 00    	je     80103e5e <mpinit+0x141>
    return;
  ismp = 1;
80103d3f:	c7 05 04 38 11 80 01 	movl   $0x1,0x80113804
80103d46:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103d49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d4c:	8b 40 24             	mov    0x24(%eax),%eax
80103d4f:	a3 1c 37 11 80       	mov    %eax,0x8011371c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d57:	83 c0 2c             	add    $0x2c,%eax
80103d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d60:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d64:	0f b7 d0             	movzwl %ax,%edx
80103d67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d6a:	01 d0                	add    %edx,%eax
80103d6c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d6f:	eb 7e                	jmp    80103def <mpinit+0xd2>
    switch(*p){
80103d71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d74:	0f b6 00             	movzbl (%eax),%eax
80103d77:	0f b6 c0             	movzbl %al,%eax
80103d7a:	83 f8 04             	cmp    $0x4,%eax
80103d7d:	77 65                	ja     80103de4 <mpinit+0xc7>
80103d7f:	8b 04 85 0c 89 10 80 	mov    -0x7fef76f4(,%eax,4),%eax
80103d86:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu < NCPU) {
80103d8e:	a1 00 3e 11 80       	mov    0x80113e00,%eax
80103d93:	83 f8 07             	cmp    $0x7,%eax
80103d96:	7f 28                	jg     80103dc0 <mpinit+0xa3>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103d98:	8b 15 00 3e 11 80    	mov    0x80113e00,%edx
80103d9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103da1:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103da5:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103dab:	81 c2 20 38 11 80    	add    $0x80113820,%edx
80103db1:	88 02                	mov    %al,(%edx)
        ncpu++;
80103db3:	a1 00 3e 11 80       	mov    0x80113e00,%eax
80103db8:	83 c0 01             	add    $0x1,%eax
80103dbb:	a3 00 3e 11 80       	mov    %eax,0x80113e00
      }
      p += sizeof(struct mpproc);
80103dc0:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103dc4:	eb 29                	jmp    80103def <mpinit+0xd2>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dc9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103dcc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103dcf:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103dd3:	a2 00 38 11 80       	mov    %al,0x80113800
      p += sizeof(struct mpioapic);
80103dd8:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103ddc:	eb 11                	jmp    80103def <mpinit+0xd2>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103dde:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103de2:	eb 0b                	jmp    80103def <mpinit+0xd2>
    default:
      ismp = 0;
80103de4:	c7 05 04 38 11 80 00 	movl   $0x0,0x80113804
80103deb:	00 00 00 
      break;
80103dee:	90                   	nop

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103def:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103df5:	0f 82 76 ff ff ff    	jb     80103d71 <mpinit+0x54>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
80103dfb:	a1 04 38 11 80       	mov    0x80113804,%eax
80103e00:	85 c0                	test   %eax,%eax
80103e02:	75 1d                	jne    80103e21 <mpinit+0x104>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e04:	c7 05 00 3e 11 80 01 	movl   $0x1,0x80113e00
80103e0b:	00 00 00 
    lapic = 0;
80103e0e:	c7 05 1c 37 11 80 00 	movl   $0x0,0x8011371c
80103e15:	00 00 00 
    ioapicid = 0;
80103e18:	c6 05 00 38 11 80 00 	movb   $0x0,0x80113800
    return;
80103e1f:	eb 3e                	jmp    80103e5f <mpinit+0x142>
  }

  if(mp->imcrp){
80103e21:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e24:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e28:	84 c0                	test   %al,%al
80103e2a:	74 33                	je     80103e5f <mpinit+0x142>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e2c:	83 ec 08             	sub    $0x8,%esp
80103e2f:	6a 70                	push   $0x70
80103e31:	6a 22                	push   $0x22
80103e33:	e8 c8 fc ff ff       	call   80103b00 <outb>
80103e38:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103e3b:	83 ec 0c             	sub    $0xc,%esp
80103e3e:	6a 23                	push   $0x23
80103e40:	e8 9e fc ff ff       	call   80103ae3 <inb>
80103e45:	83 c4 10             	add    $0x10,%esp
80103e48:	83 c8 01             	or     $0x1,%eax
80103e4b:	0f b6 c0             	movzbl %al,%eax
80103e4e:	83 ec 08             	sub    $0x8,%esp
80103e51:	50                   	push   %eax
80103e52:	6a 23                	push   $0x23
80103e54:	e8 a7 fc ff ff       	call   80103b00 <outb>
80103e59:	83 c4 10             	add    $0x10,%esp
80103e5c:	eb 01                	jmp    80103e5f <mpinit+0x142>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
80103e5e:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103e5f:	c9                   	leave  
80103e60:	c3                   	ret    

80103e61 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103e61:	55                   	push   %ebp
80103e62:	89 e5                	mov    %esp,%ebp
80103e64:	83 ec 08             	sub    $0x8,%esp
80103e67:	8b 55 08             	mov    0x8(%ebp),%edx
80103e6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e6d:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e71:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e74:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e78:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e7c:	ee                   	out    %al,(%dx)
}
80103e7d:	90                   	nop
80103e7e:	c9                   	leave  
80103e7f:	c3                   	ret    

80103e80 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	83 ec 04             	sub    $0x4,%esp
80103e86:	8b 45 08             	mov    0x8(%ebp),%eax
80103e89:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103e8d:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e91:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103e97:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e9b:	0f b6 c0             	movzbl %al,%eax
80103e9e:	50                   	push   %eax
80103e9f:	6a 21                	push   $0x21
80103ea1:	e8 bb ff ff ff       	call   80103e61 <outb>
80103ea6:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103ea9:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ead:	66 c1 e8 08          	shr    $0x8,%ax
80103eb1:	0f b6 c0             	movzbl %al,%eax
80103eb4:	50                   	push   %eax
80103eb5:	68 a1 00 00 00       	push   $0xa1
80103eba:	e8 a2 ff ff ff       	call   80103e61 <outb>
80103ebf:	83 c4 08             	add    $0x8,%esp
}
80103ec2:	90                   	nop
80103ec3:	c9                   	leave  
80103ec4:	c3                   	ret    

80103ec5 <picenable>:

void
picenable(int irq)
{
80103ec5:	55                   	push   %ebp
80103ec6:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80103ecb:	ba 01 00 00 00       	mov    $0x1,%edx
80103ed0:	89 c1                	mov    %eax,%ecx
80103ed2:	d3 e2                	shl    %cl,%edx
80103ed4:	89 d0                	mov    %edx,%eax
80103ed6:	f7 d0                	not    %eax
80103ed8:	89 c2                	mov    %eax,%edx
80103eda:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103ee1:	21 d0                	and    %edx,%eax
80103ee3:	0f b7 c0             	movzwl %ax,%eax
80103ee6:	50                   	push   %eax
80103ee7:	e8 94 ff ff ff       	call   80103e80 <picsetmask>
80103eec:	83 c4 04             	add    $0x4,%esp
}
80103eef:	90                   	nop
80103ef0:	c9                   	leave  
80103ef1:	c3                   	ret    

80103ef2 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103ef2:	55                   	push   %ebp
80103ef3:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103ef5:	68 ff 00 00 00       	push   $0xff
80103efa:	6a 21                	push   $0x21
80103efc:	e8 60 ff ff ff       	call   80103e61 <outb>
80103f01:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103f04:	68 ff 00 00 00       	push   $0xff
80103f09:	68 a1 00 00 00       	push   $0xa1
80103f0e:	e8 4e ff ff ff       	call   80103e61 <outb>
80103f13:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103f16:	6a 11                	push   $0x11
80103f18:	6a 20                	push   $0x20
80103f1a:	e8 42 ff ff ff       	call   80103e61 <outb>
80103f1f:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103f22:	6a 20                	push   $0x20
80103f24:	6a 21                	push   $0x21
80103f26:	e8 36 ff ff ff       	call   80103e61 <outb>
80103f2b:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103f2e:	6a 04                	push   $0x4
80103f30:	6a 21                	push   $0x21
80103f32:	e8 2a ff ff ff       	call   80103e61 <outb>
80103f37:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103f3a:	6a 03                	push   $0x3
80103f3c:	6a 21                	push   $0x21
80103f3e:	e8 1e ff ff ff       	call   80103e61 <outb>
80103f43:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103f46:	6a 11                	push   $0x11
80103f48:	68 a0 00 00 00       	push   $0xa0
80103f4d:	e8 0f ff ff ff       	call   80103e61 <outb>
80103f52:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103f55:	6a 28                	push   $0x28
80103f57:	68 a1 00 00 00       	push   $0xa1
80103f5c:	e8 00 ff ff ff       	call   80103e61 <outb>
80103f61:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103f64:	6a 02                	push   $0x2
80103f66:	68 a1 00 00 00       	push   $0xa1
80103f6b:	e8 f1 fe ff ff       	call   80103e61 <outb>
80103f70:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103f73:	6a 03                	push   $0x3
80103f75:	68 a1 00 00 00       	push   $0xa1
80103f7a:	e8 e2 fe ff ff       	call   80103e61 <outb>
80103f7f:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103f82:	6a 68                	push   $0x68
80103f84:	6a 20                	push   $0x20
80103f86:	e8 d6 fe ff ff       	call   80103e61 <outb>
80103f8b:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103f8e:	6a 0a                	push   $0xa
80103f90:	6a 20                	push   $0x20
80103f92:	e8 ca fe ff ff       	call   80103e61 <outb>
80103f97:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103f9a:	6a 68                	push   $0x68
80103f9c:	68 a0 00 00 00       	push   $0xa0
80103fa1:	e8 bb fe ff ff       	call   80103e61 <outb>
80103fa6:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103fa9:	6a 0a                	push   $0xa
80103fab:	68 a0 00 00 00       	push   $0xa0
80103fb0:	e8 ac fe ff ff       	call   80103e61 <outb>
80103fb5:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103fb8:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103fbf:	66 83 f8 ff          	cmp    $0xffff,%ax
80103fc3:	74 13                	je     80103fd8 <picinit+0xe6>
    picsetmask(irqmask);
80103fc5:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103fcc:	0f b7 c0             	movzwl %ax,%eax
80103fcf:	50                   	push   %eax
80103fd0:	e8 ab fe ff ff       	call   80103e80 <picsetmask>
80103fd5:	83 c4 04             	add    $0x4,%esp
}
80103fd8:	90                   	nop
80103fd9:	c9                   	leave  
80103fda:	c3                   	ret    

80103fdb <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103fdb:	55                   	push   %ebp
80103fdc:	89 e5                	mov    %esp,%ebp
80103fde:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103fe1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
80103feb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ff1:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ff4:	8b 10                	mov    (%eax),%edx
80103ff6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff9:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103ffb:	e8 06 d0 ff ff       	call   80101006 <filealloc>
80104000:	89 c2                	mov    %eax,%edx
80104002:	8b 45 08             	mov    0x8(%ebp),%eax
80104005:	89 10                	mov    %edx,(%eax)
80104007:	8b 45 08             	mov    0x8(%ebp),%eax
8010400a:	8b 00                	mov    (%eax),%eax
8010400c:	85 c0                	test   %eax,%eax
8010400e:	0f 84 cb 00 00 00    	je     801040df <pipealloc+0x104>
80104014:	e8 ed cf ff ff       	call   80101006 <filealloc>
80104019:	89 c2                	mov    %eax,%edx
8010401b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010401e:	89 10                	mov    %edx,(%eax)
80104020:	8b 45 0c             	mov    0xc(%ebp),%eax
80104023:	8b 00                	mov    (%eax),%eax
80104025:	85 c0                	test   %eax,%eax
80104027:	0f 84 b2 00 00 00    	je     801040df <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010402d:	e8 83 ec ff ff       	call   80102cb5 <kalloc>
80104032:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104035:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104039:	0f 84 9f 00 00 00    	je     801040de <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
8010403f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104042:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104049:	00 00 00 
  p->writeopen = 1;
8010404c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010404f:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104056:	00 00 00 
  p->nwrite = 0;
80104059:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010405c:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104063:	00 00 00 
  p->nread = 0;
80104066:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104069:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104070:	00 00 00 
  initlock(&p->lock, "pipe");
80104073:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104076:	83 ec 08             	sub    $0x8,%esp
80104079:	68 20 89 10 80       	push   $0x80108920
8010407e:	50                   	push   %eax
8010407f:	e8 36 10 00 00       	call   801050ba <initlock>
80104084:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104087:	8b 45 08             	mov    0x8(%ebp),%eax
8010408a:	8b 00                	mov    (%eax),%eax
8010408c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104092:	8b 45 08             	mov    0x8(%ebp),%eax
80104095:	8b 00                	mov    (%eax),%eax
80104097:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010409b:	8b 45 08             	mov    0x8(%ebp),%eax
8010409e:	8b 00                	mov    (%eax),%eax
801040a0:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801040a4:	8b 45 08             	mov    0x8(%ebp),%eax
801040a7:	8b 00                	mov    (%eax),%eax
801040a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040ac:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801040af:	8b 45 0c             	mov    0xc(%ebp),%eax
801040b2:	8b 00                	mov    (%eax),%eax
801040b4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801040ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801040bd:	8b 00                	mov    (%eax),%eax
801040bf:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801040c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801040c6:	8b 00                	mov    (%eax),%eax
801040c8:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801040cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801040cf:	8b 00                	mov    (%eax),%eax
801040d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040d4:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
801040d7:	b8 00 00 00 00       	mov    $0x0,%eax
801040dc:	eb 4e                	jmp    8010412c <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
801040de:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
801040df:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040e3:	74 0e                	je     801040f3 <pipealloc+0x118>
    kfree((char*)p);
801040e5:	83 ec 0c             	sub    $0xc,%esp
801040e8:	ff 75 f4             	pushl  -0xc(%ebp)
801040eb:	e8 2b eb ff ff       	call   80102c1b <kfree>
801040f0:	83 c4 10             	add    $0x10,%esp
  if(*f0)
801040f3:	8b 45 08             	mov    0x8(%ebp),%eax
801040f6:	8b 00                	mov    (%eax),%eax
801040f8:	85 c0                	test   %eax,%eax
801040fa:	74 11                	je     8010410d <pipealloc+0x132>
    fileclose(*f0);
801040fc:	8b 45 08             	mov    0x8(%ebp),%eax
801040ff:	8b 00                	mov    (%eax),%eax
80104101:	83 ec 0c             	sub    $0xc,%esp
80104104:	50                   	push   %eax
80104105:	e8 ba cf ff ff       	call   801010c4 <fileclose>
8010410a:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010410d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104110:	8b 00                	mov    (%eax),%eax
80104112:	85 c0                	test   %eax,%eax
80104114:	74 11                	je     80104127 <pipealloc+0x14c>
    fileclose(*f1);
80104116:	8b 45 0c             	mov    0xc(%ebp),%eax
80104119:	8b 00                	mov    (%eax),%eax
8010411b:	83 ec 0c             	sub    $0xc,%esp
8010411e:	50                   	push   %eax
8010411f:	e8 a0 cf ff ff       	call   801010c4 <fileclose>
80104124:	83 c4 10             	add    $0x10,%esp
  return -1;
80104127:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010412c:	c9                   	leave  
8010412d:	c3                   	ret    

8010412e <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
8010412e:	55                   	push   %ebp
8010412f:	89 e5                	mov    %esp,%ebp
80104131:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80104134:	8b 45 08             	mov    0x8(%ebp),%eax
80104137:	83 ec 0c             	sub    $0xc,%esp
8010413a:	50                   	push   %eax
8010413b:	e8 9c 0f 00 00       	call   801050dc <acquire>
80104140:	83 c4 10             	add    $0x10,%esp
  if(writable){
80104143:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104147:	74 23                	je     8010416c <pipeclose+0x3e>
    p->writeopen = 0;
80104149:	8b 45 08             	mov    0x8(%ebp),%eax
8010414c:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104153:	00 00 00 
    wakeup(&p->nread);
80104156:	8b 45 08             	mov    0x8(%ebp),%eax
80104159:	05 34 02 00 00       	add    $0x234,%eax
8010415e:	83 ec 0c             	sub    $0xc,%esp
80104161:	50                   	push   %eax
80104162:	e8 41 0c 00 00       	call   80104da8 <wakeup>
80104167:	83 c4 10             	add    $0x10,%esp
8010416a:	eb 21                	jmp    8010418d <pipeclose+0x5f>
  } else {
    p->readopen = 0;
8010416c:	8b 45 08             	mov    0x8(%ebp),%eax
8010416f:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104176:	00 00 00 
    wakeup(&p->nwrite);
80104179:	8b 45 08             	mov    0x8(%ebp),%eax
8010417c:	05 38 02 00 00       	add    $0x238,%eax
80104181:	83 ec 0c             	sub    $0xc,%esp
80104184:	50                   	push   %eax
80104185:	e8 1e 0c 00 00       	call   80104da8 <wakeup>
8010418a:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010418d:	8b 45 08             	mov    0x8(%ebp),%eax
80104190:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104196:	85 c0                	test   %eax,%eax
80104198:	75 2c                	jne    801041c6 <pipeclose+0x98>
8010419a:	8b 45 08             	mov    0x8(%ebp),%eax
8010419d:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801041a3:	85 c0                	test   %eax,%eax
801041a5:	75 1f                	jne    801041c6 <pipeclose+0x98>
    release(&p->lock);
801041a7:	8b 45 08             	mov    0x8(%ebp),%eax
801041aa:	83 ec 0c             	sub    $0xc,%esp
801041ad:	50                   	push   %eax
801041ae:	e8 95 0f 00 00       	call   80105148 <release>
801041b3:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801041b6:	83 ec 0c             	sub    $0xc,%esp
801041b9:	ff 75 08             	pushl  0x8(%ebp)
801041bc:	e8 5a ea ff ff       	call   80102c1b <kfree>
801041c1:	83 c4 10             	add    $0x10,%esp
801041c4:	eb 0f                	jmp    801041d5 <pipeclose+0xa7>
  } else
    release(&p->lock);
801041c6:	8b 45 08             	mov    0x8(%ebp),%eax
801041c9:	83 ec 0c             	sub    $0xc,%esp
801041cc:	50                   	push   %eax
801041cd:	e8 76 0f 00 00       	call   80105148 <release>
801041d2:	83 c4 10             	add    $0x10,%esp
}
801041d5:	90                   	nop
801041d6:	c9                   	leave  
801041d7:	c3                   	ret    

801041d8 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801041d8:	55                   	push   %ebp
801041d9:	89 e5                	mov    %esp,%ebp
801041db:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801041de:	8b 45 08             	mov    0x8(%ebp),%eax
801041e1:	83 ec 0c             	sub    $0xc,%esp
801041e4:	50                   	push   %eax
801041e5:	e8 f2 0e 00 00       	call   801050dc <acquire>
801041ea:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801041ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801041f4:	e9 ad 00 00 00       	jmp    801042a6 <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
801041f9:	8b 45 08             	mov    0x8(%ebp),%eax
801041fc:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104202:	85 c0                	test   %eax,%eax
80104204:	74 0d                	je     80104213 <pipewrite+0x3b>
80104206:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010420c:	8b 40 24             	mov    0x24(%eax),%eax
8010420f:	85 c0                	test   %eax,%eax
80104211:	74 19                	je     8010422c <pipewrite+0x54>
        release(&p->lock);
80104213:	8b 45 08             	mov    0x8(%ebp),%eax
80104216:	83 ec 0c             	sub    $0xc,%esp
80104219:	50                   	push   %eax
8010421a:	e8 29 0f 00 00       	call   80105148 <release>
8010421f:	83 c4 10             	add    $0x10,%esp
        return -1;
80104222:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104227:	e9 a8 00 00 00       	jmp    801042d4 <pipewrite+0xfc>
      }
      wakeup(&p->nread);
8010422c:	8b 45 08             	mov    0x8(%ebp),%eax
8010422f:	05 34 02 00 00       	add    $0x234,%eax
80104234:	83 ec 0c             	sub    $0xc,%esp
80104237:	50                   	push   %eax
80104238:	e8 6b 0b 00 00       	call   80104da8 <wakeup>
8010423d:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104240:	8b 45 08             	mov    0x8(%ebp),%eax
80104243:	8b 55 08             	mov    0x8(%ebp),%edx
80104246:	81 c2 38 02 00 00    	add    $0x238,%edx
8010424c:	83 ec 08             	sub    $0x8,%esp
8010424f:	50                   	push   %eax
80104250:	52                   	push   %edx
80104251:	e8 67 0a 00 00       	call   80104cbd <sleep>
80104256:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104259:	8b 45 08             	mov    0x8(%ebp),%eax
8010425c:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104262:	8b 45 08             	mov    0x8(%ebp),%eax
80104265:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010426b:	05 00 02 00 00       	add    $0x200,%eax
80104270:	39 c2                	cmp    %eax,%edx
80104272:	74 85                	je     801041f9 <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104274:	8b 45 08             	mov    0x8(%ebp),%eax
80104277:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010427d:	8d 48 01             	lea    0x1(%eax),%ecx
80104280:	8b 55 08             	mov    0x8(%ebp),%edx
80104283:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104289:	25 ff 01 00 00       	and    $0x1ff,%eax
8010428e:	89 c1                	mov    %eax,%ecx
80104290:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104293:	8b 45 0c             	mov    0xc(%ebp),%eax
80104296:	01 d0                	add    %edx,%eax
80104298:	0f b6 10             	movzbl (%eax),%edx
8010429b:	8b 45 08             	mov    0x8(%ebp),%eax
8010429e:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801042a2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042a9:	3b 45 10             	cmp    0x10(%ebp),%eax
801042ac:	7c ab                	jl     80104259 <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801042ae:	8b 45 08             	mov    0x8(%ebp),%eax
801042b1:	05 34 02 00 00       	add    $0x234,%eax
801042b6:	83 ec 0c             	sub    $0xc,%esp
801042b9:	50                   	push   %eax
801042ba:	e8 e9 0a 00 00       	call   80104da8 <wakeup>
801042bf:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042c2:	8b 45 08             	mov    0x8(%ebp),%eax
801042c5:	83 ec 0c             	sub    $0xc,%esp
801042c8:	50                   	push   %eax
801042c9:	e8 7a 0e 00 00       	call   80105148 <release>
801042ce:	83 c4 10             	add    $0x10,%esp
  return n;
801042d1:	8b 45 10             	mov    0x10(%ebp),%eax
}
801042d4:	c9                   	leave  
801042d5:	c3                   	ret    

801042d6 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801042d6:	55                   	push   %ebp
801042d7:	89 e5                	mov    %esp,%ebp
801042d9:	53                   	push   %ebx
801042da:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801042dd:	8b 45 08             	mov    0x8(%ebp),%eax
801042e0:	83 ec 0c             	sub    $0xc,%esp
801042e3:	50                   	push   %eax
801042e4:	e8 f3 0d 00 00       	call   801050dc <acquire>
801042e9:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042ec:	eb 3f                	jmp    8010432d <piperead+0x57>
    if(proc->killed){
801042ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042f4:	8b 40 24             	mov    0x24(%eax),%eax
801042f7:	85 c0                	test   %eax,%eax
801042f9:	74 19                	je     80104314 <piperead+0x3e>
      release(&p->lock);
801042fb:	8b 45 08             	mov    0x8(%ebp),%eax
801042fe:	83 ec 0c             	sub    $0xc,%esp
80104301:	50                   	push   %eax
80104302:	e8 41 0e 00 00       	call   80105148 <release>
80104307:	83 c4 10             	add    $0x10,%esp
      return -1;
8010430a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010430f:	e9 bf 00 00 00       	jmp    801043d3 <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104314:	8b 45 08             	mov    0x8(%ebp),%eax
80104317:	8b 55 08             	mov    0x8(%ebp),%edx
8010431a:	81 c2 34 02 00 00    	add    $0x234,%edx
80104320:	83 ec 08             	sub    $0x8,%esp
80104323:	50                   	push   %eax
80104324:	52                   	push   %edx
80104325:	e8 93 09 00 00       	call   80104cbd <sleep>
8010432a:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010432d:	8b 45 08             	mov    0x8(%ebp),%eax
80104330:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104336:	8b 45 08             	mov    0x8(%ebp),%eax
80104339:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010433f:	39 c2                	cmp    %eax,%edx
80104341:	75 0d                	jne    80104350 <piperead+0x7a>
80104343:	8b 45 08             	mov    0x8(%ebp),%eax
80104346:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010434c:	85 c0                	test   %eax,%eax
8010434e:	75 9e                	jne    801042ee <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104350:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104357:	eb 49                	jmp    801043a2 <piperead+0xcc>
    if(p->nread == p->nwrite)
80104359:	8b 45 08             	mov    0x8(%ebp),%eax
8010435c:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104362:	8b 45 08             	mov    0x8(%ebp),%eax
80104365:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010436b:	39 c2                	cmp    %eax,%edx
8010436d:	74 3d                	je     801043ac <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010436f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104372:	8b 45 0c             	mov    0xc(%ebp),%eax
80104375:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104378:	8b 45 08             	mov    0x8(%ebp),%eax
8010437b:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104381:	8d 48 01             	lea    0x1(%eax),%ecx
80104384:	8b 55 08             	mov    0x8(%ebp),%edx
80104387:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010438d:	25 ff 01 00 00       	and    $0x1ff,%eax
80104392:	89 c2                	mov    %eax,%edx
80104394:	8b 45 08             	mov    0x8(%ebp),%eax
80104397:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
8010439c:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010439e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801043a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043a5:	3b 45 10             	cmp    0x10(%ebp),%eax
801043a8:	7c af                	jl     80104359 <piperead+0x83>
801043aa:	eb 01                	jmp    801043ad <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
801043ac:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801043ad:	8b 45 08             	mov    0x8(%ebp),%eax
801043b0:	05 38 02 00 00       	add    $0x238,%eax
801043b5:	83 ec 0c             	sub    $0xc,%esp
801043b8:	50                   	push   %eax
801043b9:	e8 ea 09 00 00       	call   80104da8 <wakeup>
801043be:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801043c1:	8b 45 08             	mov    0x8(%ebp),%eax
801043c4:	83 ec 0c             	sub    $0xc,%esp
801043c7:	50                   	push   %eax
801043c8:	e8 7b 0d 00 00       	call   80105148 <release>
801043cd:	83 c4 10             	add    $0x10,%esp
  return i;
801043d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801043d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043d6:	c9                   	leave  
801043d7:	c3                   	ret    

801043d8 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801043d8:	55                   	push   %ebp
801043d9:	89 e5                	mov    %esp,%ebp
801043db:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043de:	9c                   	pushf  
801043df:	58                   	pop    %eax
801043e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801043e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801043e6:	c9                   	leave  
801043e7:	c3                   	ret    

801043e8 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801043e8:	55                   	push   %ebp
801043e9:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801043eb:	fb                   	sti    
}
801043ec:	90                   	nop
801043ed:	5d                   	pop    %ebp
801043ee:	c3                   	ret    

801043ef <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801043ef:	55                   	push   %ebp
801043f0:	89 e5                	mov    %esp,%ebp
801043f2:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
801043f5:	83 ec 08             	sub    $0x8,%esp
801043f8:	68 25 89 10 80       	push   $0x80108925
801043fd:	68 20 3e 11 80       	push   $0x80113e20
80104402:	e8 b3 0c 00 00       	call   801050ba <initlock>
80104407:	83 c4 10             	add    $0x10,%esp
}
8010440a:	90                   	nop
8010440b:	c9                   	leave  
8010440c:	c3                   	ret    

8010440d <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010440d:	55                   	push   %ebp
8010440e:	89 e5                	mov    %esp,%ebp
80104410:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104413:	83 ec 0c             	sub    $0xc,%esp
80104416:	68 20 3e 11 80       	push   $0x80113e20
8010441b:	e8 bc 0c 00 00       	call   801050dc <acquire>
80104420:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104423:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
8010442a:	eb 0e                	jmp    8010443a <allocproc+0x2d>
    if(p->state == UNUSED)
8010442c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010442f:	8b 40 0c             	mov    0xc(%eax),%eax
80104432:	85 c0                	test   %eax,%eax
80104434:	74 27                	je     8010445d <allocproc+0x50>
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104436:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
8010443a:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104441:	72 e9                	jb     8010442c <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104443:	83 ec 0c             	sub    $0xc,%esp
80104446:	68 20 3e 11 80       	push   $0x80113e20
8010444b:	e8 f8 0c 00 00       	call   80105148 <release>
80104450:	83 c4 10             	add    $0x10,%esp
  return 0;
80104453:	b8 00 00 00 00       	mov    $0x0,%eax
80104458:	e9 b4 00 00 00       	jmp    80104511 <allocproc+0x104>

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
8010445d:	90                   	nop

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010445e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104461:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
80104468:	a1 04 b0 10 80       	mov    0x8010b004,%eax
8010446d:	8d 50 01             	lea    0x1(%eax),%edx
80104470:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104476:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104479:	89 42 10             	mov    %eax,0x10(%edx)

  release(&ptable.lock);
8010447c:	83 ec 0c             	sub    $0xc,%esp
8010447f:	68 20 3e 11 80       	push   $0x80113e20
80104484:	e8 bf 0c 00 00       	call   80105148 <release>
80104489:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010448c:	e8 24 e8 ff ff       	call   80102cb5 <kalloc>
80104491:	89 c2                	mov    %eax,%edx
80104493:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104496:	89 50 08             	mov    %edx,0x8(%eax)
80104499:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449c:	8b 40 08             	mov    0x8(%eax),%eax
8010449f:	85 c0                	test   %eax,%eax
801044a1:	75 11                	jne    801044b4 <allocproc+0xa7>
    p->state = UNUSED;
801044a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801044ad:	b8 00 00 00 00       	mov    $0x0,%eax
801044b2:	eb 5d                	jmp    80104511 <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
801044b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044b7:	8b 40 08             	mov    0x8(%eax),%eax
801044ba:	05 00 10 00 00       	add    $0x1000,%eax
801044bf:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801044c2:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801044c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044cc:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801044cf:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801044d3:	ba 65 67 10 80       	mov    $0x80106765,%edx
801044d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801044db:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801044dd:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801044e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044e7:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
801044ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ed:	8b 40 1c             	mov    0x1c(%eax),%eax
801044f0:	83 ec 04             	sub    $0x4,%esp
801044f3:	6a 14                	push   $0x14
801044f5:	6a 00                	push   $0x0
801044f7:	50                   	push   %eax
801044f8:	e8 59 0e 00 00       	call   80105356 <memset>
801044fd:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104500:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104503:	8b 40 1c             	mov    0x1c(%eax),%eax
80104506:	ba 77 4c 10 80       	mov    $0x80104c77,%edx
8010450b:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
8010450e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104511:	c9                   	leave  
80104512:	c3                   	ret    

80104513 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104513:	55                   	push   %ebp
80104514:	89 e5                	mov    %esp,%ebp
80104516:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80104519:	e8 ef fe ff ff       	call   8010440d <allocproc>
8010451e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  initproc = p;
80104521:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104524:	a3 44 b6 10 80       	mov    %eax,0x8010b644
  if((p->pgdir = setupkvm()) == 0)
80104529:	e8 c3 38 00 00       	call   80107df1 <setupkvm>
8010452e:	89 c2                	mov    %eax,%edx
80104530:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104533:	89 50 04             	mov    %edx,0x4(%eax)
80104536:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104539:	8b 40 04             	mov    0x4(%eax),%eax
8010453c:	85 c0                	test   %eax,%eax
8010453e:	75 0d                	jne    8010454d <userinit+0x3a>
    panic("userinit: out of memory?");
80104540:	83 ec 0c             	sub    $0xc,%esp
80104543:	68 2c 89 10 80       	push   $0x8010892c
80104548:	e8 53 c0 ff ff       	call   801005a0 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010454d:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104552:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104555:	8b 40 04             	mov    0x4(%eax),%eax
80104558:	83 ec 04             	sub    $0x4,%esp
8010455b:	52                   	push   %edx
8010455c:	68 e0 b4 10 80       	push   $0x8010b4e0
80104561:	50                   	push   %eax
80104562:	e8 be 3a 00 00       	call   80108025 <inituvm>
80104567:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
8010456a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010456d:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104573:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104576:	8b 40 18             	mov    0x18(%eax),%eax
80104579:	83 ec 04             	sub    $0x4,%esp
8010457c:	6a 4c                	push   $0x4c
8010457e:	6a 00                	push   $0x0
80104580:	50                   	push   %eax
80104581:	e8 d0 0d 00 00       	call   80105356 <memset>
80104586:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104589:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458c:	8b 40 18             	mov    0x18(%eax),%eax
8010458f:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104595:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104598:	8b 40 18             	mov    0x18(%eax),%eax
8010459b:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801045a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045a4:	8b 40 18             	mov    0x18(%eax),%eax
801045a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045aa:	8b 52 18             	mov    0x18(%edx),%edx
801045ad:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045b1:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801045b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045b8:	8b 40 18             	mov    0x18(%eax),%eax
801045bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045be:	8b 52 18             	mov    0x18(%edx),%edx
801045c1:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045c5:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801045c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045cc:	8b 40 18             	mov    0x18(%eax),%eax
801045cf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801045d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045d9:	8b 40 18             	mov    0x18(%eax),%eax
801045dc:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801045e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e6:	8b 40 18             	mov    0x18(%eax),%eax
801045e9:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801045f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f3:	83 c0 6c             	add    $0x6c,%eax
801045f6:	83 ec 04             	sub    $0x4,%esp
801045f9:	6a 10                	push   $0x10
801045fb:	68 45 89 10 80       	push   $0x80108945
80104600:	50                   	push   %eax
80104601:	e8 53 0f 00 00       	call   80105559 <safestrcpy>
80104606:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104609:	83 ec 0c             	sub    $0xc,%esp
8010460c:	68 4e 89 10 80       	push   $0x8010894e
80104611:	e8 33 df ff ff       	call   80102549 <namei>
80104616:	83 c4 10             	add    $0x10,%esp
80104619:	89 c2                	mov    %eax,%edx
8010461b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461e:	89 50 68             	mov    %edx,0x68(%eax)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104621:	83 ec 0c             	sub    $0xc,%esp
80104624:	68 20 3e 11 80       	push   $0x80113e20
80104629:	e8 ae 0a 00 00       	call   801050dc <acquire>
8010462e:	83 c4 10             	add    $0x10,%esp

  p->state = RUNNABLE;
80104631:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104634:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
8010463b:	83 ec 0c             	sub    $0xc,%esp
8010463e:	68 20 3e 11 80       	push   $0x80113e20
80104643:	e8 00 0b 00 00       	call   80105148 <release>
80104648:	83 c4 10             	add    $0x10,%esp
}
8010464b:	90                   	nop
8010464c:	c9                   	leave  
8010464d:	c3                   	ret    

8010464e <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010464e:	55                   	push   %ebp
8010464f:	89 e5                	mov    %esp,%ebp
80104651:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
80104654:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010465a:	8b 00                	mov    (%eax),%eax
8010465c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
8010465f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104663:	7e 31                	jle    80104696 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104665:	8b 55 08             	mov    0x8(%ebp),%edx
80104668:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010466b:	01 c2                	add    %eax,%edx
8010466d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104673:	8b 40 04             	mov    0x4(%eax),%eax
80104676:	83 ec 04             	sub    $0x4,%esp
80104679:	52                   	push   %edx
8010467a:	ff 75 f4             	pushl  -0xc(%ebp)
8010467d:	50                   	push   %eax
8010467e:	e8 df 3a 00 00       	call   80108162 <allocuvm>
80104683:	83 c4 10             	add    $0x10,%esp
80104686:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104689:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010468d:	75 3e                	jne    801046cd <growproc+0x7f>
      return -1;
8010468f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104694:	eb 59                	jmp    801046ef <growproc+0xa1>
  } else if(n < 0){
80104696:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010469a:	79 31                	jns    801046cd <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
8010469c:	8b 55 08             	mov    0x8(%ebp),%edx
8010469f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046a2:	01 c2                	add    %eax,%edx
801046a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046aa:	8b 40 04             	mov    0x4(%eax),%eax
801046ad:	83 ec 04             	sub    $0x4,%esp
801046b0:	52                   	push   %edx
801046b1:	ff 75 f4             	pushl  -0xc(%ebp)
801046b4:	50                   	push   %eax
801046b5:	e8 ad 3b 00 00       	call   80108267 <deallocuvm>
801046ba:	83 c4 10             	add    $0x10,%esp
801046bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801046c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801046c4:	75 07                	jne    801046cd <growproc+0x7f>
      return -1;
801046c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046cb:	eb 22                	jmp    801046ef <growproc+0xa1>
  }
  proc->sz = sz;
801046cd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046d6:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801046d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046de:	83 ec 0c             	sub    $0xc,%esp
801046e1:	50                   	push   %eax
801046e2:	e8 c6 37 00 00       	call   80107ead <switchuvm>
801046e7:	83 c4 10             	add    $0x10,%esp
  return 0;
801046ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
801046ef:	c9                   	leave  
801046f0:	c3                   	ret    

801046f1 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801046f1:	55                   	push   %ebp
801046f2:	89 e5                	mov    %esp,%ebp
801046f4:	57                   	push   %edi
801046f5:	56                   	push   %esi
801046f6:	53                   	push   %ebx
801046f7:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
801046fa:	e8 0e fd ff ff       	call   8010440d <allocproc>
801046ff:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104702:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104706:	75 0a                	jne    80104712 <fork+0x21>
    return -1;
80104708:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010470d:	e9 68 01 00 00       	jmp    8010487a <fork+0x189>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104712:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104718:	8b 10                	mov    (%eax),%edx
8010471a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104720:	8b 40 04             	mov    0x4(%eax),%eax
80104723:	83 ec 08             	sub    $0x8,%esp
80104726:	52                   	push   %edx
80104727:	50                   	push   %eax
80104728:	e8 c8 3c 00 00       	call   801083f5 <copyuvm>
8010472d:	83 c4 10             	add    $0x10,%esp
80104730:	89 c2                	mov    %eax,%edx
80104732:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104735:	89 50 04             	mov    %edx,0x4(%eax)
80104738:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010473b:	8b 40 04             	mov    0x4(%eax),%eax
8010473e:	85 c0                	test   %eax,%eax
80104740:	75 30                	jne    80104772 <fork+0x81>
    kfree(np->kstack);
80104742:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104745:	8b 40 08             	mov    0x8(%eax),%eax
80104748:	83 ec 0c             	sub    $0xc,%esp
8010474b:	50                   	push   %eax
8010474c:	e8 ca e4 ff ff       	call   80102c1b <kfree>
80104751:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104754:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104757:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
8010475e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104761:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80104768:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010476d:	e9 08 01 00 00       	jmp    8010487a <fork+0x189>
  }
  np->sz = proc->sz;
80104772:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104778:	8b 10                	mov    (%eax),%edx
8010477a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010477d:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
8010477f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104786:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104789:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
8010478c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010478f:	8b 50 18             	mov    0x18(%eax),%edx
80104792:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104798:	8b 40 18             	mov    0x18(%eax),%eax
8010479b:	89 c3                	mov    %eax,%ebx
8010479d:	b8 13 00 00 00       	mov    $0x13,%eax
801047a2:	89 d7                	mov    %edx,%edi
801047a4:	89 de                	mov    %ebx,%esi
801047a6:	89 c1                	mov    %eax,%ecx
801047a8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801047aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047ad:	8b 40 18             	mov    0x18(%eax),%eax
801047b0:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801047b7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801047be:	eb 43                	jmp    80104803 <fork+0x112>
    if(proc->ofile[i])
801047c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047c9:	83 c2 08             	add    $0x8,%edx
801047cc:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047d0:	85 c0                	test   %eax,%eax
801047d2:	74 2b                	je     801047ff <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
801047d4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047dd:	83 c2 08             	add    $0x8,%edx
801047e0:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047e4:	83 ec 0c             	sub    $0xc,%esp
801047e7:	50                   	push   %eax
801047e8:	e8 86 c8 ff ff       	call   80101073 <filedup>
801047ed:	83 c4 10             	add    $0x10,%esp
801047f0:	89 c1                	mov    %eax,%ecx
801047f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047f5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047f8:	83 c2 08             	add    $0x8,%edx
801047fb:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801047ff:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104803:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104807:	7e b7                	jle    801047c0 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104809:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010480f:	8b 40 68             	mov    0x68(%eax),%eax
80104812:	83 ec 0c             	sub    $0xc,%esp
80104815:	50                   	push   %eax
80104816:	e8 ce d1 ff ff       	call   801019e9 <idup>
8010481b:	83 c4 10             	add    $0x10,%esp
8010481e:	89 c2                	mov    %eax,%edx
80104820:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104823:	89 50 68             	mov    %edx,0x68(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104826:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010482c:	8d 50 6c             	lea    0x6c(%eax),%edx
8010482f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104832:	83 c0 6c             	add    $0x6c,%eax
80104835:	83 ec 04             	sub    $0x4,%esp
80104838:	6a 10                	push   $0x10
8010483a:	52                   	push   %edx
8010483b:	50                   	push   %eax
8010483c:	e8 18 0d 00 00       	call   80105559 <safestrcpy>
80104841:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
80104844:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104847:	8b 40 10             	mov    0x10(%eax),%eax
8010484a:	89 45 dc             	mov    %eax,-0x24(%ebp)

  acquire(&ptable.lock);
8010484d:	83 ec 0c             	sub    $0xc,%esp
80104850:	68 20 3e 11 80       	push   $0x80113e20
80104855:	e8 82 08 00 00       	call   801050dc <acquire>
8010485a:	83 c4 10             	add    $0x10,%esp

  np->state = RUNNABLE;
8010485d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104860:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80104867:	83 ec 0c             	sub    $0xc,%esp
8010486a:	68 20 3e 11 80       	push   $0x80113e20
8010486f:	e8 d4 08 00 00       	call   80105148 <release>
80104874:	83 c4 10             	add    $0x10,%esp

  return pid;
80104877:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
8010487a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010487d:	5b                   	pop    %ebx
8010487e:	5e                   	pop    %esi
8010487f:	5f                   	pop    %edi
80104880:	5d                   	pop    %ebp
80104881:	c3                   	ret    

80104882 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104882:	55                   	push   %ebp
80104883:	89 e5                	mov    %esp,%ebp
80104885:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80104888:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010488f:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80104894:	39 c2                	cmp    %eax,%edx
80104896:	75 0d                	jne    801048a5 <exit+0x23>
    panic("init exiting");
80104898:	83 ec 0c             	sub    $0xc,%esp
8010489b:	68 50 89 10 80       	push   $0x80108950
801048a0:	e8 fb bc ff ff       	call   801005a0 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801048a5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801048ac:	eb 48                	jmp    801048f6 <exit+0x74>
    if(proc->ofile[fd]){
801048ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048b7:	83 c2 08             	add    $0x8,%edx
801048ba:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801048be:	85 c0                	test   %eax,%eax
801048c0:	74 30                	je     801048f2 <exit+0x70>
      fileclose(proc->ofile[fd]);
801048c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048cb:	83 c2 08             	add    $0x8,%edx
801048ce:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801048d2:	83 ec 0c             	sub    $0xc,%esp
801048d5:	50                   	push   %eax
801048d6:	e8 e9 c7 ff ff       	call   801010c4 <fileclose>
801048db:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801048de:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048e7:	83 c2 08             	add    $0x8,%edx
801048ea:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801048f1:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801048f2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801048f6:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801048fa:	7e b2                	jle    801048ae <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
801048fc:	e8 e0 ec ff ff       	call   801035e1 <begin_op>
  iput(proc->cwd);
80104901:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104907:	8b 40 68             	mov    0x68(%eax),%eax
8010490a:	83 ec 0c             	sub    $0xc,%esp
8010490d:	50                   	push   %eax
8010490e:	e8 7b d2 ff ff       	call   80101b8e <iput>
80104913:	83 c4 10             	add    $0x10,%esp
  end_op();
80104916:	e8 52 ed ff ff       	call   8010366d <end_op>
  proc->cwd = 0;
8010491b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104921:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104928:	83 ec 0c             	sub    $0xc,%esp
8010492b:	68 20 3e 11 80       	push   $0x80113e20
80104930:	e8 a7 07 00 00       	call   801050dc <acquire>
80104935:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104938:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010493e:	8b 40 14             	mov    0x14(%eax),%eax
80104941:	83 ec 0c             	sub    $0xc,%esp
80104944:	50                   	push   %eax
80104945:	e8 1f 04 00 00       	call   80104d69 <wakeup1>
8010494a:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010494d:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
80104954:	eb 3c                	jmp    80104992 <exit+0x110>
    if(p->parent == proc){
80104956:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104959:	8b 50 14             	mov    0x14(%eax),%edx
8010495c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104962:	39 c2                	cmp    %eax,%edx
80104964:	75 28                	jne    8010498e <exit+0x10c>
      p->parent = initproc;
80104966:	8b 15 44 b6 10 80    	mov    0x8010b644,%edx
8010496c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496f:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104972:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104975:	8b 40 0c             	mov    0xc(%eax),%eax
80104978:	83 f8 05             	cmp    $0x5,%eax
8010497b:	75 11                	jne    8010498e <exit+0x10c>
        wakeup1(initproc);
8010497d:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80104982:	83 ec 0c             	sub    $0xc,%esp
80104985:	50                   	push   %eax
80104986:	e8 de 03 00 00       	call   80104d69 <wakeup1>
8010498b:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010498e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104992:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104999:	72 bb                	jb     80104956 <exit+0xd4>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
8010499b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049a1:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
801049a8:	e8 d3 01 00 00       	call   80104b80 <sched>
  panic("zombie exit");
801049ad:	83 ec 0c             	sub    $0xc,%esp
801049b0:	68 5d 89 10 80       	push   $0x8010895d
801049b5:	e8 e6 bb ff ff       	call   801005a0 <panic>

801049ba <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801049ba:	55                   	push   %ebp
801049bb:	89 e5                	mov    %esp,%ebp
801049bd:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801049c0:	83 ec 0c             	sub    $0xc,%esp
801049c3:	68 20 3e 11 80       	push   $0x80113e20
801049c8:	e8 0f 07 00 00       	call   801050dc <acquire>
801049cd:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801049d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049d7:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
801049de:	e9 a6 00 00 00       	jmp    80104a89 <wait+0xcf>
      if(p->parent != proc)
801049e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e6:	8b 50 14             	mov    0x14(%eax),%edx
801049e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049ef:	39 c2                	cmp    %eax,%edx
801049f1:	0f 85 8d 00 00 00    	jne    80104a84 <wait+0xca>
        continue;
      havekids = 1;
801049f7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
801049fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a01:	8b 40 0c             	mov    0xc(%eax),%eax
80104a04:	83 f8 05             	cmp    $0x5,%eax
80104a07:	75 7c                	jne    80104a85 <wait+0xcb>
        // Found one.
        pid = p->pid;
80104a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a0c:	8b 40 10             	mov    0x10(%eax),%eax
80104a0f:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a15:	8b 40 08             	mov    0x8(%eax),%eax
80104a18:	83 ec 0c             	sub    $0xc,%esp
80104a1b:	50                   	push   %eax
80104a1c:	e8 fa e1 ff ff       	call   80102c1b <kfree>
80104a21:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a27:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a31:	8b 40 04             	mov    0x4(%eax),%eax
80104a34:	83 ec 0c             	sub    $0xc,%esp
80104a37:	50                   	push   %eax
80104a38:	e8 de 38 00 00       	call   8010831b <freevm>
80104a3d:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80104a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a43:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104a4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a4d:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a57:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a5e:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
80104a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a68:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80104a6f:	83 ec 0c             	sub    $0xc,%esp
80104a72:	68 20 3e 11 80       	push   $0x80113e20
80104a77:	e8 cc 06 00 00       	call   80105148 <release>
80104a7c:	83 c4 10             	add    $0x10,%esp
        return pid;
80104a7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a82:	eb 58                	jmp    80104adc <wait+0x122>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104a84:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a85:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a89:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104a90:	0f 82 4d ff ff ff    	jb     801049e3 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104a96:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104a9a:	74 0d                	je     80104aa9 <wait+0xef>
80104a9c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aa2:	8b 40 24             	mov    0x24(%eax),%eax
80104aa5:	85 c0                	test   %eax,%eax
80104aa7:	74 17                	je     80104ac0 <wait+0x106>
      release(&ptable.lock);
80104aa9:	83 ec 0c             	sub    $0xc,%esp
80104aac:	68 20 3e 11 80       	push   $0x80113e20
80104ab1:	e8 92 06 00 00       	call   80105148 <release>
80104ab6:	83 c4 10             	add    $0x10,%esp
      return -1;
80104ab9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104abe:	eb 1c                	jmp    80104adc <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104ac0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ac6:	83 ec 08             	sub    $0x8,%esp
80104ac9:	68 20 3e 11 80       	push   $0x80113e20
80104ace:	50                   	push   %eax
80104acf:	e8 e9 01 00 00       	call   80104cbd <sleep>
80104ad4:	83 c4 10             	add    $0x10,%esp
  }
80104ad7:	e9 f4 fe ff ff       	jmp    801049d0 <wait+0x16>
}
80104adc:	c9                   	leave  
80104add:	c3                   	ret    

80104ade <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104ade:	55                   	push   %ebp
80104adf:	89 e5                	mov    %esp,%ebp
80104ae1:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104ae4:	e8 ff f8 ff ff       	call   801043e8 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104ae9:	83 ec 0c             	sub    $0xc,%esp
80104aec:	68 20 3e 11 80       	push   $0x80113e20
80104af1:	e8 e6 05 00 00       	call   801050dc <acquire>
80104af6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104af9:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
80104b00:	eb 60                	jmp    80104b62 <scheduler+0x84>
      if(p->state != RUNNABLE)
80104b02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b05:	8b 40 0c             	mov    0xc(%eax),%eax
80104b08:	83 f8 03             	cmp    $0x3,%eax
80104b0b:	75 50                	jne    80104b5d <scheduler+0x7f>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80104b0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b10:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104b16:	83 ec 0c             	sub    $0xc,%esp
80104b19:	ff 75 f4             	pushl  -0xc(%ebp)
80104b1c:	e8 8c 33 00 00       	call   80107ead <switchuvm>
80104b21:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b27:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, p->context);
80104b2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b31:	8b 40 1c             	mov    0x1c(%eax),%eax
80104b34:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104b3b:	83 c2 04             	add    $0x4,%edx
80104b3e:	83 ec 08             	sub    $0x8,%esp
80104b41:	50                   	push   %eax
80104b42:	52                   	push   %edx
80104b43:	e8 82 0a 00 00       	call   801055ca <swtch>
80104b48:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104b4b:	e8 44 33 00 00       	call   80107e94 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104b50:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104b57:	00 00 00 00 
80104b5b:	eb 01                	jmp    80104b5e <scheduler+0x80>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104b5d:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b5e:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104b62:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104b69:	72 97                	jb     80104b02 <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104b6b:	83 ec 0c             	sub    $0xc,%esp
80104b6e:	68 20 3e 11 80       	push   $0x80113e20
80104b73:	e8 d0 05 00 00       	call   80105148 <release>
80104b78:	83 c4 10             	add    $0x10,%esp

  }
80104b7b:	e9 64 ff ff ff       	jmp    80104ae4 <scheduler+0x6>

80104b80 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104b86:	83 ec 0c             	sub    $0xc,%esp
80104b89:	68 20 3e 11 80       	push   $0x80113e20
80104b8e:	e8 81 06 00 00       	call   80105214 <holding>
80104b93:	83 c4 10             	add    $0x10,%esp
80104b96:	85 c0                	test   %eax,%eax
80104b98:	75 0d                	jne    80104ba7 <sched+0x27>
    panic("sched ptable.lock");
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	68 69 89 10 80       	push   $0x80108969
80104ba2:	e8 f9 b9 ff ff       	call   801005a0 <panic>
  if(cpu->ncli != 1)
80104ba7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bad:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104bb3:	83 f8 01             	cmp    $0x1,%eax
80104bb6:	74 0d                	je     80104bc5 <sched+0x45>
    panic("sched locks");
80104bb8:	83 ec 0c             	sub    $0xc,%esp
80104bbb:	68 7b 89 10 80       	push   $0x8010897b
80104bc0:	e8 db b9 ff ff       	call   801005a0 <panic>
  if(proc->state == RUNNING)
80104bc5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bcb:	8b 40 0c             	mov    0xc(%eax),%eax
80104bce:	83 f8 04             	cmp    $0x4,%eax
80104bd1:	75 0d                	jne    80104be0 <sched+0x60>
    panic("sched running");
80104bd3:	83 ec 0c             	sub    $0xc,%esp
80104bd6:	68 87 89 10 80       	push   $0x80108987
80104bdb:	e8 c0 b9 ff ff       	call   801005a0 <panic>
  if(readeflags()&FL_IF)
80104be0:	e8 f3 f7 ff ff       	call   801043d8 <readeflags>
80104be5:	25 00 02 00 00       	and    $0x200,%eax
80104bea:	85 c0                	test   %eax,%eax
80104bec:	74 0d                	je     80104bfb <sched+0x7b>
    panic("sched interruptible");
80104bee:	83 ec 0c             	sub    $0xc,%esp
80104bf1:	68 95 89 10 80       	push   $0x80108995
80104bf6:	e8 a5 b9 ff ff       	call   801005a0 <panic>
  intena = cpu->intena;
80104bfb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c01:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104c07:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104c0a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c10:	8b 40 04             	mov    0x4(%eax),%eax
80104c13:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c1a:	83 c2 1c             	add    $0x1c,%edx
80104c1d:	83 ec 08             	sub    $0x8,%esp
80104c20:	50                   	push   %eax
80104c21:	52                   	push   %edx
80104c22:	e8 a3 09 00 00       	call   801055ca <swtch>
80104c27:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104c2a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c30:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c33:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104c39:	90                   	nop
80104c3a:	c9                   	leave  
80104c3b:	c3                   	ret    

80104c3c <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104c3c:	55                   	push   %ebp
80104c3d:	89 e5                	mov    %esp,%ebp
80104c3f:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104c42:	83 ec 0c             	sub    $0xc,%esp
80104c45:	68 20 3e 11 80       	push   $0x80113e20
80104c4a:	e8 8d 04 00 00       	call   801050dc <acquire>
80104c4f:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104c52:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c58:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104c5f:	e8 1c ff ff ff       	call   80104b80 <sched>
  release(&ptable.lock);
80104c64:	83 ec 0c             	sub    $0xc,%esp
80104c67:	68 20 3e 11 80       	push   $0x80113e20
80104c6c:	e8 d7 04 00 00       	call   80105148 <release>
80104c71:	83 c4 10             	add    $0x10,%esp
}
80104c74:	90                   	nop
80104c75:	c9                   	leave  
80104c76:	c3                   	ret    

80104c77 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104c77:	55                   	push   %ebp
80104c78:	89 e5                	mov    %esp,%ebp
80104c7a:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104c7d:	83 ec 0c             	sub    $0xc,%esp
80104c80:	68 20 3e 11 80       	push   $0x80113e20
80104c85:	e8 be 04 00 00       	call   80105148 <release>
80104c8a:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104c8d:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c92:	85 c0                	test   %eax,%eax
80104c94:	74 24                	je     80104cba <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80104c96:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104c9d:	00 00 00 
    iinit(ROOTDEV);
80104ca0:	83 ec 0c             	sub    $0xc,%esp
80104ca3:	6a 01                	push   $0x1
80104ca5:	e8 07 ca ff ff       	call   801016b1 <iinit>
80104caa:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104cad:	83 ec 0c             	sub    $0xc,%esp
80104cb0:	6a 01                	push   $0x1
80104cb2:	e8 0c e7 ff ff       	call   801033c3 <initlog>
80104cb7:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104cba:	90                   	nop
80104cbb:	c9                   	leave  
80104cbc:	c3                   	ret    

80104cbd <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104cbd:	55                   	push   %ebp
80104cbe:	89 e5                	mov    %esp,%ebp
80104cc0:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104cc3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cc9:	85 c0                	test   %eax,%eax
80104ccb:	75 0d                	jne    80104cda <sleep+0x1d>
    panic("sleep");
80104ccd:	83 ec 0c             	sub    $0xc,%esp
80104cd0:	68 a9 89 10 80       	push   $0x801089a9
80104cd5:	e8 c6 b8 ff ff       	call   801005a0 <panic>

  if(lk == 0)
80104cda:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104cde:	75 0d                	jne    80104ced <sleep+0x30>
    panic("sleep without lk");
80104ce0:	83 ec 0c             	sub    $0xc,%esp
80104ce3:	68 af 89 10 80       	push   $0x801089af
80104ce8:	e8 b3 b8 ff ff       	call   801005a0 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104ced:	81 7d 0c 20 3e 11 80 	cmpl   $0x80113e20,0xc(%ebp)
80104cf4:	74 1e                	je     80104d14 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104cf6:	83 ec 0c             	sub    $0xc,%esp
80104cf9:	68 20 3e 11 80       	push   $0x80113e20
80104cfe:	e8 d9 03 00 00       	call   801050dc <acquire>
80104d03:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104d06:	83 ec 0c             	sub    $0xc,%esp
80104d09:	ff 75 0c             	pushl  0xc(%ebp)
80104d0c:	e8 37 04 00 00       	call   80105148 <release>
80104d11:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104d14:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d1a:	8b 55 08             	mov    0x8(%ebp),%edx
80104d1d:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
80104d20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d26:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104d2d:	e8 4e fe ff ff       	call   80104b80 <sched>

  // Tidy up.
  proc->chan = 0;
80104d32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d38:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104d3f:	81 7d 0c 20 3e 11 80 	cmpl   $0x80113e20,0xc(%ebp)
80104d46:	74 1e                	je     80104d66 <sleep+0xa9>
    release(&ptable.lock);
80104d48:	83 ec 0c             	sub    $0xc,%esp
80104d4b:	68 20 3e 11 80       	push   $0x80113e20
80104d50:	e8 f3 03 00 00       	call   80105148 <release>
80104d55:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104d58:	83 ec 0c             	sub    $0xc,%esp
80104d5b:	ff 75 0c             	pushl  0xc(%ebp)
80104d5e:	e8 79 03 00 00       	call   801050dc <acquire>
80104d63:	83 c4 10             	add    $0x10,%esp
  }
}
80104d66:	90                   	nop
80104d67:	c9                   	leave  
80104d68:	c3                   	ret    

80104d69 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104d69:	55                   	push   %ebp
80104d6a:	89 e5                	mov    %esp,%ebp
80104d6c:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d6f:	c7 45 fc 54 3e 11 80 	movl   $0x80113e54,-0x4(%ebp)
80104d76:	eb 24                	jmp    80104d9c <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104d78:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d7b:	8b 40 0c             	mov    0xc(%eax),%eax
80104d7e:	83 f8 02             	cmp    $0x2,%eax
80104d81:	75 15                	jne    80104d98 <wakeup1+0x2f>
80104d83:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d86:	8b 40 20             	mov    0x20(%eax),%eax
80104d89:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d8c:	75 0a                	jne    80104d98 <wakeup1+0x2f>
      p->state = RUNNABLE;
80104d8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d91:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d98:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104d9c:	81 7d fc 54 5d 11 80 	cmpl   $0x80115d54,-0x4(%ebp)
80104da3:	72 d3                	jb     80104d78 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104da5:	90                   	nop
80104da6:	c9                   	leave  
80104da7:	c3                   	ret    

80104da8 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104da8:	55                   	push   %ebp
80104da9:	89 e5                	mov    %esp,%ebp
80104dab:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104dae:	83 ec 0c             	sub    $0xc,%esp
80104db1:	68 20 3e 11 80       	push   $0x80113e20
80104db6:	e8 21 03 00 00       	call   801050dc <acquire>
80104dbb:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104dbe:	83 ec 0c             	sub    $0xc,%esp
80104dc1:	ff 75 08             	pushl  0x8(%ebp)
80104dc4:	e8 a0 ff ff ff       	call   80104d69 <wakeup1>
80104dc9:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104dcc:	83 ec 0c             	sub    $0xc,%esp
80104dcf:	68 20 3e 11 80       	push   $0x80113e20
80104dd4:	e8 6f 03 00 00       	call   80105148 <release>
80104dd9:	83 c4 10             	add    $0x10,%esp
}
80104ddc:	90                   	nop
80104ddd:	c9                   	leave  
80104dde:	c3                   	ret    

80104ddf <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104ddf:	55                   	push   %ebp
80104de0:	89 e5                	mov    %esp,%ebp
80104de2:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104de5:	83 ec 0c             	sub    $0xc,%esp
80104de8:	68 20 3e 11 80       	push   $0x80113e20
80104ded:	e8 ea 02 00 00       	call   801050dc <acquire>
80104df2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104df5:	c7 45 f4 54 3e 11 80 	movl   $0x80113e54,-0xc(%ebp)
80104dfc:	eb 45                	jmp    80104e43 <kill+0x64>
    if(p->pid == pid){
80104dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e01:	8b 40 10             	mov    0x10(%eax),%eax
80104e04:	3b 45 08             	cmp    0x8(%ebp),%eax
80104e07:	75 36                	jne    80104e3f <kill+0x60>
      p->killed = 1;
80104e09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e0c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e16:	8b 40 0c             	mov    0xc(%eax),%eax
80104e19:	83 f8 02             	cmp    $0x2,%eax
80104e1c:	75 0a                	jne    80104e28 <kill+0x49>
        p->state = RUNNABLE;
80104e1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e21:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104e28:	83 ec 0c             	sub    $0xc,%esp
80104e2b:	68 20 3e 11 80       	push   $0x80113e20
80104e30:	e8 13 03 00 00       	call   80105148 <release>
80104e35:	83 c4 10             	add    $0x10,%esp
      return 0;
80104e38:	b8 00 00 00 00       	mov    $0x0,%eax
80104e3d:	eb 22                	jmp    80104e61 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e3f:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104e43:	81 7d f4 54 5d 11 80 	cmpl   $0x80115d54,-0xc(%ebp)
80104e4a:	72 b2                	jb     80104dfe <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104e4c:	83 ec 0c             	sub    $0xc,%esp
80104e4f:	68 20 3e 11 80       	push   $0x80113e20
80104e54:	e8 ef 02 00 00       	call   80105148 <release>
80104e59:	83 c4 10             	add    $0x10,%esp
  return -1;
80104e5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e61:	c9                   	leave  
80104e62:	c3                   	ret    

80104e63 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104e63:	55                   	push   %ebp
80104e64:	89 e5                	mov    %esp,%ebp
80104e66:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e69:	c7 45 f0 54 3e 11 80 	movl   $0x80113e54,-0x10(%ebp)
80104e70:	e9 d7 00 00 00       	jmp    80104f4c <procdump+0xe9>
    if(p->state == UNUSED)
80104e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e78:	8b 40 0c             	mov    0xc(%eax),%eax
80104e7b:	85 c0                	test   %eax,%eax
80104e7d:	0f 84 c4 00 00 00    	je     80104f47 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e83:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e86:	8b 40 0c             	mov    0xc(%eax),%eax
80104e89:	83 f8 05             	cmp    $0x5,%eax
80104e8c:	77 23                	ja     80104eb1 <procdump+0x4e>
80104e8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e91:	8b 40 0c             	mov    0xc(%eax),%eax
80104e94:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e9b:	85 c0                	test   %eax,%eax
80104e9d:	74 12                	je     80104eb1 <procdump+0x4e>
      state = states[p->state];
80104e9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ea2:	8b 40 0c             	mov    0xc(%eax),%eax
80104ea5:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104eac:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104eaf:	eb 07                	jmp    80104eb8 <procdump+0x55>
    else
      state = "???";
80104eb1:	c7 45 ec c0 89 10 80 	movl   $0x801089c0,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104eb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ebb:	8d 50 6c             	lea    0x6c(%eax),%edx
80104ebe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ec1:	8b 40 10             	mov    0x10(%eax),%eax
80104ec4:	52                   	push   %edx
80104ec5:	ff 75 ec             	pushl  -0x14(%ebp)
80104ec8:	50                   	push   %eax
80104ec9:	68 c4 89 10 80       	push   $0x801089c4
80104ece:	e8 2d b5 ff ff       	call   80100400 <cprintf>
80104ed3:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104ed6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ed9:	8b 40 0c             	mov    0xc(%eax),%eax
80104edc:	83 f8 02             	cmp    $0x2,%eax
80104edf:	75 54                	jne    80104f35 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ee1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ee4:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ee7:	8b 40 0c             	mov    0xc(%eax),%eax
80104eea:	83 c0 08             	add    $0x8,%eax
80104eed:	89 c2                	mov    %eax,%edx
80104eef:	83 ec 08             	sub    $0x8,%esp
80104ef2:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ef5:	50                   	push   %eax
80104ef6:	52                   	push   %edx
80104ef7:	e8 9e 02 00 00       	call   8010519a <getcallerpcs>
80104efc:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104eff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104f06:	eb 1c                	jmp    80104f24 <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104f08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f0b:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f0f:	83 ec 08             	sub    $0x8,%esp
80104f12:	50                   	push   %eax
80104f13:	68 cd 89 10 80       	push   $0x801089cd
80104f18:	e8 e3 b4 ff ff       	call   80100400 <cprintf>
80104f1d:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104f20:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104f24:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104f28:	7f 0b                	jg     80104f35 <procdump+0xd2>
80104f2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f2d:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f31:	85 c0                	test   %eax,%eax
80104f33:	75 d3                	jne    80104f08 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104f35:	83 ec 0c             	sub    $0xc,%esp
80104f38:	68 d1 89 10 80       	push   $0x801089d1
80104f3d:	e8 be b4 ff ff       	call   80100400 <cprintf>
80104f42:	83 c4 10             	add    $0x10,%esp
80104f45:	eb 01                	jmp    80104f48 <procdump+0xe5>
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104f47:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f48:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104f4c:	81 7d f0 54 5d 11 80 	cmpl   $0x80115d54,-0x10(%ebp)
80104f53:	0f 82 1c ff ff ff    	jb     80104e75 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104f59:	90                   	nop
80104f5a:	c9                   	leave  
80104f5b:	c3                   	ret    

80104f5c <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104f5c:	55                   	push   %ebp
80104f5d:	89 e5                	mov    %esp,%ebp
80104f5f:	83 ec 08             	sub    $0x8,%esp
  initlock(&lk->lk, "sleep lock");
80104f62:	8b 45 08             	mov    0x8(%ebp),%eax
80104f65:	83 c0 04             	add    $0x4,%eax
80104f68:	83 ec 08             	sub    $0x8,%esp
80104f6b:	68 fd 89 10 80       	push   $0x801089fd
80104f70:	50                   	push   %eax
80104f71:	e8 44 01 00 00       	call   801050ba <initlock>
80104f76:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80104f79:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7c:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f7f:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
80104f82:	8b 45 08             	mov    0x8(%ebp),%eax
80104f85:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80104f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f8e:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80104f95:	90                   	nop
80104f96:	c9                   	leave  
80104f97:	c3                   	ret    

80104f98 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104f98:	55                   	push   %ebp
80104f99:	89 e5                	mov    %esp,%ebp
80104f9b:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80104f9e:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa1:	83 c0 04             	add    $0x4,%eax
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	50                   	push   %eax
80104fa8:	e8 2f 01 00 00       	call   801050dc <acquire>
80104fad:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80104fb0:	eb 15                	jmp    80104fc7 <acquiresleep+0x2f>
    sleep(lk, &lk->lk);
80104fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb5:	83 c0 04             	add    $0x4,%eax
80104fb8:	83 ec 08             	sub    $0x8,%esp
80104fbb:	50                   	push   %eax
80104fbc:	ff 75 08             	pushl  0x8(%ebp)
80104fbf:	e8 f9 fc ff ff       	call   80104cbd <sleep>
80104fc4:	83 c4 10             	add    $0x10,%esp

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80104fc7:	8b 45 08             	mov    0x8(%ebp),%eax
80104fca:	8b 00                	mov    (%eax),%eax
80104fcc:	85 c0                	test   %eax,%eax
80104fce:	75 e2                	jne    80104fb2 <acquiresleep+0x1a>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104fd0:	8b 45 08             	mov    0x8(%ebp),%eax
80104fd3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = proc->pid;
80104fd9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104fdf:	8b 50 10             	mov    0x10(%eax),%edx
80104fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe5:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80104fe8:	8b 45 08             	mov    0x8(%ebp),%eax
80104feb:	83 c0 04             	add    $0x4,%eax
80104fee:	83 ec 0c             	sub    $0xc,%esp
80104ff1:	50                   	push   %eax
80104ff2:	e8 51 01 00 00       	call   80105148 <release>
80104ff7:	83 c4 10             	add    $0x10,%esp
}
80104ffa:	90                   	nop
80104ffb:	c9                   	leave  
80104ffc:	c3                   	ret    

80104ffd <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ffd:	55                   	push   %ebp
80104ffe:	89 e5                	mov    %esp,%ebp
80105000:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80105003:	8b 45 08             	mov    0x8(%ebp),%eax
80105006:	83 c0 04             	add    $0x4,%eax
80105009:	83 ec 0c             	sub    $0xc,%esp
8010500c:	50                   	push   %eax
8010500d:	e8 ca 00 00 00       	call   801050dc <acquire>
80105012:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
80105015:	8b 45 08             	mov    0x8(%ebp),%eax
80105018:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
8010501e:	8b 45 08             	mov    0x8(%ebp),%eax
80105021:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
80105028:	83 ec 0c             	sub    $0xc,%esp
8010502b:	ff 75 08             	pushl  0x8(%ebp)
8010502e:	e8 75 fd ff ff       	call   80104da8 <wakeup>
80105033:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
80105036:	8b 45 08             	mov    0x8(%ebp),%eax
80105039:	83 c0 04             	add    $0x4,%eax
8010503c:	83 ec 0c             	sub    $0xc,%esp
8010503f:	50                   	push   %eax
80105040:	e8 03 01 00 00       	call   80105148 <release>
80105045:	83 c4 10             	add    $0x10,%esp
}
80105048:	90                   	nop
80105049:	c9                   	leave  
8010504a:	c3                   	ret    

8010504b <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
8010504b:	55                   	push   %ebp
8010504c:	89 e5                	mov    %esp,%ebp
8010504e:	83 ec 18             	sub    $0x18,%esp
  int r;
  
  acquire(&lk->lk);
80105051:	8b 45 08             	mov    0x8(%ebp),%eax
80105054:	83 c0 04             	add    $0x4,%eax
80105057:	83 ec 0c             	sub    $0xc,%esp
8010505a:	50                   	push   %eax
8010505b:	e8 7c 00 00 00       	call   801050dc <acquire>
80105060:	83 c4 10             	add    $0x10,%esp
  r = lk->locked;
80105063:	8b 45 08             	mov    0x8(%ebp),%eax
80105066:	8b 00                	mov    (%eax),%eax
80105068:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
8010506b:	8b 45 08             	mov    0x8(%ebp),%eax
8010506e:	83 c0 04             	add    $0x4,%eax
80105071:	83 ec 0c             	sub    $0xc,%esp
80105074:	50                   	push   %eax
80105075:	e8 ce 00 00 00       	call   80105148 <release>
8010507a:	83 c4 10             	add    $0x10,%esp
  return r;
8010507d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105080:	c9                   	leave  
80105081:	c3                   	ret    

80105082 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80105082:	55                   	push   %ebp
80105083:	89 e5                	mov    %esp,%ebp
80105085:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105088:	9c                   	pushf  
80105089:	58                   	pop    %eax
8010508a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010508d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105090:	c9                   	leave  
80105091:	c3                   	ret    

80105092 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80105092:	55                   	push   %ebp
80105093:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105095:	fa                   	cli    
}
80105096:	90                   	nop
80105097:	5d                   	pop    %ebp
80105098:	c3                   	ret    

80105099 <sti>:

static inline void
sti(void)
{
80105099:	55                   	push   %ebp
8010509a:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
8010509c:	fb                   	sti    
}
8010509d:	90                   	nop
8010509e:	5d                   	pop    %ebp
8010509f:	c3                   	ret    

801050a0 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801050a6:	8b 55 08             	mov    0x8(%ebp),%edx
801050a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050af:	f0 87 02             	lock xchg %eax,(%edx)
801050b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801050b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801050b8:	c9                   	leave  
801050b9:	c3                   	ret    

801050ba <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801050ba:	55                   	push   %ebp
801050bb:	89 e5                	mov    %esp,%ebp
  lk->name = name;
801050bd:	8b 45 08             	mov    0x8(%ebp),%eax
801050c0:	8b 55 0c             	mov    0xc(%ebp),%edx
801050c3:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
801050c6:	8b 45 08             	mov    0x8(%ebp),%eax
801050c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
801050cf:	8b 45 08             	mov    0x8(%ebp),%eax
801050d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801050d9:	90                   	nop
801050da:	5d                   	pop    %ebp
801050db:	c3                   	ret    

801050dc <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801050dc:	55                   	push   %ebp
801050dd:	89 e5                	mov    %esp,%ebp
801050df:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801050e2:	e8 57 01 00 00       	call   8010523e <pushcli>
  if(holding(lk))
801050e7:	8b 45 08             	mov    0x8(%ebp),%eax
801050ea:	83 ec 0c             	sub    $0xc,%esp
801050ed:	50                   	push   %eax
801050ee:	e8 21 01 00 00       	call   80105214 <holding>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	85 c0                	test   %eax,%eax
801050f8:	74 0d                	je     80105107 <acquire+0x2b>
    panic("acquire");
801050fa:	83 ec 0c             	sub    $0xc,%esp
801050fd:	68 08 8a 10 80       	push   $0x80108a08
80105102:	e8 99 b4 ff ff       	call   801005a0 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80105107:	90                   	nop
80105108:	8b 45 08             	mov    0x8(%ebp),%eax
8010510b:	83 ec 08             	sub    $0x8,%esp
8010510e:	6a 01                	push   $0x1
80105110:	50                   	push   %eax
80105111:	e8 8a ff ff ff       	call   801050a0 <xchg>
80105116:	83 c4 10             	add    $0x10,%esp
80105119:	85 c0                	test   %eax,%eax
8010511b:	75 eb                	jne    80105108 <acquire+0x2c>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010511d:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80105122:	8b 45 08             	mov    0x8(%ebp),%eax
80105125:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010512c:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
8010512f:	8b 45 08             	mov    0x8(%ebp),%eax
80105132:	83 c0 0c             	add    $0xc,%eax
80105135:	83 ec 08             	sub    $0x8,%esp
80105138:	50                   	push   %eax
80105139:	8d 45 08             	lea    0x8(%ebp),%eax
8010513c:	50                   	push   %eax
8010513d:	e8 58 00 00 00       	call   8010519a <getcallerpcs>
80105142:	83 c4 10             	add    $0x10,%esp
}
80105145:	90                   	nop
80105146:	c9                   	leave  
80105147:	c3                   	ret    

80105148 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80105148:	55                   	push   %ebp
80105149:	89 e5                	mov    %esp,%ebp
8010514b:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
8010514e:	83 ec 0c             	sub    $0xc,%esp
80105151:	ff 75 08             	pushl  0x8(%ebp)
80105154:	e8 bb 00 00 00       	call   80105214 <holding>
80105159:	83 c4 10             	add    $0x10,%esp
8010515c:	85 c0                	test   %eax,%eax
8010515e:	75 0d                	jne    8010516d <release+0x25>
    panic("release");
80105160:	83 ec 0c             	sub    $0xc,%esp
80105163:	68 10 8a 10 80       	push   $0x80108a10
80105168:	e8 33 b4 ff ff       	call   801005a0 <panic>

  lk->pcs[0] = 0;
8010516d:	8b 45 08             	mov    0x8(%ebp),%eax
80105170:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105177:	8b 45 08             	mov    0x8(%ebp),%eax
8010517a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80105181:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105186:	8b 45 08             	mov    0x8(%ebp),%eax
80105189:	8b 55 08             	mov    0x8(%ebp),%edx
8010518c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
80105192:	e8 fe 00 00 00       	call   80105295 <popcli>
}
80105197:	90                   	nop
80105198:	c9                   	leave  
80105199:	c3                   	ret    

8010519a <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
8010519a:	55                   	push   %ebp
8010519b:	89 e5                	mov    %esp,%ebp
8010519d:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801051a0:	8b 45 08             	mov    0x8(%ebp),%eax
801051a3:	83 e8 08             	sub    $0x8,%eax
801051a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801051a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801051b0:	eb 38                	jmp    801051ea <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051b2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801051b6:	74 53                	je     8010520b <getcallerpcs+0x71>
801051b8:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801051bf:	76 4a                	jbe    8010520b <getcallerpcs+0x71>
801051c1:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801051c5:	74 44                	je     8010520b <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
801051c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051ca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801051d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801051d4:	01 c2                	add    %eax,%edx
801051d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051d9:	8b 40 04             	mov    0x4(%eax),%eax
801051dc:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801051de:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051e1:	8b 00                	mov    (%eax),%eax
801051e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801051e6:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801051ea:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801051ee:	7e c2                	jle    801051b2 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801051f0:	eb 19                	jmp    8010520b <getcallerpcs+0x71>
    pcs[i] = 0;
801051f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801051fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ff:	01 d0                	add    %edx,%eax
80105201:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105207:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010520b:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
8010520f:	7e e1                	jle    801051f2 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80105211:	90                   	nop
80105212:	c9                   	leave  
80105213:	c3                   	ret    

80105214 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105214:	55                   	push   %ebp
80105215:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105217:	8b 45 08             	mov    0x8(%ebp),%eax
8010521a:	8b 00                	mov    (%eax),%eax
8010521c:	85 c0                	test   %eax,%eax
8010521e:	74 17                	je     80105237 <holding+0x23>
80105220:	8b 45 08             	mov    0x8(%ebp),%eax
80105223:	8b 50 08             	mov    0x8(%eax),%edx
80105226:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010522c:	39 c2                	cmp    %eax,%edx
8010522e:	75 07                	jne    80105237 <holding+0x23>
80105230:	b8 01 00 00 00       	mov    $0x1,%eax
80105235:	eb 05                	jmp    8010523c <holding+0x28>
80105237:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010523c:	5d                   	pop    %ebp
8010523d:	c3                   	ret    

8010523e <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
8010523e:	55                   	push   %ebp
8010523f:	89 e5                	mov    %esp,%ebp
80105241:	83 ec 10             	sub    $0x10,%esp
  int eflags;

  eflags = readeflags();
80105244:	e8 39 fe ff ff       	call   80105082 <readeflags>
80105249:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
8010524c:	e8 41 fe ff ff       	call   80105092 <cli>
  if(cpu->ncli == 0)
80105251:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105257:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010525d:	85 c0                	test   %eax,%eax
8010525f:	75 15                	jne    80105276 <pushcli+0x38>
    cpu->intena = eflags & FL_IF;
80105261:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105267:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010526a:	81 e2 00 02 00 00    	and    $0x200,%edx
80105270:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  cpu->ncli += 1;
80105276:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010527c:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105283:	8b 92 ac 00 00 00    	mov    0xac(%edx),%edx
80105289:	83 c2 01             	add    $0x1,%edx
8010528c:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
80105292:	90                   	nop
80105293:	c9                   	leave  
80105294:	c3                   	ret    

80105295 <popcli>:

void
popcli(void)
{
80105295:	55                   	push   %ebp
80105296:	89 e5                	mov    %esp,%ebp
80105298:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
8010529b:	e8 e2 fd ff ff       	call   80105082 <readeflags>
801052a0:	25 00 02 00 00       	and    $0x200,%eax
801052a5:	85 c0                	test   %eax,%eax
801052a7:	74 0d                	je     801052b6 <popcli+0x21>
    panic("popcli - interruptible");
801052a9:	83 ec 0c             	sub    $0xc,%esp
801052ac:	68 18 8a 10 80       	push   $0x80108a18
801052b1:	e8 ea b2 ff ff       	call   801005a0 <panic>
  if(--cpu->ncli < 0)
801052b6:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052bc:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801052c2:	83 ea 01             	sub    $0x1,%edx
801052c5:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801052cb:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801052d1:	85 c0                	test   %eax,%eax
801052d3:	79 0d                	jns    801052e2 <popcli+0x4d>
    panic("popcli");
801052d5:	83 ec 0c             	sub    $0xc,%esp
801052d8:	68 2f 8a 10 80       	push   $0x80108a2f
801052dd:	e8 be b2 ff ff       	call   801005a0 <panic>
  if(cpu->ncli == 0 && cpu->intena)
801052e2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052e8:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801052ee:	85 c0                	test   %eax,%eax
801052f0:	75 15                	jne    80105307 <popcli+0x72>
801052f2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052f8:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801052fe:	85 c0                	test   %eax,%eax
80105300:	74 05                	je     80105307 <popcli+0x72>
    sti();
80105302:	e8 92 fd ff ff       	call   80105099 <sti>
}
80105307:	90                   	nop
80105308:	c9                   	leave  
80105309:	c3                   	ret    

8010530a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010530a:	55                   	push   %ebp
8010530b:	89 e5                	mov    %esp,%ebp
8010530d:	57                   	push   %edi
8010530e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
8010530f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105312:	8b 55 10             	mov    0x10(%ebp),%edx
80105315:	8b 45 0c             	mov    0xc(%ebp),%eax
80105318:	89 cb                	mov    %ecx,%ebx
8010531a:	89 df                	mov    %ebx,%edi
8010531c:	89 d1                	mov    %edx,%ecx
8010531e:	fc                   	cld    
8010531f:	f3 aa                	rep stos %al,%es:(%edi)
80105321:	89 ca                	mov    %ecx,%edx
80105323:	89 fb                	mov    %edi,%ebx
80105325:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105328:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010532b:	90                   	nop
8010532c:	5b                   	pop    %ebx
8010532d:	5f                   	pop    %edi
8010532e:	5d                   	pop    %ebp
8010532f:	c3                   	ret    

80105330 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	57                   	push   %edi
80105334:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105335:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105338:	8b 55 10             	mov    0x10(%ebp),%edx
8010533b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010533e:	89 cb                	mov    %ecx,%ebx
80105340:	89 df                	mov    %ebx,%edi
80105342:	89 d1                	mov    %edx,%ecx
80105344:	fc                   	cld    
80105345:	f3 ab                	rep stos %eax,%es:(%edi)
80105347:	89 ca                	mov    %ecx,%edx
80105349:	89 fb                	mov    %edi,%ebx
8010534b:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010534e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105351:	90                   	nop
80105352:	5b                   	pop    %ebx
80105353:	5f                   	pop    %edi
80105354:	5d                   	pop    %ebp
80105355:	c3                   	ret    

80105356 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105356:	55                   	push   %ebp
80105357:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80105359:	8b 45 08             	mov    0x8(%ebp),%eax
8010535c:	83 e0 03             	and    $0x3,%eax
8010535f:	85 c0                	test   %eax,%eax
80105361:	75 43                	jne    801053a6 <memset+0x50>
80105363:	8b 45 10             	mov    0x10(%ebp),%eax
80105366:	83 e0 03             	and    $0x3,%eax
80105369:	85 c0                	test   %eax,%eax
8010536b:	75 39                	jne    801053a6 <memset+0x50>
    c &= 0xFF;
8010536d:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105374:	8b 45 10             	mov    0x10(%ebp),%eax
80105377:	c1 e8 02             	shr    $0x2,%eax
8010537a:	89 c1                	mov    %eax,%ecx
8010537c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010537f:	c1 e0 18             	shl    $0x18,%eax
80105382:	89 c2                	mov    %eax,%edx
80105384:	8b 45 0c             	mov    0xc(%ebp),%eax
80105387:	c1 e0 10             	shl    $0x10,%eax
8010538a:	09 c2                	or     %eax,%edx
8010538c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010538f:	c1 e0 08             	shl    $0x8,%eax
80105392:	09 d0                	or     %edx,%eax
80105394:	0b 45 0c             	or     0xc(%ebp),%eax
80105397:	51                   	push   %ecx
80105398:	50                   	push   %eax
80105399:	ff 75 08             	pushl  0x8(%ebp)
8010539c:	e8 8f ff ff ff       	call   80105330 <stosl>
801053a1:	83 c4 0c             	add    $0xc,%esp
801053a4:	eb 12                	jmp    801053b8 <memset+0x62>
  } else
    stosb(dst, c, n);
801053a6:	8b 45 10             	mov    0x10(%ebp),%eax
801053a9:	50                   	push   %eax
801053aa:	ff 75 0c             	pushl  0xc(%ebp)
801053ad:	ff 75 08             	pushl  0x8(%ebp)
801053b0:	e8 55 ff ff ff       	call   8010530a <stosb>
801053b5:	83 c4 0c             	add    $0xc,%esp
  return dst;
801053b8:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053bb:	c9                   	leave  
801053bc:	c3                   	ret    

801053bd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801053bd:	55                   	push   %ebp
801053be:	89 e5                	mov    %esp,%ebp
801053c0:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
801053c3:	8b 45 08             	mov    0x8(%ebp),%eax
801053c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801053c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801053cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801053cf:	eb 30                	jmp    80105401 <memcmp+0x44>
    if(*s1 != *s2)
801053d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053d4:	0f b6 10             	movzbl (%eax),%edx
801053d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053da:	0f b6 00             	movzbl (%eax),%eax
801053dd:	38 c2                	cmp    %al,%dl
801053df:	74 18                	je     801053f9 <memcmp+0x3c>
      return *s1 - *s2;
801053e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053e4:	0f b6 00             	movzbl (%eax),%eax
801053e7:	0f b6 d0             	movzbl %al,%edx
801053ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053ed:	0f b6 00             	movzbl (%eax),%eax
801053f0:	0f b6 c0             	movzbl %al,%eax
801053f3:	29 c2                	sub    %eax,%edx
801053f5:	89 d0                	mov    %edx,%eax
801053f7:	eb 1a                	jmp    80105413 <memcmp+0x56>
    s1++, s2++;
801053f9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801053fd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105401:	8b 45 10             	mov    0x10(%ebp),%eax
80105404:	8d 50 ff             	lea    -0x1(%eax),%edx
80105407:	89 55 10             	mov    %edx,0x10(%ebp)
8010540a:	85 c0                	test   %eax,%eax
8010540c:	75 c3                	jne    801053d1 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010540e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105413:	c9                   	leave  
80105414:	c3                   	ret    

80105415 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105415:	55                   	push   %ebp
80105416:	89 e5                	mov    %esp,%ebp
80105418:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010541b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010541e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105421:	8b 45 08             	mov    0x8(%ebp),%eax
80105424:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105427:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010542a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010542d:	73 54                	jae    80105483 <memmove+0x6e>
8010542f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105432:	8b 45 10             	mov    0x10(%ebp),%eax
80105435:	01 d0                	add    %edx,%eax
80105437:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010543a:	76 47                	jbe    80105483 <memmove+0x6e>
    s += n;
8010543c:	8b 45 10             	mov    0x10(%ebp),%eax
8010543f:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105442:	8b 45 10             	mov    0x10(%ebp),%eax
80105445:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80105448:	eb 13                	jmp    8010545d <memmove+0x48>
      *--d = *--s;
8010544a:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
8010544e:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105452:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105455:	0f b6 10             	movzbl (%eax),%edx
80105458:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010545b:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010545d:	8b 45 10             	mov    0x10(%ebp),%eax
80105460:	8d 50 ff             	lea    -0x1(%eax),%edx
80105463:	89 55 10             	mov    %edx,0x10(%ebp)
80105466:	85 c0                	test   %eax,%eax
80105468:	75 e0                	jne    8010544a <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010546a:	eb 24                	jmp    80105490 <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
8010546c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010546f:	8d 50 01             	lea    0x1(%eax),%edx
80105472:	89 55 f8             	mov    %edx,-0x8(%ebp)
80105475:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105478:	8d 4a 01             	lea    0x1(%edx),%ecx
8010547b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
8010547e:	0f b6 12             	movzbl (%edx),%edx
80105481:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105483:	8b 45 10             	mov    0x10(%ebp),%eax
80105486:	8d 50 ff             	lea    -0x1(%eax),%edx
80105489:	89 55 10             	mov    %edx,0x10(%ebp)
8010548c:	85 c0                	test   %eax,%eax
8010548e:	75 dc                	jne    8010546c <memmove+0x57>
      *d++ = *s++;

  return dst;
80105490:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105493:	c9                   	leave  
80105494:	c3                   	ret    

80105495 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105495:	55                   	push   %ebp
80105496:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80105498:	ff 75 10             	pushl  0x10(%ebp)
8010549b:	ff 75 0c             	pushl  0xc(%ebp)
8010549e:	ff 75 08             	pushl  0x8(%ebp)
801054a1:	e8 6f ff ff ff       	call   80105415 <memmove>
801054a6:	83 c4 0c             	add    $0xc,%esp
}
801054a9:	c9                   	leave  
801054aa:	c3                   	ret    

801054ab <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801054ab:	55                   	push   %ebp
801054ac:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801054ae:	eb 0c                	jmp    801054bc <strncmp+0x11>
    n--, p++, q++;
801054b0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801054b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801054b8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801054bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054c0:	74 1a                	je     801054dc <strncmp+0x31>
801054c2:	8b 45 08             	mov    0x8(%ebp),%eax
801054c5:	0f b6 00             	movzbl (%eax),%eax
801054c8:	84 c0                	test   %al,%al
801054ca:	74 10                	je     801054dc <strncmp+0x31>
801054cc:	8b 45 08             	mov    0x8(%ebp),%eax
801054cf:	0f b6 10             	movzbl (%eax),%edx
801054d2:	8b 45 0c             	mov    0xc(%ebp),%eax
801054d5:	0f b6 00             	movzbl (%eax),%eax
801054d8:	38 c2                	cmp    %al,%dl
801054da:	74 d4                	je     801054b0 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
801054dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054e0:	75 07                	jne    801054e9 <strncmp+0x3e>
    return 0;
801054e2:	b8 00 00 00 00       	mov    $0x0,%eax
801054e7:	eb 16                	jmp    801054ff <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
801054e9:	8b 45 08             	mov    0x8(%ebp),%eax
801054ec:	0f b6 00             	movzbl (%eax),%eax
801054ef:	0f b6 d0             	movzbl %al,%edx
801054f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801054f5:	0f b6 00             	movzbl (%eax),%eax
801054f8:	0f b6 c0             	movzbl %al,%eax
801054fb:	29 c2                	sub    %eax,%edx
801054fd:	89 d0                	mov    %edx,%eax
}
801054ff:	5d                   	pop    %ebp
80105500:	c3                   	ret    

80105501 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105501:	55                   	push   %ebp
80105502:	89 e5                	mov    %esp,%ebp
80105504:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80105507:	8b 45 08             	mov    0x8(%ebp),%eax
8010550a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010550d:	90                   	nop
8010550e:	8b 45 10             	mov    0x10(%ebp),%eax
80105511:	8d 50 ff             	lea    -0x1(%eax),%edx
80105514:	89 55 10             	mov    %edx,0x10(%ebp)
80105517:	85 c0                	test   %eax,%eax
80105519:	7e 2c                	jle    80105547 <strncpy+0x46>
8010551b:	8b 45 08             	mov    0x8(%ebp),%eax
8010551e:	8d 50 01             	lea    0x1(%eax),%edx
80105521:	89 55 08             	mov    %edx,0x8(%ebp)
80105524:	8b 55 0c             	mov    0xc(%ebp),%edx
80105527:	8d 4a 01             	lea    0x1(%edx),%ecx
8010552a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010552d:	0f b6 12             	movzbl (%edx),%edx
80105530:	88 10                	mov    %dl,(%eax)
80105532:	0f b6 00             	movzbl (%eax),%eax
80105535:	84 c0                	test   %al,%al
80105537:	75 d5                	jne    8010550e <strncpy+0xd>
    ;
  while(n-- > 0)
80105539:	eb 0c                	jmp    80105547 <strncpy+0x46>
    *s++ = 0;
8010553b:	8b 45 08             	mov    0x8(%ebp),%eax
8010553e:	8d 50 01             	lea    0x1(%eax),%edx
80105541:	89 55 08             	mov    %edx,0x8(%ebp)
80105544:	c6 00 00             	movb   $0x0,(%eax)
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105547:	8b 45 10             	mov    0x10(%ebp),%eax
8010554a:	8d 50 ff             	lea    -0x1(%eax),%edx
8010554d:	89 55 10             	mov    %edx,0x10(%ebp)
80105550:	85 c0                	test   %eax,%eax
80105552:	7f e7                	jg     8010553b <strncpy+0x3a>
    *s++ = 0;
  return os;
80105554:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105557:	c9                   	leave  
80105558:	c3                   	ret    

80105559 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105559:	55                   	push   %ebp
8010555a:	89 e5                	mov    %esp,%ebp
8010555c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
8010555f:	8b 45 08             	mov    0x8(%ebp),%eax
80105562:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105565:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105569:	7f 05                	jg     80105570 <safestrcpy+0x17>
    return os;
8010556b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010556e:	eb 31                	jmp    801055a1 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80105570:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105574:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105578:	7e 1e                	jle    80105598 <safestrcpy+0x3f>
8010557a:	8b 45 08             	mov    0x8(%ebp),%eax
8010557d:	8d 50 01             	lea    0x1(%eax),%edx
80105580:	89 55 08             	mov    %edx,0x8(%ebp)
80105583:	8b 55 0c             	mov    0xc(%ebp),%edx
80105586:	8d 4a 01             	lea    0x1(%edx),%ecx
80105589:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010558c:	0f b6 12             	movzbl (%edx),%edx
8010558f:	88 10                	mov    %dl,(%eax)
80105591:	0f b6 00             	movzbl (%eax),%eax
80105594:	84 c0                	test   %al,%al
80105596:	75 d8                	jne    80105570 <safestrcpy+0x17>
    ;
  *s = 0;
80105598:	8b 45 08             	mov    0x8(%ebp),%eax
8010559b:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010559e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801055a1:	c9                   	leave  
801055a2:	c3                   	ret    

801055a3 <strlen>:

int
strlen(const char *s)
{
801055a3:	55                   	push   %ebp
801055a4:	89 e5                	mov    %esp,%ebp
801055a6:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801055a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055b0:	eb 04                	jmp    801055b6 <strlen+0x13>
801055b2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055b9:	8b 45 08             	mov    0x8(%ebp),%eax
801055bc:	01 d0                	add    %edx,%eax
801055be:	0f b6 00             	movzbl (%eax),%eax
801055c1:	84 c0                	test   %al,%al
801055c3:	75 ed                	jne    801055b2 <strlen+0xf>
    ;
  return n;
801055c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801055c8:	c9                   	leave  
801055c9:	c3                   	ret    

801055ca <swtch>:
801055ca:	8b 44 24 04          	mov    0x4(%esp),%eax
801055ce:	8b 54 24 08          	mov    0x8(%esp),%edx
801055d2:	55                   	push   %ebp
801055d3:	53                   	push   %ebx
801055d4:	56                   	push   %esi
801055d5:	57                   	push   %edi
801055d6:	89 20                	mov    %esp,(%eax)
801055d8:	89 d4                	mov    %edx,%esp
801055da:	5f                   	pop    %edi
801055db:	5e                   	pop    %esi
801055dc:	5b                   	pop    %ebx
801055dd:	5d                   	pop    %ebp
801055de:	c3                   	ret    

801055df <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801055df:	55                   	push   %ebp
801055e0:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801055e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055e8:	8b 00                	mov    (%eax),%eax
801055ea:	3b 45 08             	cmp    0x8(%ebp),%eax
801055ed:	76 12                	jbe    80105601 <fetchint+0x22>
801055ef:	8b 45 08             	mov    0x8(%ebp),%eax
801055f2:	8d 50 04             	lea    0x4(%eax),%edx
801055f5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055fb:	8b 00                	mov    (%eax),%eax
801055fd:	39 c2                	cmp    %eax,%edx
801055ff:	76 07                	jbe    80105608 <fetchint+0x29>
    return -1;
80105601:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105606:	eb 0f                	jmp    80105617 <fetchint+0x38>
  *ip = *(int*)(addr);
80105608:	8b 45 08             	mov    0x8(%ebp),%eax
8010560b:	8b 10                	mov    (%eax),%edx
8010560d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105610:	89 10                	mov    %edx,(%eax)
  return 0;
80105612:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105617:	5d                   	pop    %ebp
80105618:	c3                   	ret    

80105619 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105619:	55                   	push   %ebp
8010561a:	89 e5                	mov    %esp,%ebp
8010561c:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
8010561f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105625:	8b 00                	mov    (%eax),%eax
80105627:	3b 45 08             	cmp    0x8(%ebp),%eax
8010562a:	77 07                	ja     80105633 <fetchstr+0x1a>
    return -1;
8010562c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105631:	eb 46                	jmp    80105679 <fetchstr+0x60>
  *pp = (char*)addr;
80105633:	8b 55 08             	mov    0x8(%ebp),%edx
80105636:	8b 45 0c             	mov    0xc(%ebp),%eax
80105639:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
8010563b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105641:	8b 00                	mov    (%eax),%eax
80105643:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105646:	8b 45 0c             	mov    0xc(%ebp),%eax
80105649:	8b 00                	mov    (%eax),%eax
8010564b:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010564e:	eb 1c                	jmp    8010566c <fetchstr+0x53>
    if(*s == 0)
80105650:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105653:	0f b6 00             	movzbl (%eax),%eax
80105656:	84 c0                	test   %al,%al
80105658:	75 0e                	jne    80105668 <fetchstr+0x4f>
      return s - *pp;
8010565a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010565d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105660:	8b 00                	mov    (%eax),%eax
80105662:	29 c2                	sub    %eax,%edx
80105664:	89 d0                	mov    %edx,%eax
80105666:	eb 11                	jmp    80105679 <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80105668:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010566c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010566f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105672:	72 dc                	jb     80105650 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105679:	c9                   	leave  
8010567a:	c3                   	ret    

8010567b <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010567b:	55                   	push   %ebp
8010567c:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010567e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105684:	8b 40 18             	mov    0x18(%eax),%eax
80105687:	8b 40 44             	mov    0x44(%eax),%eax
8010568a:	8b 55 08             	mov    0x8(%ebp),%edx
8010568d:	c1 e2 02             	shl    $0x2,%edx
80105690:	01 d0                	add    %edx,%eax
80105692:	83 c0 04             	add    $0x4,%eax
80105695:	ff 75 0c             	pushl  0xc(%ebp)
80105698:	50                   	push   %eax
80105699:	e8 41 ff ff ff       	call   801055df <fetchint>
8010569e:	83 c4 08             	add    $0x8,%esp
}
801056a1:	c9                   	leave  
801056a2:	c3                   	ret    

801056a3 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801056a3:	55                   	push   %ebp
801056a4:	89 e5                	mov    %esp,%ebp
801056a6:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(argint(n, &i) < 0)
801056a9:	8d 45 fc             	lea    -0x4(%ebp),%eax
801056ac:	50                   	push   %eax
801056ad:	ff 75 08             	pushl  0x8(%ebp)
801056b0:	e8 c6 ff ff ff       	call   8010567b <argint>
801056b5:	83 c4 08             	add    $0x8,%esp
801056b8:	85 c0                	test   %eax,%eax
801056ba:	79 07                	jns    801056c3 <argptr+0x20>
    return -1;
801056bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056c1:	eb 3b                	jmp    801056fe <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801056c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056c9:	8b 00                	mov    (%eax),%eax
801056cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056ce:	39 d0                	cmp    %edx,%eax
801056d0:	76 16                	jbe    801056e8 <argptr+0x45>
801056d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056d5:	89 c2                	mov    %eax,%edx
801056d7:	8b 45 10             	mov    0x10(%ebp),%eax
801056da:	01 c2                	add    %eax,%edx
801056dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056e2:	8b 00                	mov    (%eax),%eax
801056e4:	39 c2                	cmp    %eax,%edx
801056e6:	76 07                	jbe    801056ef <argptr+0x4c>
    return -1;
801056e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ed:	eb 0f                	jmp    801056fe <argptr+0x5b>
  *pp = (char*)i;
801056ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056f2:	89 c2                	mov    %eax,%edx
801056f4:	8b 45 0c             	mov    0xc(%ebp),%eax
801056f7:	89 10                	mov    %edx,(%eax)
  return 0;
801056f9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056fe:	c9                   	leave  
801056ff:	c3                   	ret    

80105700 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105706:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105709:	50                   	push   %eax
8010570a:	ff 75 08             	pushl  0x8(%ebp)
8010570d:	e8 69 ff ff ff       	call   8010567b <argint>
80105712:	83 c4 08             	add    $0x8,%esp
80105715:	85 c0                	test   %eax,%eax
80105717:	79 07                	jns    80105720 <argstr+0x20>
    return -1;
80105719:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010571e:	eb 0f                	jmp    8010572f <argstr+0x2f>
  return fetchstr(addr, pp);
80105720:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105723:	ff 75 0c             	pushl  0xc(%ebp)
80105726:	50                   	push   %eax
80105727:	e8 ed fe ff ff       	call   80105619 <fetchstr>
8010572c:	83 c4 08             	add    $0x8,%esp
}
8010572f:	c9                   	leave  
80105730:	c3                   	ret    

80105731 <syscall>:
[SYS_date]    sys_date,
};

void
syscall(void)
{
80105731:	55                   	push   %ebp
80105732:	89 e5                	mov    %esp,%ebp
80105734:	53                   	push   %ebx
80105735:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
80105738:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010573e:	8b 40 18             	mov    0x18(%eax),%eax
80105741:	8b 40 1c             	mov    0x1c(%eax),%eax
80105744:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105747:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010574b:	7e 30                	jle    8010577d <syscall+0x4c>
8010574d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105750:	83 f8 16             	cmp    $0x16,%eax
80105753:	77 28                	ja     8010577d <syscall+0x4c>
80105755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105758:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010575f:	85 c0                	test   %eax,%eax
80105761:	74 1a                	je     8010577d <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105763:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105769:	8b 58 18             	mov    0x18(%eax),%ebx
8010576c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010576f:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105776:	ff d0                	call   *%eax
80105778:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010577b:	eb 34                	jmp    801057b1 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010577d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105783:	8d 50 6c             	lea    0x6c(%eax),%edx
80105786:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010578c:	8b 40 10             	mov    0x10(%eax),%eax
8010578f:	ff 75 f4             	pushl  -0xc(%ebp)
80105792:	52                   	push   %edx
80105793:	50                   	push   %eax
80105794:	68 36 8a 10 80       	push   $0x80108a36
80105799:	e8 62 ac ff ff       	call   80100400 <cprintf>
8010579e:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801057a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057a7:	8b 40 18             	mov    0x18(%eax),%eax
801057aa:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801057b1:	90                   	nop
801057b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    

801057b7 <argfd>:
801057b7:	55                   	push   %ebp
801057b8:	89 e5                	mov    %esp,%ebp
801057ba:	83 ec 18             	sub    $0x18,%esp
801057bd:	83 ec 08             	sub    $0x8,%esp
801057c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057c3:	50                   	push   %eax
801057c4:	ff 75 08             	pushl  0x8(%ebp)
801057c7:	e8 af fe ff ff       	call   8010567b <argint>
801057cc:	83 c4 10             	add    $0x10,%esp
801057cf:	85 c0                	test   %eax,%eax
801057d1:	79 07                	jns    801057da <argfd+0x23>
801057d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057d8:	eb 50                	jmp    8010582a <argfd+0x73>
801057da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057dd:	85 c0                	test   %eax,%eax
801057df:	78 21                	js     80105802 <argfd+0x4b>
801057e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057e4:	83 f8 0f             	cmp    $0xf,%eax
801057e7:	7f 19                	jg     80105802 <argfd+0x4b>
801057e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
801057f2:	83 c2 08             	add    $0x8,%edx
801057f5:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801057f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801057fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105800:	75 07                	jne    80105809 <argfd+0x52>
80105802:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105807:	eb 21                	jmp    8010582a <argfd+0x73>
80105809:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010580d:	74 08                	je     80105817 <argfd+0x60>
8010580f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105812:	8b 45 0c             	mov    0xc(%ebp),%eax
80105815:	89 10                	mov    %edx,(%eax)
80105817:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010581b:	74 08                	je     80105825 <argfd+0x6e>
8010581d:	8b 45 10             	mov    0x10(%ebp),%eax
80105820:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105823:	89 10                	mov    %edx,(%eax)
80105825:	b8 00 00 00 00       	mov    $0x0,%eax
8010582a:	c9                   	leave  
8010582b:	c3                   	ret    

8010582c <fdalloc>:
8010582c:	55                   	push   %ebp
8010582d:	89 e5                	mov    %esp,%ebp
8010582f:	83 ec 10             	sub    $0x10,%esp
80105832:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105839:	eb 30                	jmp    8010586b <fdalloc+0x3f>
8010583b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105841:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105844:	83 c2 08             	add    $0x8,%edx
80105847:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010584b:	85 c0                	test   %eax,%eax
8010584d:	75 18                	jne    80105867 <fdalloc+0x3b>
8010584f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105855:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105858:	8d 4a 08             	lea    0x8(%edx),%ecx
8010585b:	8b 55 08             	mov    0x8(%ebp),%edx
8010585e:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
80105862:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105865:	eb 0f                	jmp    80105876 <fdalloc+0x4a>
80105867:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010586b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
8010586f:	7e ca                	jle    8010583b <fdalloc+0xf>
80105871:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105876:	c9                   	leave  
80105877:	c3                   	ret    

80105878 <sys_dup>:
80105878:	55                   	push   %ebp
80105879:	89 e5                	mov    %esp,%ebp
8010587b:	83 ec 18             	sub    $0x18,%esp
8010587e:	83 ec 04             	sub    $0x4,%esp
80105881:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105884:	50                   	push   %eax
80105885:	6a 00                	push   $0x0
80105887:	6a 00                	push   $0x0
80105889:	e8 29 ff ff ff       	call   801057b7 <argfd>
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	85 c0                	test   %eax,%eax
80105893:	79 07                	jns    8010589c <sys_dup+0x24>
80105895:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010589a:	eb 31                	jmp    801058cd <sys_dup+0x55>
8010589c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010589f:	83 ec 0c             	sub    $0xc,%esp
801058a2:	50                   	push   %eax
801058a3:	e8 84 ff ff ff       	call   8010582c <fdalloc>
801058a8:	83 c4 10             	add    $0x10,%esp
801058ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058b2:	79 07                	jns    801058bb <sys_dup+0x43>
801058b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058b9:	eb 12                	jmp    801058cd <sys_dup+0x55>
801058bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058be:	83 ec 0c             	sub    $0xc,%esp
801058c1:	50                   	push   %eax
801058c2:	e8 ac b7 ff ff       	call   80101073 <filedup>
801058c7:	83 c4 10             	add    $0x10,%esp
801058ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058cd:	c9                   	leave  
801058ce:	c3                   	ret    

801058cf <sys_read>:
801058cf:	55                   	push   %ebp
801058d0:	89 e5                	mov    %esp,%ebp
801058d2:	83 ec 18             	sub    $0x18,%esp
801058d5:	83 ec 04             	sub    $0x4,%esp
801058d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058db:	50                   	push   %eax
801058dc:	6a 00                	push   $0x0
801058de:	6a 00                	push   $0x0
801058e0:	e8 d2 fe ff ff       	call   801057b7 <argfd>
801058e5:	83 c4 10             	add    $0x10,%esp
801058e8:	85 c0                	test   %eax,%eax
801058ea:	78 2e                	js     8010591a <sys_read+0x4b>
801058ec:	83 ec 08             	sub    $0x8,%esp
801058ef:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058f2:	50                   	push   %eax
801058f3:	6a 02                	push   $0x2
801058f5:	e8 81 fd ff ff       	call   8010567b <argint>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	85 c0                	test   %eax,%eax
801058ff:	78 19                	js     8010591a <sys_read+0x4b>
80105901:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105904:	83 ec 04             	sub    $0x4,%esp
80105907:	50                   	push   %eax
80105908:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010590b:	50                   	push   %eax
8010590c:	6a 01                	push   $0x1
8010590e:	e8 90 fd ff ff       	call   801056a3 <argptr>
80105913:	83 c4 10             	add    $0x10,%esp
80105916:	85 c0                	test   %eax,%eax
80105918:	79 07                	jns    80105921 <sys_read+0x52>
8010591a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010591f:	eb 17                	jmp    80105938 <sys_read+0x69>
80105921:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105924:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105927:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010592a:	83 ec 04             	sub    $0x4,%esp
8010592d:	51                   	push   %ecx
8010592e:	52                   	push   %edx
8010592f:	50                   	push   %eax
80105930:	e8 ce b8 ff ff       	call   80101203 <fileread>
80105935:	83 c4 10             	add    $0x10,%esp
80105938:	c9                   	leave  
80105939:	c3                   	ret    

8010593a <sys_write>:
8010593a:	55                   	push   %ebp
8010593b:	89 e5                	mov    %esp,%ebp
8010593d:	83 ec 18             	sub    $0x18,%esp
80105940:	83 ec 04             	sub    $0x4,%esp
80105943:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105946:	50                   	push   %eax
80105947:	6a 00                	push   $0x0
80105949:	6a 00                	push   $0x0
8010594b:	e8 67 fe ff ff       	call   801057b7 <argfd>
80105950:	83 c4 10             	add    $0x10,%esp
80105953:	85 c0                	test   %eax,%eax
80105955:	78 2e                	js     80105985 <sys_write+0x4b>
80105957:	83 ec 08             	sub    $0x8,%esp
8010595a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010595d:	50                   	push   %eax
8010595e:	6a 02                	push   $0x2
80105960:	e8 16 fd ff ff       	call   8010567b <argint>
80105965:	83 c4 10             	add    $0x10,%esp
80105968:	85 c0                	test   %eax,%eax
8010596a:	78 19                	js     80105985 <sys_write+0x4b>
8010596c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010596f:	83 ec 04             	sub    $0x4,%esp
80105972:	50                   	push   %eax
80105973:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105976:	50                   	push   %eax
80105977:	6a 01                	push   $0x1
80105979:	e8 25 fd ff ff       	call   801056a3 <argptr>
8010597e:	83 c4 10             	add    $0x10,%esp
80105981:	85 c0                	test   %eax,%eax
80105983:	79 07                	jns    8010598c <sys_write+0x52>
80105985:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010598a:	eb 17                	jmp    801059a3 <sys_write+0x69>
8010598c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010598f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105992:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105995:	83 ec 04             	sub    $0x4,%esp
80105998:	51                   	push   %ecx
80105999:	52                   	push   %edx
8010599a:	50                   	push   %eax
8010599b:	e8 1b b9 ff ff       	call   801012bb <filewrite>
801059a0:	83 c4 10             	add    $0x10,%esp
801059a3:	c9                   	leave  
801059a4:	c3                   	ret    

801059a5 <sys_close>:
801059a5:	55                   	push   %ebp
801059a6:	89 e5                	mov    %esp,%ebp
801059a8:	83 ec 18             	sub    $0x18,%esp
801059ab:	83 ec 04             	sub    $0x4,%esp
801059ae:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059b1:	50                   	push   %eax
801059b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059b5:	50                   	push   %eax
801059b6:	6a 00                	push   $0x0
801059b8:	e8 fa fd ff ff       	call   801057b7 <argfd>
801059bd:	83 c4 10             	add    $0x10,%esp
801059c0:	85 c0                	test   %eax,%eax
801059c2:	79 07                	jns    801059cb <sys_close+0x26>
801059c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059c9:	eb 28                	jmp    801059f3 <sys_close+0x4e>
801059cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059d4:	83 c2 08             	add    $0x8,%edx
801059d7:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801059de:	00 
801059df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059e2:	83 ec 0c             	sub    $0xc,%esp
801059e5:	50                   	push   %eax
801059e6:	e8 d9 b6 ff ff       	call   801010c4 <fileclose>
801059eb:	83 c4 10             	add    $0x10,%esp
801059ee:	b8 00 00 00 00       	mov    $0x0,%eax
801059f3:	c9                   	leave  
801059f4:	c3                   	ret    

801059f5 <sys_fstat>:
801059f5:	55                   	push   %ebp
801059f6:	89 e5                	mov    %esp,%ebp
801059f8:	83 ec 18             	sub    $0x18,%esp
801059fb:	83 ec 04             	sub    $0x4,%esp
801059fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a01:	50                   	push   %eax
80105a02:	6a 00                	push   $0x0
80105a04:	6a 00                	push   $0x0
80105a06:	e8 ac fd ff ff       	call   801057b7 <argfd>
80105a0b:	83 c4 10             	add    $0x10,%esp
80105a0e:	85 c0                	test   %eax,%eax
80105a10:	78 17                	js     80105a29 <sys_fstat+0x34>
80105a12:	83 ec 04             	sub    $0x4,%esp
80105a15:	6a 14                	push   $0x14
80105a17:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a1a:	50                   	push   %eax
80105a1b:	6a 01                	push   $0x1
80105a1d:	e8 81 fc ff ff       	call   801056a3 <argptr>
80105a22:	83 c4 10             	add    $0x10,%esp
80105a25:	85 c0                	test   %eax,%eax
80105a27:	79 07                	jns    80105a30 <sys_fstat+0x3b>
80105a29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a2e:	eb 13                	jmp    80105a43 <sys_fstat+0x4e>
80105a30:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a36:	83 ec 08             	sub    $0x8,%esp
80105a39:	52                   	push   %edx
80105a3a:	50                   	push   %eax
80105a3b:	e8 6c b7 ff ff       	call   801011ac <filestat>
80105a40:	83 c4 10             	add    $0x10,%esp
80105a43:	c9                   	leave  
80105a44:	c3                   	ret    

80105a45 <sys_link>:
80105a45:	55                   	push   %ebp
80105a46:	89 e5                	mov    %esp,%ebp
80105a48:	83 ec 28             	sub    $0x28,%esp
80105a4b:	83 ec 08             	sub    $0x8,%esp
80105a4e:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a51:	50                   	push   %eax
80105a52:	6a 00                	push   $0x0
80105a54:	e8 a7 fc ff ff       	call   80105700 <argstr>
80105a59:	83 c4 10             	add    $0x10,%esp
80105a5c:	85 c0                	test   %eax,%eax
80105a5e:	78 15                	js     80105a75 <sys_link+0x30>
80105a60:	83 ec 08             	sub    $0x8,%esp
80105a63:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105a66:	50                   	push   %eax
80105a67:	6a 01                	push   $0x1
80105a69:	e8 92 fc ff ff       	call   80105700 <argstr>
80105a6e:	83 c4 10             	add    $0x10,%esp
80105a71:	85 c0                	test   %eax,%eax
80105a73:	79 0a                	jns    80105a7f <sys_link+0x3a>
80105a75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a7a:	e9 68 01 00 00       	jmp    80105be7 <sys_link+0x1a2>
80105a7f:	e8 5d db ff ff       	call   801035e1 <begin_op>
80105a84:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105a87:	83 ec 0c             	sub    $0xc,%esp
80105a8a:	50                   	push   %eax
80105a8b:	e8 b9 ca ff ff       	call   80102549 <namei>
80105a90:	83 c4 10             	add    $0x10,%esp
80105a93:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105a96:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105a9a:	75 0f                	jne    80105aab <sys_link+0x66>
80105a9c:	e8 cc db ff ff       	call   8010366d <end_op>
80105aa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aa6:	e9 3c 01 00 00       	jmp    80105be7 <sys_link+0x1a2>
80105aab:	83 ec 0c             	sub    $0xc,%esp
80105aae:	ff 75 f4             	pushl  -0xc(%ebp)
80105ab1:	e8 6d bf ff ff       	call   80101a23 <ilock>
80105ab6:	83 c4 10             	add    $0x10,%esp
80105ab9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105abc:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105ac0:	66 83 f8 01          	cmp    $0x1,%ax
80105ac4:	75 1d                	jne    80105ae3 <sys_link+0x9e>
80105ac6:	83 ec 0c             	sub    $0xc,%esp
80105ac9:	ff 75 f4             	pushl  -0xc(%ebp)
80105acc:	e8 68 c1 ff ff       	call   80101c39 <iunlockput>
80105ad1:	83 c4 10             	add    $0x10,%esp
80105ad4:	e8 94 db ff ff       	call   8010366d <end_op>
80105ad9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ade:	e9 04 01 00 00       	jmp    80105be7 <sys_link+0x1a2>
80105ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae6:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105aea:	83 c0 01             	add    $0x1,%eax
80105aed:	89 c2                	mov    %eax,%edx
80105aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105af2:	66 89 50 56          	mov    %dx,0x56(%eax)
80105af6:	83 ec 0c             	sub    $0xc,%esp
80105af9:	ff 75 f4             	pushl  -0xc(%ebp)
80105afc:	e8 45 bd ff ff       	call   80101846 <iupdate>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	83 ec 0c             	sub    $0xc,%esp
80105b07:	ff 75 f4             	pushl  -0xc(%ebp)
80105b0a:	e8 31 c0 ff ff       	call   80101b40 <iunlock>
80105b0f:	83 c4 10             	add    $0x10,%esp
80105b12:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b15:	83 ec 08             	sub    $0x8,%esp
80105b18:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105b1b:	52                   	push   %edx
80105b1c:	50                   	push   %eax
80105b1d:	e8 43 ca ff ff       	call   80102565 <nameiparent>
80105b22:	83 c4 10             	add    $0x10,%esp
80105b25:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b2c:	74 71                	je     80105b9f <sys_link+0x15a>
80105b2e:	83 ec 0c             	sub    $0xc,%esp
80105b31:	ff 75 f0             	pushl  -0x10(%ebp)
80105b34:	e8 ea be ff ff       	call   80101a23 <ilock>
80105b39:	83 c4 10             	add    $0x10,%esp
80105b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b3f:	8b 10                	mov    (%eax),%edx
80105b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b44:	8b 00                	mov    (%eax),%eax
80105b46:	39 c2                	cmp    %eax,%edx
80105b48:	75 1d                	jne    80105b67 <sys_link+0x122>
80105b4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b4d:	8b 40 04             	mov    0x4(%eax),%eax
80105b50:	83 ec 04             	sub    $0x4,%esp
80105b53:	50                   	push   %eax
80105b54:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105b57:	50                   	push   %eax
80105b58:	ff 75 f0             	pushl  -0x10(%ebp)
80105b5b:	e8 4d c7 ff ff       	call   801022ad <dirlink>
80105b60:	83 c4 10             	add    $0x10,%esp
80105b63:	85 c0                	test   %eax,%eax
80105b65:	79 10                	jns    80105b77 <sys_link+0x132>
80105b67:	83 ec 0c             	sub    $0xc,%esp
80105b6a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b6d:	e8 c7 c0 ff ff       	call   80101c39 <iunlockput>
80105b72:	83 c4 10             	add    $0x10,%esp
80105b75:	eb 29                	jmp    80105ba0 <sys_link+0x15b>
80105b77:	83 ec 0c             	sub    $0xc,%esp
80105b7a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b7d:	e8 b7 c0 ff ff       	call   80101c39 <iunlockput>
80105b82:	83 c4 10             	add    $0x10,%esp
80105b85:	83 ec 0c             	sub    $0xc,%esp
80105b88:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8b:	e8 fe bf ff ff       	call   80101b8e <iput>
80105b90:	83 c4 10             	add    $0x10,%esp
80105b93:	e8 d5 da ff ff       	call   8010366d <end_op>
80105b98:	b8 00 00 00 00       	mov    $0x0,%eax
80105b9d:	eb 48                	jmp    80105be7 <sys_link+0x1a2>
80105b9f:	90                   	nop
80105ba0:	83 ec 0c             	sub    $0xc,%esp
80105ba3:	ff 75 f4             	pushl  -0xc(%ebp)
80105ba6:	e8 78 be ff ff       	call   80101a23 <ilock>
80105bab:	83 c4 10             	add    $0x10,%esp
80105bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bb1:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105bb5:	83 e8 01             	sub    $0x1,%eax
80105bb8:	89 c2                	mov    %eax,%edx
80105bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bbd:	66 89 50 56          	mov    %dx,0x56(%eax)
80105bc1:	83 ec 0c             	sub    $0xc,%esp
80105bc4:	ff 75 f4             	pushl  -0xc(%ebp)
80105bc7:	e8 7a bc ff ff       	call   80101846 <iupdate>
80105bcc:	83 c4 10             	add    $0x10,%esp
80105bcf:	83 ec 0c             	sub    $0xc,%esp
80105bd2:	ff 75 f4             	pushl  -0xc(%ebp)
80105bd5:	e8 5f c0 ff ff       	call   80101c39 <iunlockput>
80105bda:	83 c4 10             	add    $0x10,%esp
80105bdd:	e8 8b da ff ff       	call   8010366d <end_op>
80105be2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105be7:	c9                   	leave  
80105be8:	c3                   	ret    

80105be9 <isdirempty>:
80105be9:	55                   	push   %ebp
80105bea:	89 e5                	mov    %esp,%ebp
80105bec:	83 ec 28             	sub    $0x28,%esp
80105bef:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105bf6:	eb 40                	jmp    80105c38 <isdirempty+0x4f>
80105bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bfb:	6a 10                	push   $0x10
80105bfd:	50                   	push   %eax
80105bfe:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c01:	50                   	push   %eax
80105c02:	ff 75 08             	pushl  0x8(%ebp)
80105c05:	e8 ef c2 ff ff       	call   80101ef9 <readi>
80105c0a:	83 c4 10             	add    $0x10,%esp
80105c0d:	83 f8 10             	cmp    $0x10,%eax
80105c10:	74 0d                	je     80105c1f <isdirempty+0x36>
80105c12:	83 ec 0c             	sub    $0xc,%esp
80105c15:	68 52 8a 10 80       	push   $0x80108a52
80105c1a:	e8 81 a9 ff ff       	call   801005a0 <panic>
80105c1f:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105c23:	66 85 c0             	test   %ax,%ax
80105c26:	74 07                	je     80105c2f <isdirempty+0x46>
80105c28:	b8 00 00 00 00       	mov    $0x0,%eax
80105c2d:	eb 1b                	jmp    80105c4a <isdirempty+0x61>
80105c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c32:	83 c0 10             	add    $0x10,%eax
80105c35:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c38:	8b 45 08             	mov    0x8(%ebp),%eax
80105c3b:	8b 50 58             	mov    0x58(%eax),%edx
80105c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c41:	39 c2                	cmp    %eax,%edx
80105c43:	77 b3                	ja     80105bf8 <isdirempty+0xf>
80105c45:	b8 01 00 00 00       	mov    $0x1,%eax
80105c4a:	c9                   	leave  
80105c4b:	c3                   	ret    

80105c4c <sys_unlink>:
80105c4c:	55                   	push   %ebp
80105c4d:	89 e5                	mov    %esp,%ebp
80105c4f:	83 ec 38             	sub    $0x38,%esp
80105c52:	83 ec 08             	sub    $0x8,%esp
80105c55:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105c58:	50                   	push   %eax
80105c59:	6a 00                	push   $0x0
80105c5b:	e8 a0 fa ff ff       	call   80105700 <argstr>
80105c60:	83 c4 10             	add    $0x10,%esp
80105c63:	85 c0                	test   %eax,%eax
80105c65:	79 0a                	jns    80105c71 <sys_unlink+0x25>
80105c67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c6c:	e9 bc 01 00 00       	jmp    80105e2d <sys_unlink+0x1e1>
80105c71:	e8 6b d9 ff ff       	call   801035e1 <begin_op>
80105c76:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105c79:	83 ec 08             	sub    $0x8,%esp
80105c7c:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105c7f:	52                   	push   %edx
80105c80:	50                   	push   %eax
80105c81:	e8 df c8 ff ff       	call   80102565 <nameiparent>
80105c86:	83 c4 10             	add    $0x10,%esp
80105c89:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c8c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c90:	75 0f                	jne    80105ca1 <sys_unlink+0x55>
80105c92:	e8 d6 d9 ff ff       	call   8010366d <end_op>
80105c97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9c:	e9 8c 01 00 00       	jmp    80105e2d <sys_unlink+0x1e1>
80105ca1:	83 ec 0c             	sub    $0xc,%esp
80105ca4:	ff 75 f4             	pushl  -0xc(%ebp)
80105ca7:	e8 77 bd ff ff       	call   80101a23 <ilock>
80105cac:	83 c4 10             	add    $0x10,%esp
80105caf:	83 ec 08             	sub    $0x8,%esp
80105cb2:	68 64 8a 10 80       	push   $0x80108a64
80105cb7:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cba:	50                   	push   %eax
80105cbb:	e8 18 c5 ff ff       	call   801021d8 <namecmp>
80105cc0:	83 c4 10             	add    $0x10,%esp
80105cc3:	85 c0                	test   %eax,%eax
80105cc5:	0f 84 4a 01 00 00    	je     80105e15 <sys_unlink+0x1c9>
80105ccb:	83 ec 08             	sub    $0x8,%esp
80105cce:	68 66 8a 10 80       	push   $0x80108a66
80105cd3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cd6:	50                   	push   %eax
80105cd7:	e8 fc c4 ff ff       	call   801021d8 <namecmp>
80105cdc:	83 c4 10             	add    $0x10,%esp
80105cdf:	85 c0                	test   %eax,%eax
80105ce1:	0f 84 2e 01 00 00    	je     80105e15 <sys_unlink+0x1c9>
80105ce7:	83 ec 04             	sub    $0x4,%esp
80105cea:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105ced:	50                   	push   %eax
80105cee:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105cf1:	50                   	push   %eax
80105cf2:	ff 75 f4             	pushl  -0xc(%ebp)
80105cf5:	e8 f9 c4 ff ff       	call   801021f3 <dirlookup>
80105cfa:	83 c4 10             	add    $0x10,%esp
80105cfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d00:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d04:	0f 84 0a 01 00 00    	je     80105e14 <sys_unlink+0x1c8>
80105d0a:	83 ec 0c             	sub    $0xc,%esp
80105d0d:	ff 75 f0             	pushl  -0x10(%ebp)
80105d10:	e8 0e bd ff ff       	call   80101a23 <ilock>
80105d15:	83 c4 10             	add    $0x10,%esp
80105d18:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d1b:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105d1f:	66 85 c0             	test   %ax,%ax
80105d22:	7f 0d                	jg     80105d31 <sys_unlink+0xe5>
80105d24:	83 ec 0c             	sub    $0xc,%esp
80105d27:	68 69 8a 10 80       	push   $0x80108a69
80105d2c:	e8 6f a8 ff ff       	call   801005a0 <panic>
80105d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d34:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105d38:	66 83 f8 01          	cmp    $0x1,%ax
80105d3c:	75 25                	jne    80105d63 <sys_unlink+0x117>
80105d3e:	83 ec 0c             	sub    $0xc,%esp
80105d41:	ff 75 f0             	pushl  -0x10(%ebp)
80105d44:	e8 a0 fe ff ff       	call   80105be9 <isdirempty>
80105d49:	83 c4 10             	add    $0x10,%esp
80105d4c:	85 c0                	test   %eax,%eax
80105d4e:	75 13                	jne    80105d63 <sys_unlink+0x117>
80105d50:	83 ec 0c             	sub    $0xc,%esp
80105d53:	ff 75 f0             	pushl  -0x10(%ebp)
80105d56:	e8 de be ff ff       	call   80101c39 <iunlockput>
80105d5b:	83 c4 10             	add    $0x10,%esp
80105d5e:	e9 b2 00 00 00       	jmp    80105e15 <sys_unlink+0x1c9>
80105d63:	83 ec 04             	sub    $0x4,%esp
80105d66:	6a 10                	push   $0x10
80105d68:	6a 00                	push   $0x0
80105d6a:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d6d:	50                   	push   %eax
80105d6e:	e8 e3 f5 ff ff       	call   80105356 <memset>
80105d73:	83 c4 10             	add    $0x10,%esp
80105d76:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105d79:	6a 10                	push   $0x10
80105d7b:	50                   	push   %eax
80105d7c:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d7f:	50                   	push   %eax
80105d80:	ff 75 f4             	pushl  -0xc(%ebp)
80105d83:	e8 c8 c2 ff ff       	call   80102050 <writei>
80105d88:	83 c4 10             	add    $0x10,%esp
80105d8b:	83 f8 10             	cmp    $0x10,%eax
80105d8e:	74 0d                	je     80105d9d <sys_unlink+0x151>
80105d90:	83 ec 0c             	sub    $0xc,%esp
80105d93:	68 7b 8a 10 80       	push   $0x80108a7b
80105d98:	e8 03 a8 ff ff       	call   801005a0 <panic>
80105d9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105da0:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105da4:	66 83 f8 01          	cmp    $0x1,%ax
80105da8:	75 21                	jne    80105dcb <sys_unlink+0x17f>
80105daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dad:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105db1:	83 e8 01             	sub    $0x1,%eax
80105db4:	89 c2                	mov    %eax,%edx
80105db6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db9:	66 89 50 56          	mov    %dx,0x56(%eax)
80105dbd:	83 ec 0c             	sub    $0xc,%esp
80105dc0:	ff 75 f4             	pushl  -0xc(%ebp)
80105dc3:	e8 7e ba ff ff       	call   80101846 <iupdate>
80105dc8:	83 c4 10             	add    $0x10,%esp
80105dcb:	83 ec 0c             	sub    $0xc,%esp
80105dce:	ff 75 f4             	pushl  -0xc(%ebp)
80105dd1:	e8 63 be ff ff       	call   80101c39 <iunlockput>
80105dd6:	83 c4 10             	add    $0x10,%esp
80105dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ddc:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105de0:	83 e8 01             	sub    $0x1,%eax
80105de3:	89 c2                	mov    %eax,%edx
80105de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105de8:	66 89 50 56          	mov    %dx,0x56(%eax)
80105dec:	83 ec 0c             	sub    $0xc,%esp
80105def:	ff 75 f0             	pushl  -0x10(%ebp)
80105df2:	e8 4f ba ff ff       	call   80101846 <iupdate>
80105df7:	83 c4 10             	add    $0x10,%esp
80105dfa:	83 ec 0c             	sub    $0xc,%esp
80105dfd:	ff 75 f0             	pushl  -0x10(%ebp)
80105e00:	e8 34 be ff ff       	call   80101c39 <iunlockput>
80105e05:	83 c4 10             	add    $0x10,%esp
80105e08:	e8 60 d8 ff ff       	call   8010366d <end_op>
80105e0d:	b8 00 00 00 00       	mov    $0x0,%eax
80105e12:	eb 19                	jmp    80105e2d <sys_unlink+0x1e1>
80105e14:	90                   	nop
80105e15:	83 ec 0c             	sub    $0xc,%esp
80105e18:	ff 75 f4             	pushl  -0xc(%ebp)
80105e1b:	e8 19 be ff ff       	call   80101c39 <iunlockput>
80105e20:	83 c4 10             	add    $0x10,%esp
80105e23:	e8 45 d8 ff ff       	call   8010366d <end_op>
80105e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e2d:	c9                   	leave  
80105e2e:	c3                   	ret    

80105e2f <create>:
80105e2f:	55                   	push   %ebp
80105e30:	89 e5                	mov    %esp,%ebp
80105e32:	83 ec 38             	sub    $0x38,%esp
80105e35:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105e38:	8b 55 10             	mov    0x10(%ebp),%edx
80105e3b:	8b 45 14             	mov    0x14(%ebp),%eax
80105e3e:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105e42:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105e46:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
80105e4a:	83 ec 08             	sub    $0x8,%esp
80105e4d:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e50:	50                   	push   %eax
80105e51:	ff 75 08             	pushl  0x8(%ebp)
80105e54:	e8 0c c7 ff ff       	call   80102565 <nameiparent>
80105e59:	83 c4 10             	add    $0x10,%esp
80105e5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e5f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e63:	75 0a                	jne    80105e6f <create+0x40>
80105e65:	b8 00 00 00 00       	mov    $0x0,%eax
80105e6a:	e9 90 01 00 00       	jmp    80105fff <create+0x1d0>
80105e6f:	83 ec 0c             	sub    $0xc,%esp
80105e72:	ff 75 f4             	pushl  -0xc(%ebp)
80105e75:	e8 a9 bb ff ff       	call   80101a23 <ilock>
80105e7a:	83 c4 10             	add    $0x10,%esp
80105e7d:	83 ec 04             	sub    $0x4,%esp
80105e80:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e83:	50                   	push   %eax
80105e84:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e87:	50                   	push   %eax
80105e88:	ff 75 f4             	pushl  -0xc(%ebp)
80105e8b:	e8 63 c3 ff ff       	call   801021f3 <dirlookup>
80105e90:	83 c4 10             	add    $0x10,%esp
80105e93:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105e96:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105e9a:	74 50                	je     80105eec <create+0xbd>
80105e9c:	83 ec 0c             	sub    $0xc,%esp
80105e9f:	ff 75 f4             	pushl  -0xc(%ebp)
80105ea2:	e8 92 bd ff ff       	call   80101c39 <iunlockput>
80105ea7:	83 c4 10             	add    $0x10,%esp
80105eaa:	83 ec 0c             	sub    $0xc,%esp
80105ead:	ff 75 f0             	pushl  -0x10(%ebp)
80105eb0:	e8 6e bb ff ff       	call   80101a23 <ilock>
80105eb5:	83 c4 10             	add    $0x10,%esp
80105eb8:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105ebd:	75 15                	jne    80105ed4 <create+0xa5>
80105ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ec2:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105ec6:	66 83 f8 02          	cmp    $0x2,%ax
80105eca:	75 08                	jne    80105ed4 <create+0xa5>
80105ecc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ecf:	e9 2b 01 00 00       	jmp    80105fff <create+0x1d0>
80105ed4:	83 ec 0c             	sub    $0xc,%esp
80105ed7:	ff 75 f0             	pushl  -0x10(%ebp)
80105eda:	e8 5a bd ff ff       	call   80101c39 <iunlockput>
80105edf:	83 c4 10             	add    $0x10,%esp
80105ee2:	b8 00 00 00 00       	mov    $0x0,%eax
80105ee7:	e9 13 01 00 00       	jmp    80105fff <create+0x1d0>
80105eec:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105ef0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ef3:	8b 00                	mov    (%eax),%eax
80105ef5:	83 ec 08             	sub    $0x8,%esp
80105ef8:	52                   	push   %edx
80105ef9:	50                   	push   %eax
80105efa:	e8 70 b8 ff ff       	call   8010176f <ialloc>
80105eff:	83 c4 10             	add    $0x10,%esp
80105f02:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f05:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f09:	75 0d                	jne    80105f18 <create+0xe9>
80105f0b:	83 ec 0c             	sub    $0xc,%esp
80105f0e:	68 8a 8a 10 80       	push   $0x80108a8a
80105f13:	e8 88 a6 ff ff       	call   801005a0 <panic>
80105f18:	83 ec 0c             	sub    $0xc,%esp
80105f1b:	ff 75 f0             	pushl  -0x10(%ebp)
80105f1e:	e8 00 bb ff ff       	call   80101a23 <ilock>
80105f23:	83 c4 10             	add    $0x10,%esp
80105f26:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f29:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105f2d:	66 89 50 52          	mov    %dx,0x52(%eax)
80105f31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f34:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105f38:	66 89 50 54          	mov    %dx,0x54(%eax)
80105f3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f3f:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
80105f45:	83 ec 0c             	sub    $0xc,%esp
80105f48:	ff 75 f0             	pushl  -0x10(%ebp)
80105f4b:	e8 f6 b8 ff ff       	call   80101846 <iupdate>
80105f50:	83 c4 10             	add    $0x10,%esp
80105f53:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105f58:	75 6a                	jne    80105fc4 <create+0x195>
80105f5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f5d:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105f61:	83 c0 01             	add    $0x1,%eax
80105f64:	89 c2                	mov    %eax,%edx
80105f66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f69:	66 89 50 56          	mov    %dx,0x56(%eax)
80105f6d:	83 ec 0c             	sub    $0xc,%esp
80105f70:	ff 75 f4             	pushl  -0xc(%ebp)
80105f73:	e8 ce b8 ff ff       	call   80101846 <iupdate>
80105f78:	83 c4 10             	add    $0x10,%esp
80105f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f7e:	8b 40 04             	mov    0x4(%eax),%eax
80105f81:	83 ec 04             	sub    $0x4,%esp
80105f84:	50                   	push   %eax
80105f85:	68 64 8a 10 80       	push   $0x80108a64
80105f8a:	ff 75 f0             	pushl  -0x10(%ebp)
80105f8d:	e8 1b c3 ff ff       	call   801022ad <dirlink>
80105f92:	83 c4 10             	add    $0x10,%esp
80105f95:	85 c0                	test   %eax,%eax
80105f97:	78 1e                	js     80105fb7 <create+0x188>
80105f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f9c:	8b 40 04             	mov    0x4(%eax),%eax
80105f9f:	83 ec 04             	sub    $0x4,%esp
80105fa2:	50                   	push   %eax
80105fa3:	68 66 8a 10 80       	push   $0x80108a66
80105fa8:	ff 75 f0             	pushl  -0x10(%ebp)
80105fab:	e8 fd c2 ff ff       	call   801022ad <dirlink>
80105fb0:	83 c4 10             	add    $0x10,%esp
80105fb3:	85 c0                	test   %eax,%eax
80105fb5:	79 0d                	jns    80105fc4 <create+0x195>
80105fb7:	83 ec 0c             	sub    $0xc,%esp
80105fba:	68 99 8a 10 80       	push   $0x80108a99
80105fbf:	e8 dc a5 ff ff       	call   801005a0 <panic>
80105fc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fc7:	8b 40 04             	mov    0x4(%eax),%eax
80105fca:	83 ec 04             	sub    $0x4,%esp
80105fcd:	50                   	push   %eax
80105fce:	8d 45 de             	lea    -0x22(%ebp),%eax
80105fd1:	50                   	push   %eax
80105fd2:	ff 75 f4             	pushl  -0xc(%ebp)
80105fd5:	e8 d3 c2 ff ff       	call   801022ad <dirlink>
80105fda:	83 c4 10             	add    $0x10,%esp
80105fdd:	85 c0                	test   %eax,%eax
80105fdf:	79 0d                	jns    80105fee <create+0x1bf>
80105fe1:	83 ec 0c             	sub    $0xc,%esp
80105fe4:	68 a5 8a 10 80       	push   $0x80108aa5
80105fe9:	e8 b2 a5 ff ff       	call   801005a0 <panic>
80105fee:	83 ec 0c             	sub    $0xc,%esp
80105ff1:	ff 75 f4             	pushl  -0xc(%ebp)
80105ff4:	e8 40 bc ff ff       	call   80101c39 <iunlockput>
80105ff9:	83 c4 10             	add    $0x10,%esp
80105ffc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fff:	c9                   	leave  
80106000:	c3                   	ret    

80106001 <sys_open>:
80106001:	55                   	push   %ebp
80106002:	89 e5                	mov    %esp,%ebp
80106004:	83 ec 28             	sub    $0x28,%esp
80106007:	83 ec 08             	sub    $0x8,%esp
8010600a:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010600d:	50                   	push   %eax
8010600e:	6a 00                	push   $0x0
80106010:	e8 eb f6 ff ff       	call   80105700 <argstr>
80106015:	83 c4 10             	add    $0x10,%esp
80106018:	85 c0                	test   %eax,%eax
8010601a:	78 15                	js     80106031 <sys_open+0x30>
8010601c:	83 ec 08             	sub    $0x8,%esp
8010601f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106022:	50                   	push   %eax
80106023:	6a 01                	push   $0x1
80106025:	e8 51 f6 ff ff       	call   8010567b <argint>
8010602a:	83 c4 10             	add    $0x10,%esp
8010602d:	85 c0                	test   %eax,%eax
8010602f:	79 0a                	jns    8010603b <sys_open+0x3a>
80106031:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106036:	e9 61 01 00 00       	jmp    8010619c <sys_open+0x19b>
8010603b:	e8 a1 d5 ff ff       	call   801035e1 <begin_op>
80106040:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106043:	25 00 02 00 00       	and    $0x200,%eax
80106048:	85 c0                	test   %eax,%eax
8010604a:	74 2a                	je     80106076 <sys_open+0x75>
8010604c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010604f:	6a 00                	push   $0x0
80106051:	6a 00                	push   $0x0
80106053:	6a 02                	push   $0x2
80106055:	50                   	push   %eax
80106056:	e8 d4 fd ff ff       	call   80105e2f <create>
8010605b:	83 c4 10             	add    $0x10,%esp
8010605e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106061:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106065:	75 75                	jne    801060dc <sys_open+0xdb>
80106067:	e8 01 d6 ff ff       	call   8010366d <end_op>
8010606c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106071:	e9 26 01 00 00       	jmp    8010619c <sys_open+0x19b>
80106076:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106079:	83 ec 0c             	sub    $0xc,%esp
8010607c:	50                   	push   %eax
8010607d:	e8 c7 c4 ff ff       	call   80102549 <namei>
80106082:	83 c4 10             	add    $0x10,%esp
80106085:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106088:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010608c:	75 0f                	jne    8010609d <sys_open+0x9c>
8010608e:	e8 da d5 ff ff       	call   8010366d <end_op>
80106093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106098:	e9 ff 00 00 00       	jmp    8010619c <sys_open+0x19b>
8010609d:	83 ec 0c             	sub    $0xc,%esp
801060a0:	ff 75 f4             	pushl  -0xc(%ebp)
801060a3:	e8 7b b9 ff ff       	call   80101a23 <ilock>
801060a8:	83 c4 10             	add    $0x10,%esp
801060ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060ae:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801060b2:	66 83 f8 01          	cmp    $0x1,%ax
801060b6:	75 24                	jne    801060dc <sys_open+0xdb>
801060b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060bb:	85 c0                	test   %eax,%eax
801060bd:	74 1d                	je     801060dc <sys_open+0xdb>
801060bf:	83 ec 0c             	sub    $0xc,%esp
801060c2:	ff 75 f4             	pushl  -0xc(%ebp)
801060c5:	e8 6f bb ff ff       	call   80101c39 <iunlockput>
801060ca:	83 c4 10             	add    $0x10,%esp
801060cd:	e8 9b d5 ff ff       	call   8010366d <end_op>
801060d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d7:	e9 c0 00 00 00       	jmp    8010619c <sys_open+0x19b>
801060dc:	e8 25 af ff ff       	call   80101006 <filealloc>
801060e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801060e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801060e8:	74 17                	je     80106101 <sys_open+0x100>
801060ea:	83 ec 0c             	sub    $0xc,%esp
801060ed:	ff 75 f0             	pushl  -0x10(%ebp)
801060f0:	e8 37 f7 ff ff       	call   8010582c <fdalloc>
801060f5:	83 c4 10             	add    $0x10,%esp
801060f8:	89 45 ec             	mov    %eax,-0x14(%ebp)
801060fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801060ff:	79 2e                	jns    8010612f <sys_open+0x12e>
80106101:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106105:	74 0e                	je     80106115 <sys_open+0x114>
80106107:	83 ec 0c             	sub    $0xc,%esp
8010610a:	ff 75 f0             	pushl  -0x10(%ebp)
8010610d:	e8 b2 af ff ff       	call   801010c4 <fileclose>
80106112:	83 c4 10             	add    $0x10,%esp
80106115:	83 ec 0c             	sub    $0xc,%esp
80106118:	ff 75 f4             	pushl  -0xc(%ebp)
8010611b:	e8 19 bb ff ff       	call   80101c39 <iunlockput>
80106120:	83 c4 10             	add    $0x10,%esp
80106123:	e8 45 d5 ff ff       	call   8010366d <end_op>
80106128:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010612d:	eb 6d                	jmp    8010619c <sys_open+0x19b>
8010612f:	83 ec 0c             	sub    $0xc,%esp
80106132:	ff 75 f4             	pushl  -0xc(%ebp)
80106135:	e8 06 ba ff ff       	call   80101b40 <iunlock>
8010613a:	83 c4 10             	add    $0x10,%esp
8010613d:	e8 2b d5 ff ff       	call   8010366d <end_op>
80106142:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106145:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
8010614b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010614e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106151:	89 50 10             	mov    %edx,0x10(%eax)
80106154:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106157:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
8010615e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106161:	83 e0 01             	and    $0x1,%eax
80106164:	85 c0                	test   %eax,%eax
80106166:	0f 94 c0             	sete   %al
80106169:	89 c2                	mov    %eax,%edx
8010616b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010616e:	88 50 08             	mov    %dl,0x8(%eax)
80106171:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106174:	83 e0 01             	and    $0x1,%eax
80106177:	85 c0                	test   %eax,%eax
80106179:	75 0a                	jne    80106185 <sys_open+0x184>
8010617b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010617e:	83 e0 02             	and    $0x2,%eax
80106181:	85 c0                	test   %eax,%eax
80106183:	74 07                	je     8010618c <sys_open+0x18b>
80106185:	b8 01 00 00 00       	mov    $0x1,%eax
8010618a:	eb 05                	jmp    80106191 <sys_open+0x190>
8010618c:	b8 00 00 00 00       	mov    $0x0,%eax
80106191:	89 c2                	mov    %eax,%edx
80106193:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106196:	88 50 09             	mov    %dl,0x9(%eax)
80106199:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010619c:	c9                   	leave  
8010619d:	c3                   	ret    

8010619e <sys_mkdir>:
8010619e:	55                   	push   %ebp
8010619f:	89 e5                	mov    %esp,%ebp
801061a1:	83 ec 18             	sub    $0x18,%esp
801061a4:	e8 38 d4 ff ff       	call   801035e1 <begin_op>
801061a9:	83 ec 08             	sub    $0x8,%esp
801061ac:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061af:	50                   	push   %eax
801061b0:	6a 00                	push   $0x0
801061b2:	e8 49 f5 ff ff       	call   80105700 <argstr>
801061b7:	83 c4 10             	add    $0x10,%esp
801061ba:	85 c0                	test   %eax,%eax
801061bc:	78 1b                	js     801061d9 <sys_mkdir+0x3b>
801061be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061c1:	6a 00                	push   $0x0
801061c3:	6a 00                	push   $0x0
801061c5:	6a 01                	push   $0x1
801061c7:	50                   	push   %eax
801061c8:	e8 62 fc ff ff       	call   80105e2f <create>
801061cd:	83 c4 10             	add    $0x10,%esp
801061d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061d7:	75 0c                	jne    801061e5 <sys_mkdir+0x47>
801061d9:	e8 8f d4 ff ff       	call   8010366d <end_op>
801061de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e3:	eb 18                	jmp    801061fd <sys_mkdir+0x5f>
801061e5:	83 ec 0c             	sub    $0xc,%esp
801061e8:	ff 75 f4             	pushl  -0xc(%ebp)
801061eb:	e8 49 ba ff ff       	call   80101c39 <iunlockput>
801061f0:	83 c4 10             	add    $0x10,%esp
801061f3:	e8 75 d4 ff ff       	call   8010366d <end_op>
801061f8:	b8 00 00 00 00       	mov    $0x0,%eax
801061fd:	c9                   	leave  
801061fe:	c3                   	ret    

801061ff <sys_mknod>:
801061ff:	55                   	push   %ebp
80106200:	89 e5                	mov    %esp,%ebp
80106202:	83 ec 18             	sub    $0x18,%esp
80106205:	e8 d7 d3 ff ff       	call   801035e1 <begin_op>
8010620a:	83 ec 08             	sub    $0x8,%esp
8010620d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106210:	50                   	push   %eax
80106211:	6a 00                	push   $0x0
80106213:	e8 e8 f4 ff ff       	call   80105700 <argstr>
80106218:	83 c4 10             	add    $0x10,%esp
8010621b:	85 c0                	test   %eax,%eax
8010621d:	78 4f                	js     8010626e <sys_mknod+0x6f>
8010621f:	83 ec 08             	sub    $0x8,%esp
80106222:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106225:	50                   	push   %eax
80106226:	6a 01                	push   $0x1
80106228:	e8 4e f4 ff ff       	call   8010567b <argint>
8010622d:	83 c4 10             	add    $0x10,%esp
80106230:	85 c0                	test   %eax,%eax
80106232:	78 3a                	js     8010626e <sys_mknod+0x6f>
80106234:	83 ec 08             	sub    $0x8,%esp
80106237:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010623a:	50                   	push   %eax
8010623b:	6a 02                	push   $0x2
8010623d:	e8 39 f4 ff ff       	call   8010567b <argint>
80106242:	83 c4 10             	add    $0x10,%esp
80106245:	85 c0                	test   %eax,%eax
80106247:	78 25                	js     8010626e <sys_mknod+0x6f>
80106249:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010624c:	0f bf c8             	movswl %ax,%ecx
8010624f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106252:	0f bf d0             	movswl %ax,%edx
80106255:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106258:	51                   	push   %ecx
80106259:	52                   	push   %edx
8010625a:	6a 03                	push   $0x3
8010625c:	50                   	push   %eax
8010625d:	e8 cd fb ff ff       	call   80105e2f <create>
80106262:	83 c4 10             	add    $0x10,%esp
80106265:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106268:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010626c:	75 0c                	jne    8010627a <sys_mknod+0x7b>
8010626e:	e8 fa d3 ff ff       	call   8010366d <end_op>
80106273:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106278:	eb 18                	jmp    80106292 <sys_mknod+0x93>
8010627a:	83 ec 0c             	sub    $0xc,%esp
8010627d:	ff 75 f4             	pushl  -0xc(%ebp)
80106280:	e8 b4 b9 ff ff       	call   80101c39 <iunlockput>
80106285:	83 c4 10             	add    $0x10,%esp
80106288:	e8 e0 d3 ff ff       	call   8010366d <end_op>
8010628d:	b8 00 00 00 00       	mov    $0x0,%eax
80106292:	c9                   	leave  
80106293:	c3                   	ret    

80106294 <sys_chdir>:
80106294:	55                   	push   %ebp
80106295:	89 e5                	mov    %esp,%ebp
80106297:	83 ec 18             	sub    $0x18,%esp
8010629a:	e8 42 d3 ff ff       	call   801035e1 <begin_op>
8010629f:	83 ec 08             	sub    $0x8,%esp
801062a2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062a5:	50                   	push   %eax
801062a6:	6a 00                	push   $0x0
801062a8:	e8 53 f4 ff ff       	call   80105700 <argstr>
801062ad:	83 c4 10             	add    $0x10,%esp
801062b0:	85 c0                	test   %eax,%eax
801062b2:	78 18                	js     801062cc <sys_chdir+0x38>
801062b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062b7:	83 ec 0c             	sub    $0xc,%esp
801062ba:	50                   	push   %eax
801062bb:	e8 89 c2 ff ff       	call   80102549 <namei>
801062c0:	83 c4 10             	add    $0x10,%esp
801062c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062ca:	75 0c                	jne    801062d8 <sys_chdir+0x44>
801062cc:	e8 9c d3 ff ff       	call   8010366d <end_op>
801062d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062d6:	eb 6e                	jmp    80106346 <sys_chdir+0xb2>
801062d8:	83 ec 0c             	sub    $0xc,%esp
801062db:	ff 75 f4             	pushl  -0xc(%ebp)
801062de:	e8 40 b7 ff ff       	call   80101a23 <ilock>
801062e3:	83 c4 10             	add    $0x10,%esp
801062e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062e9:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801062ed:	66 83 f8 01          	cmp    $0x1,%ax
801062f1:	74 1a                	je     8010630d <sys_chdir+0x79>
801062f3:	83 ec 0c             	sub    $0xc,%esp
801062f6:	ff 75 f4             	pushl  -0xc(%ebp)
801062f9:	e8 3b b9 ff ff       	call   80101c39 <iunlockput>
801062fe:	83 c4 10             	add    $0x10,%esp
80106301:	e8 67 d3 ff ff       	call   8010366d <end_op>
80106306:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010630b:	eb 39                	jmp    80106346 <sys_chdir+0xb2>
8010630d:	83 ec 0c             	sub    $0xc,%esp
80106310:	ff 75 f4             	pushl  -0xc(%ebp)
80106313:	e8 28 b8 ff ff       	call   80101b40 <iunlock>
80106318:	83 c4 10             	add    $0x10,%esp
8010631b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106321:	8b 40 68             	mov    0x68(%eax),%eax
80106324:	83 ec 0c             	sub    $0xc,%esp
80106327:	50                   	push   %eax
80106328:	e8 61 b8 ff ff       	call   80101b8e <iput>
8010632d:	83 c4 10             	add    $0x10,%esp
80106330:	e8 38 d3 ff ff       	call   8010366d <end_op>
80106335:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010633b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010633e:	89 50 68             	mov    %edx,0x68(%eax)
80106341:	b8 00 00 00 00       	mov    $0x0,%eax
80106346:	c9                   	leave  
80106347:	c3                   	ret    

80106348 <sys_exec>:
80106348:	55                   	push   %ebp
80106349:	89 e5                	mov    %esp,%ebp
8010634b:	81 ec 98 00 00 00    	sub    $0x98,%esp
80106351:	83 ec 08             	sub    $0x8,%esp
80106354:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106357:	50                   	push   %eax
80106358:	6a 00                	push   $0x0
8010635a:	e8 a1 f3 ff ff       	call   80105700 <argstr>
8010635f:	83 c4 10             	add    $0x10,%esp
80106362:	85 c0                	test   %eax,%eax
80106364:	78 18                	js     8010637e <sys_exec+0x36>
80106366:	83 ec 08             	sub    $0x8,%esp
80106369:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
8010636f:	50                   	push   %eax
80106370:	6a 01                	push   $0x1
80106372:	e8 04 f3 ff ff       	call   8010567b <argint>
80106377:	83 c4 10             	add    $0x10,%esp
8010637a:	85 c0                	test   %eax,%eax
8010637c:	79 0a                	jns    80106388 <sys_exec+0x40>
8010637e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106383:	e9 c6 00 00 00       	jmp    8010644e <sys_exec+0x106>
80106388:	83 ec 04             	sub    $0x4,%esp
8010638b:	68 80 00 00 00       	push   $0x80
80106390:	6a 00                	push   $0x0
80106392:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106398:	50                   	push   %eax
80106399:	e8 b8 ef ff ff       	call   80105356 <memset>
8010639e:	83 c4 10             	add    $0x10,%esp
801063a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801063a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063ab:	83 f8 1f             	cmp    $0x1f,%eax
801063ae:	76 0a                	jbe    801063ba <sys_exec+0x72>
801063b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063b5:	e9 94 00 00 00       	jmp    8010644e <sys_exec+0x106>
801063ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063bd:	c1 e0 02             	shl    $0x2,%eax
801063c0:	89 c2                	mov    %eax,%edx
801063c2:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801063c8:	01 c2                	add    %eax,%edx
801063ca:	83 ec 08             	sub    $0x8,%esp
801063cd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801063d3:	50                   	push   %eax
801063d4:	52                   	push   %edx
801063d5:	e8 05 f2 ff ff       	call   801055df <fetchint>
801063da:	83 c4 10             	add    $0x10,%esp
801063dd:	85 c0                	test   %eax,%eax
801063df:	79 07                	jns    801063e8 <sys_exec+0xa0>
801063e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063e6:	eb 66                	jmp    8010644e <sys_exec+0x106>
801063e8:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801063ee:	85 c0                	test   %eax,%eax
801063f0:	75 27                	jne    80106419 <sys_exec+0xd1>
801063f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063f5:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801063fc:	00 00 00 00 
80106400:	90                   	nop
80106401:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106404:	83 ec 08             	sub    $0x8,%esp
80106407:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010640d:	52                   	push   %edx
8010640e:	50                   	push   %eax
8010640f:	e8 97 a7 ff ff       	call   80100bab <exec>
80106414:	83 c4 10             	add    $0x10,%esp
80106417:	eb 35                	jmp    8010644e <sys_exec+0x106>
80106419:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010641f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106422:	c1 e2 02             	shl    $0x2,%edx
80106425:	01 c2                	add    %eax,%edx
80106427:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010642d:	83 ec 08             	sub    $0x8,%esp
80106430:	52                   	push   %edx
80106431:	50                   	push   %eax
80106432:	e8 e2 f1 ff ff       	call   80105619 <fetchstr>
80106437:	83 c4 10             	add    $0x10,%esp
8010643a:	85 c0                	test   %eax,%eax
8010643c:	79 07                	jns    80106445 <sys_exec+0xfd>
8010643e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106443:	eb 09                	jmp    8010644e <sys_exec+0x106>
80106445:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106449:	e9 5a ff ff ff       	jmp    801063a8 <sys_exec+0x60>
8010644e:	c9                   	leave  
8010644f:	c3                   	ret    

80106450 <sys_pipe>:
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	83 ec 28             	sub    $0x28,%esp
80106456:	83 ec 04             	sub    $0x4,%esp
80106459:	6a 08                	push   $0x8
8010645b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010645e:	50                   	push   %eax
8010645f:	6a 00                	push   $0x0
80106461:	e8 3d f2 ff ff       	call   801056a3 <argptr>
80106466:	83 c4 10             	add    $0x10,%esp
80106469:	85 c0                	test   %eax,%eax
8010646b:	79 0a                	jns    80106477 <sys_pipe+0x27>
8010646d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106472:	e9 af 00 00 00       	jmp    80106526 <sys_pipe+0xd6>
80106477:	83 ec 08             	sub    $0x8,%esp
8010647a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010647d:	50                   	push   %eax
8010647e:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106481:	50                   	push   %eax
80106482:	e8 54 db ff ff       	call   80103fdb <pipealloc>
80106487:	83 c4 10             	add    $0x10,%esp
8010648a:	85 c0                	test   %eax,%eax
8010648c:	79 0a                	jns    80106498 <sys_pipe+0x48>
8010648e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106493:	e9 8e 00 00 00       	jmp    80106526 <sys_pipe+0xd6>
80106498:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
8010649f:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064a2:	83 ec 0c             	sub    $0xc,%esp
801064a5:	50                   	push   %eax
801064a6:	e8 81 f3 ff ff       	call   8010582c <fdalloc>
801064ab:	83 c4 10             	add    $0x10,%esp
801064ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064b5:	78 18                	js     801064cf <sys_pipe+0x7f>
801064b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064ba:	83 ec 0c             	sub    $0xc,%esp
801064bd:	50                   	push   %eax
801064be:	e8 69 f3 ff ff       	call   8010582c <fdalloc>
801064c3:	83 c4 10             	add    $0x10,%esp
801064c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801064c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801064cd:	79 3f                	jns    8010650e <sys_pipe+0xbe>
801064cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064d3:	78 14                	js     801064e9 <sys_pipe+0x99>
801064d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064db:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064de:	83 c2 08             	add    $0x8,%edx
801064e1:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801064e8:	00 
801064e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064ec:	83 ec 0c             	sub    $0xc,%esp
801064ef:	50                   	push   %eax
801064f0:	e8 cf ab ff ff       	call   801010c4 <fileclose>
801064f5:	83 c4 10             	add    $0x10,%esp
801064f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064fb:	83 ec 0c             	sub    $0xc,%esp
801064fe:	50                   	push   %eax
801064ff:	e8 c0 ab ff ff       	call   801010c4 <fileclose>
80106504:	83 c4 10             	add    $0x10,%esp
80106507:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010650c:	eb 18                	jmp    80106526 <sys_pipe+0xd6>
8010650e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106511:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106514:	89 10                	mov    %edx,(%eax)
80106516:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106519:	8d 50 04             	lea    0x4(%eax),%edx
8010651c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010651f:	89 02                	mov    %eax,(%edx)
80106521:	b8 00 00 00 00       	mov    $0x0,%eax
80106526:	c9                   	leave  
80106527:	c3                   	ret    

80106528 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106528:	55                   	push   %ebp
80106529:	89 e5                	mov    %esp,%ebp
8010652b:	83 ec 08             	sub    $0x8,%esp
  return fork();
8010652e:	e8 be e1 ff ff       	call   801046f1 <fork>
}
80106533:	c9                   	leave  
80106534:	c3                   	ret    

80106535 <sys_exit>:

int
sys_exit(void)
{
80106535:	55                   	push   %ebp
80106536:	89 e5                	mov    %esp,%ebp
80106538:	83 ec 08             	sub    $0x8,%esp
  exit();
8010653b:	e8 42 e3 ff ff       	call   80104882 <exit>
  return 0;  // not reached
80106540:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106545:	c9                   	leave  
80106546:	c3                   	ret    

80106547 <sys_wait>:

int
sys_wait(void)
{
80106547:	55                   	push   %ebp
80106548:	89 e5                	mov    %esp,%ebp
8010654a:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010654d:	e8 68 e4 ff ff       	call   801049ba <wait>
}
80106552:	c9                   	leave  
80106553:	c3                   	ret    

80106554 <sys_kill>:

int
sys_kill(void)
{
80106554:	55                   	push   %ebp
80106555:	89 e5                	mov    %esp,%ebp
80106557:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010655a:	83 ec 08             	sub    $0x8,%esp
8010655d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106560:	50                   	push   %eax
80106561:	6a 00                	push   $0x0
80106563:	e8 13 f1 ff ff       	call   8010567b <argint>
80106568:	83 c4 10             	add    $0x10,%esp
8010656b:	85 c0                	test   %eax,%eax
8010656d:	79 07                	jns    80106576 <sys_kill+0x22>
    return -1;
8010656f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106574:	eb 0f                	jmp    80106585 <sys_kill+0x31>
  return kill(pid);
80106576:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106579:	83 ec 0c             	sub    $0xc,%esp
8010657c:	50                   	push   %eax
8010657d:	e8 5d e8 ff ff       	call   80104ddf <kill>
80106582:	83 c4 10             	add    $0x10,%esp
}
80106585:	c9                   	leave  
80106586:	c3                   	ret    

80106587 <sys_getpid>:

int
sys_getpid(void)
{
80106587:	55                   	push   %ebp
80106588:	89 e5                	mov    %esp,%ebp
  return proc->pid;
8010658a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106590:	8b 40 10             	mov    0x10(%eax),%eax
}
80106593:	5d                   	pop    %ebp
80106594:	c3                   	ret    

80106595 <sys_sbrk>:

int
sys_sbrk(void)
{
80106595:	55                   	push   %ebp
80106596:	89 e5                	mov    %esp,%ebp
80106598:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010659b:	83 ec 08             	sub    $0x8,%esp
8010659e:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065a1:	50                   	push   %eax
801065a2:	6a 00                	push   $0x0
801065a4:	e8 d2 f0 ff ff       	call   8010567b <argint>
801065a9:	83 c4 10             	add    $0x10,%esp
801065ac:	85 c0                	test   %eax,%eax
801065ae:	79 07                	jns    801065b7 <sys_sbrk+0x22>
    return -1;
801065b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065b5:	eb 28                	jmp    801065df <sys_sbrk+0x4a>
  addr = proc->sz;
801065b7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065bd:	8b 00                	mov    (%eax),%eax
801065bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801065c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065c5:	83 ec 0c             	sub    $0xc,%esp
801065c8:	50                   	push   %eax
801065c9:	e8 80 e0 ff ff       	call   8010464e <growproc>
801065ce:	83 c4 10             	add    $0x10,%esp
801065d1:	85 c0                	test   %eax,%eax
801065d3:	79 07                	jns    801065dc <sys_sbrk+0x47>
    return -1;
801065d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065da:	eb 03                	jmp    801065df <sys_sbrk+0x4a>
  return addr;
801065dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801065df:	c9                   	leave  
801065e0:	c3                   	ret    

801065e1 <sys_sleep>:

int
sys_sleep(void)
{
801065e1:	55                   	push   %ebp
801065e2:	89 e5                	mov    %esp,%ebp
801065e4:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801065e7:	83 ec 08             	sub    $0x8,%esp
801065ea:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065ed:	50                   	push   %eax
801065ee:	6a 00                	push   $0x0
801065f0:	e8 86 f0 ff ff       	call   8010567b <argint>
801065f5:	83 c4 10             	add    $0x10,%esp
801065f8:	85 c0                	test   %eax,%eax
801065fa:	79 07                	jns    80106603 <sys_sleep+0x22>
    return -1;
801065fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106601:	eb 77                	jmp    8010667a <sys_sleep+0x99>
  acquire(&tickslock);
80106603:	83 ec 0c             	sub    $0xc,%esp
80106606:	68 60 5d 11 80       	push   $0x80115d60
8010660b:	e8 cc ea ff ff       	call   801050dc <acquire>
80106610:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106613:	a1 a0 65 11 80       	mov    0x801165a0,%eax
80106618:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
8010661b:	eb 39                	jmp    80106656 <sys_sleep+0x75>
    if(proc->killed){
8010661d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106623:	8b 40 24             	mov    0x24(%eax),%eax
80106626:	85 c0                	test   %eax,%eax
80106628:	74 17                	je     80106641 <sys_sleep+0x60>
      release(&tickslock);
8010662a:	83 ec 0c             	sub    $0xc,%esp
8010662d:	68 60 5d 11 80       	push   $0x80115d60
80106632:	e8 11 eb ff ff       	call   80105148 <release>
80106637:	83 c4 10             	add    $0x10,%esp
      return -1;
8010663a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010663f:	eb 39                	jmp    8010667a <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106641:	83 ec 08             	sub    $0x8,%esp
80106644:	68 60 5d 11 80       	push   $0x80115d60
80106649:	68 a0 65 11 80       	push   $0x801165a0
8010664e:	e8 6a e6 ff ff       	call   80104cbd <sleep>
80106653:	83 c4 10             	add    $0x10,%esp

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106656:	a1 a0 65 11 80       	mov    0x801165a0,%eax
8010665b:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010665e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106661:	39 d0                	cmp    %edx,%eax
80106663:	72 b8                	jb     8010661d <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106665:	83 ec 0c             	sub    $0xc,%esp
80106668:	68 60 5d 11 80       	push   $0x80115d60
8010666d:	e8 d6 ea ff ff       	call   80105148 <release>
80106672:	83 c4 10             	add    $0x10,%esp
  return 0;
80106675:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010667a:	c9                   	leave  
8010667b:	c3                   	ret    

8010667c <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
8010667c:	55                   	push   %ebp
8010667d:	89 e5                	mov    %esp,%ebp
8010667f:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
80106682:	83 ec 0c             	sub    $0xc,%esp
80106685:	68 60 5d 11 80       	push   $0x80115d60
8010668a:	e8 4d ea ff ff       	call   801050dc <acquire>
8010668f:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80106692:	a1 a0 65 11 80       	mov    0x801165a0,%eax
80106697:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010669a:	83 ec 0c             	sub    $0xc,%esp
8010669d:	68 60 5d 11 80       	push   $0x80115d60
801066a2:	e8 a1 ea ff ff       	call   80105148 <release>
801066a7:	83 c4 10             	add    $0x10,%esp
  return xticks;
801066aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801066ad:	c9                   	leave  
801066ae:	c3                   	ret    

801066af <sys_date>:

// Return current UTC time
int
sys_date(void)
{
801066af:	55                   	push   %ebp
801066b0:	89 e5                	mov    %esp,%ebp
801066b2:	83 ec 18             	sub    $0x18,%esp
  struct rtcdate *date;
  if(argptr(0,(void *)&date,sizeof(struct rtcdat *))<0)
801066b5:	83 ec 04             	sub    $0x4,%esp
801066b8:	6a 04                	push   $0x4
801066ba:	8d 45 f4             	lea    -0xc(%ebp),%eax
801066bd:	50                   	push   %eax
801066be:	6a 00                	push   $0x0
801066c0:	e8 de ef ff ff       	call   801056a3 <argptr>
801066c5:	83 c4 10             	add    $0x10,%esp
801066c8:	85 c0                	test   %eax,%eax
801066ca:	79 07                	jns    801066d3 <sys_date+0x24>
  {
	return -1;
801066cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066d1:	eb 14                	jmp    801066e7 <sys_date+0x38>
  }
  cmostime(date);
801066d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066d6:	83 ec 0c             	sub    $0xc,%esp
801066d9:	50                   	push   %eax
801066da:	e8 7d cb ff ff       	call   8010325c <cmostime>
801066df:	83 c4 10             	add    $0x10,%esp
  return 0;
801066e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801066e7:	c9                   	leave  
801066e8:	c3                   	ret    

801066e9 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801066e9:	55                   	push   %ebp
801066ea:	89 e5                	mov    %esp,%ebp
801066ec:	83 ec 08             	sub    $0x8,%esp
801066ef:	8b 55 08             	mov    0x8(%ebp),%edx
801066f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801066f5:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801066f9:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801066fc:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106700:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106704:	ee                   	out    %al,(%dx)
}
80106705:	90                   	nop
80106706:	c9                   	leave  
80106707:	c3                   	ret    

80106708 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106708:	55                   	push   %ebp
80106709:	89 e5                	mov    %esp,%ebp
8010670b:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
8010670e:	6a 34                	push   $0x34
80106710:	6a 43                	push   $0x43
80106712:	e8 d2 ff ff ff       	call   801066e9 <outb>
80106717:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
8010671a:	68 9c 00 00 00       	push   $0x9c
8010671f:	6a 40                	push   $0x40
80106721:	e8 c3 ff ff ff       	call   801066e9 <outb>
80106726:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106729:	6a 2e                	push   $0x2e
8010672b:	6a 40                	push   $0x40
8010672d:	e8 b7 ff ff ff       	call   801066e9 <outb>
80106732:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106735:	83 ec 0c             	sub    $0xc,%esp
80106738:	6a 00                	push   $0x0
8010673a:	e8 86 d7 ff ff       	call   80103ec5 <picenable>
8010673f:	83 c4 10             	add    $0x10,%esp
}
80106742:	90                   	nop
80106743:	c9                   	leave  
80106744:	c3                   	ret    

80106745 <alltraps>:
80106745:	1e                   	push   %ds
80106746:	06                   	push   %es
80106747:	0f a0                	push   %fs
80106749:	0f a8                	push   %gs
8010674b:	60                   	pusha  
8010674c:	66 b8 10 00          	mov    $0x10,%ax
80106750:	8e d8                	mov    %eax,%ds
80106752:	8e c0                	mov    %eax,%es
80106754:	66 b8 18 00          	mov    $0x18,%ax
80106758:	8e e0                	mov    %eax,%fs
8010675a:	8e e8                	mov    %eax,%gs
8010675c:	54                   	push   %esp
8010675d:	e8 d7 01 00 00       	call   80106939 <trap>
80106762:	83 c4 04             	add    $0x4,%esp

80106765 <trapret>:
80106765:	61                   	popa   
80106766:	0f a9                	pop    %gs
80106768:	0f a1                	pop    %fs
8010676a:	07                   	pop    %es
8010676b:	1f                   	pop    %ds
8010676c:	83 c4 08             	add    $0x8,%esp
8010676f:	cf                   	iret   

80106770 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80106776:	8b 45 0c             	mov    0xc(%ebp),%eax
80106779:	83 e8 01             	sub    $0x1,%eax
8010677c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106780:	8b 45 08             	mov    0x8(%ebp),%eax
80106783:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106787:	8b 45 08             	mov    0x8(%ebp),%eax
8010678a:	c1 e8 10             	shr    $0x10,%eax
8010678d:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106791:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106794:	0f 01 18             	lidtl  (%eax)
}
80106797:	90                   	nop
80106798:	c9                   	leave  
80106799:	c3                   	ret    

8010679a <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
8010679a:	55                   	push   %ebp
8010679b:	89 e5                	mov    %esp,%ebp
8010679d:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801067a0:	0f 20 d0             	mov    %cr2,%eax
801067a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801067a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801067a9:	c9                   	leave  
801067aa:	c3                   	ret    

801067ab <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801067ab:	55                   	push   %ebp
801067ac:	89 e5                	mov    %esp,%ebp
801067ae:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801067b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801067b8:	e9 c3 00 00 00       	jmp    80106880 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801067bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067c0:	8b 04 85 9c b0 10 80 	mov    -0x7fef4f64(,%eax,4),%eax
801067c7:	89 c2                	mov    %eax,%edx
801067c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067cc:	66 89 14 c5 a0 5d 11 	mov    %dx,-0x7feea260(,%eax,8)
801067d3:	80 
801067d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067d7:	66 c7 04 c5 a2 5d 11 	movw   $0x8,-0x7feea25e(,%eax,8)
801067de:	80 08 00 
801067e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067e4:	0f b6 14 c5 a4 5d 11 	movzbl -0x7feea25c(,%eax,8),%edx
801067eb:	80 
801067ec:	83 e2 e0             	and    $0xffffffe0,%edx
801067ef:	88 14 c5 a4 5d 11 80 	mov    %dl,-0x7feea25c(,%eax,8)
801067f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067f9:	0f b6 14 c5 a4 5d 11 	movzbl -0x7feea25c(,%eax,8),%edx
80106800:	80 
80106801:	83 e2 1f             	and    $0x1f,%edx
80106804:	88 14 c5 a4 5d 11 80 	mov    %dl,-0x7feea25c(,%eax,8)
8010680b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010680e:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
80106815:	80 
80106816:	83 e2 f0             	and    $0xfffffff0,%edx
80106819:	83 ca 0e             	or     $0xe,%edx
8010681c:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
80106823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106826:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
8010682d:	80 
8010682e:	83 e2 ef             	and    $0xffffffef,%edx
80106831:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
80106838:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010683b:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
80106842:	80 
80106843:	83 e2 9f             	and    $0xffffff9f,%edx
80106846:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
8010684d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106850:	0f b6 14 c5 a5 5d 11 	movzbl -0x7feea25b(,%eax,8),%edx
80106857:	80 
80106858:	83 ca 80             	or     $0xffffff80,%edx
8010685b:	88 14 c5 a5 5d 11 80 	mov    %dl,-0x7feea25b(,%eax,8)
80106862:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106865:	8b 04 85 9c b0 10 80 	mov    -0x7fef4f64(,%eax,4),%eax
8010686c:	c1 e8 10             	shr    $0x10,%eax
8010686f:	89 c2                	mov    %eax,%edx
80106871:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106874:	66 89 14 c5 a6 5d 11 	mov    %dx,-0x7feea25a(,%eax,8)
8010687b:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010687c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106880:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
80106887:	0f 8e 30 ff ff ff    	jle    801067bd <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010688d:	a1 9c b1 10 80       	mov    0x8010b19c,%eax
80106892:	66 a3 a0 5f 11 80    	mov    %ax,0x80115fa0
80106898:	66 c7 05 a2 5f 11 80 	movw   $0x8,0x80115fa2
8010689f:	08 00 
801068a1:	0f b6 05 a4 5f 11 80 	movzbl 0x80115fa4,%eax
801068a8:	83 e0 e0             	and    $0xffffffe0,%eax
801068ab:	a2 a4 5f 11 80       	mov    %al,0x80115fa4
801068b0:	0f b6 05 a4 5f 11 80 	movzbl 0x80115fa4,%eax
801068b7:	83 e0 1f             	and    $0x1f,%eax
801068ba:	a2 a4 5f 11 80       	mov    %al,0x80115fa4
801068bf:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
801068c6:	83 c8 0f             	or     $0xf,%eax
801068c9:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
801068ce:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
801068d5:	83 e0 ef             	and    $0xffffffef,%eax
801068d8:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
801068dd:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
801068e4:	83 c8 60             	or     $0x60,%eax
801068e7:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
801068ec:	0f b6 05 a5 5f 11 80 	movzbl 0x80115fa5,%eax
801068f3:	83 c8 80             	or     $0xffffff80,%eax
801068f6:	a2 a5 5f 11 80       	mov    %al,0x80115fa5
801068fb:	a1 9c b1 10 80       	mov    0x8010b19c,%eax
80106900:	c1 e8 10             	shr    $0x10,%eax
80106903:	66 a3 a6 5f 11 80    	mov    %ax,0x80115fa6

  initlock(&tickslock, "time");
80106909:	83 ec 08             	sub    $0x8,%esp
8010690c:	68 b8 8a 10 80       	push   $0x80108ab8
80106911:	68 60 5d 11 80       	push   $0x80115d60
80106916:	e8 9f e7 ff ff       	call   801050ba <initlock>
8010691b:	83 c4 10             	add    $0x10,%esp
}
8010691e:	90                   	nop
8010691f:	c9                   	leave  
80106920:	c3                   	ret    

80106921 <idtinit>:

void
idtinit(void)
{
80106921:	55                   	push   %ebp
80106922:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106924:	68 00 08 00 00       	push   $0x800
80106929:	68 a0 5d 11 80       	push   $0x80115da0
8010692e:	e8 3d fe ff ff       	call   80106770 <lidt>
80106933:	83 c4 08             	add    $0x8,%esp
}
80106936:	90                   	nop
80106937:	c9                   	leave  
80106938:	c3                   	ret    

80106939 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106939:	55                   	push   %ebp
8010693a:	89 e5                	mov    %esp,%ebp
8010693c:	57                   	push   %edi
8010693d:	56                   	push   %esi
8010693e:	53                   	push   %ebx
8010693f:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106942:	8b 45 08             	mov    0x8(%ebp),%eax
80106945:	8b 40 30             	mov    0x30(%eax),%eax
80106948:	83 f8 40             	cmp    $0x40,%eax
8010694b:	75 3e                	jne    8010698b <trap+0x52>
    if(proc->killed)
8010694d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106953:	8b 40 24             	mov    0x24(%eax),%eax
80106956:	85 c0                	test   %eax,%eax
80106958:	74 05                	je     8010695f <trap+0x26>
      exit();
8010695a:	e8 23 df ff ff       	call   80104882 <exit>
    proc->tf = tf;
8010695f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106965:	8b 55 08             	mov    0x8(%ebp),%edx
80106968:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
8010696b:	e8 c1 ed ff ff       	call   80105731 <syscall>
    if(proc->killed)
80106970:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106976:	8b 40 24             	mov    0x24(%eax),%eax
80106979:	85 c0                	test   %eax,%eax
8010697b:	0f 84 06 02 00 00    	je     80106b87 <trap+0x24e>
      exit();
80106981:	e8 fc de ff ff       	call   80104882 <exit>
    return;
80106986:	e9 fc 01 00 00       	jmp    80106b87 <trap+0x24e>
  }

  switch(tf->trapno){
8010698b:	8b 45 08             	mov    0x8(%ebp),%eax
8010698e:	8b 40 30             	mov    0x30(%eax),%eax
80106991:	83 e8 20             	sub    $0x20,%eax
80106994:	83 f8 1f             	cmp    $0x1f,%eax
80106997:	0f 87 b5 00 00 00    	ja     80106a52 <trap+0x119>
8010699d:	8b 04 85 60 8b 10 80 	mov    -0x7fef74a0(,%eax,4),%eax
801069a4:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
801069a6:	e8 70 c6 ff ff       	call   8010301b <cpunum>
801069ab:	85 c0                	test   %eax,%eax
801069ad:	75 3d                	jne    801069ec <trap+0xb3>
      acquire(&tickslock);
801069af:	83 ec 0c             	sub    $0xc,%esp
801069b2:	68 60 5d 11 80       	push   $0x80115d60
801069b7:	e8 20 e7 ff ff       	call   801050dc <acquire>
801069bc:	83 c4 10             	add    $0x10,%esp
      ticks++;
801069bf:	a1 a0 65 11 80       	mov    0x801165a0,%eax
801069c4:	83 c0 01             	add    $0x1,%eax
801069c7:	a3 a0 65 11 80       	mov    %eax,0x801165a0
      wakeup(&ticks);
801069cc:	83 ec 0c             	sub    $0xc,%esp
801069cf:	68 a0 65 11 80       	push   $0x801165a0
801069d4:	e8 cf e3 ff ff       	call   80104da8 <wakeup>
801069d9:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
801069dc:	83 ec 0c             	sub    $0xc,%esp
801069df:	68 60 5d 11 80       	push   $0x80115d60
801069e4:	e8 5f e7 ff ff       	call   80105148 <release>
801069e9:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
801069ec:	e8 c8 c6 ff ff       	call   801030b9 <lapiceoi>
    break;
801069f1:	e9 0b 01 00 00       	jmp    80106b01 <trap+0x1c8>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801069f6:	e8 92 be ff ff       	call   8010288d <ideintr>
    lapiceoi();
801069fb:	e8 b9 c6 ff ff       	call   801030b9 <lapiceoi>
    break;
80106a00:	e9 fc 00 00 00       	jmp    80106b01 <trap+0x1c8>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106a05:	e8 6c c4 ff ff       	call   80102e76 <kbdintr>
    lapiceoi();
80106a0a:	e8 aa c6 ff ff       	call   801030b9 <lapiceoi>
    break;
80106a0f:	e9 ed 00 00 00       	jmp    80106b01 <trap+0x1c8>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106a14:	e8 4f 03 00 00       	call   80106d68 <uartintr>
    lapiceoi();
80106a19:	e8 9b c6 ff ff       	call   801030b9 <lapiceoi>
    break;
80106a1e:	e9 de 00 00 00       	jmp    80106b01 <trap+0x1c8>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a23:	8b 45 08             	mov    0x8(%ebp),%eax
80106a26:	8b 70 38             	mov    0x38(%eax),%esi
            cpunum(), tf->cs, tf->eip);
80106a29:	8b 45 08             	mov    0x8(%ebp),%eax
80106a2c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106a30:	0f b7 d8             	movzwl %ax,%ebx
80106a33:	e8 e3 c5 ff ff       	call   8010301b <cpunum>
80106a38:	56                   	push   %esi
80106a39:	53                   	push   %ebx
80106a3a:	50                   	push   %eax
80106a3b:	68 c0 8a 10 80       	push   $0x80108ac0
80106a40:	e8 bb 99 ff ff       	call   80100400 <cprintf>
80106a45:	83 c4 10             	add    $0x10,%esp
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80106a48:	e8 6c c6 ff ff       	call   801030b9 <lapiceoi>
    break;
80106a4d:	e9 af 00 00 00       	jmp    80106b01 <trap+0x1c8>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106a52:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a58:	85 c0                	test   %eax,%eax
80106a5a:	74 11                	je     80106a6d <trap+0x134>
80106a5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a5f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a63:	0f b7 c0             	movzwl %ax,%eax
80106a66:	83 e0 03             	and    $0x3,%eax
80106a69:	85 c0                	test   %eax,%eax
80106a6b:	75 3b                	jne    80106aa8 <trap+0x16f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a6d:	e8 28 fd ff ff       	call   8010679a <rcr2>
80106a72:	89 c6                	mov    %eax,%esi
80106a74:	8b 45 08             	mov    0x8(%ebp),%eax
80106a77:	8b 58 38             	mov    0x38(%eax),%ebx
80106a7a:	e8 9c c5 ff ff       	call   8010301b <cpunum>
80106a7f:	89 c2                	mov    %eax,%edx
80106a81:	8b 45 08             	mov    0x8(%ebp),%eax
80106a84:	8b 40 30             	mov    0x30(%eax),%eax
80106a87:	83 ec 0c             	sub    $0xc,%esp
80106a8a:	56                   	push   %esi
80106a8b:	53                   	push   %ebx
80106a8c:	52                   	push   %edx
80106a8d:	50                   	push   %eax
80106a8e:	68 e4 8a 10 80       	push   $0x80108ae4
80106a93:	e8 68 99 ff ff       	call   80100400 <cprintf>
80106a98:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80106a9b:	83 ec 0c             	sub    $0xc,%esp
80106a9e:	68 16 8b 10 80       	push   $0x80108b16
80106aa3:	e8 f8 9a ff ff       	call   801005a0 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106aa8:	e8 ed fc ff ff       	call   8010679a <rcr2>
80106aad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ab0:	8b 45 08             	mov    0x8(%ebp),%eax
80106ab3:	8b 58 38             	mov    0x38(%eax),%ebx
80106ab6:	e8 60 c5 ff ff       	call   8010301b <cpunum>
80106abb:	89 c7                	mov    %eax,%edi
80106abd:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac0:	8b 48 34             	mov    0x34(%eax),%ecx
80106ac3:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac6:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80106ac9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106acf:	8d 70 6c             	lea    0x6c(%eax),%esi
80106ad2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106ad8:	8b 40 10             	mov    0x10(%eax),%eax
80106adb:	ff 75 e4             	pushl  -0x1c(%ebp)
80106ade:	53                   	push   %ebx
80106adf:	57                   	push   %edi
80106ae0:	51                   	push   %ecx
80106ae1:	52                   	push   %edx
80106ae2:	56                   	push   %esi
80106ae3:	50                   	push   %eax
80106ae4:	68 1c 8b 10 80       	push   $0x80108b1c
80106ae9:	e8 12 99 ff ff       	call   80100400 <cprintf>
80106aee:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80106af1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106af7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106afe:	eb 01                	jmp    80106b01 <trap+0x1c8>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106b00:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b01:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b07:	85 c0                	test   %eax,%eax
80106b09:	74 24                	je     80106b2f <trap+0x1f6>
80106b0b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b11:	8b 40 24             	mov    0x24(%eax),%eax
80106b14:	85 c0                	test   %eax,%eax
80106b16:	74 17                	je     80106b2f <trap+0x1f6>
80106b18:	8b 45 08             	mov    0x8(%ebp),%eax
80106b1b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b1f:	0f b7 c0             	movzwl %ax,%eax
80106b22:	83 e0 03             	and    $0x3,%eax
80106b25:	83 f8 03             	cmp    $0x3,%eax
80106b28:	75 05                	jne    80106b2f <trap+0x1f6>
    exit();
80106b2a:	e8 53 dd ff ff       	call   80104882 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106b2f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b35:	85 c0                	test   %eax,%eax
80106b37:	74 1e                	je     80106b57 <trap+0x21e>
80106b39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b3f:	8b 40 0c             	mov    0xc(%eax),%eax
80106b42:	83 f8 04             	cmp    $0x4,%eax
80106b45:	75 10                	jne    80106b57 <trap+0x21e>
80106b47:	8b 45 08             	mov    0x8(%ebp),%eax
80106b4a:	8b 40 30             	mov    0x30(%eax),%eax
80106b4d:	83 f8 20             	cmp    $0x20,%eax
80106b50:	75 05                	jne    80106b57 <trap+0x21e>
    yield();
80106b52:	e8 e5 e0 ff ff       	call   80104c3c <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106b57:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b5d:	85 c0                	test   %eax,%eax
80106b5f:	74 27                	je     80106b88 <trap+0x24f>
80106b61:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b67:	8b 40 24             	mov    0x24(%eax),%eax
80106b6a:	85 c0                	test   %eax,%eax
80106b6c:	74 1a                	je     80106b88 <trap+0x24f>
80106b6e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b71:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b75:	0f b7 c0             	movzwl %ax,%eax
80106b78:	83 e0 03             	and    $0x3,%eax
80106b7b:	83 f8 03             	cmp    $0x3,%eax
80106b7e:	75 08                	jne    80106b88 <trap+0x24f>
    exit();
80106b80:	e8 fd dc ff ff       	call   80104882 <exit>
80106b85:	eb 01                	jmp    80106b88 <trap+0x24f>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106b87:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b8b:	5b                   	pop    %ebx
80106b8c:	5e                   	pop    %esi
80106b8d:	5f                   	pop    %edi
80106b8e:	5d                   	pop    %ebp
80106b8f:	c3                   	ret    

80106b90 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	83 ec 14             	sub    $0x14,%esp
80106b96:	8b 45 08             	mov    0x8(%ebp),%eax
80106b99:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b9d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106ba1:	89 c2                	mov    %eax,%edx
80106ba3:	ec                   	in     (%dx),%al
80106ba4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106ba7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106bab:	c9                   	leave  
80106bac:	c3                   	ret    

80106bad <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106bad:	55                   	push   %ebp
80106bae:	89 e5                	mov    %esp,%ebp
80106bb0:	83 ec 08             	sub    $0x8,%esp
80106bb3:	8b 55 08             	mov    0x8(%ebp),%edx
80106bb6:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bb9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106bbd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106bc0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106bc4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106bc8:	ee                   	out    %al,(%dx)
}
80106bc9:	90                   	nop
80106bca:	c9                   	leave  
80106bcb:	c3                   	ret    

80106bcc <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106bcc:	55                   	push   %ebp
80106bcd:	89 e5                	mov    %esp,%ebp
80106bcf:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106bd2:	6a 00                	push   $0x0
80106bd4:	68 fa 03 00 00       	push   $0x3fa
80106bd9:	e8 cf ff ff ff       	call   80106bad <outb>
80106bde:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106be1:	68 80 00 00 00       	push   $0x80
80106be6:	68 fb 03 00 00       	push   $0x3fb
80106beb:	e8 bd ff ff ff       	call   80106bad <outb>
80106bf0:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106bf3:	6a 0c                	push   $0xc
80106bf5:	68 f8 03 00 00       	push   $0x3f8
80106bfa:	e8 ae ff ff ff       	call   80106bad <outb>
80106bff:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106c02:	6a 00                	push   $0x0
80106c04:	68 f9 03 00 00       	push   $0x3f9
80106c09:	e8 9f ff ff ff       	call   80106bad <outb>
80106c0e:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106c11:	6a 03                	push   $0x3
80106c13:	68 fb 03 00 00       	push   $0x3fb
80106c18:	e8 90 ff ff ff       	call   80106bad <outb>
80106c1d:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106c20:	6a 00                	push   $0x0
80106c22:	68 fc 03 00 00       	push   $0x3fc
80106c27:	e8 81 ff ff ff       	call   80106bad <outb>
80106c2c:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106c2f:	6a 01                	push   $0x1
80106c31:	68 f9 03 00 00       	push   $0x3f9
80106c36:	e8 72 ff ff ff       	call   80106bad <outb>
80106c3b:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106c3e:	68 fd 03 00 00       	push   $0x3fd
80106c43:	e8 48 ff ff ff       	call   80106b90 <inb>
80106c48:	83 c4 04             	add    $0x4,%esp
80106c4b:	3c ff                	cmp    $0xff,%al
80106c4d:	74 6e                	je     80106cbd <uartinit+0xf1>
    return;
  uart = 1;
80106c4f:	c7 05 48 b6 10 80 01 	movl   $0x1,0x8010b648
80106c56:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106c59:	68 fa 03 00 00       	push   $0x3fa
80106c5e:	e8 2d ff ff ff       	call   80106b90 <inb>
80106c63:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106c66:	68 f8 03 00 00       	push   $0x3f8
80106c6b:	e8 20 ff ff ff       	call   80106b90 <inb>
80106c70:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106c73:	83 ec 0c             	sub    $0xc,%esp
80106c76:	6a 04                	push   $0x4
80106c78:	e8 48 d2 ff ff       	call   80103ec5 <picenable>
80106c7d:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106c80:	83 ec 08             	sub    $0x8,%esp
80106c83:	6a 00                	push   $0x0
80106c85:	6a 04                	push   $0x4
80106c87:	e8 ad be ff ff       	call   80102b39 <ioapicenable>
80106c8c:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c8f:	c7 45 f4 e0 8b 10 80 	movl   $0x80108be0,-0xc(%ebp)
80106c96:	eb 19                	jmp    80106cb1 <uartinit+0xe5>
    uartputc(*p);
80106c98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c9b:	0f b6 00             	movzbl (%eax),%eax
80106c9e:	0f be c0             	movsbl %al,%eax
80106ca1:	83 ec 0c             	sub    $0xc,%esp
80106ca4:	50                   	push   %eax
80106ca5:	e8 16 00 00 00       	call   80106cc0 <uartputc>
80106caa:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106cad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106cb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cb4:	0f b6 00             	movzbl (%eax),%eax
80106cb7:	84 c0                	test   %al,%al
80106cb9:	75 dd                	jne    80106c98 <uartinit+0xcc>
80106cbb:	eb 01                	jmp    80106cbe <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106cbd:	90                   	nop
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106cbe:	c9                   	leave  
80106cbf:	c3                   	ret    

80106cc0 <uartputc>:

void
uartputc(int c)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80106cc6:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80106ccb:	85 c0                	test   %eax,%eax
80106ccd:	74 53                	je     80106d22 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106ccf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106cd6:	eb 11                	jmp    80106ce9 <uartputc+0x29>
    microdelay(10);
80106cd8:	83 ec 0c             	sub    $0xc,%esp
80106cdb:	6a 0a                	push   $0xa
80106cdd:	e8 f2 c3 ff ff       	call   801030d4 <microdelay>
80106ce2:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106ce5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106ce9:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106ced:	7f 1a                	jg     80106d09 <uartputc+0x49>
80106cef:	83 ec 0c             	sub    $0xc,%esp
80106cf2:	68 fd 03 00 00       	push   $0x3fd
80106cf7:	e8 94 fe ff ff       	call   80106b90 <inb>
80106cfc:	83 c4 10             	add    $0x10,%esp
80106cff:	0f b6 c0             	movzbl %al,%eax
80106d02:	83 e0 20             	and    $0x20,%eax
80106d05:	85 c0                	test   %eax,%eax
80106d07:	74 cf                	je     80106cd8 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106d09:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0c:	0f b6 c0             	movzbl %al,%eax
80106d0f:	83 ec 08             	sub    $0x8,%esp
80106d12:	50                   	push   %eax
80106d13:	68 f8 03 00 00       	push   $0x3f8
80106d18:	e8 90 fe ff ff       	call   80106bad <outb>
80106d1d:	83 c4 10             	add    $0x10,%esp
80106d20:	eb 01                	jmp    80106d23 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106d22:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106d23:	c9                   	leave  
80106d24:	c3                   	ret    

80106d25 <uartgetc>:

static int
uartgetc(void)
{
80106d25:	55                   	push   %ebp
80106d26:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106d28:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80106d2d:	85 c0                	test   %eax,%eax
80106d2f:	75 07                	jne    80106d38 <uartgetc+0x13>
    return -1;
80106d31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d36:	eb 2e                	jmp    80106d66 <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106d38:	68 fd 03 00 00       	push   $0x3fd
80106d3d:	e8 4e fe ff ff       	call   80106b90 <inb>
80106d42:	83 c4 04             	add    $0x4,%esp
80106d45:	0f b6 c0             	movzbl %al,%eax
80106d48:	83 e0 01             	and    $0x1,%eax
80106d4b:	85 c0                	test   %eax,%eax
80106d4d:	75 07                	jne    80106d56 <uartgetc+0x31>
    return -1;
80106d4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d54:	eb 10                	jmp    80106d66 <uartgetc+0x41>
  return inb(COM1+0);
80106d56:	68 f8 03 00 00       	push   $0x3f8
80106d5b:	e8 30 fe ff ff       	call   80106b90 <inb>
80106d60:	83 c4 04             	add    $0x4,%esp
80106d63:	0f b6 c0             	movzbl %al,%eax
}
80106d66:	c9                   	leave  
80106d67:	c3                   	ret    

80106d68 <uartintr>:

void
uartintr(void)
{
80106d68:	55                   	push   %ebp
80106d69:	89 e5                	mov    %esp,%ebp
80106d6b:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80106d6e:	83 ec 0c             	sub    $0xc,%esp
80106d71:	68 25 6d 10 80       	push   $0x80106d25
80106d76:	e8 b8 9a ff ff       	call   80100833 <consoleintr>
80106d7b:	83 c4 10             	add    $0x10,%esp
}
80106d7e:	90                   	nop
80106d7f:	c9                   	leave  
80106d80:	c3                   	ret    

80106d81 <vector0>:
80106d81:	6a 00                	push   $0x0
80106d83:	6a 00                	push   $0x0
80106d85:	e9 bb f9 ff ff       	jmp    80106745 <alltraps>

80106d8a <vector1>:
80106d8a:	6a 00                	push   $0x0
80106d8c:	6a 01                	push   $0x1
80106d8e:	e9 b2 f9 ff ff       	jmp    80106745 <alltraps>

80106d93 <vector2>:
80106d93:	6a 00                	push   $0x0
80106d95:	6a 02                	push   $0x2
80106d97:	e9 a9 f9 ff ff       	jmp    80106745 <alltraps>

80106d9c <vector3>:
80106d9c:	6a 00                	push   $0x0
80106d9e:	6a 03                	push   $0x3
80106da0:	e9 a0 f9 ff ff       	jmp    80106745 <alltraps>

80106da5 <vector4>:
80106da5:	6a 00                	push   $0x0
80106da7:	6a 04                	push   $0x4
80106da9:	e9 97 f9 ff ff       	jmp    80106745 <alltraps>

80106dae <vector5>:
80106dae:	6a 00                	push   $0x0
80106db0:	6a 05                	push   $0x5
80106db2:	e9 8e f9 ff ff       	jmp    80106745 <alltraps>

80106db7 <vector6>:
80106db7:	6a 00                	push   $0x0
80106db9:	6a 06                	push   $0x6
80106dbb:	e9 85 f9 ff ff       	jmp    80106745 <alltraps>

80106dc0 <vector7>:
80106dc0:	6a 00                	push   $0x0
80106dc2:	6a 07                	push   $0x7
80106dc4:	e9 7c f9 ff ff       	jmp    80106745 <alltraps>

80106dc9 <vector8>:
80106dc9:	6a 08                	push   $0x8
80106dcb:	e9 75 f9 ff ff       	jmp    80106745 <alltraps>

80106dd0 <vector9>:
80106dd0:	6a 00                	push   $0x0
80106dd2:	6a 09                	push   $0x9
80106dd4:	e9 6c f9 ff ff       	jmp    80106745 <alltraps>

80106dd9 <vector10>:
80106dd9:	6a 0a                	push   $0xa
80106ddb:	e9 65 f9 ff ff       	jmp    80106745 <alltraps>

80106de0 <vector11>:
80106de0:	6a 0b                	push   $0xb
80106de2:	e9 5e f9 ff ff       	jmp    80106745 <alltraps>

80106de7 <vector12>:
80106de7:	6a 0c                	push   $0xc
80106de9:	e9 57 f9 ff ff       	jmp    80106745 <alltraps>

80106dee <vector13>:
80106dee:	6a 0d                	push   $0xd
80106df0:	e9 50 f9 ff ff       	jmp    80106745 <alltraps>

80106df5 <vector14>:
80106df5:	6a 0e                	push   $0xe
80106df7:	e9 49 f9 ff ff       	jmp    80106745 <alltraps>

80106dfc <vector15>:
80106dfc:	6a 00                	push   $0x0
80106dfe:	6a 0f                	push   $0xf
80106e00:	e9 40 f9 ff ff       	jmp    80106745 <alltraps>

80106e05 <vector16>:
80106e05:	6a 00                	push   $0x0
80106e07:	6a 10                	push   $0x10
80106e09:	e9 37 f9 ff ff       	jmp    80106745 <alltraps>

80106e0e <vector17>:
80106e0e:	6a 11                	push   $0x11
80106e10:	e9 30 f9 ff ff       	jmp    80106745 <alltraps>

80106e15 <vector18>:
80106e15:	6a 00                	push   $0x0
80106e17:	6a 12                	push   $0x12
80106e19:	e9 27 f9 ff ff       	jmp    80106745 <alltraps>

80106e1e <vector19>:
80106e1e:	6a 00                	push   $0x0
80106e20:	6a 13                	push   $0x13
80106e22:	e9 1e f9 ff ff       	jmp    80106745 <alltraps>

80106e27 <vector20>:
80106e27:	6a 00                	push   $0x0
80106e29:	6a 14                	push   $0x14
80106e2b:	e9 15 f9 ff ff       	jmp    80106745 <alltraps>

80106e30 <vector21>:
80106e30:	6a 00                	push   $0x0
80106e32:	6a 15                	push   $0x15
80106e34:	e9 0c f9 ff ff       	jmp    80106745 <alltraps>

80106e39 <vector22>:
80106e39:	6a 00                	push   $0x0
80106e3b:	6a 16                	push   $0x16
80106e3d:	e9 03 f9 ff ff       	jmp    80106745 <alltraps>

80106e42 <vector23>:
80106e42:	6a 00                	push   $0x0
80106e44:	6a 17                	push   $0x17
80106e46:	e9 fa f8 ff ff       	jmp    80106745 <alltraps>

80106e4b <vector24>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	6a 18                	push   $0x18
80106e4f:	e9 f1 f8 ff ff       	jmp    80106745 <alltraps>

80106e54 <vector25>:
80106e54:	6a 00                	push   $0x0
80106e56:	6a 19                	push   $0x19
80106e58:	e9 e8 f8 ff ff       	jmp    80106745 <alltraps>

80106e5d <vector26>:
80106e5d:	6a 00                	push   $0x0
80106e5f:	6a 1a                	push   $0x1a
80106e61:	e9 df f8 ff ff       	jmp    80106745 <alltraps>

80106e66 <vector27>:
80106e66:	6a 00                	push   $0x0
80106e68:	6a 1b                	push   $0x1b
80106e6a:	e9 d6 f8 ff ff       	jmp    80106745 <alltraps>

80106e6f <vector28>:
80106e6f:	6a 00                	push   $0x0
80106e71:	6a 1c                	push   $0x1c
80106e73:	e9 cd f8 ff ff       	jmp    80106745 <alltraps>

80106e78 <vector29>:
80106e78:	6a 00                	push   $0x0
80106e7a:	6a 1d                	push   $0x1d
80106e7c:	e9 c4 f8 ff ff       	jmp    80106745 <alltraps>

80106e81 <vector30>:
80106e81:	6a 00                	push   $0x0
80106e83:	6a 1e                	push   $0x1e
80106e85:	e9 bb f8 ff ff       	jmp    80106745 <alltraps>

80106e8a <vector31>:
80106e8a:	6a 00                	push   $0x0
80106e8c:	6a 1f                	push   $0x1f
80106e8e:	e9 b2 f8 ff ff       	jmp    80106745 <alltraps>

80106e93 <vector32>:
80106e93:	6a 00                	push   $0x0
80106e95:	6a 20                	push   $0x20
80106e97:	e9 a9 f8 ff ff       	jmp    80106745 <alltraps>

80106e9c <vector33>:
80106e9c:	6a 00                	push   $0x0
80106e9e:	6a 21                	push   $0x21
80106ea0:	e9 a0 f8 ff ff       	jmp    80106745 <alltraps>

80106ea5 <vector34>:
80106ea5:	6a 00                	push   $0x0
80106ea7:	6a 22                	push   $0x22
80106ea9:	e9 97 f8 ff ff       	jmp    80106745 <alltraps>

80106eae <vector35>:
80106eae:	6a 00                	push   $0x0
80106eb0:	6a 23                	push   $0x23
80106eb2:	e9 8e f8 ff ff       	jmp    80106745 <alltraps>

80106eb7 <vector36>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	6a 24                	push   $0x24
80106ebb:	e9 85 f8 ff ff       	jmp    80106745 <alltraps>

80106ec0 <vector37>:
80106ec0:	6a 00                	push   $0x0
80106ec2:	6a 25                	push   $0x25
80106ec4:	e9 7c f8 ff ff       	jmp    80106745 <alltraps>

80106ec9 <vector38>:
80106ec9:	6a 00                	push   $0x0
80106ecb:	6a 26                	push   $0x26
80106ecd:	e9 73 f8 ff ff       	jmp    80106745 <alltraps>

80106ed2 <vector39>:
80106ed2:	6a 00                	push   $0x0
80106ed4:	6a 27                	push   $0x27
80106ed6:	e9 6a f8 ff ff       	jmp    80106745 <alltraps>

80106edb <vector40>:
80106edb:	6a 00                	push   $0x0
80106edd:	6a 28                	push   $0x28
80106edf:	e9 61 f8 ff ff       	jmp    80106745 <alltraps>

80106ee4 <vector41>:
80106ee4:	6a 00                	push   $0x0
80106ee6:	6a 29                	push   $0x29
80106ee8:	e9 58 f8 ff ff       	jmp    80106745 <alltraps>

80106eed <vector42>:
80106eed:	6a 00                	push   $0x0
80106eef:	6a 2a                	push   $0x2a
80106ef1:	e9 4f f8 ff ff       	jmp    80106745 <alltraps>

80106ef6 <vector43>:
80106ef6:	6a 00                	push   $0x0
80106ef8:	6a 2b                	push   $0x2b
80106efa:	e9 46 f8 ff ff       	jmp    80106745 <alltraps>

80106eff <vector44>:
80106eff:	6a 00                	push   $0x0
80106f01:	6a 2c                	push   $0x2c
80106f03:	e9 3d f8 ff ff       	jmp    80106745 <alltraps>

80106f08 <vector45>:
80106f08:	6a 00                	push   $0x0
80106f0a:	6a 2d                	push   $0x2d
80106f0c:	e9 34 f8 ff ff       	jmp    80106745 <alltraps>

80106f11 <vector46>:
80106f11:	6a 00                	push   $0x0
80106f13:	6a 2e                	push   $0x2e
80106f15:	e9 2b f8 ff ff       	jmp    80106745 <alltraps>

80106f1a <vector47>:
80106f1a:	6a 00                	push   $0x0
80106f1c:	6a 2f                	push   $0x2f
80106f1e:	e9 22 f8 ff ff       	jmp    80106745 <alltraps>

80106f23 <vector48>:
80106f23:	6a 00                	push   $0x0
80106f25:	6a 30                	push   $0x30
80106f27:	e9 19 f8 ff ff       	jmp    80106745 <alltraps>

80106f2c <vector49>:
80106f2c:	6a 00                	push   $0x0
80106f2e:	6a 31                	push   $0x31
80106f30:	e9 10 f8 ff ff       	jmp    80106745 <alltraps>

80106f35 <vector50>:
80106f35:	6a 00                	push   $0x0
80106f37:	6a 32                	push   $0x32
80106f39:	e9 07 f8 ff ff       	jmp    80106745 <alltraps>

80106f3e <vector51>:
80106f3e:	6a 00                	push   $0x0
80106f40:	6a 33                	push   $0x33
80106f42:	e9 fe f7 ff ff       	jmp    80106745 <alltraps>

80106f47 <vector52>:
80106f47:	6a 00                	push   $0x0
80106f49:	6a 34                	push   $0x34
80106f4b:	e9 f5 f7 ff ff       	jmp    80106745 <alltraps>

80106f50 <vector53>:
80106f50:	6a 00                	push   $0x0
80106f52:	6a 35                	push   $0x35
80106f54:	e9 ec f7 ff ff       	jmp    80106745 <alltraps>

80106f59 <vector54>:
80106f59:	6a 00                	push   $0x0
80106f5b:	6a 36                	push   $0x36
80106f5d:	e9 e3 f7 ff ff       	jmp    80106745 <alltraps>

80106f62 <vector55>:
80106f62:	6a 00                	push   $0x0
80106f64:	6a 37                	push   $0x37
80106f66:	e9 da f7 ff ff       	jmp    80106745 <alltraps>

80106f6b <vector56>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	6a 38                	push   $0x38
80106f6f:	e9 d1 f7 ff ff       	jmp    80106745 <alltraps>

80106f74 <vector57>:
80106f74:	6a 00                	push   $0x0
80106f76:	6a 39                	push   $0x39
80106f78:	e9 c8 f7 ff ff       	jmp    80106745 <alltraps>

80106f7d <vector58>:
80106f7d:	6a 00                	push   $0x0
80106f7f:	6a 3a                	push   $0x3a
80106f81:	e9 bf f7 ff ff       	jmp    80106745 <alltraps>

80106f86 <vector59>:
80106f86:	6a 00                	push   $0x0
80106f88:	6a 3b                	push   $0x3b
80106f8a:	e9 b6 f7 ff ff       	jmp    80106745 <alltraps>

80106f8f <vector60>:
80106f8f:	6a 00                	push   $0x0
80106f91:	6a 3c                	push   $0x3c
80106f93:	e9 ad f7 ff ff       	jmp    80106745 <alltraps>

80106f98 <vector61>:
80106f98:	6a 00                	push   $0x0
80106f9a:	6a 3d                	push   $0x3d
80106f9c:	e9 a4 f7 ff ff       	jmp    80106745 <alltraps>

80106fa1 <vector62>:
80106fa1:	6a 00                	push   $0x0
80106fa3:	6a 3e                	push   $0x3e
80106fa5:	e9 9b f7 ff ff       	jmp    80106745 <alltraps>

80106faa <vector63>:
80106faa:	6a 00                	push   $0x0
80106fac:	6a 3f                	push   $0x3f
80106fae:	e9 92 f7 ff ff       	jmp    80106745 <alltraps>

80106fb3 <vector64>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	6a 40                	push   $0x40
80106fb7:	e9 89 f7 ff ff       	jmp    80106745 <alltraps>

80106fbc <vector65>:
80106fbc:	6a 00                	push   $0x0
80106fbe:	6a 41                	push   $0x41
80106fc0:	e9 80 f7 ff ff       	jmp    80106745 <alltraps>

80106fc5 <vector66>:
80106fc5:	6a 00                	push   $0x0
80106fc7:	6a 42                	push   $0x42
80106fc9:	e9 77 f7 ff ff       	jmp    80106745 <alltraps>

80106fce <vector67>:
80106fce:	6a 00                	push   $0x0
80106fd0:	6a 43                	push   $0x43
80106fd2:	e9 6e f7 ff ff       	jmp    80106745 <alltraps>

80106fd7 <vector68>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	6a 44                	push   $0x44
80106fdb:	e9 65 f7 ff ff       	jmp    80106745 <alltraps>

80106fe0 <vector69>:
80106fe0:	6a 00                	push   $0x0
80106fe2:	6a 45                	push   $0x45
80106fe4:	e9 5c f7 ff ff       	jmp    80106745 <alltraps>

80106fe9 <vector70>:
80106fe9:	6a 00                	push   $0x0
80106feb:	6a 46                	push   $0x46
80106fed:	e9 53 f7 ff ff       	jmp    80106745 <alltraps>

80106ff2 <vector71>:
80106ff2:	6a 00                	push   $0x0
80106ff4:	6a 47                	push   $0x47
80106ff6:	e9 4a f7 ff ff       	jmp    80106745 <alltraps>

80106ffb <vector72>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	6a 48                	push   $0x48
80106fff:	e9 41 f7 ff ff       	jmp    80106745 <alltraps>

80107004 <vector73>:
80107004:	6a 00                	push   $0x0
80107006:	6a 49                	push   $0x49
80107008:	e9 38 f7 ff ff       	jmp    80106745 <alltraps>

8010700d <vector74>:
8010700d:	6a 00                	push   $0x0
8010700f:	6a 4a                	push   $0x4a
80107011:	e9 2f f7 ff ff       	jmp    80106745 <alltraps>

80107016 <vector75>:
80107016:	6a 00                	push   $0x0
80107018:	6a 4b                	push   $0x4b
8010701a:	e9 26 f7 ff ff       	jmp    80106745 <alltraps>

8010701f <vector76>:
8010701f:	6a 00                	push   $0x0
80107021:	6a 4c                	push   $0x4c
80107023:	e9 1d f7 ff ff       	jmp    80106745 <alltraps>

80107028 <vector77>:
80107028:	6a 00                	push   $0x0
8010702a:	6a 4d                	push   $0x4d
8010702c:	e9 14 f7 ff ff       	jmp    80106745 <alltraps>

80107031 <vector78>:
80107031:	6a 00                	push   $0x0
80107033:	6a 4e                	push   $0x4e
80107035:	e9 0b f7 ff ff       	jmp    80106745 <alltraps>

8010703a <vector79>:
8010703a:	6a 00                	push   $0x0
8010703c:	6a 4f                	push   $0x4f
8010703e:	e9 02 f7 ff ff       	jmp    80106745 <alltraps>

80107043 <vector80>:
80107043:	6a 00                	push   $0x0
80107045:	6a 50                	push   $0x50
80107047:	e9 f9 f6 ff ff       	jmp    80106745 <alltraps>

8010704c <vector81>:
8010704c:	6a 00                	push   $0x0
8010704e:	6a 51                	push   $0x51
80107050:	e9 f0 f6 ff ff       	jmp    80106745 <alltraps>

80107055 <vector82>:
80107055:	6a 00                	push   $0x0
80107057:	6a 52                	push   $0x52
80107059:	e9 e7 f6 ff ff       	jmp    80106745 <alltraps>

8010705e <vector83>:
8010705e:	6a 00                	push   $0x0
80107060:	6a 53                	push   $0x53
80107062:	e9 de f6 ff ff       	jmp    80106745 <alltraps>

80107067 <vector84>:
80107067:	6a 00                	push   $0x0
80107069:	6a 54                	push   $0x54
8010706b:	e9 d5 f6 ff ff       	jmp    80106745 <alltraps>

80107070 <vector85>:
80107070:	6a 00                	push   $0x0
80107072:	6a 55                	push   $0x55
80107074:	e9 cc f6 ff ff       	jmp    80106745 <alltraps>

80107079 <vector86>:
80107079:	6a 00                	push   $0x0
8010707b:	6a 56                	push   $0x56
8010707d:	e9 c3 f6 ff ff       	jmp    80106745 <alltraps>

80107082 <vector87>:
80107082:	6a 00                	push   $0x0
80107084:	6a 57                	push   $0x57
80107086:	e9 ba f6 ff ff       	jmp    80106745 <alltraps>

8010708b <vector88>:
8010708b:	6a 00                	push   $0x0
8010708d:	6a 58                	push   $0x58
8010708f:	e9 b1 f6 ff ff       	jmp    80106745 <alltraps>

80107094 <vector89>:
80107094:	6a 00                	push   $0x0
80107096:	6a 59                	push   $0x59
80107098:	e9 a8 f6 ff ff       	jmp    80106745 <alltraps>

8010709d <vector90>:
8010709d:	6a 00                	push   $0x0
8010709f:	6a 5a                	push   $0x5a
801070a1:	e9 9f f6 ff ff       	jmp    80106745 <alltraps>

801070a6 <vector91>:
801070a6:	6a 00                	push   $0x0
801070a8:	6a 5b                	push   $0x5b
801070aa:	e9 96 f6 ff ff       	jmp    80106745 <alltraps>

801070af <vector92>:
801070af:	6a 00                	push   $0x0
801070b1:	6a 5c                	push   $0x5c
801070b3:	e9 8d f6 ff ff       	jmp    80106745 <alltraps>

801070b8 <vector93>:
801070b8:	6a 00                	push   $0x0
801070ba:	6a 5d                	push   $0x5d
801070bc:	e9 84 f6 ff ff       	jmp    80106745 <alltraps>

801070c1 <vector94>:
801070c1:	6a 00                	push   $0x0
801070c3:	6a 5e                	push   $0x5e
801070c5:	e9 7b f6 ff ff       	jmp    80106745 <alltraps>

801070ca <vector95>:
801070ca:	6a 00                	push   $0x0
801070cc:	6a 5f                	push   $0x5f
801070ce:	e9 72 f6 ff ff       	jmp    80106745 <alltraps>

801070d3 <vector96>:
801070d3:	6a 00                	push   $0x0
801070d5:	6a 60                	push   $0x60
801070d7:	e9 69 f6 ff ff       	jmp    80106745 <alltraps>

801070dc <vector97>:
801070dc:	6a 00                	push   $0x0
801070de:	6a 61                	push   $0x61
801070e0:	e9 60 f6 ff ff       	jmp    80106745 <alltraps>

801070e5 <vector98>:
801070e5:	6a 00                	push   $0x0
801070e7:	6a 62                	push   $0x62
801070e9:	e9 57 f6 ff ff       	jmp    80106745 <alltraps>

801070ee <vector99>:
801070ee:	6a 00                	push   $0x0
801070f0:	6a 63                	push   $0x63
801070f2:	e9 4e f6 ff ff       	jmp    80106745 <alltraps>

801070f7 <vector100>:
801070f7:	6a 00                	push   $0x0
801070f9:	6a 64                	push   $0x64
801070fb:	e9 45 f6 ff ff       	jmp    80106745 <alltraps>

80107100 <vector101>:
80107100:	6a 00                	push   $0x0
80107102:	6a 65                	push   $0x65
80107104:	e9 3c f6 ff ff       	jmp    80106745 <alltraps>

80107109 <vector102>:
80107109:	6a 00                	push   $0x0
8010710b:	6a 66                	push   $0x66
8010710d:	e9 33 f6 ff ff       	jmp    80106745 <alltraps>

80107112 <vector103>:
80107112:	6a 00                	push   $0x0
80107114:	6a 67                	push   $0x67
80107116:	e9 2a f6 ff ff       	jmp    80106745 <alltraps>

8010711b <vector104>:
8010711b:	6a 00                	push   $0x0
8010711d:	6a 68                	push   $0x68
8010711f:	e9 21 f6 ff ff       	jmp    80106745 <alltraps>

80107124 <vector105>:
80107124:	6a 00                	push   $0x0
80107126:	6a 69                	push   $0x69
80107128:	e9 18 f6 ff ff       	jmp    80106745 <alltraps>

8010712d <vector106>:
8010712d:	6a 00                	push   $0x0
8010712f:	6a 6a                	push   $0x6a
80107131:	e9 0f f6 ff ff       	jmp    80106745 <alltraps>

80107136 <vector107>:
80107136:	6a 00                	push   $0x0
80107138:	6a 6b                	push   $0x6b
8010713a:	e9 06 f6 ff ff       	jmp    80106745 <alltraps>

8010713f <vector108>:
8010713f:	6a 00                	push   $0x0
80107141:	6a 6c                	push   $0x6c
80107143:	e9 fd f5 ff ff       	jmp    80106745 <alltraps>

80107148 <vector109>:
80107148:	6a 00                	push   $0x0
8010714a:	6a 6d                	push   $0x6d
8010714c:	e9 f4 f5 ff ff       	jmp    80106745 <alltraps>

80107151 <vector110>:
80107151:	6a 00                	push   $0x0
80107153:	6a 6e                	push   $0x6e
80107155:	e9 eb f5 ff ff       	jmp    80106745 <alltraps>

8010715a <vector111>:
8010715a:	6a 00                	push   $0x0
8010715c:	6a 6f                	push   $0x6f
8010715e:	e9 e2 f5 ff ff       	jmp    80106745 <alltraps>

80107163 <vector112>:
80107163:	6a 00                	push   $0x0
80107165:	6a 70                	push   $0x70
80107167:	e9 d9 f5 ff ff       	jmp    80106745 <alltraps>

8010716c <vector113>:
8010716c:	6a 00                	push   $0x0
8010716e:	6a 71                	push   $0x71
80107170:	e9 d0 f5 ff ff       	jmp    80106745 <alltraps>

80107175 <vector114>:
80107175:	6a 00                	push   $0x0
80107177:	6a 72                	push   $0x72
80107179:	e9 c7 f5 ff ff       	jmp    80106745 <alltraps>

8010717e <vector115>:
8010717e:	6a 00                	push   $0x0
80107180:	6a 73                	push   $0x73
80107182:	e9 be f5 ff ff       	jmp    80106745 <alltraps>

80107187 <vector116>:
80107187:	6a 00                	push   $0x0
80107189:	6a 74                	push   $0x74
8010718b:	e9 b5 f5 ff ff       	jmp    80106745 <alltraps>

80107190 <vector117>:
80107190:	6a 00                	push   $0x0
80107192:	6a 75                	push   $0x75
80107194:	e9 ac f5 ff ff       	jmp    80106745 <alltraps>

80107199 <vector118>:
80107199:	6a 00                	push   $0x0
8010719b:	6a 76                	push   $0x76
8010719d:	e9 a3 f5 ff ff       	jmp    80106745 <alltraps>

801071a2 <vector119>:
801071a2:	6a 00                	push   $0x0
801071a4:	6a 77                	push   $0x77
801071a6:	e9 9a f5 ff ff       	jmp    80106745 <alltraps>

801071ab <vector120>:
801071ab:	6a 00                	push   $0x0
801071ad:	6a 78                	push   $0x78
801071af:	e9 91 f5 ff ff       	jmp    80106745 <alltraps>

801071b4 <vector121>:
801071b4:	6a 00                	push   $0x0
801071b6:	6a 79                	push   $0x79
801071b8:	e9 88 f5 ff ff       	jmp    80106745 <alltraps>

801071bd <vector122>:
801071bd:	6a 00                	push   $0x0
801071bf:	6a 7a                	push   $0x7a
801071c1:	e9 7f f5 ff ff       	jmp    80106745 <alltraps>

801071c6 <vector123>:
801071c6:	6a 00                	push   $0x0
801071c8:	6a 7b                	push   $0x7b
801071ca:	e9 76 f5 ff ff       	jmp    80106745 <alltraps>

801071cf <vector124>:
801071cf:	6a 00                	push   $0x0
801071d1:	6a 7c                	push   $0x7c
801071d3:	e9 6d f5 ff ff       	jmp    80106745 <alltraps>

801071d8 <vector125>:
801071d8:	6a 00                	push   $0x0
801071da:	6a 7d                	push   $0x7d
801071dc:	e9 64 f5 ff ff       	jmp    80106745 <alltraps>

801071e1 <vector126>:
801071e1:	6a 00                	push   $0x0
801071e3:	6a 7e                	push   $0x7e
801071e5:	e9 5b f5 ff ff       	jmp    80106745 <alltraps>

801071ea <vector127>:
801071ea:	6a 00                	push   $0x0
801071ec:	6a 7f                	push   $0x7f
801071ee:	e9 52 f5 ff ff       	jmp    80106745 <alltraps>

801071f3 <vector128>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 80 00 00 00       	push   $0x80
801071fa:	e9 46 f5 ff ff       	jmp    80106745 <alltraps>

801071ff <vector129>:
801071ff:	6a 00                	push   $0x0
80107201:	68 81 00 00 00       	push   $0x81
80107206:	e9 3a f5 ff ff       	jmp    80106745 <alltraps>

8010720b <vector130>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 82 00 00 00       	push   $0x82
80107212:	e9 2e f5 ff ff       	jmp    80106745 <alltraps>

80107217 <vector131>:
80107217:	6a 00                	push   $0x0
80107219:	68 83 00 00 00       	push   $0x83
8010721e:	e9 22 f5 ff ff       	jmp    80106745 <alltraps>

80107223 <vector132>:
80107223:	6a 00                	push   $0x0
80107225:	68 84 00 00 00       	push   $0x84
8010722a:	e9 16 f5 ff ff       	jmp    80106745 <alltraps>

8010722f <vector133>:
8010722f:	6a 00                	push   $0x0
80107231:	68 85 00 00 00       	push   $0x85
80107236:	e9 0a f5 ff ff       	jmp    80106745 <alltraps>

8010723b <vector134>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 86 00 00 00       	push   $0x86
80107242:	e9 fe f4 ff ff       	jmp    80106745 <alltraps>

80107247 <vector135>:
80107247:	6a 00                	push   $0x0
80107249:	68 87 00 00 00       	push   $0x87
8010724e:	e9 f2 f4 ff ff       	jmp    80106745 <alltraps>

80107253 <vector136>:
80107253:	6a 00                	push   $0x0
80107255:	68 88 00 00 00       	push   $0x88
8010725a:	e9 e6 f4 ff ff       	jmp    80106745 <alltraps>

8010725f <vector137>:
8010725f:	6a 00                	push   $0x0
80107261:	68 89 00 00 00       	push   $0x89
80107266:	e9 da f4 ff ff       	jmp    80106745 <alltraps>

8010726b <vector138>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 8a 00 00 00       	push   $0x8a
80107272:	e9 ce f4 ff ff       	jmp    80106745 <alltraps>

80107277 <vector139>:
80107277:	6a 00                	push   $0x0
80107279:	68 8b 00 00 00       	push   $0x8b
8010727e:	e9 c2 f4 ff ff       	jmp    80106745 <alltraps>

80107283 <vector140>:
80107283:	6a 00                	push   $0x0
80107285:	68 8c 00 00 00       	push   $0x8c
8010728a:	e9 b6 f4 ff ff       	jmp    80106745 <alltraps>

8010728f <vector141>:
8010728f:	6a 00                	push   $0x0
80107291:	68 8d 00 00 00       	push   $0x8d
80107296:	e9 aa f4 ff ff       	jmp    80106745 <alltraps>

8010729b <vector142>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 8e 00 00 00       	push   $0x8e
801072a2:	e9 9e f4 ff ff       	jmp    80106745 <alltraps>

801072a7 <vector143>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 8f 00 00 00       	push   $0x8f
801072ae:	e9 92 f4 ff ff       	jmp    80106745 <alltraps>

801072b3 <vector144>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 90 00 00 00       	push   $0x90
801072ba:	e9 86 f4 ff ff       	jmp    80106745 <alltraps>

801072bf <vector145>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 91 00 00 00       	push   $0x91
801072c6:	e9 7a f4 ff ff       	jmp    80106745 <alltraps>

801072cb <vector146>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 92 00 00 00       	push   $0x92
801072d2:	e9 6e f4 ff ff       	jmp    80106745 <alltraps>

801072d7 <vector147>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 93 00 00 00       	push   $0x93
801072de:	e9 62 f4 ff ff       	jmp    80106745 <alltraps>

801072e3 <vector148>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 94 00 00 00       	push   $0x94
801072ea:	e9 56 f4 ff ff       	jmp    80106745 <alltraps>

801072ef <vector149>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 95 00 00 00       	push   $0x95
801072f6:	e9 4a f4 ff ff       	jmp    80106745 <alltraps>

801072fb <vector150>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 96 00 00 00       	push   $0x96
80107302:	e9 3e f4 ff ff       	jmp    80106745 <alltraps>

80107307 <vector151>:
80107307:	6a 00                	push   $0x0
80107309:	68 97 00 00 00       	push   $0x97
8010730e:	e9 32 f4 ff ff       	jmp    80106745 <alltraps>

80107313 <vector152>:
80107313:	6a 00                	push   $0x0
80107315:	68 98 00 00 00       	push   $0x98
8010731a:	e9 26 f4 ff ff       	jmp    80106745 <alltraps>

8010731f <vector153>:
8010731f:	6a 00                	push   $0x0
80107321:	68 99 00 00 00       	push   $0x99
80107326:	e9 1a f4 ff ff       	jmp    80106745 <alltraps>

8010732b <vector154>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 9a 00 00 00       	push   $0x9a
80107332:	e9 0e f4 ff ff       	jmp    80106745 <alltraps>

80107337 <vector155>:
80107337:	6a 00                	push   $0x0
80107339:	68 9b 00 00 00       	push   $0x9b
8010733e:	e9 02 f4 ff ff       	jmp    80106745 <alltraps>

80107343 <vector156>:
80107343:	6a 00                	push   $0x0
80107345:	68 9c 00 00 00       	push   $0x9c
8010734a:	e9 f6 f3 ff ff       	jmp    80106745 <alltraps>

8010734f <vector157>:
8010734f:	6a 00                	push   $0x0
80107351:	68 9d 00 00 00       	push   $0x9d
80107356:	e9 ea f3 ff ff       	jmp    80106745 <alltraps>

8010735b <vector158>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 9e 00 00 00       	push   $0x9e
80107362:	e9 de f3 ff ff       	jmp    80106745 <alltraps>

80107367 <vector159>:
80107367:	6a 00                	push   $0x0
80107369:	68 9f 00 00 00       	push   $0x9f
8010736e:	e9 d2 f3 ff ff       	jmp    80106745 <alltraps>

80107373 <vector160>:
80107373:	6a 00                	push   $0x0
80107375:	68 a0 00 00 00       	push   $0xa0
8010737a:	e9 c6 f3 ff ff       	jmp    80106745 <alltraps>

8010737f <vector161>:
8010737f:	6a 00                	push   $0x0
80107381:	68 a1 00 00 00       	push   $0xa1
80107386:	e9 ba f3 ff ff       	jmp    80106745 <alltraps>

8010738b <vector162>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 a2 00 00 00       	push   $0xa2
80107392:	e9 ae f3 ff ff       	jmp    80106745 <alltraps>

80107397 <vector163>:
80107397:	6a 00                	push   $0x0
80107399:	68 a3 00 00 00       	push   $0xa3
8010739e:	e9 a2 f3 ff ff       	jmp    80106745 <alltraps>

801073a3 <vector164>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 a4 00 00 00       	push   $0xa4
801073aa:	e9 96 f3 ff ff       	jmp    80106745 <alltraps>

801073af <vector165>:
801073af:	6a 00                	push   $0x0
801073b1:	68 a5 00 00 00       	push   $0xa5
801073b6:	e9 8a f3 ff ff       	jmp    80106745 <alltraps>

801073bb <vector166>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 a6 00 00 00       	push   $0xa6
801073c2:	e9 7e f3 ff ff       	jmp    80106745 <alltraps>

801073c7 <vector167>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 a7 00 00 00       	push   $0xa7
801073ce:	e9 72 f3 ff ff       	jmp    80106745 <alltraps>

801073d3 <vector168>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 a8 00 00 00       	push   $0xa8
801073da:	e9 66 f3 ff ff       	jmp    80106745 <alltraps>

801073df <vector169>:
801073df:	6a 00                	push   $0x0
801073e1:	68 a9 00 00 00       	push   $0xa9
801073e6:	e9 5a f3 ff ff       	jmp    80106745 <alltraps>

801073eb <vector170>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 aa 00 00 00       	push   $0xaa
801073f2:	e9 4e f3 ff ff       	jmp    80106745 <alltraps>

801073f7 <vector171>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 ab 00 00 00       	push   $0xab
801073fe:	e9 42 f3 ff ff       	jmp    80106745 <alltraps>

80107403 <vector172>:
80107403:	6a 00                	push   $0x0
80107405:	68 ac 00 00 00       	push   $0xac
8010740a:	e9 36 f3 ff ff       	jmp    80106745 <alltraps>

8010740f <vector173>:
8010740f:	6a 00                	push   $0x0
80107411:	68 ad 00 00 00       	push   $0xad
80107416:	e9 2a f3 ff ff       	jmp    80106745 <alltraps>

8010741b <vector174>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 ae 00 00 00       	push   $0xae
80107422:	e9 1e f3 ff ff       	jmp    80106745 <alltraps>

80107427 <vector175>:
80107427:	6a 00                	push   $0x0
80107429:	68 af 00 00 00       	push   $0xaf
8010742e:	e9 12 f3 ff ff       	jmp    80106745 <alltraps>

80107433 <vector176>:
80107433:	6a 00                	push   $0x0
80107435:	68 b0 00 00 00       	push   $0xb0
8010743a:	e9 06 f3 ff ff       	jmp    80106745 <alltraps>

8010743f <vector177>:
8010743f:	6a 00                	push   $0x0
80107441:	68 b1 00 00 00       	push   $0xb1
80107446:	e9 fa f2 ff ff       	jmp    80106745 <alltraps>

8010744b <vector178>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 b2 00 00 00       	push   $0xb2
80107452:	e9 ee f2 ff ff       	jmp    80106745 <alltraps>

80107457 <vector179>:
80107457:	6a 00                	push   $0x0
80107459:	68 b3 00 00 00       	push   $0xb3
8010745e:	e9 e2 f2 ff ff       	jmp    80106745 <alltraps>

80107463 <vector180>:
80107463:	6a 00                	push   $0x0
80107465:	68 b4 00 00 00       	push   $0xb4
8010746a:	e9 d6 f2 ff ff       	jmp    80106745 <alltraps>

8010746f <vector181>:
8010746f:	6a 00                	push   $0x0
80107471:	68 b5 00 00 00       	push   $0xb5
80107476:	e9 ca f2 ff ff       	jmp    80106745 <alltraps>

8010747b <vector182>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 b6 00 00 00       	push   $0xb6
80107482:	e9 be f2 ff ff       	jmp    80106745 <alltraps>

80107487 <vector183>:
80107487:	6a 00                	push   $0x0
80107489:	68 b7 00 00 00       	push   $0xb7
8010748e:	e9 b2 f2 ff ff       	jmp    80106745 <alltraps>

80107493 <vector184>:
80107493:	6a 00                	push   $0x0
80107495:	68 b8 00 00 00       	push   $0xb8
8010749a:	e9 a6 f2 ff ff       	jmp    80106745 <alltraps>

8010749f <vector185>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 b9 00 00 00       	push   $0xb9
801074a6:	e9 9a f2 ff ff       	jmp    80106745 <alltraps>

801074ab <vector186>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 ba 00 00 00       	push   $0xba
801074b2:	e9 8e f2 ff ff       	jmp    80106745 <alltraps>

801074b7 <vector187>:
801074b7:	6a 00                	push   $0x0
801074b9:	68 bb 00 00 00       	push   $0xbb
801074be:	e9 82 f2 ff ff       	jmp    80106745 <alltraps>

801074c3 <vector188>:
801074c3:	6a 00                	push   $0x0
801074c5:	68 bc 00 00 00       	push   $0xbc
801074ca:	e9 76 f2 ff ff       	jmp    80106745 <alltraps>

801074cf <vector189>:
801074cf:	6a 00                	push   $0x0
801074d1:	68 bd 00 00 00       	push   $0xbd
801074d6:	e9 6a f2 ff ff       	jmp    80106745 <alltraps>

801074db <vector190>:
801074db:	6a 00                	push   $0x0
801074dd:	68 be 00 00 00       	push   $0xbe
801074e2:	e9 5e f2 ff ff       	jmp    80106745 <alltraps>

801074e7 <vector191>:
801074e7:	6a 00                	push   $0x0
801074e9:	68 bf 00 00 00       	push   $0xbf
801074ee:	e9 52 f2 ff ff       	jmp    80106745 <alltraps>

801074f3 <vector192>:
801074f3:	6a 00                	push   $0x0
801074f5:	68 c0 00 00 00       	push   $0xc0
801074fa:	e9 46 f2 ff ff       	jmp    80106745 <alltraps>

801074ff <vector193>:
801074ff:	6a 00                	push   $0x0
80107501:	68 c1 00 00 00       	push   $0xc1
80107506:	e9 3a f2 ff ff       	jmp    80106745 <alltraps>

8010750b <vector194>:
8010750b:	6a 00                	push   $0x0
8010750d:	68 c2 00 00 00       	push   $0xc2
80107512:	e9 2e f2 ff ff       	jmp    80106745 <alltraps>

80107517 <vector195>:
80107517:	6a 00                	push   $0x0
80107519:	68 c3 00 00 00       	push   $0xc3
8010751e:	e9 22 f2 ff ff       	jmp    80106745 <alltraps>

80107523 <vector196>:
80107523:	6a 00                	push   $0x0
80107525:	68 c4 00 00 00       	push   $0xc4
8010752a:	e9 16 f2 ff ff       	jmp    80106745 <alltraps>

8010752f <vector197>:
8010752f:	6a 00                	push   $0x0
80107531:	68 c5 00 00 00       	push   $0xc5
80107536:	e9 0a f2 ff ff       	jmp    80106745 <alltraps>

8010753b <vector198>:
8010753b:	6a 00                	push   $0x0
8010753d:	68 c6 00 00 00       	push   $0xc6
80107542:	e9 fe f1 ff ff       	jmp    80106745 <alltraps>

80107547 <vector199>:
80107547:	6a 00                	push   $0x0
80107549:	68 c7 00 00 00       	push   $0xc7
8010754e:	e9 f2 f1 ff ff       	jmp    80106745 <alltraps>

80107553 <vector200>:
80107553:	6a 00                	push   $0x0
80107555:	68 c8 00 00 00       	push   $0xc8
8010755a:	e9 e6 f1 ff ff       	jmp    80106745 <alltraps>

8010755f <vector201>:
8010755f:	6a 00                	push   $0x0
80107561:	68 c9 00 00 00       	push   $0xc9
80107566:	e9 da f1 ff ff       	jmp    80106745 <alltraps>

8010756b <vector202>:
8010756b:	6a 00                	push   $0x0
8010756d:	68 ca 00 00 00       	push   $0xca
80107572:	e9 ce f1 ff ff       	jmp    80106745 <alltraps>

80107577 <vector203>:
80107577:	6a 00                	push   $0x0
80107579:	68 cb 00 00 00       	push   $0xcb
8010757e:	e9 c2 f1 ff ff       	jmp    80106745 <alltraps>

80107583 <vector204>:
80107583:	6a 00                	push   $0x0
80107585:	68 cc 00 00 00       	push   $0xcc
8010758a:	e9 b6 f1 ff ff       	jmp    80106745 <alltraps>

8010758f <vector205>:
8010758f:	6a 00                	push   $0x0
80107591:	68 cd 00 00 00       	push   $0xcd
80107596:	e9 aa f1 ff ff       	jmp    80106745 <alltraps>

8010759b <vector206>:
8010759b:	6a 00                	push   $0x0
8010759d:	68 ce 00 00 00       	push   $0xce
801075a2:	e9 9e f1 ff ff       	jmp    80106745 <alltraps>

801075a7 <vector207>:
801075a7:	6a 00                	push   $0x0
801075a9:	68 cf 00 00 00       	push   $0xcf
801075ae:	e9 92 f1 ff ff       	jmp    80106745 <alltraps>

801075b3 <vector208>:
801075b3:	6a 00                	push   $0x0
801075b5:	68 d0 00 00 00       	push   $0xd0
801075ba:	e9 86 f1 ff ff       	jmp    80106745 <alltraps>

801075bf <vector209>:
801075bf:	6a 00                	push   $0x0
801075c1:	68 d1 00 00 00       	push   $0xd1
801075c6:	e9 7a f1 ff ff       	jmp    80106745 <alltraps>

801075cb <vector210>:
801075cb:	6a 00                	push   $0x0
801075cd:	68 d2 00 00 00       	push   $0xd2
801075d2:	e9 6e f1 ff ff       	jmp    80106745 <alltraps>

801075d7 <vector211>:
801075d7:	6a 00                	push   $0x0
801075d9:	68 d3 00 00 00       	push   $0xd3
801075de:	e9 62 f1 ff ff       	jmp    80106745 <alltraps>

801075e3 <vector212>:
801075e3:	6a 00                	push   $0x0
801075e5:	68 d4 00 00 00       	push   $0xd4
801075ea:	e9 56 f1 ff ff       	jmp    80106745 <alltraps>

801075ef <vector213>:
801075ef:	6a 00                	push   $0x0
801075f1:	68 d5 00 00 00       	push   $0xd5
801075f6:	e9 4a f1 ff ff       	jmp    80106745 <alltraps>

801075fb <vector214>:
801075fb:	6a 00                	push   $0x0
801075fd:	68 d6 00 00 00       	push   $0xd6
80107602:	e9 3e f1 ff ff       	jmp    80106745 <alltraps>

80107607 <vector215>:
80107607:	6a 00                	push   $0x0
80107609:	68 d7 00 00 00       	push   $0xd7
8010760e:	e9 32 f1 ff ff       	jmp    80106745 <alltraps>

80107613 <vector216>:
80107613:	6a 00                	push   $0x0
80107615:	68 d8 00 00 00       	push   $0xd8
8010761a:	e9 26 f1 ff ff       	jmp    80106745 <alltraps>

8010761f <vector217>:
8010761f:	6a 00                	push   $0x0
80107621:	68 d9 00 00 00       	push   $0xd9
80107626:	e9 1a f1 ff ff       	jmp    80106745 <alltraps>

8010762b <vector218>:
8010762b:	6a 00                	push   $0x0
8010762d:	68 da 00 00 00       	push   $0xda
80107632:	e9 0e f1 ff ff       	jmp    80106745 <alltraps>

80107637 <vector219>:
80107637:	6a 00                	push   $0x0
80107639:	68 db 00 00 00       	push   $0xdb
8010763e:	e9 02 f1 ff ff       	jmp    80106745 <alltraps>

80107643 <vector220>:
80107643:	6a 00                	push   $0x0
80107645:	68 dc 00 00 00       	push   $0xdc
8010764a:	e9 f6 f0 ff ff       	jmp    80106745 <alltraps>

8010764f <vector221>:
8010764f:	6a 00                	push   $0x0
80107651:	68 dd 00 00 00       	push   $0xdd
80107656:	e9 ea f0 ff ff       	jmp    80106745 <alltraps>

8010765b <vector222>:
8010765b:	6a 00                	push   $0x0
8010765d:	68 de 00 00 00       	push   $0xde
80107662:	e9 de f0 ff ff       	jmp    80106745 <alltraps>

80107667 <vector223>:
80107667:	6a 00                	push   $0x0
80107669:	68 df 00 00 00       	push   $0xdf
8010766e:	e9 d2 f0 ff ff       	jmp    80106745 <alltraps>

80107673 <vector224>:
80107673:	6a 00                	push   $0x0
80107675:	68 e0 00 00 00       	push   $0xe0
8010767a:	e9 c6 f0 ff ff       	jmp    80106745 <alltraps>

8010767f <vector225>:
8010767f:	6a 00                	push   $0x0
80107681:	68 e1 00 00 00       	push   $0xe1
80107686:	e9 ba f0 ff ff       	jmp    80106745 <alltraps>

8010768b <vector226>:
8010768b:	6a 00                	push   $0x0
8010768d:	68 e2 00 00 00       	push   $0xe2
80107692:	e9 ae f0 ff ff       	jmp    80106745 <alltraps>

80107697 <vector227>:
80107697:	6a 00                	push   $0x0
80107699:	68 e3 00 00 00       	push   $0xe3
8010769e:	e9 a2 f0 ff ff       	jmp    80106745 <alltraps>

801076a3 <vector228>:
801076a3:	6a 00                	push   $0x0
801076a5:	68 e4 00 00 00       	push   $0xe4
801076aa:	e9 96 f0 ff ff       	jmp    80106745 <alltraps>

801076af <vector229>:
801076af:	6a 00                	push   $0x0
801076b1:	68 e5 00 00 00       	push   $0xe5
801076b6:	e9 8a f0 ff ff       	jmp    80106745 <alltraps>

801076bb <vector230>:
801076bb:	6a 00                	push   $0x0
801076bd:	68 e6 00 00 00       	push   $0xe6
801076c2:	e9 7e f0 ff ff       	jmp    80106745 <alltraps>

801076c7 <vector231>:
801076c7:	6a 00                	push   $0x0
801076c9:	68 e7 00 00 00       	push   $0xe7
801076ce:	e9 72 f0 ff ff       	jmp    80106745 <alltraps>

801076d3 <vector232>:
801076d3:	6a 00                	push   $0x0
801076d5:	68 e8 00 00 00       	push   $0xe8
801076da:	e9 66 f0 ff ff       	jmp    80106745 <alltraps>

801076df <vector233>:
801076df:	6a 00                	push   $0x0
801076e1:	68 e9 00 00 00       	push   $0xe9
801076e6:	e9 5a f0 ff ff       	jmp    80106745 <alltraps>

801076eb <vector234>:
801076eb:	6a 00                	push   $0x0
801076ed:	68 ea 00 00 00       	push   $0xea
801076f2:	e9 4e f0 ff ff       	jmp    80106745 <alltraps>

801076f7 <vector235>:
801076f7:	6a 00                	push   $0x0
801076f9:	68 eb 00 00 00       	push   $0xeb
801076fe:	e9 42 f0 ff ff       	jmp    80106745 <alltraps>

80107703 <vector236>:
80107703:	6a 00                	push   $0x0
80107705:	68 ec 00 00 00       	push   $0xec
8010770a:	e9 36 f0 ff ff       	jmp    80106745 <alltraps>

8010770f <vector237>:
8010770f:	6a 00                	push   $0x0
80107711:	68 ed 00 00 00       	push   $0xed
80107716:	e9 2a f0 ff ff       	jmp    80106745 <alltraps>

8010771b <vector238>:
8010771b:	6a 00                	push   $0x0
8010771d:	68 ee 00 00 00       	push   $0xee
80107722:	e9 1e f0 ff ff       	jmp    80106745 <alltraps>

80107727 <vector239>:
80107727:	6a 00                	push   $0x0
80107729:	68 ef 00 00 00       	push   $0xef
8010772e:	e9 12 f0 ff ff       	jmp    80106745 <alltraps>

80107733 <vector240>:
80107733:	6a 00                	push   $0x0
80107735:	68 f0 00 00 00       	push   $0xf0
8010773a:	e9 06 f0 ff ff       	jmp    80106745 <alltraps>

8010773f <vector241>:
8010773f:	6a 00                	push   $0x0
80107741:	68 f1 00 00 00       	push   $0xf1
80107746:	e9 fa ef ff ff       	jmp    80106745 <alltraps>

8010774b <vector242>:
8010774b:	6a 00                	push   $0x0
8010774d:	68 f2 00 00 00       	push   $0xf2
80107752:	e9 ee ef ff ff       	jmp    80106745 <alltraps>

80107757 <vector243>:
80107757:	6a 00                	push   $0x0
80107759:	68 f3 00 00 00       	push   $0xf3
8010775e:	e9 e2 ef ff ff       	jmp    80106745 <alltraps>

80107763 <vector244>:
80107763:	6a 00                	push   $0x0
80107765:	68 f4 00 00 00       	push   $0xf4
8010776a:	e9 d6 ef ff ff       	jmp    80106745 <alltraps>

8010776f <vector245>:
8010776f:	6a 00                	push   $0x0
80107771:	68 f5 00 00 00       	push   $0xf5
80107776:	e9 ca ef ff ff       	jmp    80106745 <alltraps>

8010777b <vector246>:
8010777b:	6a 00                	push   $0x0
8010777d:	68 f6 00 00 00       	push   $0xf6
80107782:	e9 be ef ff ff       	jmp    80106745 <alltraps>

80107787 <vector247>:
80107787:	6a 00                	push   $0x0
80107789:	68 f7 00 00 00       	push   $0xf7
8010778e:	e9 b2 ef ff ff       	jmp    80106745 <alltraps>

80107793 <vector248>:
80107793:	6a 00                	push   $0x0
80107795:	68 f8 00 00 00       	push   $0xf8
8010779a:	e9 a6 ef ff ff       	jmp    80106745 <alltraps>

8010779f <vector249>:
8010779f:	6a 00                	push   $0x0
801077a1:	68 f9 00 00 00       	push   $0xf9
801077a6:	e9 9a ef ff ff       	jmp    80106745 <alltraps>

801077ab <vector250>:
801077ab:	6a 00                	push   $0x0
801077ad:	68 fa 00 00 00       	push   $0xfa
801077b2:	e9 8e ef ff ff       	jmp    80106745 <alltraps>

801077b7 <vector251>:
801077b7:	6a 00                	push   $0x0
801077b9:	68 fb 00 00 00       	push   $0xfb
801077be:	e9 82 ef ff ff       	jmp    80106745 <alltraps>

801077c3 <vector252>:
801077c3:	6a 00                	push   $0x0
801077c5:	68 fc 00 00 00       	push   $0xfc
801077ca:	e9 76 ef ff ff       	jmp    80106745 <alltraps>

801077cf <vector253>:
801077cf:	6a 00                	push   $0x0
801077d1:	68 fd 00 00 00       	push   $0xfd
801077d6:	e9 6a ef ff ff       	jmp    80106745 <alltraps>

801077db <vector254>:
801077db:	6a 00                	push   $0x0
801077dd:	68 fe 00 00 00       	push   $0xfe
801077e2:	e9 5e ef ff ff       	jmp    80106745 <alltraps>

801077e7 <vector255>:
801077e7:	6a 00                	push   $0x0
801077e9:	68 ff 00 00 00       	push   $0xff
801077ee:	e9 52 ef ff ff       	jmp    80106745 <alltraps>

801077f3 <lgdt>:
801077f3:	55                   	push   %ebp
801077f4:	89 e5                	mov    %esp,%ebp
801077f6:	83 ec 10             	sub    $0x10,%esp
801077f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801077fc:	83 e8 01             	sub    $0x1,%eax
801077ff:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80107803:	8b 45 08             	mov    0x8(%ebp),%eax
80107806:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010780a:	8b 45 08             	mov    0x8(%ebp),%eax
8010780d:	c1 e8 10             	shr    $0x10,%eax
80107810:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80107814:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107817:	0f 01 10             	lgdtl  (%eax)
8010781a:	90                   	nop
8010781b:	c9                   	leave  
8010781c:	c3                   	ret    

8010781d <ltr>:
8010781d:	55                   	push   %ebp
8010781e:	89 e5                	mov    %esp,%ebp
80107820:	83 ec 04             	sub    $0x4,%esp
80107823:	8b 45 08             	mov    0x8(%ebp),%eax
80107826:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010782a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010782e:	0f 00 d8             	ltr    %ax
80107831:	90                   	nop
80107832:	c9                   	leave  
80107833:	c3                   	ret    

80107834 <loadgs>:
80107834:	55                   	push   %ebp
80107835:	89 e5                	mov    %esp,%ebp
80107837:	83 ec 04             	sub    $0x4,%esp
8010783a:	8b 45 08             	mov    0x8(%ebp),%eax
8010783d:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107841:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107845:	8e e8                	mov    %eax,%gs
80107847:	90                   	nop
80107848:	c9                   	leave  
80107849:	c3                   	ret    

8010784a <lcr3>:
8010784a:	55                   	push   %ebp
8010784b:	89 e5                	mov    %esp,%ebp
8010784d:	8b 45 08             	mov    0x8(%ebp),%eax
80107850:	0f 22 d8             	mov    %eax,%cr3
80107853:	90                   	nop
80107854:	5d                   	pop    %ebp
80107855:	c3                   	ret    

80107856 <seginit>:
80107856:	55                   	push   %ebp
80107857:	89 e5                	mov    %esp,%ebp
80107859:	53                   	push   %ebx
8010785a:	83 ec 14             	sub    $0x14,%esp
8010785d:	e8 b9 b7 ff ff       	call   8010301b <cpunum>
80107862:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107868:	05 20 38 11 80       	add    $0x80113820,%eax
8010786d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107870:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107873:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107879:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787c:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107882:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107885:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107889:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010788c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107890:	83 e2 f0             	and    $0xfffffff0,%edx
80107893:	83 ca 0a             	or     $0xa,%edx
80107896:	88 50 7d             	mov    %dl,0x7d(%eax)
80107899:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010789c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078a0:	83 ca 10             	or     $0x10,%edx
801078a3:	88 50 7d             	mov    %dl,0x7d(%eax)
801078a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a9:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078ad:	83 e2 9f             	and    $0xffffff9f,%edx
801078b0:	88 50 7d             	mov    %dl,0x7d(%eax)
801078b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b6:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801078ba:	83 ca 80             	or     $0xffffff80,%edx
801078bd:	88 50 7d             	mov    %dl,0x7d(%eax)
801078c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c3:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078c7:	83 ca 0f             	or     $0xf,%edx
801078ca:	88 50 7e             	mov    %dl,0x7e(%eax)
801078cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d0:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078d4:	83 e2 ef             	and    $0xffffffef,%edx
801078d7:	88 50 7e             	mov    %dl,0x7e(%eax)
801078da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078dd:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078e1:	83 e2 df             	and    $0xffffffdf,%edx
801078e4:	88 50 7e             	mov    %dl,0x7e(%eax)
801078e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ea:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078ee:	83 ca 40             	or     $0x40,%edx
801078f1:	88 50 7e             	mov    %dl,0x7e(%eax)
801078f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f7:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801078fb:	83 ca 80             	or     $0xffffff80,%edx
801078fe:	88 50 7e             	mov    %dl,0x7e(%eax)
80107901:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107904:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
80107908:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010790b:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107912:	ff ff 
80107914:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107917:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
8010791e:	00 00 
80107920:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107923:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
8010792a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107934:	83 e2 f0             	and    $0xfffffff0,%edx
80107937:	83 ca 02             	or     $0x2,%edx
8010793a:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107940:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107943:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010794a:	83 ca 10             	or     $0x10,%edx
8010794d:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107953:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107956:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010795d:	83 e2 9f             	and    $0xffffff9f,%edx
80107960:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107966:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107969:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107970:	83 ca 80             	or     $0xffffff80,%edx
80107973:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107979:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010797c:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107983:	83 ca 0f             	or     $0xf,%edx
80107986:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010798c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798f:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107996:	83 e2 ef             	and    $0xffffffef,%edx
80107999:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010799f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a2:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079a9:	83 e2 df             	and    $0xffffffdf,%edx
801079ac:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b5:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079bc:	83 ca 40             	or     $0x40,%edx
801079bf:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079c8:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801079cf:	83 ca 80             	or     $0xffffff80,%edx
801079d2:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801079d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079db:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
801079e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e5:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801079ec:	ff ff 
801079ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f1:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801079f8:	00 00 
801079fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079fd:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a07:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a0e:	83 e2 f0             	and    $0xfffffff0,%edx
80107a11:	83 ca 0a             	or     $0xa,%edx
80107a14:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a1d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a24:	83 ca 10             	or     $0x10,%edx
80107a27:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a30:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a37:	83 ca 60             	or     $0x60,%edx
80107a3a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a43:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107a4a:	83 ca 80             	or     $0xffffff80,%edx
80107a4d:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a56:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a5d:	83 ca 0f             	or     $0xf,%edx
80107a60:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a69:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a70:	83 e2 ef             	and    $0xffffffef,%edx
80107a73:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a7c:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a83:	83 e2 df             	and    $0xffffffdf,%edx
80107a86:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a8f:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a96:	83 ca 40             	or     $0x40,%edx
80107a99:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa2:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107aa9:	83 ca 80             	or     $0xffffff80,%edx
80107aac:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab5:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
80107abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107abf:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107ac6:	ff ff 
80107ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107acb:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107ad2:	00 00 
80107ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ad7:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ae1:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107ae8:	83 e2 f0             	and    $0xfffffff0,%edx
80107aeb:	83 ca 02             	or     $0x2,%edx
80107aee:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af7:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107afe:	83 ca 10             	or     $0x10,%edx
80107b01:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b0a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b11:	83 ca 60             	or     $0x60,%edx
80107b14:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b1d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107b24:	83 ca 80             	or     $0xffffff80,%edx
80107b27:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b30:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b37:	83 ca 0f             	or     $0xf,%edx
80107b3a:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b43:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b4a:	83 e2 ef             	and    $0xffffffef,%edx
80107b4d:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b56:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b5d:	83 e2 df             	and    $0xffffffdf,%edx
80107b60:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b69:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b70:	83 ca 40             	or     $0x40,%edx
80107b73:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b7c:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b83:	83 ca 80             	or     $0xffffff80,%edx
80107b86:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8f:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
80107b96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b99:	05 b4 00 00 00       	add    $0xb4,%eax
80107b9e:	89 c3                	mov    %eax,%ebx
80107ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba3:	05 b4 00 00 00       	add    $0xb4,%eax
80107ba8:	c1 e8 10             	shr    $0x10,%eax
80107bab:	89 c2                	mov    %eax,%edx
80107bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb0:	05 b4 00 00 00       	add    $0xb4,%eax
80107bb5:	c1 e8 18             	shr    $0x18,%eax
80107bb8:	89 c1                	mov    %eax,%ecx
80107bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bbd:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107bc4:	00 00 
80107bc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc9:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd3:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bdc:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107be3:	83 e2 f0             	and    $0xfffffff0,%edx
80107be6:	83 ca 02             	or     $0x2,%edx
80107be9:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107bef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bf2:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107bf9:	83 ca 10             	or     $0x10,%edx
80107bfc:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107c02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c05:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107c0c:	83 e2 9f             	and    $0xffffff9f,%edx
80107c0f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107c15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c18:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107c1f:	83 ca 80             	or     $0xffffff80,%edx
80107c22:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c2b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c32:	83 e2 f0             	and    $0xfffffff0,%edx
80107c35:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c3e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c45:	83 e2 ef             	and    $0xffffffef,%edx
80107c48:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c51:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c58:	83 e2 df             	and    $0xffffffdf,%edx
80107c5b:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c64:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c6b:	83 ca 40             	or     $0x40,%edx
80107c6e:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c77:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107c7e:	83 ca 80             	or     $0xffffff80,%edx
80107c81:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c8a:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
80107c90:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c93:	83 c0 70             	add    $0x70,%eax
80107c96:	83 ec 08             	sub    $0x8,%esp
80107c99:	6a 38                	push   $0x38
80107c9b:	50                   	push   %eax
80107c9c:	e8 52 fb ff ff       	call   801077f3 <lgdt>
80107ca1:	83 c4 10             	add    $0x10,%esp
80107ca4:	83 ec 0c             	sub    $0xc,%esp
80107ca7:	6a 18                	push   $0x18
80107ca9:	e8 86 fb ff ff       	call   80107834 <loadgs>
80107cae:	83 c4 10             	add    $0x10,%esp
80107cb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cb4:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
80107cba:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107cc1:	00 00 00 00 
80107cc5:	90                   	nop
80107cc6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107cc9:	c9                   	leave  
80107cca:	c3                   	ret    

80107ccb <walkpgdir>:
80107ccb:	55                   	push   %ebp
80107ccc:	89 e5                	mov    %esp,%ebp
80107cce:	83 ec 18             	sub    $0x18,%esp
80107cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80107cd4:	c1 e8 16             	shr    $0x16,%eax
80107cd7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107cde:	8b 45 08             	mov    0x8(%ebp),%eax
80107ce1:	01 d0                	add    %edx,%eax
80107ce3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107ce6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ce9:	8b 00                	mov    (%eax),%eax
80107ceb:	83 e0 01             	and    $0x1,%eax
80107cee:	85 c0                	test   %eax,%eax
80107cf0:	74 14                	je     80107d06 <walkpgdir+0x3b>
80107cf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cf5:	8b 00                	mov    (%eax),%eax
80107cf7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cfc:	05 00 00 00 80       	add    $0x80000000,%eax
80107d01:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d04:	eb 42                	jmp    80107d48 <walkpgdir+0x7d>
80107d06:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107d0a:	74 0e                	je     80107d1a <walkpgdir+0x4f>
80107d0c:	e8 a4 af ff ff       	call   80102cb5 <kalloc>
80107d11:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d14:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107d18:	75 07                	jne    80107d21 <walkpgdir+0x56>
80107d1a:	b8 00 00 00 00       	mov    $0x0,%eax
80107d1f:	eb 3e                	jmp    80107d5f <walkpgdir+0x94>
80107d21:	83 ec 04             	sub    $0x4,%esp
80107d24:	68 00 10 00 00       	push   $0x1000
80107d29:	6a 00                	push   $0x0
80107d2b:	ff 75 f4             	pushl  -0xc(%ebp)
80107d2e:	e8 23 d6 ff ff       	call   80105356 <memset>
80107d33:	83 c4 10             	add    $0x10,%esp
80107d36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d39:	05 00 00 00 80       	add    $0x80000000,%eax
80107d3e:	83 c8 07             	or     $0x7,%eax
80107d41:	89 c2                	mov    %eax,%edx
80107d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d46:	89 10                	mov    %edx,(%eax)
80107d48:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d4b:	c1 e8 0c             	shr    $0xc,%eax
80107d4e:	25 ff 03 00 00       	and    $0x3ff,%eax
80107d53:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107d5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d5d:	01 d0                	add    %edx,%eax
80107d5f:	c9                   	leave  
80107d60:	c3                   	ret    

80107d61 <mappages>:
80107d61:	55                   	push   %ebp
80107d62:	89 e5                	mov    %esp,%ebp
80107d64:	83 ec 18             	sub    $0x18,%esp
80107d67:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d6a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d72:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d75:	8b 45 10             	mov    0x10(%ebp),%eax
80107d78:	01 d0                	add    %edx,%eax
80107d7a:	83 e8 01             	sub    $0x1,%eax
80107d7d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d82:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107d85:	83 ec 04             	sub    $0x4,%esp
80107d88:	6a 01                	push   $0x1
80107d8a:	ff 75 f4             	pushl  -0xc(%ebp)
80107d8d:	ff 75 08             	pushl  0x8(%ebp)
80107d90:	e8 36 ff ff ff       	call   80107ccb <walkpgdir>
80107d95:	83 c4 10             	add    $0x10,%esp
80107d98:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107d9b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107d9f:	75 07                	jne    80107da8 <mappages+0x47>
80107da1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107da6:	eb 47                	jmp    80107def <mappages+0x8e>
80107da8:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107dab:	8b 00                	mov    (%eax),%eax
80107dad:	83 e0 01             	and    $0x1,%eax
80107db0:	85 c0                	test   %eax,%eax
80107db2:	74 0d                	je     80107dc1 <mappages+0x60>
80107db4:	83 ec 0c             	sub    $0xc,%esp
80107db7:	68 e8 8b 10 80       	push   $0x80108be8
80107dbc:	e8 df 87 ff ff       	call   801005a0 <panic>
80107dc1:	8b 45 18             	mov    0x18(%ebp),%eax
80107dc4:	0b 45 14             	or     0x14(%ebp),%eax
80107dc7:	83 c8 01             	or     $0x1,%eax
80107dca:	89 c2                	mov    %eax,%edx
80107dcc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107dcf:	89 10                	mov    %edx,(%eax)
80107dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107dd7:	74 10                	je     80107de9 <mappages+0x88>
80107dd9:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107de0:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
80107de7:	eb 9c                	jmp    80107d85 <mappages+0x24>
80107de9:	90                   	nop
80107dea:	b8 00 00 00 00       	mov    $0x0,%eax
80107def:	c9                   	leave  
80107df0:	c3                   	ret    

80107df1 <setupkvm>:
80107df1:	55                   	push   %ebp
80107df2:	89 e5                	mov    %esp,%ebp
80107df4:	53                   	push   %ebx
80107df5:	83 ec 14             	sub    $0x14,%esp
80107df8:	e8 b8 ae ff ff       	call   80102cb5 <kalloc>
80107dfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107e00:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e04:	75 07                	jne    80107e0d <setupkvm+0x1c>
80107e06:	b8 00 00 00 00       	mov    $0x0,%eax
80107e0b:	eb 6a                	jmp    80107e77 <setupkvm+0x86>
80107e0d:	83 ec 04             	sub    $0x4,%esp
80107e10:	68 00 10 00 00       	push   $0x1000
80107e15:	6a 00                	push   $0x0
80107e17:	ff 75 f0             	pushl  -0x10(%ebp)
80107e1a:	e8 37 d5 ff ff       	call   80105356 <memset>
80107e1f:	83 c4 10             	add    $0x10,%esp
80107e22:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107e29:	eb 40                	jmp    80107e6b <setupkvm+0x7a>
80107e2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e2e:	8b 48 0c             	mov    0xc(%eax),%ecx
80107e31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e34:	8b 50 04             	mov    0x4(%eax),%edx
80107e37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3a:	8b 58 08             	mov    0x8(%eax),%ebx
80107e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e40:	8b 40 04             	mov    0x4(%eax),%eax
80107e43:	29 c3                	sub    %eax,%ebx
80107e45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e48:	8b 00                	mov    (%eax),%eax
80107e4a:	83 ec 0c             	sub    $0xc,%esp
80107e4d:	51                   	push   %ecx
80107e4e:	52                   	push   %edx
80107e4f:	53                   	push   %ebx
80107e50:	50                   	push   %eax
80107e51:	ff 75 f0             	pushl  -0x10(%ebp)
80107e54:	e8 08 ff ff ff       	call   80107d61 <mappages>
80107e59:	83 c4 20             	add    $0x20,%esp
80107e5c:	85 c0                	test   %eax,%eax
80107e5e:	79 07                	jns    80107e67 <setupkvm+0x76>
80107e60:	b8 00 00 00 00       	mov    $0x0,%eax
80107e65:	eb 10                	jmp    80107e77 <setupkvm+0x86>
80107e67:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107e6b:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107e72:	72 b7                	jb     80107e2b <setupkvm+0x3a>
80107e74:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107e7a:	c9                   	leave  
80107e7b:	c3                   	ret    

80107e7c <kvmalloc>:
80107e7c:	55                   	push   %ebp
80107e7d:	89 e5                	mov    %esp,%ebp
80107e7f:	83 ec 08             	sub    $0x8,%esp
80107e82:	e8 6a ff ff ff       	call   80107df1 <setupkvm>
80107e87:	a3 a4 65 11 80       	mov    %eax,0x801165a4
80107e8c:	e8 03 00 00 00       	call   80107e94 <switchkvm>
80107e91:	90                   	nop
80107e92:	c9                   	leave  
80107e93:	c3                   	ret    

80107e94 <switchkvm>:
80107e94:	55                   	push   %ebp
80107e95:	89 e5                	mov    %esp,%ebp
80107e97:	a1 a4 65 11 80       	mov    0x801165a4,%eax
80107e9c:	05 00 00 00 80       	add    $0x80000000,%eax
80107ea1:	50                   	push   %eax
80107ea2:	e8 a3 f9 ff ff       	call   8010784a <lcr3>
80107ea7:	83 c4 04             	add    $0x4,%esp
80107eaa:	90                   	nop
80107eab:	c9                   	leave  
80107eac:	c3                   	ret    

80107ead <switchuvm>:
80107ead:	55                   	push   %ebp
80107eae:	89 e5                	mov    %esp,%ebp
80107eb0:	56                   	push   %esi
80107eb1:	53                   	push   %ebx
80107eb2:	e8 87 d3 ff ff       	call   8010523e <pushcli>
80107eb7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107ebd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ec4:	83 c2 08             	add    $0x8,%edx
80107ec7:	89 d6                	mov    %edx,%esi
80107ec9:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ed0:	83 c2 08             	add    $0x8,%edx
80107ed3:	c1 ea 10             	shr    $0x10,%edx
80107ed6:	89 d3                	mov    %edx,%ebx
80107ed8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107edf:	83 c2 08             	add    $0x8,%edx
80107ee2:	c1 ea 18             	shr    $0x18,%edx
80107ee5:	89 d1                	mov    %edx,%ecx
80107ee7:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107eee:	67 00 
80107ef0:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107ef7:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107efd:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f04:	83 e2 f0             	and    $0xfffffff0,%edx
80107f07:	83 ca 09             	or     $0x9,%edx
80107f0a:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f10:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f17:	83 ca 10             	or     $0x10,%edx
80107f1a:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f20:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f27:	83 e2 9f             	and    $0xffffff9f,%edx
80107f2a:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f30:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f37:	83 ca 80             	or     $0xffffff80,%edx
80107f3a:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107f40:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f47:	83 e2 f0             	and    $0xfffffff0,%edx
80107f4a:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f50:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f57:	83 e2 ef             	and    $0xffffffef,%edx
80107f5a:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f60:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f67:	83 e2 df             	and    $0xffffffdf,%edx
80107f6a:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f70:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f77:	83 ca 40             	or     $0x40,%edx
80107f7a:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f80:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107f87:	83 e2 7f             	and    $0x7f,%edx
80107f8a:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107f90:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
80107f96:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f9c:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107fa3:	83 e2 ef             	and    $0xffffffef,%edx
80107fa6:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107fac:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fb2:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
80107fb8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fbe:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107fc5:	8b 52 08             	mov    0x8(%edx),%edx
80107fc8:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107fce:	89 50 0c             	mov    %edx,0xc(%eax)
80107fd1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107fd7:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
80107fdd:	83 ec 0c             	sub    $0xc,%esp
80107fe0:	6a 30                	push   $0x30
80107fe2:	e8 36 f8 ff ff       	call   8010781d <ltr>
80107fe7:	83 c4 10             	add    $0x10,%esp
80107fea:	8b 45 08             	mov    0x8(%ebp),%eax
80107fed:	8b 40 04             	mov    0x4(%eax),%eax
80107ff0:	85 c0                	test   %eax,%eax
80107ff2:	75 0d                	jne    80108001 <switchuvm+0x154>
80107ff4:	83 ec 0c             	sub    $0xc,%esp
80107ff7:	68 ee 8b 10 80       	push   $0x80108bee
80107ffc:	e8 9f 85 ff ff       	call   801005a0 <panic>
80108001:	8b 45 08             	mov    0x8(%ebp),%eax
80108004:	8b 40 04             	mov    0x4(%eax),%eax
80108007:	05 00 00 00 80       	add    $0x80000000,%eax
8010800c:	83 ec 0c             	sub    $0xc,%esp
8010800f:	50                   	push   %eax
80108010:	e8 35 f8 ff ff       	call   8010784a <lcr3>
80108015:	83 c4 10             	add    $0x10,%esp
80108018:	e8 78 d2 ff ff       	call   80105295 <popcli>
8010801d:	90                   	nop
8010801e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108021:	5b                   	pop    %ebx
80108022:	5e                   	pop    %esi
80108023:	5d                   	pop    %ebp
80108024:	c3                   	ret    

80108025 <inituvm>:
80108025:	55                   	push   %ebp
80108026:	89 e5                	mov    %esp,%ebp
80108028:	83 ec 18             	sub    $0x18,%esp
8010802b:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108032:	76 0d                	jbe    80108041 <inituvm+0x1c>
80108034:	83 ec 0c             	sub    $0xc,%esp
80108037:	68 02 8c 10 80       	push   $0x80108c02
8010803c:	e8 5f 85 ff ff       	call   801005a0 <panic>
80108041:	e8 6f ac ff ff       	call   80102cb5 <kalloc>
80108046:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108049:	83 ec 04             	sub    $0x4,%esp
8010804c:	68 00 10 00 00       	push   $0x1000
80108051:	6a 00                	push   $0x0
80108053:	ff 75 f4             	pushl  -0xc(%ebp)
80108056:	e8 fb d2 ff ff       	call   80105356 <memset>
8010805b:	83 c4 10             	add    $0x10,%esp
8010805e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108061:	05 00 00 00 80       	add    $0x80000000,%eax
80108066:	83 ec 0c             	sub    $0xc,%esp
80108069:	6a 06                	push   $0x6
8010806b:	50                   	push   %eax
8010806c:	68 00 10 00 00       	push   $0x1000
80108071:	6a 00                	push   $0x0
80108073:	ff 75 08             	pushl  0x8(%ebp)
80108076:	e8 e6 fc ff ff       	call   80107d61 <mappages>
8010807b:	83 c4 20             	add    $0x20,%esp
8010807e:	83 ec 04             	sub    $0x4,%esp
80108081:	ff 75 10             	pushl  0x10(%ebp)
80108084:	ff 75 0c             	pushl  0xc(%ebp)
80108087:	ff 75 f4             	pushl  -0xc(%ebp)
8010808a:	e8 86 d3 ff ff       	call   80105415 <memmove>
8010808f:	83 c4 10             	add    $0x10,%esp
80108092:	90                   	nop
80108093:	c9                   	leave  
80108094:	c3                   	ret    

80108095 <loaduvm>:
80108095:	55                   	push   %ebp
80108096:	89 e5                	mov    %esp,%ebp
80108098:	83 ec 18             	sub    $0x18,%esp
8010809b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010809e:	25 ff 0f 00 00       	and    $0xfff,%eax
801080a3:	85 c0                	test   %eax,%eax
801080a5:	74 0d                	je     801080b4 <loaduvm+0x1f>
801080a7:	83 ec 0c             	sub    $0xc,%esp
801080aa:	68 1c 8c 10 80       	push   $0x80108c1c
801080af:	e8 ec 84 ff ff       	call   801005a0 <panic>
801080b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801080bb:	e9 8f 00 00 00       	jmp    8010814f <loaduvm+0xba>
801080c0:	8b 55 0c             	mov    0xc(%ebp),%edx
801080c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080c6:	01 d0                	add    %edx,%eax
801080c8:	83 ec 04             	sub    $0x4,%esp
801080cb:	6a 00                	push   $0x0
801080cd:	50                   	push   %eax
801080ce:	ff 75 08             	pushl  0x8(%ebp)
801080d1:	e8 f5 fb ff ff       	call   80107ccb <walkpgdir>
801080d6:	83 c4 10             	add    $0x10,%esp
801080d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
801080dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080e0:	75 0d                	jne    801080ef <loaduvm+0x5a>
801080e2:	83 ec 0c             	sub    $0xc,%esp
801080e5:	68 3f 8c 10 80       	push   $0x80108c3f
801080ea:	e8 b1 84 ff ff       	call   801005a0 <panic>
801080ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080f2:	8b 00                	mov    (%eax),%eax
801080f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080f9:	89 45 e8             	mov    %eax,-0x18(%ebp)
801080fc:	8b 45 18             	mov    0x18(%ebp),%eax
801080ff:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108102:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108107:	77 0b                	ja     80108114 <loaduvm+0x7f>
80108109:	8b 45 18             	mov    0x18(%ebp),%eax
8010810c:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010810f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108112:	eb 07                	jmp    8010811b <loaduvm+0x86>
80108114:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
8010811b:	8b 55 14             	mov    0x14(%ebp),%edx
8010811e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108121:	01 d0                	add    %edx,%eax
80108123:	8b 55 e8             	mov    -0x18(%ebp),%edx
80108126:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010812c:	ff 75 f0             	pushl  -0x10(%ebp)
8010812f:	50                   	push   %eax
80108130:	52                   	push   %edx
80108131:	ff 75 10             	pushl  0x10(%ebp)
80108134:	e8 c0 9d ff ff       	call   80101ef9 <readi>
80108139:	83 c4 10             	add    $0x10,%esp
8010813c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010813f:	74 07                	je     80108148 <loaduvm+0xb3>
80108141:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108146:	eb 18                	jmp    80108160 <loaduvm+0xcb>
80108148:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010814f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108152:	3b 45 18             	cmp    0x18(%ebp),%eax
80108155:	0f 82 65 ff ff ff    	jb     801080c0 <loaduvm+0x2b>
8010815b:	b8 00 00 00 00       	mov    $0x0,%eax
80108160:	c9                   	leave  
80108161:	c3                   	ret    

80108162 <allocuvm>:
80108162:	55                   	push   %ebp
80108163:	89 e5                	mov    %esp,%ebp
80108165:	83 ec 18             	sub    $0x18,%esp
80108168:	8b 45 10             	mov    0x10(%ebp),%eax
8010816b:	85 c0                	test   %eax,%eax
8010816d:	79 0a                	jns    80108179 <allocuvm+0x17>
8010816f:	b8 00 00 00 00       	mov    $0x0,%eax
80108174:	e9 ec 00 00 00       	jmp    80108265 <allocuvm+0x103>
80108179:	8b 45 10             	mov    0x10(%ebp),%eax
8010817c:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010817f:	73 08                	jae    80108189 <allocuvm+0x27>
80108181:	8b 45 0c             	mov    0xc(%ebp),%eax
80108184:	e9 dc 00 00 00       	jmp    80108265 <allocuvm+0x103>
80108189:	8b 45 0c             	mov    0xc(%ebp),%eax
8010818c:	05 ff 0f 00 00       	add    $0xfff,%eax
80108191:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108196:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108199:	e9 b8 00 00 00       	jmp    80108256 <allocuvm+0xf4>
8010819e:	e8 12 ab ff ff       	call   80102cb5 <kalloc>
801081a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801081a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801081aa:	75 2e                	jne    801081da <allocuvm+0x78>
801081ac:	83 ec 0c             	sub    $0xc,%esp
801081af:	68 5d 8c 10 80       	push   $0x80108c5d
801081b4:	e8 47 82 ff ff       	call   80100400 <cprintf>
801081b9:	83 c4 10             	add    $0x10,%esp
801081bc:	83 ec 04             	sub    $0x4,%esp
801081bf:	ff 75 0c             	pushl  0xc(%ebp)
801081c2:	ff 75 10             	pushl  0x10(%ebp)
801081c5:	ff 75 08             	pushl  0x8(%ebp)
801081c8:	e8 9a 00 00 00       	call   80108267 <deallocuvm>
801081cd:	83 c4 10             	add    $0x10,%esp
801081d0:	b8 00 00 00 00       	mov    $0x0,%eax
801081d5:	e9 8b 00 00 00       	jmp    80108265 <allocuvm+0x103>
801081da:	83 ec 04             	sub    $0x4,%esp
801081dd:	68 00 10 00 00       	push   $0x1000
801081e2:	6a 00                	push   $0x0
801081e4:	ff 75 f0             	pushl  -0x10(%ebp)
801081e7:	e8 6a d1 ff ff       	call   80105356 <memset>
801081ec:	83 c4 10             	add    $0x10,%esp
801081ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081f2:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801081f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081fb:	83 ec 0c             	sub    $0xc,%esp
801081fe:	6a 06                	push   $0x6
80108200:	52                   	push   %edx
80108201:	68 00 10 00 00       	push   $0x1000
80108206:	50                   	push   %eax
80108207:	ff 75 08             	pushl  0x8(%ebp)
8010820a:	e8 52 fb ff ff       	call   80107d61 <mappages>
8010820f:	83 c4 20             	add    $0x20,%esp
80108212:	85 c0                	test   %eax,%eax
80108214:	79 39                	jns    8010824f <allocuvm+0xed>
80108216:	83 ec 0c             	sub    $0xc,%esp
80108219:	68 75 8c 10 80       	push   $0x80108c75
8010821e:	e8 dd 81 ff ff       	call   80100400 <cprintf>
80108223:	83 c4 10             	add    $0x10,%esp
80108226:	83 ec 04             	sub    $0x4,%esp
80108229:	ff 75 0c             	pushl  0xc(%ebp)
8010822c:	ff 75 10             	pushl  0x10(%ebp)
8010822f:	ff 75 08             	pushl  0x8(%ebp)
80108232:	e8 30 00 00 00       	call   80108267 <deallocuvm>
80108237:	83 c4 10             	add    $0x10,%esp
8010823a:	83 ec 0c             	sub    $0xc,%esp
8010823d:	ff 75 f0             	pushl  -0x10(%ebp)
80108240:	e8 d6 a9 ff ff       	call   80102c1b <kfree>
80108245:	83 c4 10             	add    $0x10,%esp
80108248:	b8 00 00 00 00       	mov    $0x0,%eax
8010824d:	eb 16                	jmp    80108265 <allocuvm+0x103>
8010824f:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108256:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108259:	3b 45 10             	cmp    0x10(%ebp),%eax
8010825c:	0f 82 3c ff ff ff    	jb     8010819e <allocuvm+0x3c>
80108262:	8b 45 10             	mov    0x10(%ebp),%eax
80108265:	c9                   	leave  
80108266:	c3                   	ret    

80108267 <deallocuvm>:
80108267:	55                   	push   %ebp
80108268:	89 e5                	mov    %esp,%ebp
8010826a:	83 ec 18             	sub    $0x18,%esp
8010826d:	8b 45 10             	mov    0x10(%ebp),%eax
80108270:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108273:	72 08                	jb     8010827d <deallocuvm+0x16>
80108275:	8b 45 0c             	mov    0xc(%ebp),%eax
80108278:	e9 9c 00 00 00       	jmp    80108319 <deallocuvm+0xb2>
8010827d:	8b 45 10             	mov    0x10(%ebp),%eax
80108280:	05 ff 0f 00 00       	add    $0xfff,%eax
80108285:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010828a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010828d:	eb 7b                	jmp    8010830a <deallocuvm+0xa3>
8010828f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108292:	83 ec 04             	sub    $0x4,%esp
80108295:	6a 00                	push   $0x0
80108297:	50                   	push   %eax
80108298:	ff 75 08             	pushl  0x8(%ebp)
8010829b:	e8 2b fa ff ff       	call   80107ccb <walkpgdir>
801082a0:	83 c4 10             	add    $0x10,%esp
801082a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801082a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801082aa:	75 09                	jne    801082b5 <deallocuvm+0x4e>
801082ac:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
801082b3:	eb 4e                	jmp    80108303 <deallocuvm+0x9c>
801082b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082b8:	8b 00                	mov    (%eax),%eax
801082ba:	83 e0 01             	and    $0x1,%eax
801082bd:	85 c0                	test   %eax,%eax
801082bf:	74 42                	je     80108303 <deallocuvm+0x9c>
801082c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082c4:	8b 00                	mov    (%eax),%eax
801082c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
801082ce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801082d2:	75 0d                	jne    801082e1 <deallocuvm+0x7a>
801082d4:	83 ec 0c             	sub    $0xc,%esp
801082d7:	68 91 8c 10 80       	push   $0x80108c91
801082dc:	e8 bf 82 ff ff       	call   801005a0 <panic>
801082e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082e4:	05 00 00 00 80       	add    $0x80000000,%eax
801082e9:	89 45 e8             	mov    %eax,-0x18(%ebp)
801082ec:	83 ec 0c             	sub    $0xc,%esp
801082ef:	ff 75 e8             	pushl  -0x18(%ebp)
801082f2:	e8 24 a9 ff ff       	call   80102c1b <kfree>
801082f7:	83 c4 10             	add    $0x10,%esp
801082fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80108303:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010830a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010830d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108310:	0f 82 79 ff ff ff    	jb     8010828f <deallocuvm+0x28>
80108316:	8b 45 10             	mov    0x10(%ebp),%eax
80108319:	c9                   	leave  
8010831a:	c3                   	ret    

8010831b <freevm>:
8010831b:	55                   	push   %ebp
8010831c:	89 e5                	mov    %esp,%ebp
8010831e:	83 ec 18             	sub    $0x18,%esp
80108321:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108325:	75 0d                	jne    80108334 <freevm+0x19>
80108327:	83 ec 0c             	sub    $0xc,%esp
8010832a:	68 97 8c 10 80       	push   $0x80108c97
8010832f:	e8 6c 82 ff ff       	call   801005a0 <panic>
80108334:	83 ec 04             	sub    $0x4,%esp
80108337:	6a 00                	push   $0x0
80108339:	68 00 00 00 80       	push   $0x80000000
8010833e:	ff 75 08             	pushl  0x8(%ebp)
80108341:	e8 21 ff ff ff       	call   80108267 <deallocuvm>
80108346:	83 c4 10             	add    $0x10,%esp
80108349:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108350:	eb 48                	jmp    8010839a <freevm+0x7f>
80108352:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108355:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010835c:	8b 45 08             	mov    0x8(%ebp),%eax
8010835f:	01 d0                	add    %edx,%eax
80108361:	8b 00                	mov    (%eax),%eax
80108363:	83 e0 01             	and    $0x1,%eax
80108366:	85 c0                	test   %eax,%eax
80108368:	74 2c                	je     80108396 <freevm+0x7b>
8010836a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010836d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108374:	8b 45 08             	mov    0x8(%ebp),%eax
80108377:	01 d0                	add    %edx,%eax
80108379:	8b 00                	mov    (%eax),%eax
8010837b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108380:	05 00 00 00 80       	add    $0x80000000,%eax
80108385:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108388:	83 ec 0c             	sub    $0xc,%esp
8010838b:	ff 75 f0             	pushl  -0x10(%ebp)
8010838e:	e8 88 a8 ff ff       	call   80102c1b <kfree>
80108393:	83 c4 10             	add    $0x10,%esp
80108396:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010839a:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801083a1:	76 af                	jbe    80108352 <freevm+0x37>
801083a3:	83 ec 0c             	sub    $0xc,%esp
801083a6:	ff 75 08             	pushl  0x8(%ebp)
801083a9:	e8 6d a8 ff ff       	call   80102c1b <kfree>
801083ae:	83 c4 10             	add    $0x10,%esp
801083b1:	90                   	nop
801083b2:	c9                   	leave  
801083b3:	c3                   	ret    

801083b4 <clearpteu>:
801083b4:	55                   	push   %ebp
801083b5:	89 e5                	mov    %esp,%ebp
801083b7:	83 ec 18             	sub    $0x18,%esp
801083ba:	83 ec 04             	sub    $0x4,%esp
801083bd:	6a 00                	push   $0x0
801083bf:	ff 75 0c             	pushl  0xc(%ebp)
801083c2:	ff 75 08             	pushl  0x8(%ebp)
801083c5:	e8 01 f9 ff ff       	call   80107ccb <walkpgdir>
801083ca:	83 c4 10             	add    $0x10,%esp
801083cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801083d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801083d4:	75 0d                	jne    801083e3 <clearpteu+0x2f>
801083d6:	83 ec 0c             	sub    $0xc,%esp
801083d9:	68 a8 8c 10 80       	push   $0x80108ca8
801083de:	e8 bd 81 ff ff       	call   801005a0 <panic>
801083e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083e6:	8b 00                	mov    (%eax),%eax
801083e8:	83 e0 fb             	and    $0xfffffffb,%eax
801083eb:	89 c2                	mov    %eax,%edx
801083ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083f0:	89 10                	mov    %edx,(%eax)
801083f2:	90                   	nop
801083f3:	c9                   	leave  
801083f4:	c3                   	ret    

801083f5 <copyuvm>:
801083f5:	55                   	push   %ebp
801083f6:	89 e5                	mov    %esp,%ebp
801083f8:	83 ec 28             	sub    $0x28,%esp
801083fb:	e8 f1 f9 ff ff       	call   80107df1 <setupkvm>
80108400:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108403:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108407:	75 0a                	jne    80108413 <copyuvm+0x1e>
80108409:	b8 00 00 00 00       	mov    $0x0,%eax
8010840e:	e9 eb 00 00 00       	jmp    801084fe <copyuvm+0x109>
80108413:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010841a:	e9 b7 00 00 00       	jmp    801084d6 <copyuvm+0xe1>
8010841f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108422:	83 ec 04             	sub    $0x4,%esp
80108425:	6a 00                	push   $0x0
80108427:	50                   	push   %eax
80108428:	ff 75 08             	pushl  0x8(%ebp)
8010842b:	e8 9b f8 ff ff       	call   80107ccb <walkpgdir>
80108430:	83 c4 10             	add    $0x10,%esp
80108433:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108436:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010843a:	75 0d                	jne    80108449 <copyuvm+0x54>
8010843c:	83 ec 0c             	sub    $0xc,%esp
8010843f:	68 b2 8c 10 80       	push   $0x80108cb2
80108444:	e8 57 81 ff ff       	call   801005a0 <panic>
80108449:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010844c:	8b 00                	mov    (%eax),%eax
8010844e:	83 e0 01             	and    $0x1,%eax
80108451:	85 c0                	test   %eax,%eax
80108453:	75 0d                	jne    80108462 <copyuvm+0x6d>
80108455:	83 ec 0c             	sub    $0xc,%esp
80108458:	68 cc 8c 10 80       	push   $0x80108ccc
8010845d:	e8 3e 81 ff ff       	call   801005a0 <panic>
80108462:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108465:	8b 00                	mov    (%eax),%eax
80108467:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010846c:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010846f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108472:	8b 00                	mov    (%eax),%eax
80108474:	25 ff 0f 00 00       	and    $0xfff,%eax
80108479:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010847c:	e8 34 a8 ff ff       	call   80102cb5 <kalloc>
80108481:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108484:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80108488:	74 5d                	je     801084e7 <copyuvm+0xf2>
8010848a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010848d:	05 00 00 00 80       	add    $0x80000000,%eax
80108492:	83 ec 04             	sub    $0x4,%esp
80108495:	68 00 10 00 00       	push   $0x1000
8010849a:	50                   	push   %eax
8010849b:	ff 75 e0             	pushl  -0x20(%ebp)
8010849e:	e8 72 cf ff ff       	call   80105415 <memmove>
801084a3:	83 c4 10             	add    $0x10,%esp
801084a6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801084a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084ac:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801084b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084b5:	83 ec 0c             	sub    $0xc,%esp
801084b8:	52                   	push   %edx
801084b9:	51                   	push   %ecx
801084ba:	68 00 10 00 00       	push   $0x1000
801084bf:	50                   	push   %eax
801084c0:	ff 75 f0             	pushl  -0x10(%ebp)
801084c3:	e8 99 f8 ff ff       	call   80107d61 <mappages>
801084c8:	83 c4 20             	add    $0x20,%esp
801084cb:	85 c0                	test   %eax,%eax
801084cd:	78 1b                	js     801084ea <copyuvm+0xf5>
801084cf:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801084d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801084d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084dc:	0f 82 3d ff ff ff    	jb     8010841f <copyuvm+0x2a>
801084e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084e5:	eb 17                	jmp    801084fe <copyuvm+0x109>
801084e7:	90                   	nop
801084e8:	eb 01                	jmp    801084eb <copyuvm+0xf6>
801084ea:	90                   	nop
801084eb:	83 ec 0c             	sub    $0xc,%esp
801084ee:	ff 75 f0             	pushl  -0x10(%ebp)
801084f1:	e8 25 fe ff ff       	call   8010831b <freevm>
801084f6:	83 c4 10             	add    $0x10,%esp
801084f9:	b8 00 00 00 00       	mov    $0x0,%eax
801084fe:	c9                   	leave  
801084ff:	c3                   	ret    

80108500 <uva2ka>:
80108500:	55                   	push   %ebp
80108501:	89 e5                	mov    %esp,%ebp
80108503:	83 ec 18             	sub    $0x18,%esp
80108506:	83 ec 04             	sub    $0x4,%esp
80108509:	6a 00                	push   $0x0
8010850b:	ff 75 0c             	pushl  0xc(%ebp)
8010850e:	ff 75 08             	pushl  0x8(%ebp)
80108511:	e8 b5 f7 ff ff       	call   80107ccb <walkpgdir>
80108516:	83 c4 10             	add    $0x10,%esp
80108519:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010851c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010851f:	8b 00                	mov    (%eax),%eax
80108521:	83 e0 01             	and    $0x1,%eax
80108524:	85 c0                	test   %eax,%eax
80108526:	75 07                	jne    8010852f <uva2ka+0x2f>
80108528:	b8 00 00 00 00       	mov    $0x0,%eax
8010852d:	eb 22                	jmp    80108551 <uva2ka+0x51>
8010852f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108532:	8b 00                	mov    (%eax),%eax
80108534:	83 e0 04             	and    $0x4,%eax
80108537:	85 c0                	test   %eax,%eax
80108539:	75 07                	jne    80108542 <uva2ka+0x42>
8010853b:	b8 00 00 00 00       	mov    $0x0,%eax
80108540:	eb 0f                	jmp    80108551 <uva2ka+0x51>
80108542:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108545:	8b 00                	mov    (%eax),%eax
80108547:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010854c:	05 00 00 00 80       	add    $0x80000000,%eax
80108551:	c9                   	leave  
80108552:	c3                   	ret    

80108553 <copyout>:
80108553:	55                   	push   %ebp
80108554:	89 e5                	mov    %esp,%ebp
80108556:	83 ec 18             	sub    $0x18,%esp
80108559:	8b 45 10             	mov    0x10(%ebp),%eax
8010855c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010855f:	eb 7f                	jmp    801085e0 <copyout+0x8d>
80108561:	8b 45 0c             	mov    0xc(%ebp),%eax
80108564:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108569:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010856c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010856f:	83 ec 08             	sub    $0x8,%esp
80108572:	50                   	push   %eax
80108573:	ff 75 08             	pushl  0x8(%ebp)
80108576:	e8 85 ff ff ff       	call   80108500 <uva2ka>
8010857b:	83 c4 10             	add    $0x10,%esp
8010857e:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108581:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108585:	75 07                	jne    8010858e <copyout+0x3b>
80108587:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010858c:	eb 61                	jmp    801085ef <copyout+0x9c>
8010858e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108591:	2b 45 0c             	sub    0xc(%ebp),%eax
80108594:	05 00 10 00 00       	add    $0x1000,%eax
80108599:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010859c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010859f:	3b 45 14             	cmp    0x14(%ebp),%eax
801085a2:	76 06                	jbe    801085aa <copyout+0x57>
801085a4:	8b 45 14             	mov    0x14(%ebp),%eax
801085a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801085aa:	8b 45 0c             	mov    0xc(%ebp),%eax
801085ad:	2b 45 ec             	sub    -0x14(%ebp),%eax
801085b0:	89 c2                	mov    %eax,%edx
801085b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801085b5:	01 d0                	add    %edx,%eax
801085b7:	83 ec 04             	sub    $0x4,%esp
801085ba:	ff 75 f0             	pushl  -0x10(%ebp)
801085bd:	ff 75 f4             	pushl  -0xc(%ebp)
801085c0:	50                   	push   %eax
801085c1:	e8 4f ce ff ff       	call   80105415 <memmove>
801085c6:	83 c4 10             	add    $0x10,%esp
801085c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085cc:	29 45 14             	sub    %eax,0x14(%ebp)
801085cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085d2:	01 45 f4             	add    %eax,-0xc(%ebp)
801085d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801085d8:	05 00 10 00 00       	add    $0x1000,%eax
801085dd:	89 45 0c             	mov    %eax,0xc(%ebp)
801085e0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801085e4:	0f 85 77 ff ff ff    	jne    80108561 <copyout+0xe>
801085ea:	b8 00 00 00 00       	mov    $0x0,%eax
801085ef:	c9                   	leave  
801085f0:	c3                   	ret    
