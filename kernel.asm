
kernel:     formato del fichero elf32-i386


Desensamblado de la sección .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 50 d6 10 80       	mov    $0x8010d650,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 1b 39 10 80       	mov    $0x8010391b,%eax
  jmp *%eax
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
8010003d:	68 10 89 10 80       	push   $0x80108910
80100042:	68 60 d6 10 80       	push   $0x8010d660
80100047:	e8 80 50 00 00       	call   801050cc <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 ac 1d 11 80 5c 	movl   $0x80111d5c,0x80111dac
80100056:	1d 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 b0 1d 11 80 5c 	movl   $0x80111d5c,0x80111db0
80100060:	1d 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 94 d6 10 80 	movl   $0x8010d694,-0xc(%ebp)
8010006a:	eb 47                	jmp    801000b3 <binit+0x7f>
    b->next = bcache.head.next;
8010006c:	8b 15 b0 1d 11 80    	mov    0x80111db0,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 50 5c 1d 11 80 	movl   $0x80111d5c,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	83 c0 0c             	add    $0xc,%eax
80100088:	83 ec 08             	sub    $0x8,%esp
8010008b:	68 17 89 10 80       	push   $0x80108917
80100090:	50                   	push   %eax
80100091:	e8 d8 4e 00 00       	call   80104f6e <initsleeplock>
80100096:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
80100099:	a1 b0 1d 11 80       	mov    0x80111db0,%eax
8010009e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000a1:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a7:	a3 b0 1d 11 80       	mov    %eax,0x80111db0

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ac:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b3:	b8 5c 1d 11 80       	mov    $0x80111d5c,%eax
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
801000c9:	68 60 d6 10 80       	push   $0x8010d660
801000ce:	e8 1b 50 00 00       	call   801050ee <acquire>
801000d3:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000d6:	a1 b0 1d 11 80       	mov    0x80111db0,%eax
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
80100108:	68 60 d6 10 80       	push   $0x8010d660
8010010d:	e8 48 50 00 00       	call   8010515a <release>
80100112:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100115:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100118:	83 c0 0c             	add    $0xc,%eax
8010011b:	83 ec 0c             	sub    $0xc,%esp
8010011e:	50                   	push   %eax
8010011f:	e8 86 4e 00 00       	call   80104faa <acquiresleep>
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
80100138:	81 7d f4 5c 1d 11 80 	cmpl   $0x80111d5c,-0xc(%ebp)
8010013f:	75 9f                	jne    801000e0 <bget+0x20>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100141:	a1 ac 1d 11 80       	mov    0x80111dac,%eax
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
80100189:	68 60 d6 10 80       	push   $0x8010d660
8010018e:	e8 c7 4f 00 00       	call   8010515a <release>
80100193:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100196:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100199:	83 c0 0c             	add    $0xc,%eax
8010019c:	83 ec 0c             	sub    $0xc,%esp
8010019f:	50                   	push   %eax
801001a0:	e8 05 4e 00 00       	call   80104faa <acquiresleep>
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
801001b6:	81 7d f4 5c 1d 11 80 	cmpl   $0x80111d5c,-0xc(%ebp)
801001bd:	75 8c                	jne    8010014b <bget+0x8b>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001bf:	83 ec 0c             	sub    $0xc,%esp
801001c2:	68 1e 89 10 80       	push   $0x8010891e
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
801001fa:	e8 75 27 00 00       	call   80102974 <iderw>
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
80100217:	e8 41 4e 00 00       	call   8010505d <holdingsleep>
8010021c:	83 c4 10             	add    $0x10,%esp
8010021f:	85 c0                	test   %eax,%eax
80100221:	75 0d                	jne    80100230 <bwrite+0x29>
    panic("bwrite");
80100223:	83 ec 0c             	sub    $0xc,%esp
80100226:	68 2f 89 10 80       	push   $0x8010892f
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
80100245:	e8 2a 27 00 00       	call   80102974 <iderw>
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
80100260:	e8 f8 4d 00 00       	call   8010505d <holdingsleep>
80100265:	83 c4 10             	add    $0x10,%esp
80100268:	85 c0                	test   %eax,%eax
8010026a:	75 0d                	jne    80100279 <brelse+0x29>
    panic("brelse");
8010026c:	83 ec 0c             	sub    $0xc,%esp
8010026f:	68 36 89 10 80       	push   $0x80108936
80100274:	e8 27 03 00 00       	call   801005a0 <panic>

  releasesleep(&b->lock);
80100279:	8b 45 08             	mov    0x8(%ebp),%eax
8010027c:	83 c0 0c             	add    $0xc,%eax
8010027f:	83 ec 0c             	sub    $0xc,%esp
80100282:	50                   	push   %eax
80100283:	e8 87 4d 00 00       	call   8010500f <releasesleep>
80100288:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
8010028b:	83 ec 0c             	sub    $0xc,%esp
8010028e:	68 60 d6 10 80       	push   $0x8010d660
80100293:	e8 56 4e 00 00       	call   801050ee <acquire>
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
801002d2:	8b 15 b0 1d 11 80    	mov    0x80111db0,%edx
801002d8:	8b 45 08             	mov    0x8(%ebp),%eax
801002db:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801002de:	8b 45 08             	mov    0x8(%ebp),%eax
801002e1:	c7 40 50 5c 1d 11 80 	movl   $0x80111d5c,0x50(%eax)
    bcache.head.next->prev = b;
801002e8:	a1 b0 1d 11 80       	mov    0x80111db0,%eax
801002ed:	8b 55 08             	mov    0x8(%ebp),%edx
801002f0:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801002f3:	8b 45 08             	mov    0x8(%ebp),%eax
801002f6:	a3 b0 1d 11 80       	mov    %eax,0x80111db0
  }
  
  release(&bcache.lock);
801002fb:	83 ec 0c             	sub    $0xc,%esp
801002fe:	68 60 d6 10 80       	push   $0x8010d660
80100303:	e8 52 4e 00 00       	call   8010515a <release>
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
8010039f:	0f b6 80 04 a0 10 80 	movzbl -0x7fef5ffc(%eax),%eax
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
80100406:	a1 f4 c5 10 80       	mov    0x8010c5f4,%eax
8010040b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
8010040e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100412:	74 10                	je     80100424 <cprintf+0x24>
    acquire(&cons.lock);
80100414:	83 ec 0c             	sub    $0xc,%esp
80100417:	68 c0 c5 10 80       	push   $0x8010c5c0
8010041c:	e8 cd 4c 00 00       	call   801050ee <acquire>
80100421:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100424:	8b 45 08             	mov    0x8(%ebp),%eax
80100427:	85 c0                	test   %eax,%eax
80100429:	75 0d                	jne    80100438 <cprintf+0x38>
    panic("null fmt");
8010042b:	83 ec 0c             	sub    $0xc,%esp
8010042e:	68 3d 89 10 80       	push   $0x8010893d
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
80100507:	c7 45 ec 46 89 10 80 	movl   $0x80108946,-0x14(%ebp)
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
80100590:	68 c0 c5 10 80       	push   $0x8010c5c0
80100595:	e8 c0 4b 00 00       	call   8010515a <release>
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
801005ab:	c7 05 f4 c5 10 80 00 	movl   $0x0,0x8010c5f4
801005b2:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
801005b5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801005bb:	0f b6 00             	movzbl (%eax),%eax
801005be:	0f b6 c0             	movzbl %al,%eax
801005c1:	83 ec 08             	sub    $0x8,%esp
801005c4:	50                   	push   %eax
801005c5:	68 4d 89 10 80       	push   $0x8010894d
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
801005e4:	68 69 89 10 80       	push   $0x80108969
801005e9:	e8 12 fe ff ff       	call   80100400 <cprintf>
801005ee:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005f1:	83 ec 08             	sub    $0x8,%esp
801005f4:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005f7:	50                   	push   %eax
801005f8:	8d 45 08             	lea    0x8(%ebp),%eax
801005fb:	50                   	push   %eax
801005fc:	e8 ab 4b 00 00       	call   801051ac <getcallerpcs>
80100601:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100604:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010060b:	eb 1c                	jmp    80100629 <panic+0x89>
    cprintf(" %p", pcs[i]);
8010060d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100610:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100614:	83 ec 08             	sub    $0x8,%esp
80100617:	50                   	push   %eax
80100618:	68 6b 89 10 80       	push   $0x8010896b
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
8010062f:	c7 05 a0 c5 10 80 01 	movl   $0x1,0x8010c5a0
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
801006d3:	8b 0d 00 a0 10 80    	mov    0x8010a000,%ecx
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
80100704:	68 6f 89 10 80       	push   $0x8010896f
80100709:	e8 92 fe ff ff       	call   801005a0 <panic>

  if((pos/80) >= 24){  // Scroll up.
8010070e:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100715:	7e 4c                	jle    80100763 <cgaputc+0x128>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100717:	a1 00 a0 10 80       	mov    0x8010a000,%eax
8010071c:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100722:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100727:	83 ec 04             	sub    $0x4,%esp
8010072a:	68 60 0e 00 00       	push   $0xe60
8010072f:	52                   	push   %edx
80100730:	50                   	push   %eax
80100731:	e8 f1 4c 00 00       	call   80105427 <memmove>
80100736:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100739:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010073d:	b8 80 07 00 00       	mov    $0x780,%eax
80100742:	2b 45 f4             	sub    -0xc(%ebp),%eax
80100745:	8d 14 00             	lea    (%eax,%eax,1),%edx
80100748:	a1 00 a0 10 80       	mov    0x8010a000,%eax
8010074d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100750:	01 c9                	add    %ecx,%ecx
80100752:	01 c8                	add    %ecx,%eax
80100754:	83 ec 04             	sub    $0x4,%esp
80100757:	52                   	push   %edx
80100758:	6a 00                	push   $0x0
8010075a:	50                   	push   %eax
8010075b:	e8 08 4c 00 00       	call   80105368 <memset>
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
801007b8:	a1 00 a0 10 80       	mov    0x8010a000,%eax
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
801007d2:	a1 a0 c5 10 80       	mov    0x8010c5a0,%eax
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
801007f0:	e8 11 68 00 00       	call   80107006 <uartputc>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	83 ec 0c             	sub    $0xc,%esp
801007fb:	6a 20                	push   $0x20
801007fd:	e8 04 68 00 00       	call   80107006 <uartputc>
80100802:	83 c4 10             	add    $0x10,%esp
80100805:	83 ec 0c             	sub    $0xc,%esp
80100808:	6a 08                	push   $0x8
8010080a:	e8 f7 67 00 00       	call   80107006 <uartputc>
8010080f:	83 c4 10             	add    $0x10,%esp
80100812:	eb 0e                	jmp    80100822 <consputc+0x56>
  } else
    uartputc(c);
80100814:	83 ec 0c             	sub    $0xc,%esp
80100817:	ff 75 08             	pushl  0x8(%ebp)
8010081a:	e8 e7 67 00 00       	call   80107006 <uartputc>
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
80100843:	68 c0 c5 10 80       	push   $0x8010c5c0
80100848:	e8 a1 48 00 00       	call   801050ee <acquire>
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
80100887:	a1 48 20 11 80       	mov    0x80112048,%eax
8010088c:	83 e8 01             	sub    $0x1,%eax
8010088f:	a3 48 20 11 80       	mov    %eax,0x80112048
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
801008a4:	8b 15 48 20 11 80    	mov    0x80112048,%edx
801008aa:	a1 44 20 11 80       	mov    0x80112044,%eax
801008af:	39 c2                	cmp    %eax,%edx
801008b1:	0f 84 e2 00 00 00    	je     80100999 <consoleintr+0x166>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008b7:	a1 48 20 11 80       	mov    0x80112048,%eax
801008bc:	83 e8 01             	sub    $0x1,%eax
801008bf:	83 e0 7f             	and    $0x7f,%eax
801008c2:	0f b6 80 c0 1f 11 80 	movzbl -0x7feee040(%eax),%eax
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
801008d2:	8b 15 48 20 11 80    	mov    0x80112048,%edx
801008d8:	a1 44 20 11 80       	mov    0x80112044,%eax
801008dd:	39 c2                	cmp    %eax,%edx
801008df:	0f 84 b4 00 00 00    	je     80100999 <consoleintr+0x166>
        input.e--;
801008e5:	a1 48 20 11 80       	mov    0x80112048,%eax
801008ea:	83 e8 01             	sub    $0x1,%eax
801008ed:	a3 48 20 11 80       	mov    %eax,0x80112048
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
80100911:	8b 15 48 20 11 80    	mov    0x80112048,%edx
80100917:	a1 40 20 11 80       	mov    0x80112040,%eax
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
80100938:	a1 48 20 11 80       	mov    0x80112048,%eax
8010093d:	8d 50 01             	lea    0x1(%eax),%edx
80100940:	89 15 48 20 11 80    	mov    %edx,0x80112048
80100946:	83 e0 7f             	and    $0x7f,%eax
80100949:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010094c:	88 90 c0 1f 11 80    	mov    %dl,-0x7feee040(%eax)
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
8010096c:	a1 48 20 11 80       	mov    0x80112048,%eax
80100971:	8b 15 40 20 11 80    	mov    0x80112040,%edx
80100977:	83 ea 80             	sub    $0xffffff80,%edx
8010097a:	39 d0                	cmp    %edx,%eax
8010097c:	75 1a                	jne    80100998 <consoleintr+0x165>
          input.w = input.e;
8010097e:	a1 48 20 11 80       	mov    0x80112048,%eax
80100983:	a3 44 20 11 80       	mov    %eax,0x80112044
          wakeup(&input.r);
80100988:	83 ec 0c             	sub    $0xc,%esp
8010098b:	68 40 20 11 80       	push   $0x80112040
80100990:	e8 25 44 00 00       	call   80104dba <wakeup>
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
801009ae:	68 c0 c5 10 80       	push   $0x8010c5c0
801009b3:	e8 a2 47 00 00       	call   8010515a <release>
801009b8:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
801009bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801009bf:	74 05                	je     801009c6 <consoleintr+0x193>
    procdump();  // now call procdump() wo. cons.lock held
801009c1:	e8 af 44 00 00       	call   80104e75 <procdump>
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
801009d5:	e8 78 11 00 00       	call   80101b52 <iunlock>
801009da:	83 c4 10             	add    $0x10,%esp
  target = n;
801009dd:	8b 45 10             	mov    0x10(%ebp),%eax
801009e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
801009e3:	83 ec 0c             	sub    $0xc,%esp
801009e6:	68 c0 c5 10 80       	push   $0x8010c5c0
801009eb:	e8 fe 46 00 00       	call   801050ee <acquire>
801009f0:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
801009f3:	e9 ac 00 00 00       	jmp    80100aa4 <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
801009f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009fe:	8b 40 28             	mov    0x28(%eax),%eax
80100a01:	85 c0                	test   %eax,%eax
80100a03:	74 28                	je     80100a2d <consoleread+0x64>
        release(&cons.lock);
80100a05:	83 ec 0c             	sub    $0xc,%esp
80100a08:	68 c0 c5 10 80       	push   $0x8010c5c0
80100a0d:	e8 48 47 00 00       	call   8010515a <release>
80100a12:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100a15:	83 ec 0c             	sub    $0xc,%esp
80100a18:	ff 75 08             	pushl  0x8(%ebp)
80100a1b:	e8 15 10 00 00       	call   80101a35 <ilock>
80100a20:	83 c4 10             	add    $0x10,%esp
        return -1;
80100a23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a28:	e9 ab 00 00 00       	jmp    80100ad8 <consoleread+0x10f>
      }
      sleep(&input.r, &cons.lock);
80100a2d:	83 ec 08             	sub    $0x8,%esp
80100a30:	68 c0 c5 10 80       	push   $0x8010c5c0
80100a35:	68 40 20 11 80       	push   $0x80112040
80100a3a:	e8 90 42 00 00       	call   80104ccf <sleep>
80100a3f:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100a42:	8b 15 40 20 11 80    	mov    0x80112040,%edx
80100a48:	a1 44 20 11 80       	mov    0x80112044,%eax
80100a4d:	39 c2                	cmp    %eax,%edx
80100a4f:	74 a7                	je     801009f8 <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a51:	a1 40 20 11 80       	mov    0x80112040,%eax
80100a56:	8d 50 01             	lea    0x1(%eax),%edx
80100a59:	89 15 40 20 11 80    	mov    %edx,0x80112040
80100a5f:	83 e0 7f             	and    $0x7f,%eax
80100a62:	0f b6 80 c0 1f 11 80 	movzbl -0x7feee040(%eax),%eax
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
80100a7d:	a1 40 20 11 80       	mov    0x80112040,%eax
80100a82:	83 e8 01             	sub    $0x1,%eax
80100a85:	a3 40 20 11 80       	mov    %eax,0x80112040
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
80100ab3:	68 c0 c5 10 80       	push   $0x8010c5c0
80100ab8:	e8 9d 46 00 00       	call   8010515a <release>
80100abd:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	ff 75 08             	pushl  0x8(%ebp)
80100ac6:	e8 6a 0f 00 00       	call   80101a35 <ilock>
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
80100ae6:	e8 67 10 00 00       	call   80101b52 <iunlock>
80100aeb:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100aee:	83 ec 0c             	sub    $0xc,%esp
80100af1:	68 c0 c5 10 80       	push   $0x8010c5c0
80100af6:	e8 f3 45 00 00       	call   801050ee <acquire>
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
80100b33:	68 c0 c5 10 80       	push   $0x8010c5c0
80100b38:	e8 1d 46 00 00       	call   8010515a <release>
80100b3d:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b40:	83 ec 0c             	sub    $0xc,%esp
80100b43:	ff 75 08             	pushl  0x8(%ebp)
80100b46:	e8 ea 0e 00 00       	call   80101a35 <ilock>
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
80100b5c:	68 82 89 10 80       	push   $0x80108982
80100b61:	68 c0 c5 10 80       	push   $0x8010c5c0
80100b66:	e8 61 45 00 00       	call   801050cc <initlock>
80100b6b:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b6e:	c7 05 0c 2a 11 80 da 	movl   $0x80100ada,0x80112a0c
80100b75:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b78:	c7 05 08 2a 11 80 c9 	movl   $0x801009c9,0x80112a08
80100b7f:	09 10 80 
  cons.locking = 1;
80100b82:	c7 05 f4 c5 10 80 01 	movl   $0x1,0x8010c5f4
80100b89:	00 00 00 

  picenable(IRQ_KBD);
80100b8c:	83 ec 0c             	sub    $0xc,%esp
80100b8f:	6a 01                	push   $0x1
80100b91:	e8 41 33 00 00       	call   80103ed7 <picenable>
80100b96:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b99:	83 ec 08             	sub    $0x8,%esp
80100b9c:	6a 00                	push   $0x0
80100b9e:	6a 01                	push   $0x1
80100ba0:	e8 a6 1f 00 00       	call   80102b4b <ioapicenable>
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
80100bb4:	e8 3a 2a 00 00       	call   801035f3 <begin_op>

  if((ip = namei(path)) == 0){
80100bb9:	83 ec 0c             	sub    $0xc,%esp
80100bbc:	ff 75 08             	pushl  0x8(%ebp)
80100bbf:	e8 97 19 00 00       	call   8010255b <namei>
80100bc4:	83 c4 10             	add    $0x10,%esp
80100bc7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100bca:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100bce:	75 0f                	jne    80100bdf <exec+0x34>
    end_op();
80100bd0:	e8 aa 2a 00 00       	call   8010367f <end_op>
    return -1;
80100bd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bda:	e9 19 04 00 00       	jmp    80100ff8 <exec+0x44d>
  }
  ilock(ip);
80100bdf:	83 ec 0c             	sub    $0xc,%esp
80100be2:	ff 75 d8             	pushl  -0x28(%ebp)
80100be5:	e8 4b 0e 00 00       	call   80101a35 <ilock>
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
80100c02:	e8 04 13 00 00       	call   80101f0b <readi>
80100c07:	83 c4 10             	add    $0x10,%esp
80100c0a:	83 f8 33             	cmp    $0x33,%eax
80100c0d:	0f 86 8e 03 00 00    	jbe    80100fa1 <exec+0x3f6>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c13:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c19:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100c1e:	0f 85 80 03 00 00    	jne    80100fa4 <exec+0x3f9>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c24:	e8 0e 75 00 00       	call   80108137 <setupkvm>
80100c29:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100c2c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100c30:	0f 84 71 03 00 00    	je     80100fa7 <exec+0x3fc>
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
80100c62:	e8 a4 12 00 00       	call   80101f0b <readi>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	83 f8 20             	cmp    $0x20,%eax
80100c6d:	0f 85 37 03 00 00    	jne    80100faa <exec+0x3ff>
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
80100c90:	0f 82 17 03 00 00    	jb     80100fad <exec+0x402>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c96:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c9c:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100ca2:	01 c2                	add    %eax,%edx
80100ca4:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100caa:	39 c2                	cmp    %eax,%edx
80100cac:	0f 82 fe 02 00 00    	jb     80100fb0 <exec+0x405>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100cb2:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100cb8:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100cbe:	01 d0                	add    %edx,%eax
80100cc0:	83 ec 04             	sub    $0x4,%esp
80100cc3:	50                   	push   %eax
80100cc4:	ff 75 e0             	pushl  -0x20(%ebp)
80100cc7:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cca:	e8 d9 77 00 00       	call   801084a8 <allocuvm>
80100ccf:	83 c4 10             	add    $0x10,%esp
80100cd2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cd5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cd9:	0f 84 d4 02 00 00    	je     80100fb3 <exec+0x408>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100cdf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100ce5:	25 ff 0f 00 00       	and    $0xfff,%eax
80100cea:	85 c0                	test   %eax,%eax
80100cec:	0f 85 c4 02 00 00    	jne    80100fb6 <exec+0x40b>
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
80100d10:	e8 c6 76 00 00       	call   801083db <loaduvm>
80100d15:	83 c4 20             	add    $0x20,%esp
80100d18:	85 c0                	test   %eax,%eax
80100d1a:	0f 88 99 02 00 00    	js     80100fb9 <exec+0x40e>
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
80100d49:	e8 fd 0e 00 00       	call   80101c4b <iunlockput>
80100d4e:	83 c4 10             	add    $0x10,%esp
  end_op();
80100d51:	e8 29 29 00 00       	call   8010367f <end_op>
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
80100d7f:	e8 24 77 00 00       	call   801084a8 <allocuvm>
80100d84:	83 c4 10             	add    $0x10,%esp
80100d87:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d8a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d8e:	0f 84 28 02 00 00    	je     80100fbc <exec+0x411>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d94:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d97:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d9c:	83 ec 08             	sub    $0x8,%esp
80100d9f:	50                   	push   %eax
80100da0:	ff 75 d4             	pushl  -0x2c(%ebp)
80100da3:	e8 38 79 00 00       	call   801086e0 <clearpteu>
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
80100dc1:	0f 87 f8 01 00 00    	ja     80100fbf <exec+0x414>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100dc7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dd1:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dd4:	01 d0                	add    %edx,%eax
80100dd6:	8b 00                	mov    (%eax),%eax
80100dd8:	83 ec 0c             	sub    $0xc,%esp
80100ddb:	50                   	push   %eax
80100ddc:	e8 d4 47 00 00       	call   801055b5 <strlen>
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
80100e09:	e8 a7 47 00 00       	call   801055b5 <strlen>
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
80100e2f:	e8 3e 7a 00 00       	call   80108872 <copyout>
80100e34:	83 c4 10             	add    $0x10,%esp
80100e37:	85 c0                	test   %eax,%eax
80100e39:	0f 88 83 01 00 00    	js     80100fc2 <exec+0x417>
      goto bad;
    ustack[3+argc] = sp;
80100e3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e42:	8d 50 03             	lea    0x3(%eax),%edx
80100e45:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e48:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
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
80100ecb:	e8 a2 79 00 00       	call   80108872 <copyout>
80100ed0:	83 c4 10             	add    $0x10,%esp
80100ed3:	85 c0                	test   %eax,%eax
80100ed5:	0f 88 ea 00 00 00    	js     80100fc5 <exec+0x41a>
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
80100f10:	83 c0 70             	add    $0x70,%eax
80100f13:	83 ec 04             	sub    $0x4,%esp
80100f16:	6a 10                	push   $0x10
80100f18:	ff 75 f0             	pushl  -0x10(%ebp)
80100f1b:	50                   	push   %eax
80100f1c:	e8 4a 46 00 00       	call   8010556b <safestrcpy>
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
80100f4d:	8b 40 1c             	mov    0x1c(%eax),%eax
80100f50:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100f56:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100f59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f5f:	8b 40 1c             	mov    0x1c(%eax),%eax
80100f62:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f65:	89 50 44             	mov    %edx,0x44(%eax)
  proc->ustack=sz-2*PGSIZE;		// Inicializar guarda
80100f68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f6e:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f71:	81 ea 00 20 00 00    	sub    $0x2000,%edx
80100f77:	89 50 0c             	mov    %edx,0xc(%eax)
  switchuvm(proc);
80100f7a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100f80:	83 ec 0c             	sub    $0xc,%esp
80100f83:	50                   	push   %eax
80100f84:	e8 6a 72 00 00       	call   801081f3 <switchuvm>
80100f89:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f8c:	83 ec 0c             	sub    $0xc,%esp
80100f8f:	ff 75 d0             	pushl  -0x30(%ebp)
80100f92:	e8 b0 76 00 00       	call   80108647 <freevm>
80100f97:	83 c4 10             	add    $0x10,%esp
  return 0;
80100f9a:	b8 00 00 00 00       	mov    $0x0,%eax
80100f9f:	eb 57                	jmp    80100ff8 <exec+0x44d>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100fa1:	90                   	nop
80100fa2:	eb 22                	jmp    80100fc6 <exec+0x41b>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100fa4:	90                   	nop
80100fa5:	eb 1f                	jmp    80100fc6 <exec+0x41b>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100fa7:	90                   	nop
80100fa8:	eb 1c                	jmp    80100fc6 <exec+0x41b>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100faa:	90                   	nop
80100fab:	eb 19                	jmp    80100fc6 <exec+0x41b>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100fad:	90                   	nop
80100fae:	eb 16                	jmp    80100fc6 <exec+0x41b>
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
80100fb0:	90                   	nop
80100fb1:	eb 13                	jmp    80100fc6 <exec+0x41b>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100fb3:	90                   	nop
80100fb4:	eb 10                	jmp    80100fc6 <exec+0x41b>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
80100fb6:	90                   	nop
80100fb7:	eb 0d                	jmp    80100fc6 <exec+0x41b>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100fb9:	90                   	nop
80100fba:	eb 0a                	jmp    80100fc6 <exec+0x41b>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100fbc:	90                   	nop
80100fbd:	eb 07                	jmp    80100fc6 <exec+0x41b>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100fbf:	90                   	nop
80100fc0:	eb 04                	jmp    80100fc6 <exec+0x41b>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100fc2:	90                   	nop
80100fc3:	eb 01                	jmp    80100fc6 <exec+0x41b>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100fc5:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100fc6:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100fca:	74 0e                	je     80100fda <exec+0x42f>
    freevm(pgdir);
80100fcc:	83 ec 0c             	sub    $0xc,%esp
80100fcf:	ff 75 d4             	pushl  -0x2c(%ebp)
80100fd2:	e8 70 76 00 00       	call   80108647 <freevm>
80100fd7:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100fda:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100fde:	74 13                	je     80100ff3 <exec+0x448>
    iunlockput(ip);
80100fe0:	83 ec 0c             	sub    $0xc,%esp
80100fe3:	ff 75 d8             	pushl  -0x28(%ebp)
80100fe6:	e8 60 0c 00 00       	call   80101c4b <iunlockput>
80100feb:	83 c4 10             	add    $0x10,%esp
    end_op();
80100fee:	e8 8c 26 00 00       	call   8010367f <end_op>
  }
  return -1;
80100ff3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ff8:	c9                   	leave  
80100ff9:	c3                   	ret    

80100ffa <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ffa:	55                   	push   %ebp
80100ffb:	89 e5                	mov    %esp,%ebp
80100ffd:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80101000:	83 ec 08             	sub    $0x8,%esp
80101003:	68 8a 89 10 80       	push   $0x8010898a
80101008:	68 60 20 11 80       	push   $0x80112060
8010100d:	e8 ba 40 00 00       	call   801050cc <initlock>
80101012:	83 c4 10             	add    $0x10,%esp
}
80101015:	90                   	nop
80101016:	c9                   	leave  
80101017:	c3                   	ret    

80101018 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101018:	55                   	push   %ebp
80101019:	89 e5                	mov    %esp,%ebp
8010101b:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
8010101e:	83 ec 0c             	sub    $0xc,%esp
80101021:	68 60 20 11 80       	push   $0x80112060
80101026:	e8 c3 40 00 00       	call   801050ee <acquire>
8010102b:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
8010102e:	c7 45 f4 94 20 11 80 	movl   $0x80112094,-0xc(%ebp)
80101035:	eb 2d                	jmp    80101064 <filealloc+0x4c>
    if(f->ref == 0){
80101037:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010103a:	8b 40 04             	mov    0x4(%eax),%eax
8010103d:	85 c0                	test   %eax,%eax
8010103f:	75 1f                	jne    80101060 <filealloc+0x48>
      f->ref = 1;
80101041:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101044:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	68 60 20 11 80       	push   $0x80112060
80101053:	e8 02 41 00 00       	call   8010515a <release>
80101058:	83 c4 10             	add    $0x10,%esp
      return f;
8010105b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010105e:	eb 23                	jmp    80101083 <filealloc+0x6b>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101060:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101064:	b8 f4 29 11 80       	mov    $0x801129f4,%eax
80101069:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010106c:	72 c9                	jb     80101037 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
8010106e:	83 ec 0c             	sub    $0xc,%esp
80101071:	68 60 20 11 80       	push   $0x80112060
80101076:	e8 df 40 00 00       	call   8010515a <release>
8010107b:	83 c4 10             	add    $0x10,%esp
  return 0;
8010107e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101083:	c9                   	leave  
80101084:	c3                   	ret    

80101085 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101085:	55                   	push   %ebp
80101086:	89 e5                	mov    %esp,%ebp
80101088:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
8010108b:	83 ec 0c             	sub    $0xc,%esp
8010108e:	68 60 20 11 80       	push   $0x80112060
80101093:	e8 56 40 00 00       	call   801050ee <acquire>
80101098:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
8010109b:	8b 45 08             	mov    0x8(%ebp),%eax
8010109e:	8b 40 04             	mov    0x4(%eax),%eax
801010a1:	85 c0                	test   %eax,%eax
801010a3:	7f 0d                	jg     801010b2 <filedup+0x2d>
    panic("filedup");
801010a5:	83 ec 0c             	sub    $0xc,%esp
801010a8:	68 91 89 10 80       	push   $0x80108991
801010ad:	e8 ee f4 ff ff       	call   801005a0 <panic>
  f->ref++;
801010b2:	8b 45 08             	mov    0x8(%ebp),%eax
801010b5:	8b 40 04             	mov    0x4(%eax),%eax
801010b8:	8d 50 01             	lea    0x1(%eax),%edx
801010bb:	8b 45 08             	mov    0x8(%ebp),%eax
801010be:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801010c1:	83 ec 0c             	sub    $0xc,%esp
801010c4:	68 60 20 11 80       	push   $0x80112060
801010c9:	e8 8c 40 00 00       	call   8010515a <release>
801010ce:	83 c4 10             	add    $0x10,%esp
  return f;
801010d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
801010d4:	c9                   	leave  
801010d5:	c3                   	ret    

801010d6 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801010d6:	55                   	push   %ebp
801010d7:	89 e5                	mov    %esp,%ebp
801010d9:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
801010dc:	83 ec 0c             	sub    $0xc,%esp
801010df:	68 60 20 11 80       	push   $0x80112060
801010e4:	e8 05 40 00 00       	call   801050ee <acquire>
801010e9:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010ec:	8b 45 08             	mov    0x8(%ebp),%eax
801010ef:	8b 40 04             	mov    0x4(%eax),%eax
801010f2:	85 c0                	test   %eax,%eax
801010f4:	7f 0d                	jg     80101103 <fileclose+0x2d>
    panic("fileclose");
801010f6:	83 ec 0c             	sub    $0xc,%esp
801010f9:	68 99 89 10 80       	push   $0x80108999
801010fe:	e8 9d f4 ff ff       	call   801005a0 <panic>
  if(--f->ref > 0){
80101103:	8b 45 08             	mov    0x8(%ebp),%eax
80101106:	8b 40 04             	mov    0x4(%eax),%eax
80101109:	8d 50 ff             	lea    -0x1(%eax),%edx
8010110c:	8b 45 08             	mov    0x8(%ebp),%eax
8010110f:	89 50 04             	mov    %edx,0x4(%eax)
80101112:	8b 45 08             	mov    0x8(%ebp),%eax
80101115:	8b 40 04             	mov    0x4(%eax),%eax
80101118:	85 c0                	test   %eax,%eax
8010111a:	7e 15                	jle    80101131 <fileclose+0x5b>
    release(&ftable.lock);
8010111c:	83 ec 0c             	sub    $0xc,%esp
8010111f:	68 60 20 11 80       	push   $0x80112060
80101124:	e8 31 40 00 00       	call   8010515a <release>
80101129:	83 c4 10             	add    $0x10,%esp
8010112c:	e9 8b 00 00 00       	jmp    801011bc <fileclose+0xe6>
    return;
  }
  ff = *f;
80101131:	8b 45 08             	mov    0x8(%ebp),%eax
80101134:	8b 10                	mov    (%eax),%edx
80101136:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101139:	8b 50 04             	mov    0x4(%eax),%edx
8010113c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010113f:	8b 50 08             	mov    0x8(%eax),%edx
80101142:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101145:	8b 50 0c             	mov    0xc(%eax),%edx
80101148:	89 55 ec             	mov    %edx,-0x14(%ebp)
8010114b:	8b 50 10             	mov    0x10(%eax),%edx
8010114e:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101151:	8b 40 14             	mov    0x14(%eax),%eax
80101154:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101157:	8b 45 08             	mov    0x8(%ebp),%eax
8010115a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101161:	8b 45 08             	mov    0x8(%ebp),%eax
80101164:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
8010116a:	83 ec 0c             	sub    $0xc,%esp
8010116d:	68 60 20 11 80       	push   $0x80112060
80101172:	e8 e3 3f 00 00       	call   8010515a <release>
80101177:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
8010117a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010117d:	83 f8 01             	cmp    $0x1,%eax
80101180:	75 19                	jne    8010119b <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
80101182:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101186:	0f be d0             	movsbl %al,%edx
80101189:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010118c:	83 ec 08             	sub    $0x8,%esp
8010118f:	52                   	push   %edx
80101190:	50                   	push   %eax
80101191:	e8 aa 2f 00 00       	call   80104140 <pipeclose>
80101196:	83 c4 10             	add    $0x10,%esp
80101199:	eb 21                	jmp    801011bc <fileclose+0xe6>
  else if(ff.type == FD_INODE){
8010119b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010119e:	83 f8 02             	cmp    $0x2,%eax
801011a1:	75 19                	jne    801011bc <fileclose+0xe6>
    begin_op();
801011a3:	e8 4b 24 00 00       	call   801035f3 <begin_op>
    iput(ff.ip);
801011a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801011ab:	83 ec 0c             	sub    $0xc,%esp
801011ae:	50                   	push   %eax
801011af:	e8 ec 09 00 00       	call   80101ba0 <iput>
801011b4:	83 c4 10             	add    $0x10,%esp
    end_op();
801011b7:	e8 c3 24 00 00       	call   8010367f <end_op>
  }
}
801011bc:	c9                   	leave  
801011bd:	c3                   	ret    

801011be <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801011be:	55                   	push   %ebp
801011bf:	89 e5                	mov    %esp,%ebp
801011c1:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
801011c4:	8b 45 08             	mov    0x8(%ebp),%eax
801011c7:	8b 00                	mov    (%eax),%eax
801011c9:	83 f8 02             	cmp    $0x2,%eax
801011cc:	75 40                	jne    8010120e <filestat+0x50>
    ilock(f->ip);
801011ce:	8b 45 08             	mov    0x8(%ebp),%eax
801011d1:	8b 40 10             	mov    0x10(%eax),%eax
801011d4:	83 ec 0c             	sub    $0xc,%esp
801011d7:	50                   	push   %eax
801011d8:	e8 58 08 00 00       	call   80101a35 <ilock>
801011dd:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801011e0:	8b 45 08             	mov    0x8(%ebp),%eax
801011e3:	8b 40 10             	mov    0x10(%eax),%eax
801011e6:	83 ec 08             	sub    $0x8,%esp
801011e9:	ff 75 0c             	pushl  0xc(%ebp)
801011ec:	50                   	push   %eax
801011ed:	e8 d3 0c 00 00       	call   80101ec5 <stati>
801011f2:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
801011f5:	8b 45 08             	mov    0x8(%ebp),%eax
801011f8:	8b 40 10             	mov    0x10(%eax),%eax
801011fb:	83 ec 0c             	sub    $0xc,%esp
801011fe:	50                   	push   %eax
801011ff:	e8 4e 09 00 00       	call   80101b52 <iunlock>
80101204:	83 c4 10             	add    $0x10,%esp
    return 0;
80101207:	b8 00 00 00 00       	mov    $0x0,%eax
8010120c:	eb 05                	jmp    80101213 <filestat+0x55>
  }
  return -1;
8010120e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101213:	c9                   	leave  
80101214:	c3                   	ret    

80101215 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101215:	55                   	push   %ebp
80101216:	89 e5                	mov    %esp,%ebp
80101218:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
8010121b:	8b 45 08             	mov    0x8(%ebp),%eax
8010121e:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101222:	84 c0                	test   %al,%al
80101224:	75 0a                	jne    80101230 <fileread+0x1b>
    return -1;
80101226:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010122b:	e9 9b 00 00 00       	jmp    801012cb <fileread+0xb6>
  if(f->type == FD_PIPE)
80101230:	8b 45 08             	mov    0x8(%ebp),%eax
80101233:	8b 00                	mov    (%eax),%eax
80101235:	83 f8 01             	cmp    $0x1,%eax
80101238:	75 1a                	jne    80101254 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
8010123a:	8b 45 08             	mov    0x8(%ebp),%eax
8010123d:	8b 40 0c             	mov    0xc(%eax),%eax
80101240:	83 ec 04             	sub    $0x4,%esp
80101243:	ff 75 10             	pushl  0x10(%ebp)
80101246:	ff 75 0c             	pushl  0xc(%ebp)
80101249:	50                   	push   %eax
8010124a:	e8 99 30 00 00       	call   801042e8 <piperead>
8010124f:	83 c4 10             	add    $0x10,%esp
80101252:	eb 77                	jmp    801012cb <fileread+0xb6>
  if(f->type == FD_INODE){
80101254:	8b 45 08             	mov    0x8(%ebp),%eax
80101257:	8b 00                	mov    (%eax),%eax
80101259:	83 f8 02             	cmp    $0x2,%eax
8010125c:	75 60                	jne    801012be <fileread+0xa9>
    ilock(f->ip);
8010125e:	8b 45 08             	mov    0x8(%ebp),%eax
80101261:	8b 40 10             	mov    0x10(%eax),%eax
80101264:	83 ec 0c             	sub    $0xc,%esp
80101267:	50                   	push   %eax
80101268:	e8 c8 07 00 00       	call   80101a35 <ilock>
8010126d:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101270:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101273:	8b 45 08             	mov    0x8(%ebp),%eax
80101276:	8b 50 14             	mov    0x14(%eax),%edx
80101279:	8b 45 08             	mov    0x8(%ebp),%eax
8010127c:	8b 40 10             	mov    0x10(%eax),%eax
8010127f:	51                   	push   %ecx
80101280:	52                   	push   %edx
80101281:	ff 75 0c             	pushl  0xc(%ebp)
80101284:	50                   	push   %eax
80101285:	e8 81 0c 00 00       	call   80101f0b <readi>
8010128a:	83 c4 10             	add    $0x10,%esp
8010128d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101290:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101294:	7e 11                	jle    801012a7 <fileread+0x92>
      f->off += r;
80101296:	8b 45 08             	mov    0x8(%ebp),%eax
80101299:	8b 50 14             	mov    0x14(%eax),%edx
8010129c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010129f:	01 c2                	add    %eax,%edx
801012a1:	8b 45 08             	mov    0x8(%ebp),%eax
801012a4:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801012a7:	8b 45 08             	mov    0x8(%ebp),%eax
801012aa:	8b 40 10             	mov    0x10(%eax),%eax
801012ad:	83 ec 0c             	sub    $0xc,%esp
801012b0:	50                   	push   %eax
801012b1:	e8 9c 08 00 00       	call   80101b52 <iunlock>
801012b6:	83 c4 10             	add    $0x10,%esp
    return r;
801012b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012bc:	eb 0d                	jmp    801012cb <fileread+0xb6>
  }
  panic("fileread");
801012be:	83 ec 0c             	sub    $0xc,%esp
801012c1:	68 a3 89 10 80       	push   $0x801089a3
801012c6:	e8 d5 f2 ff ff       	call   801005a0 <panic>
}
801012cb:	c9                   	leave  
801012cc:	c3                   	ret    

801012cd <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801012cd:	55                   	push   %ebp
801012ce:	89 e5                	mov    %esp,%ebp
801012d0:	53                   	push   %ebx
801012d1:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
801012d4:	8b 45 08             	mov    0x8(%ebp),%eax
801012d7:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801012db:	84 c0                	test   %al,%al
801012dd:	75 0a                	jne    801012e9 <filewrite+0x1c>
    return -1;
801012df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012e4:	e9 1b 01 00 00       	jmp    80101404 <filewrite+0x137>
  if(f->type == FD_PIPE)
801012e9:	8b 45 08             	mov    0x8(%ebp),%eax
801012ec:	8b 00                	mov    (%eax),%eax
801012ee:	83 f8 01             	cmp    $0x1,%eax
801012f1:	75 1d                	jne    80101310 <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
801012f3:	8b 45 08             	mov    0x8(%ebp),%eax
801012f6:	8b 40 0c             	mov    0xc(%eax),%eax
801012f9:	83 ec 04             	sub    $0x4,%esp
801012fc:	ff 75 10             	pushl  0x10(%ebp)
801012ff:	ff 75 0c             	pushl  0xc(%ebp)
80101302:	50                   	push   %eax
80101303:	e8 e2 2e 00 00       	call   801041ea <pipewrite>
80101308:	83 c4 10             	add    $0x10,%esp
8010130b:	e9 f4 00 00 00       	jmp    80101404 <filewrite+0x137>
  if(f->type == FD_INODE){
80101310:	8b 45 08             	mov    0x8(%ebp),%eax
80101313:	8b 00                	mov    (%eax),%eax
80101315:	83 f8 02             	cmp    $0x2,%eax
80101318:	0f 85 d9 00 00 00    	jne    801013f7 <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010131e:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
80101325:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
8010132c:	e9 a3 00 00 00       	jmp    801013d4 <filewrite+0x107>
      int n1 = n - i;
80101331:	8b 45 10             	mov    0x10(%ebp),%eax
80101334:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101337:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010133a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010133d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101340:	7e 06                	jle    80101348 <filewrite+0x7b>
        n1 = max;
80101342:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101345:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
80101348:	e8 a6 22 00 00       	call   801035f3 <begin_op>
      ilock(f->ip);
8010134d:	8b 45 08             	mov    0x8(%ebp),%eax
80101350:	8b 40 10             	mov    0x10(%eax),%eax
80101353:	83 ec 0c             	sub    $0xc,%esp
80101356:	50                   	push   %eax
80101357:	e8 d9 06 00 00       	call   80101a35 <ilock>
8010135c:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010135f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101362:	8b 45 08             	mov    0x8(%ebp),%eax
80101365:	8b 50 14             	mov    0x14(%eax),%edx
80101368:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010136b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010136e:	01 c3                	add    %eax,%ebx
80101370:	8b 45 08             	mov    0x8(%ebp),%eax
80101373:	8b 40 10             	mov    0x10(%eax),%eax
80101376:	51                   	push   %ecx
80101377:	52                   	push   %edx
80101378:	53                   	push   %ebx
80101379:	50                   	push   %eax
8010137a:	e8 e3 0c 00 00       	call   80102062 <writei>
8010137f:	83 c4 10             	add    $0x10,%esp
80101382:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101385:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101389:	7e 11                	jle    8010139c <filewrite+0xcf>
        f->off += r;
8010138b:	8b 45 08             	mov    0x8(%ebp),%eax
8010138e:	8b 50 14             	mov    0x14(%eax),%edx
80101391:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101394:	01 c2                	add    %eax,%edx
80101396:	8b 45 08             	mov    0x8(%ebp),%eax
80101399:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
8010139c:	8b 45 08             	mov    0x8(%ebp),%eax
8010139f:	8b 40 10             	mov    0x10(%eax),%eax
801013a2:	83 ec 0c             	sub    $0xc,%esp
801013a5:	50                   	push   %eax
801013a6:	e8 a7 07 00 00       	call   80101b52 <iunlock>
801013ab:	83 c4 10             	add    $0x10,%esp
      end_op();
801013ae:	e8 cc 22 00 00       	call   8010367f <end_op>

      if(r < 0)
801013b3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801013b7:	78 29                	js     801013e2 <filewrite+0x115>
        break;
      if(r != n1)
801013b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013bc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801013bf:	74 0d                	je     801013ce <filewrite+0x101>
        panic("short filewrite");
801013c1:	83 ec 0c             	sub    $0xc,%esp
801013c4:	68 ac 89 10 80       	push   $0x801089ac
801013c9:	e8 d2 f1 ff ff       	call   801005a0 <panic>
      i += r;
801013ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013d1:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801013d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013d7:	3b 45 10             	cmp    0x10(%ebp),%eax
801013da:	0f 8c 51 ff ff ff    	jl     80101331 <filewrite+0x64>
801013e0:	eb 01                	jmp    801013e3 <filewrite+0x116>
        f->off += r;
      iunlock(f->ip);
      end_op();

      if(r < 0)
        break;
801013e2:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801013e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013e6:	3b 45 10             	cmp    0x10(%ebp),%eax
801013e9:	75 05                	jne    801013f0 <filewrite+0x123>
801013eb:	8b 45 10             	mov    0x10(%ebp),%eax
801013ee:	eb 14                	jmp    80101404 <filewrite+0x137>
801013f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013f5:	eb 0d                	jmp    80101404 <filewrite+0x137>
  }
  panic("filewrite");
801013f7:	83 ec 0c             	sub    $0xc,%esp
801013fa:	68 bc 89 10 80       	push   $0x801089bc
801013ff:	e8 9c f1 ff ff       	call   801005a0 <panic>
}
80101404:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101407:	c9                   	leave  
80101408:	c3                   	ret    

80101409 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101409:	55                   	push   %ebp
8010140a:	89 e5                	mov    %esp,%ebp
8010140c:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
8010140f:	8b 45 08             	mov    0x8(%ebp),%eax
80101412:	83 ec 08             	sub    $0x8,%esp
80101415:	6a 01                	push   $0x1
80101417:	50                   	push   %eax
80101418:	e8 b1 ed ff ff       	call   801001ce <bread>
8010141d:	83 c4 10             	add    $0x10,%esp
80101420:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101423:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101426:	83 c0 5c             	add    $0x5c,%eax
80101429:	83 ec 04             	sub    $0x4,%esp
8010142c:	6a 1c                	push   $0x1c
8010142e:	50                   	push   %eax
8010142f:	ff 75 0c             	pushl  0xc(%ebp)
80101432:	e8 f0 3f 00 00       	call   80105427 <memmove>
80101437:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010143a:	83 ec 0c             	sub    $0xc,%esp
8010143d:	ff 75 f4             	pushl  -0xc(%ebp)
80101440:	e8 0b ee ff ff       	call   80100250 <brelse>
80101445:	83 c4 10             	add    $0x10,%esp
}
80101448:	90                   	nop
80101449:	c9                   	leave  
8010144a:	c3                   	ret    

8010144b <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010144b:	55                   	push   %ebp
8010144c:	89 e5                	mov    %esp,%ebp
8010144e:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
80101451:	8b 55 0c             	mov    0xc(%ebp),%edx
80101454:	8b 45 08             	mov    0x8(%ebp),%eax
80101457:	83 ec 08             	sub    $0x8,%esp
8010145a:	52                   	push   %edx
8010145b:	50                   	push   %eax
8010145c:	e8 6d ed ff ff       	call   801001ce <bread>
80101461:	83 c4 10             	add    $0x10,%esp
80101464:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101467:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010146a:	83 c0 5c             	add    $0x5c,%eax
8010146d:	83 ec 04             	sub    $0x4,%esp
80101470:	68 00 02 00 00       	push   $0x200
80101475:	6a 00                	push   $0x0
80101477:	50                   	push   %eax
80101478:	e8 eb 3e 00 00       	call   80105368 <memset>
8010147d:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101480:	83 ec 0c             	sub    $0xc,%esp
80101483:	ff 75 f4             	pushl  -0xc(%ebp)
80101486:	e8 a0 23 00 00       	call   8010382b <log_write>
8010148b:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
8010148e:	83 ec 0c             	sub    $0xc,%esp
80101491:	ff 75 f4             	pushl  -0xc(%ebp)
80101494:	e8 b7 ed ff ff       	call   80100250 <brelse>
80101499:	83 c4 10             	add    $0x10,%esp
}
8010149c:	90                   	nop
8010149d:	c9                   	leave  
8010149e:	c3                   	ret    

8010149f <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010149f:	55                   	push   %ebp
801014a0:	89 e5                	mov    %esp,%ebp
801014a2:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801014a5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801014ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801014b3:	e9 13 01 00 00       	jmp    801015cb <balloc+0x12c>
    bp = bread(dev, BBLOCK(b, sb));
801014b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014bb:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801014c1:	85 c0                	test   %eax,%eax
801014c3:	0f 48 c2             	cmovs  %edx,%eax
801014c6:	c1 f8 0c             	sar    $0xc,%eax
801014c9:	89 c2                	mov    %eax,%edx
801014cb:	a1 78 2a 11 80       	mov    0x80112a78,%eax
801014d0:	01 d0                	add    %edx,%eax
801014d2:	83 ec 08             	sub    $0x8,%esp
801014d5:	50                   	push   %eax
801014d6:	ff 75 08             	pushl  0x8(%ebp)
801014d9:	e8 f0 ec ff ff       	call   801001ce <bread>
801014de:	83 c4 10             	add    $0x10,%esp
801014e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801014eb:	e9 a6 00 00 00       	jmp    80101596 <balloc+0xf7>
      m = 1 << (bi % 8);
801014f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014f3:	99                   	cltd   
801014f4:	c1 ea 1d             	shr    $0x1d,%edx
801014f7:	01 d0                	add    %edx,%eax
801014f9:	83 e0 07             	and    $0x7,%eax
801014fc:	29 d0                	sub    %edx,%eax
801014fe:	ba 01 00 00 00       	mov    $0x1,%edx
80101503:	89 c1                	mov    %eax,%ecx
80101505:	d3 e2                	shl    %cl,%edx
80101507:	89 d0                	mov    %edx,%eax
80101509:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010150c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010150f:	8d 50 07             	lea    0x7(%eax),%edx
80101512:	85 c0                	test   %eax,%eax
80101514:	0f 48 c2             	cmovs  %edx,%eax
80101517:	c1 f8 03             	sar    $0x3,%eax
8010151a:	89 c2                	mov    %eax,%edx
8010151c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010151f:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101524:	0f b6 c0             	movzbl %al,%eax
80101527:	23 45 e8             	and    -0x18(%ebp),%eax
8010152a:	85 c0                	test   %eax,%eax
8010152c:	75 64                	jne    80101592 <balloc+0xf3>
        bp->data[bi/8] |= m;  // Mark block in use.
8010152e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101531:	8d 50 07             	lea    0x7(%eax),%edx
80101534:	85 c0                	test   %eax,%eax
80101536:	0f 48 c2             	cmovs  %edx,%eax
80101539:	c1 f8 03             	sar    $0x3,%eax
8010153c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010153f:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
80101544:	89 d1                	mov    %edx,%ecx
80101546:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101549:	09 ca                	or     %ecx,%edx
8010154b:	89 d1                	mov    %edx,%ecx
8010154d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101550:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
80101554:	83 ec 0c             	sub    $0xc,%esp
80101557:	ff 75 ec             	pushl  -0x14(%ebp)
8010155a:	e8 cc 22 00 00       	call   8010382b <log_write>
8010155f:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80101562:	83 ec 0c             	sub    $0xc,%esp
80101565:	ff 75 ec             	pushl  -0x14(%ebp)
80101568:	e8 e3 ec ff ff       	call   80100250 <brelse>
8010156d:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
80101570:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101573:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101576:	01 c2                	add    %eax,%edx
80101578:	8b 45 08             	mov    0x8(%ebp),%eax
8010157b:	83 ec 08             	sub    $0x8,%esp
8010157e:	52                   	push   %edx
8010157f:	50                   	push   %eax
80101580:	e8 c6 fe ff ff       	call   8010144b <bzero>
80101585:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101588:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010158b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010158e:	01 d0                	add    %edx,%eax
80101590:	eb 57                	jmp    801015e9 <balloc+0x14a>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101592:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101596:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010159d:	7f 17                	jg     801015b6 <balloc+0x117>
8010159f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015a5:	01 d0                	add    %edx,%eax
801015a7:	89 c2                	mov    %eax,%edx
801015a9:	a1 60 2a 11 80       	mov    0x80112a60,%eax
801015ae:	39 c2                	cmp    %eax,%edx
801015b0:	0f 82 3a ff ff ff    	jb     801014f0 <balloc+0x51>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801015b6:	83 ec 0c             	sub    $0xc,%esp
801015b9:	ff 75 ec             	pushl  -0x14(%ebp)
801015bc:	e8 8f ec ff ff       	call   80100250 <brelse>
801015c1:	83 c4 10             	add    $0x10,%esp
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801015c4:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801015cb:	8b 15 60 2a 11 80    	mov    0x80112a60,%edx
801015d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015d4:	39 c2                	cmp    %eax,%edx
801015d6:	0f 87 dc fe ff ff    	ja     801014b8 <balloc+0x19>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801015dc:	83 ec 0c             	sub    $0xc,%esp
801015df:	68 c8 89 10 80       	push   $0x801089c8
801015e4:	e8 b7 ef ff ff       	call   801005a0 <panic>
}
801015e9:	c9                   	leave  
801015ea:	c3                   	ret    

801015eb <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015eb:	55                   	push   %ebp
801015ec:	89 e5                	mov    %esp,%ebp
801015ee:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801015f1:	83 ec 08             	sub    $0x8,%esp
801015f4:	68 60 2a 11 80       	push   $0x80112a60
801015f9:	ff 75 08             	pushl  0x8(%ebp)
801015fc:	e8 08 fe ff ff       	call   80101409 <readsb>
80101601:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101604:	8b 45 0c             	mov    0xc(%ebp),%eax
80101607:	c1 e8 0c             	shr    $0xc,%eax
8010160a:	89 c2                	mov    %eax,%edx
8010160c:	a1 78 2a 11 80       	mov    0x80112a78,%eax
80101611:	01 c2                	add    %eax,%edx
80101613:	8b 45 08             	mov    0x8(%ebp),%eax
80101616:	83 ec 08             	sub    $0x8,%esp
80101619:	52                   	push   %edx
8010161a:	50                   	push   %eax
8010161b:	e8 ae eb ff ff       	call   801001ce <bread>
80101620:	83 c4 10             	add    $0x10,%esp
80101623:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101626:	8b 45 0c             	mov    0xc(%ebp),%eax
80101629:	25 ff 0f 00 00       	and    $0xfff,%eax
8010162e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101631:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101634:	99                   	cltd   
80101635:	c1 ea 1d             	shr    $0x1d,%edx
80101638:	01 d0                	add    %edx,%eax
8010163a:	83 e0 07             	and    $0x7,%eax
8010163d:	29 d0                	sub    %edx,%eax
8010163f:	ba 01 00 00 00       	mov    $0x1,%edx
80101644:	89 c1                	mov    %eax,%ecx
80101646:	d3 e2                	shl    %cl,%edx
80101648:	89 d0                	mov    %edx,%eax
8010164a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
8010164d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101650:	8d 50 07             	lea    0x7(%eax),%edx
80101653:	85 c0                	test   %eax,%eax
80101655:	0f 48 c2             	cmovs  %edx,%eax
80101658:	c1 f8 03             	sar    $0x3,%eax
8010165b:	89 c2                	mov    %eax,%edx
8010165d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101660:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101665:	0f b6 c0             	movzbl %al,%eax
80101668:	23 45 ec             	and    -0x14(%ebp),%eax
8010166b:	85 c0                	test   %eax,%eax
8010166d:	75 0d                	jne    8010167c <bfree+0x91>
    panic("freeing free block");
8010166f:	83 ec 0c             	sub    $0xc,%esp
80101672:	68 de 89 10 80       	push   $0x801089de
80101677:	e8 24 ef ff ff       	call   801005a0 <panic>
  bp->data[bi/8] &= ~m;
8010167c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010167f:	8d 50 07             	lea    0x7(%eax),%edx
80101682:	85 c0                	test   %eax,%eax
80101684:	0f 48 c2             	cmovs  %edx,%eax
80101687:	c1 f8 03             	sar    $0x3,%eax
8010168a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010168d:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
80101692:	89 d1                	mov    %edx,%ecx
80101694:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101697:	f7 d2                	not    %edx
80101699:	21 ca                	and    %ecx,%edx
8010169b:	89 d1                	mov    %edx,%ecx
8010169d:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016a0:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
801016a4:	83 ec 0c             	sub    $0xc,%esp
801016a7:	ff 75 f4             	pushl  -0xc(%ebp)
801016aa:	e8 7c 21 00 00       	call   8010382b <log_write>
801016af:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801016b2:	83 ec 0c             	sub    $0xc,%esp
801016b5:	ff 75 f4             	pushl  -0xc(%ebp)
801016b8:	e8 93 eb ff ff       	call   80100250 <brelse>
801016bd:	83 c4 10             	add    $0x10,%esp
}
801016c0:	90                   	nop
801016c1:	c9                   	leave  
801016c2:	c3                   	ret    

801016c3 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801016c3:	55                   	push   %ebp
801016c4:	89 e5                	mov    %esp,%ebp
801016c6:	57                   	push   %edi
801016c7:	56                   	push   %esi
801016c8:	53                   	push   %ebx
801016c9:	83 ec 2c             	sub    $0x2c,%esp
  int i = 0;
801016cc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
801016d3:	83 ec 08             	sub    $0x8,%esp
801016d6:	68 f1 89 10 80       	push   $0x801089f1
801016db:	68 80 2a 11 80       	push   $0x80112a80
801016e0:	e8 e7 39 00 00       	call   801050cc <initlock>
801016e5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
801016e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801016ef:	eb 2d                	jmp    8010171e <iinit+0x5b>
    initsleeplock(&icache.inode[i].lock, "inode");
801016f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016f4:	89 d0                	mov    %edx,%eax
801016f6:	c1 e0 03             	shl    $0x3,%eax
801016f9:	01 d0                	add    %edx,%eax
801016fb:	c1 e0 04             	shl    $0x4,%eax
801016fe:	83 c0 30             	add    $0x30,%eax
80101701:	05 80 2a 11 80       	add    $0x80112a80,%eax
80101706:	83 c0 10             	add    $0x10,%eax
80101709:	83 ec 08             	sub    $0x8,%esp
8010170c:	68 f8 89 10 80       	push   $0x801089f8
80101711:	50                   	push   %eax
80101712:	e8 57 38 00 00       	call   80104f6e <initsleeplock>
80101717:	83 c4 10             	add    $0x10,%esp
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
8010171a:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010171e:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101722:	7e cd                	jle    801016f1 <iinit+0x2e>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
80101724:	83 ec 08             	sub    $0x8,%esp
80101727:	68 60 2a 11 80       	push   $0x80112a60
8010172c:	ff 75 08             	pushl  0x8(%ebp)
8010172f:	e8 d5 fc ff ff       	call   80101409 <readsb>
80101734:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101737:	a1 78 2a 11 80       	mov    0x80112a78,%eax
8010173c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010173f:	8b 3d 74 2a 11 80    	mov    0x80112a74,%edi
80101745:	8b 35 70 2a 11 80    	mov    0x80112a70,%esi
8010174b:	8b 1d 6c 2a 11 80    	mov    0x80112a6c,%ebx
80101751:	8b 0d 68 2a 11 80    	mov    0x80112a68,%ecx
80101757:	8b 15 64 2a 11 80    	mov    0x80112a64,%edx
8010175d:	a1 60 2a 11 80       	mov    0x80112a60,%eax
80101762:	ff 75 d4             	pushl  -0x2c(%ebp)
80101765:	57                   	push   %edi
80101766:	56                   	push   %esi
80101767:	53                   	push   %ebx
80101768:	51                   	push   %ecx
80101769:	52                   	push   %edx
8010176a:	50                   	push   %eax
8010176b:	68 00 8a 10 80       	push   $0x80108a00
80101770:	e8 8b ec ff ff       	call   80100400 <cprintf>
80101775:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101778:	90                   	nop
80101779:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010177c:	5b                   	pop    %ebx
8010177d:	5e                   	pop    %esi
8010177e:	5f                   	pop    %edi
8010177f:	5d                   	pop    %ebp
80101780:	c3                   	ret    

80101781 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101781:	55                   	push   %ebp
80101782:	89 e5                	mov    %esp,%ebp
80101784:	83 ec 28             	sub    $0x28,%esp
80101787:	8b 45 0c             	mov    0xc(%ebp),%eax
8010178a:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010178e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101795:	e9 9e 00 00 00       	jmp    80101838 <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
8010179a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010179d:	c1 e8 03             	shr    $0x3,%eax
801017a0:	89 c2                	mov    %eax,%edx
801017a2:	a1 74 2a 11 80       	mov    0x80112a74,%eax
801017a7:	01 d0                	add    %edx,%eax
801017a9:	83 ec 08             	sub    $0x8,%esp
801017ac:	50                   	push   %eax
801017ad:	ff 75 08             	pushl  0x8(%ebp)
801017b0:	e8 19 ea ff ff       	call   801001ce <bread>
801017b5:	83 c4 10             	add    $0x10,%esp
801017b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801017bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017be:	8d 50 5c             	lea    0x5c(%eax),%edx
801017c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017c4:	83 e0 07             	and    $0x7,%eax
801017c7:	c1 e0 06             	shl    $0x6,%eax
801017ca:	01 d0                	add    %edx,%eax
801017cc:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801017cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017d2:	0f b7 00             	movzwl (%eax),%eax
801017d5:	66 85 c0             	test   %ax,%ax
801017d8:	75 4c                	jne    80101826 <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
801017da:	83 ec 04             	sub    $0x4,%esp
801017dd:	6a 40                	push   $0x40
801017df:	6a 00                	push   $0x0
801017e1:	ff 75 ec             	pushl  -0x14(%ebp)
801017e4:	e8 7f 3b 00 00       	call   80105368 <memset>
801017e9:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801017ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017ef:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801017f3:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801017f6:	83 ec 0c             	sub    $0xc,%esp
801017f9:	ff 75 f0             	pushl  -0x10(%ebp)
801017fc:	e8 2a 20 00 00       	call   8010382b <log_write>
80101801:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
80101804:	83 ec 0c             	sub    $0xc,%esp
80101807:	ff 75 f0             	pushl  -0x10(%ebp)
8010180a:	e8 41 ea ff ff       	call   80100250 <brelse>
8010180f:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
80101812:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101815:	83 ec 08             	sub    $0x8,%esp
80101818:	50                   	push   %eax
80101819:	ff 75 08             	pushl  0x8(%ebp)
8010181c:	e8 f8 00 00 00       	call   80101919 <iget>
80101821:	83 c4 10             	add    $0x10,%esp
80101824:	eb 30                	jmp    80101856 <ialloc+0xd5>
    }
    brelse(bp);
80101826:	83 ec 0c             	sub    $0xc,%esp
80101829:	ff 75 f0             	pushl  -0x10(%ebp)
8010182c:	e8 1f ea ff ff       	call   80100250 <brelse>
80101831:	83 c4 10             	add    $0x10,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101834:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101838:	8b 15 68 2a 11 80    	mov    0x80112a68,%edx
8010183e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101841:	39 c2                	cmp    %eax,%edx
80101843:	0f 87 51 ff ff ff    	ja     8010179a <ialloc+0x19>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101849:	83 ec 0c             	sub    $0xc,%esp
8010184c:	68 53 8a 10 80       	push   $0x80108a53
80101851:	e8 4a ed ff ff       	call   801005a0 <panic>
}
80101856:	c9                   	leave  
80101857:	c3                   	ret    

80101858 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101858:	55                   	push   %ebp
80101859:	89 e5                	mov    %esp,%ebp
8010185b:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010185e:	8b 45 08             	mov    0x8(%ebp),%eax
80101861:	8b 40 04             	mov    0x4(%eax),%eax
80101864:	c1 e8 03             	shr    $0x3,%eax
80101867:	89 c2                	mov    %eax,%edx
80101869:	a1 74 2a 11 80       	mov    0x80112a74,%eax
8010186e:	01 c2                	add    %eax,%edx
80101870:	8b 45 08             	mov    0x8(%ebp),%eax
80101873:	8b 00                	mov    (%eax),%eax
80101875:	83 ec 08             	sub    $0x8,%esp
80101878:	52                   	push   %edx
80101879:	50                   	push   %eax
8010187a:	e8 4f e9 ff ff       	call   801001ce <bread>
8010187f:	83 c4 10             	add    $0x10,%esp
80101882:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101885:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101888:	8d 50 5c             	lea    0x5c(%eax),%edx
8010188b:	8b 45 08             	mov    0x8(%ebp),%eax
8010188e:	8b 40 04             	mov    0x4(%eax),%eax
80101891:	83 e0 07             	and    $0x7,%eax
80101894:	c1 e0 06             	shl    $0x6,%eax
80101897:	01 d0                	add    %edx,%eax
80101899:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
8010189c:	8b 45 08             	mov    0x8(%ebp),%eax
8010189f:	0f b7 50 50          	movzwl 0x50(%eax),%edx
801018a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018a6:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801018a9:	8b 45 08             	mov    0x8(%ebp),%eax
801018ac:	0f b7 50 52          	movzwl 0x52(%eax),%edx
801018b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018b3:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801018b7:	8b 45 08             	mov    0x8(%ebp),%eax
801018ba:	0f b7 50 54          	movzwl 0x54(%eax),%edx
801018be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018c1:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801018c5:	8b 45 08             	mov    0x8(%ebp),%eax
801018c8:	0f b7 50 56          	movzwl 0x56(%eax),%edx
801018cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018cf:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801018d3:	8b 45 08             	mov    0x8(%ebp),%eax
801018d6:	8b 50 58             	mov    0x58(%eax),%edx
801018d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018dc:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018df:	8b 45 08             	mov    0x8(%ebp),%eax
801018e2:	8d 50 5c             	lea    0x5c(%eax),%edx
801018e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018e8:	83 c0 0c             	add    $0xc,%eax
801018eb:	83 ec 04             	sub    $0x4,%esp
801018ee:	6a 34                	push   $0x34
801018f0:	52                   	push   %edx
801018f1:	50                   	push   %eax
801018f2:	e8 30 3b 00 00       	call   80105427 <memmove>
801018f7:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801018fa:	83 ec 0c             	sub    $0xc,%esp
801018fd:	ff 75 f4             	pushl  -0xc(%ebp)
80101900:	e8 26 1f 00 00       	call   8010382b <log_write>
80101905:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	ff 75 f4             	pushl  -0xc(%ebp)
8010190e:	e8 3d e9 ff ff       	call   80100250 <brelse>
80101913:	83 c4 10             	add    $0x10,%esp
}
80101916:	90                   	nop
80101917:	c9                   	leave  
80101918:	c3                   	ret    

80101919 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101919:	55                   	push   %ebp
8010191a:	89 e5                	mov    %esp,%ebp
8010191c:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010191f:	83 ec 0c             	sub    $0xc,%esp
80101922:	68 80 2a 11 80       	push   $0x80112a80
80101927:	e8 c2 37 00 00       	call   801050ee <acquire>
8010192c:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
8010192f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101936:	c7 45 f4 b4 2a 11 80 	movl   $0x80112ab4,-0xc(%ebp)
8010193d:	eb 60                	jmp    8010199f <iget+0x86>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010193f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101942:	8b 40 08             	mov    0x8(%eax),%eax
80101945:	85 c0                	test   %eax,%eax
80101947:	7e 39                	jle    80101982 <iget+0x69>
80101949:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010194c:	8b 00                	mov    (%eax),%eax
8010194e:	3b 45 08             	cmp    0x8(%ebp),%eax
80101951:	75 2f                	jne    80101982 <iget+0x69>
80101953:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101956:	8b 40 04             	mov    0x4(%eax),%eax
80101959:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010195c:	75 24                	jne    80101982 <iget+0x69>
      ip->ref++;
8010195e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101961:	8b 40 08             	mov    0x8(%eax),%eax
80101964:	8d 50 01             	lea    0x1(%eax),%edx
80101967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010196a:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
8010196d:	83 ec 0c             	sub    $0xc,%esp
80101970:	68 80 2a 11 80       	push   $0x80112a80
80101975:	e8 e0 37 00 00       	call   8010515a <release>
8010197a:	83 c4 10             	add    $0x10,%esp
      return ip;
8010197d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101980:	eb 77                	jmp    801019f9 <iget+0xe0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101982:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101986:	75 10                	jne    80101998 <iget+0x7f>
80101988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010198b:	8b 40 08             	mov    0x8(%eax),%eax
8010198e:	85 c0                	test   %eax,%eax
80101990:	75 06                	jne    80101998 <iget+0x7f>
      empty = ip;
80101992:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101995:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101998:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
8010199f:	81 7d f4 d4 46 11 80 	cmpl   $0x801146d4,-0xc(%ebp)
801019a6:	72 97                	jb     8010193f <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801019a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801019ac:	75 0d                	jne    801019bb <iget+0xa2>
    panic("iget: no inodes");
801019ae:	83 ec 0c             	sub    $0xc,%esp
801019b1:	68 65 8a 10 80       	push   $0x80108a65
801019b6:	e8 e5 eb ff ff       	call   801005a0 <panic>

  ip = empty;
801019bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801019c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019c4:	8b 55 08             	mov    0x8(%ebp),%edx
801019c7:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801019c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019cc:	8b 55 0c             	mov    0xc(%ebp),%edx
801019cf:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801019d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019d5:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
801019dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019df:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
801019e6:	83 ec 0c             	sub    $0xc,%esp
801019e9:	68 80 2a 11 80       	push   $0x80112a80
801019ee:	e8 67 37 00 00       	call   8010515a <release>
801019f3:	83 c4 10             	add    $0x10,%esp

  return ip;
801019f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801019f9:	c9                   	leave  
801019fa:	c3                   	ret    

801019fb <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801019fb:	55                   	push   %ebp
801019fc:	89 e5                	mov    %esp,%ebp
801019fe:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101a01:	83 ec 0c             	sub    $0xc,%esp
80101a04:	68 80 2a 11 80       	push   $0x80112a80
80101a09:	e8 e0 36 00 00       	call   801050ee <acquire>
80101a0e:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101a11:	8b 45 08             	mov    0x8(%ebp),%eax
80101a14:	8b 40 08             	mov    0x8(%eax),%eax
80101a17:	8d 50 01             	lea    0x1(%eax),%edx
80101a1a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1d:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101a20:	83 ec 0c             	sub    $0xc,%esp
80101a23:	68 80 2a 11 80       	push   $0x80112a80
80101a28:	e8 2d 37 00 00       	call   8010515a <release>
80101a2d:	83 c4 10             	add    $0x10,%esp
  return ip;
80101a30:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101a33:	c9                   	leave  
80101a34:	c3                   	ret    

80101a35 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101a35:	55                   	push   %ebp
80101a36:	89 e5                	mov    %esp,%ebp
80101a38:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101a3b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a3f:	74 0a                	je     80101a4b <ilock+0x16>
80101a41:	8b 45 08             	mov    0x8(%ebp),%eax
80101a44:	8b 40 08             	mov    0x8(%eax),%eax
80101a47:	85 c0                	test   %eax,%eax
80101a49:	7f 0d                	jg     80101a58 <ilock+0x23>
    panic("ilock");
80101a4b:	83 ec 0c             	sub    $0xc,%esp
80101a4e:	68 75 8a 10 80       	push   $0x80108a75
80101a53:	e8 48 eb ff ff       	call   801005a0 <panic>

  acquiresleep(&ip->lock);
80101a58:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5b:	83 c0 0c             	add    $0xc,%eax
80101a5e:	83 ec 0c             	sub    $0xc,%esp
80101a61:	50                   	push   %eax
80101a62:	e8 43 35 00 00       	call   80104faa <acquiresleep>
80101a67:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101a6a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6d:	8b 40 4c             	mov    0x4c(%eax),%eax
80101a70:	83 e0 02             	and    $0x2,%eax
80101a73:	85 c0                	test   %eax,%eax
80101a75:	0f 85 d4 00 00 00    	jne    80101b4f <ilock+0x11a>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7e:	8b 40 04             	mov    0x4(%eax),%eax
80101a81:	c1 e8 03             	shr    $0x3,%eax
80101a84:	89 c2                	mov    %eax,%edx
80101a86:	a1 74 2a 11 80       	mov    0x80112a74,%eax
80101a8b:	01 c2                	add    %eax,%edx
80101a8d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a90:	8b 00                	mov    (%eax),%eax
80101a92:	83 ec 08             	sub    $0x8,%esp
80101a95:	52                   	push   %edx
80101a96:	50                   	push   %eax
80101a97:	e8 32 e7 ff ff       	call   801001ce <bread>
80101a9c:	83 c4 10             	add    $0x10,%esp
80101a9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101aa5:	8d 50 5c             	lea    0x5c(%eax),%edx
80101aa8:	8b 45 08             	mov    0x8(%ebp),%eax
80101aab:	8b 40 04             	mov    0x4(%eax),%eax
80101aae:	83 e0 07             	and    $0x7,%eax
80101ab1:	c1 e0 06             	shl    $0x6,%eax
80101ab4:	01 d0                	add    %edx,%eax
80101ab6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101abc:	0f b7 10             	movzwl (%eax),%edx
80101abf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac2:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
80101ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ac9:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101acd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad0:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101ad4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ad7:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101adb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ade:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101ae2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ae5:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aec:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101af3:	8b 50 08             	mov    0x8(%eax),%edx
80101af6:	8b 45 08             	mov    0x8(%ebp),%eax
80101af9:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101afc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aff:	8d 50 0c             	lea    0xc(%eax),%edx
80101b02:	8b 45 08             	mov    0x8(%ebp),%eax
80101b05:	83 c0 5c             	add    $0x5c,%eax
80101b08:	83 ec 04             	sub    $0x4,%esp
80101b0b:	6a 34                	push   $0x34
80101b0d:	52                   	push   %edx
80101b0e:	50                   	push   %eax
80101b0f:	e8 13 39 00 00       	call   80105427 <memmove>
80101b14:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101b17:	83 ec 0c             	sub    $0xc,%esp
80101b1a:	ff 75 f4             	pushl  -0xc(%ebp)
80101b1d:	e8 2e e7 ff ff       	call   80100250 <brelse>
80101b22:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101b25:	8b 45 08             	mov    0x8(%ebp),%eax
80101b28:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b2b:	83 c8 02             	or     $0x2,%eax
80101b2e:	89 c2                	mov    %eax,%edx
80101b30:	8b 45 08             	mov    0x8(%ebp),%eax
80101b33:	89 50 4c             	mov    %edx,0x4c(%eax)
    if(ip->type == 0)
80101b36:	8b 45 08             	mov    0x8(%ebp),%eax
80101b39:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101b3d:	66 85 c0             	test   %ax,%ax
80101b40:	75 0d                	jne    80101b4f <ilock+0x11a>
      panic("ilock: no type");
80101b42:	83 ec 0c             	sub    $0xc,%esp
80101b45:	68 7b 8a 10 80       	push   $0x80108a7b
80101b4a:	e8 51 ea ff ff       	call   801005a0 <panic>
  }
}
80101b4f:	90                   	nop
80101b50:	c9                   	leave  
80101b51:	c3                   	ret    

80101b52 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101b52:	55                   	push   %ebp
80101b53:	89 e5                	mov    %esp,%ebp
80101b55:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b58:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101b5c:	74 20                	je     80101b7e <iunlock+0x2c>
80101b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b61:	83 c0 0c             	add    $0xc,%eax
80101b64:	83 ec 0c             	sub    $0xc,%esp
80101b67:	50                   	push   %eax
80101b68:	e8 f0 34 00 00       	call   8010505d <holdingsleep>
80101b6d:	83 c4 10             	add    $0x10,%esp
80101b70:	85 c0                	test   %eax,%eax
80101b72:	74 0a                	je     80101b7e <iunlock+0x2c>
80101b74:	8b 45 08             	mov    0x8(%ebp),%eax
80101b77:	8b 40 08             	mov    0x8(%eax),%eax
80101b7a:	85 c0                	test   %eax,%eax
80101b7c:	7f 0d                	jg     80101b8b <iunlock+0x39>
    panic("iunlock");
80101b7e:	83 ec 0c             	sub    $0xc,%esp
80101b81:	68 8a 8a 10 80       	push   $0x80108a8a
80101b86:	e8 15 ea ff ff       	call   801005a0 <panic>

  releasesleep(&ip->lock);
80101b8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101b8e:	83 c0 0c             	add    $0xc,%eax
80101b91:	83 ec 0c             	sub    $0xc,%esp
80101b94:	50                   	push   %eax
80101b95:	e8 75 34 00 00       	call   8010500f <releasesleep>
80101b9a:	83 c4 10             	add    $0x10,%esp
}
80101b9d:	90                   	nop
80101b9e:	c9                   	leave  
80101b9f:	c3                   	ret    

80101ba0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101ba6:	83 ec 0c             	sub    $0xc,%esp
80101ba9:	68 80 2a 11 80       	push   $0x80112a80
80101bae:	e8 3b 35 00 00       	call   801050ee <acquire>
80101bb3:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101bb6:	8b 45 08             	mov    0x8(%ebp),%eax
80101bb9:	8b 40 08             	mov    0x8(%eax),%eax
80101bbc:	83 f8 01             	cmp    $0x1,%eax
80101bbf:	75 68                	jne    80101c29 <iput+0x89>
80101bc1:	8b 45 08             	mov    0x8(%ebp),%eax
80101bc4:	8b 40 4c             	mov    0x4c(%eax),%eax
80101bc7:	83 e0 02             	and    $0x2,%eax
80101bca:	85 c0                	test   %eax,%eax
80101bcc:	74 5b                	je     80101c29 <iput+0x89>
80101bce:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd1:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101bd5:	66 85 c0             	test   %ax,%ax
80101bd8:	75 4f                	jne    80101c29 <iput+0x89>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
80101bda:	83 ec 0c             	sub    $0xc,%esp
80101bdd:	68 80 2a 11 80       	push   $0x80112a80
80101be2:	e8 73 35 00 00       	call   8010515a <release>
80101be7:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101bea:	83 ec 0c             	sub    $0xc,%esp
80101bed:	ff 75 08             	pushl  0x8(%ebp)
80101bf0:	e8 a0 01 00 00       	call   80101d95 <itrunc>
80101bf5:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101bf8:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfb:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
    iupdate(ip);
80101c01:	83 ec 0c             	sub    $0xc,%esp
80101c04:	ff 75 08             	pushl  0x8(%ebp)
80101c07:	e8 4c fc ff ff       	call   80101858 <iupdate>
80101c0c:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101c0f:	83 ec 0c             	sub    $0xc,%esp
80101c12:	68 80 2a 11 80       	push   $0x80112a80
80101c17:	e8 d2 34 00 00       	call   801050ee <acquire>
80101c1c:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101c1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c22:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }
  ip->ref--;
80101c29:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2c:	8b 40 08             	mov    0x8(%eax),%eax
80101c2f:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c32:	8b 45 08             	mov    0x8(%ebp),%eax
80101c35:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c38:	83 ec 0c             	sub    $0xc,%esp
80101c3b:	68 80 2a 11 80       	push   $0x80112a80
80101c40:	e8 15 35 00 00       	call   8010515a <release>
80101c45:	83 c4 10             	add    $0x10,%esp
}
80101c48:	90                   	nop
80101c49:	c9                   	leave  
80101c4a:	c3                   	ret    

80101c4b <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c4b:	55                   	push   %ebp
80101c4c:	89 e5                	mov    %esp,%ebp
80101c4e:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c51:	83 ec 0c             	sub    $0xc,%esp
80101c54:	ff 75 08             	pushl  0x8(%ebp)
80101c57:	e8 f6 fe ff ff       	call   80101b52 <iunlock>
80101c5c:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c5f:	83 ec 0c             	sub    $0xc,%esp
80101c62:	ff 75 08             	pushl  0x8(%ebp)
80101c65:	e8 36 ff ff ff       	call   80101ba0 <iput>
80101c6a:	83 c4 10             	add    $0x10,%esp
}
80101c6d:	90                   	nop
80101c6e:	c9                   	leave  
80101c6f:	c3                   	ret    

80101c70 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	53                   	push   %ebx
80101c74:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c77:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c7b:	77 42                	ja     80101cbf <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101c7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c80:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c83:	83 c2 14             	add    $0x14,%edx
80101c86:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c8d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c91:	75 24                	jne    80101cb7 <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c93:	8b 45 08             	mov    0x8(%ebp),%eax
80101c96:	8b 00                	mov    (%eax),%eax
80101c98:	83 ec 0c             	sub    $0xc,%esp
80101c9b:	50                   	push   %eax
80101c9c:	e8 fe f7 ff ff       	call   8010149f <balloc>
80101ca1:	83 c4 10             	add    $0x10,%esp
80101ca4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80101caa:	8b 55 0c             	mov    0xc(%ebp),%edx
80101cad:	8d 4a 14             	lea    0x14(%edx),%ecx
80101cb0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cb3:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cba:	e9 d1 00 00 00       	jmp    80101d90 <bmap+0x120>
  }
  bn -= NDIRECT;
80101cbf:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101cc3:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101cc7:	0f 87 b6 00 00 00    	ja     80101d83 <bmap+0x113>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101ccd:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101cd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cd9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cdd:	75 20                	jne    80101cff <bmap+0x8f>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101cdf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce2:	8b 00                	mov    (%eax),%eax
80101ce4:	83 ec 0c             	sub    $0xc,%esp
80101ce7:	50                   	push   %eax
80101ce8:	e8 b2 f7 ff ff       	call   8010149f <balloc>
80101ced:	83 c4 10             	add    $0x10,%esp
80101cf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cf3:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cf9:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101cff:	8b 45 08             	mov    0x8(%ebp),%eax
80101d02:	8b 00                	mov    (%eax),%eax
80101d04:	83 ec 08             	sub    $0x8,%esp
80101d07:	ff 75 f4             	pushl  -0xc(%ebp)
80101d0a:	50                   	push   %eax
80101d0b:	e8 be e4 ff ff       	call   801001ce <bread>
80101d10:	83 c4 10             	add    $0x10,%esp
80101d13:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101d16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d19:	83 c0 5c             	add    $0x5c,%eax
80101d1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d29:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d2c:	01 d0                	add    %edx,%eax
80101d2e:	8b 00                	mov    (%eax),%eax
80101d30:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d33:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d37:	75 37                	jne    80101d70 <bmap+0x100>
      a[bn] = addr = balloc(ip->dev);
80101d39:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d43:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d46:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101d49:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4c:	8b 00                	mov    (%eax),%eax
80101d4e:	83 ec 0c             	sub    $0xc,%esp
80101d51:	50                   	push   %eax
80101d52:	e8 48 f7 ff ff       	call   8010149f <balloc>
80101d57:	83 c4 10             	add    $0x10,%esp
80101d5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d60:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101d62:	83 ec 0c             	sub    $0xc,%esp
80101d65:	ff 75 f0             	pushl  -0x10(%ebp)
80101d68:	e8 be 1a 00 00       	call   8010382b <log_write>
80101d6d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d70:	83 ec 0c             	sub    $0xc,%esp
80101d73:	ff 75 f0             	pushl  -0x10(%ebp)
80101d76:	e8 d5 e4 ff ff       	call   80100250 <brelse>
80101d7b:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d81:	eb 0d                	jmp    80101d90 <bmap+0x120>
  }

  panic("bmap: out of range");
80101d83:	83 ec 0c             	sub    $0xc,%esp
80101d86:	68 92 8a 10 80       	push   $0x80108a92
80101d8b:	e8 10 e8 ff ff       	call   801005a0 <panic>
}
80101d90:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d93:	c9                   	leave  
80101d94:	c3                   	ret    

80101d95 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d95:	55                   	push   %ebp
80101d96:	89 e5                	mov    %esp,%ebp
80101d98:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101da2:	eb 45                	jmp    80101de9 <itrunc+0x54>
    if(ip->addrs[i]){
80101da4:	8b 45 08             	mov    0x8(%ebp),%eax
80101da7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101daa:	83 c2 14             	add    $0x14,%edx
80101dad:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101db1:	85 c0                	test   %eax,%eax
80101db3:	74 30                	je     80101de5 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101db5:	8b 45 08             	mov    0x8(%ebp),%eax
80101db8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101dbb:	83 c2 14             	add    $0x14,%edx
80101dbe:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101dc2:	8b 55 08             	mov    0x8(%ebp),%edx
80101dc5:	8b 12                	mov    (%edx),%edx
80101dc7:	83 ec 08             	sub    $0x8,%esp
80101dca:	50                   	push   %eax
80101dcb:	52                   	push   %edx
80101dcc:	e8 1a f8 ff ff       	call   801015eb <bfree>
80101dd1:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101dd4:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101dda:	83 c2 14             	add    $0x14,%edx
80101ddd:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101de4:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101de5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101de9:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101ded:	7e b5                	jle    80101da4 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
80101def:	8b 45 08             	mov    0x8(%ebp),%eax
80101df2:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101df8:	85 c0                	test   %eax,%eax
80101dfa:	0f 84 aa 00 00 00    	je     80101eaa <itrunc+0x115>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101e00:	8b 45 08             	mov    0x8(%ebp),%eax
80101e03:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101e09:	8b 45 08             	mov    0x8(%ebp),%eax
80101e0c:	8b 00                	mov    (%eax),%eax
80101e0e:	83 ec 08             	sub    $0x8,%esp
80101e11:	52                   	push   %edx
80101e12:	50                   	push   %eax
80101e13:	e8 b6 e3 ff ff       	call   801001ce <bread>
80101e18:	83 c4 10             	add    $0x10,%esp
80101e1b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101e1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e21:	83 c0 5c             	add    $0x5c,%eax
80101e24:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e27:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101e2e:	eb 3c                	jmp    80101e6c <itrunc+0xd7>
      if(a[j])
80101e30:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e3d:	01 d0                	add    %edx,%eax
80101e3f:	8b 00                	mov    (%eax),%eax
80101e41:	85 c0                	test   %eax,%eax
80101e43:	74 23                	je     80101e68 <itrunc+0xd3>
        bfree(ip->dev, a[j]);
80101e45:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e48:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e52:	01 d0                	add    %edx,%eax
80101e54:	8b 00                	mov    (%eax),%eax
80101e56:	8b 55 08             	mov    0x8(%ebp),%edx
80101e59:	8b 12                	mov    (%edx),%edx
80101e5b:	83 ec 08             	sub    $0x8,%esp
80101e5e:	50                   	push   %eax
80101e5f:	52                   	push   %edx
80101e60:	e8 86 f7 ff ff       	call   801015eb <bfree>
80101e65:	83 c4 10             	add    $0x10,%esp
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101e68:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e6f:	83 f8 7f             	cmp    $0x7f,%eax
80101e72:	76 bc                	jbe    80101e30 <itrunc+0x9b>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101e74:	83 ec 0c             	sub    $0xc,%esp
80101e77:	ff 75 ec             	pushl  -0x14(%ebp)
80101e7a:	e8 d1 e3 ff ff       	call   80100250 <brelse>
80101e7f:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e82:	8b 45 08             	mov    0x8(%ebp),%eax
80101e85:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101e8b:	8b 55 08             	mov    0x8(%ebp),%edx
80101e8e:	8b 12                	mov    (%edx),%edx
80101e90:	83 ec 08             	sub    $0x8,%esp
80101e93:	50                   	push   %eax
80101e94:	52                   	push   %edx
80101e95:	e8 51 f7 ff ff       	call   801015eb <bfree>
80101e9a:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea0:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101ea7:	00 00 00 
  }

  ip->size = 0;
80101eaa:	8b 45 08             	mov    0x8(%ebp),%eax
80101ead:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101eb4:	83 ec 0c             	sub    $0xc,%esp
80101eb7:	ff 75 08             	pushl  0x8(%ebp)
80101eba:	e8 99 f9 ff ff       	call   80101858 <iupdate>
80101ebf:	83 c4 10             	add    $0x10,%esp
}
80101ec2:	90                   	nop
80101ec3:	c9                   	leave  
80101ec4:	c3                   	ret    

80101ec5 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101ec5:	55                   	push   %ebp
80101ec6:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ecb:	8b 00                	mov    (%eax),%eax
80101ecd:	89 c2                	mov    %eax,%edx
80101ecf:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ed2:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101ed5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed8:	8b 50 04             	mov    0x4(%eax),%edx
80101edb:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ede:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee4:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101ee8:	8b 45 0c             	mov    0xc(%ebp),%eax
80101eeb:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101eee:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef1:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101ef5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ef8:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101efc:	8b 45 08             	mov    0x8(%ebp),%eax
80101eff:	8b 50 58             	mov    0x58(%eax),%edx
80101f02:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f05:	89 50 10             	mov    %edx,0x10(%eax)
}
80101f08:	90                   	nop
80101f09:	5d                   	pop    %ebp
80101f0a:	c3                   	ret    

80101f0b <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101f0b:	55                   	push   %ebp
80101f0c:	89 e5                	mov    %esp,%ebp
80101f0e:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f11:	8b 45 08             	mov    0x8(%ebp),%eax
80101f14:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101f18:	66 83 f8 03          	cmp    $0x3,%ax
80101f1c:	75 5c                	jne    80101f7a <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101f1e:	8b 45 08             	mov    0x8(%ebp),%eax
80101f21:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f25:	66 85 c0             	test   %ax,%ax
80101f28:	78 20                	js     80101f4a <readi+0x3f>
80101f2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2d:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f31:	66 83 f8 09          	cmp    $0x9,%ax
80101f35:	7f 13                	jg     80101f4a <readi+0x3f>
80101f37:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3a:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f3e:	98                   	cwtl   
80101f3f:	8b 04 c5 00 2a 11 80 	mov    -0x7feed600(,%eax,8),%eax
80101f46:	85 c0                	test   %eax,%eax
80101f48:	75 0a                	jne    80101f54 <readi+0x49>
      return -1;
80101f4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f4f:	e9 0c 01 00 00       	jmp    80102060 <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101f54:	8b 45 08             	mov    0x8(%ebp),%eax
80101f57:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f5b:	98                   	cwtl   
80101f5c:	8b 04 c5 00 2a 11 80 	mov    -0x7feed600(,%eax,8),%eax
80101f63:	8b 55 14             	mov    0x14(%ebp),%edx
80101f66:	83 ec 04             	sub    $0x4,%esp
80101f69:	52                   	push   %edx
80101f6a:	ff 75 0c             	pushl  0xc(%ebp)
80101f6d:	ff 75 08             	pushl  0x8(%ebp)
80101f70:	ff d0                	call   *%eax
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	e9 e6 00 00 00       	jmp    80102060 <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80101f7a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f7d:	8b 40 58             	mov    0x58(%eax),%eax
80101f80:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f83:	72 0d                	jb     80101f92 <readi+0x87>
80101f85:	8b 55 10             	mov    0x10(%ebp),%edx
80101f88:	8b 45 14             	mov    0x14(%ebp),%eax
80101f8b:	01 d0                	add    %edx,%eax
80101f8d:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f90:	73 0a                	jae    80101f9c <readi+0x91>
    return -1;
80101f92:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f97:	e9 c4 00 00 00       	jmp    80102060 <readi+0x155>
  if(off + n > ip->size)
80101f9c:	8b 55 10             	mov    0x10(%ebp),%edx
80101f9f:	8b 45 14             	mov    0x14(%ebp),%eax
80101fa2:	01 c2                	add    %eax,%edx
80101fa4:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa7:	8b 40 58             	mov    0x58(%eax),%eax
80101faa:	39 c2                	cmp    %eax,%edx
80101fac:	76 0c                	jbe    80101fba <readi+0xaf>
    n = ip->size - off;
80101fae:	8b 45 08             	mov    0x8(%ebp),%eax
80101fb1:	8b 40 58             	mov    0x58(%eax),%eax
80101fb4:	2b 45 10             	sub    0x10(%ebp),%eax
80101fb7:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101fc1:	e9 8b 00 00 00       	jmp    80102051 <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fc6:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc9:	c1 e8 09             	shr    $0x9,%eax
80101fcc:	83 ec 08             	sub    $0x8,%esp
80101fcf:	50                   	push   %eax
80101fd0:	ff 75 08             	pushl  0x8(%ebp)
80101fd3:	e8 98 fc ff ff       	call   80101c70 <bmap>
80101fd8:	83 c4 10             	add    $0x10,%esp
80101fdb:	89 c2                	mov    %eax,%edx
80101fdd:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe0:	8b 00                	mov    (%eax),%eax
80101fe2:	83 ec 08             	sub    $0x8,%esp
80101fe5:	52                   	push   %edx
80101fe6:	50                   	push   %eax
80101fe7:	e8 e2 e1 ff ff       	call   801001ce <bread>
80101fec:	83 c4 10             	add    $0x10,%esp
80101fef:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ff2:	8b 45 10             	mov    0x10(%ebp),%eax
80101ff5:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ffa:	ba 00 02 00 00       	mov    $0x200,%edx
80101fff:	29 c2                	sub    %eax,%edx
80102001:	8b 45 14             	mov    0x14(%ebp),%eax
80102004:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102007:	39 c2                	cmp    %eax,%edx
80102009:	0f 46 c2             	cmovbe %edx,%eax
8010200c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
8010200f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102012:	8d 50 5c             	lea    0x5c(%eax),%edx
80102015:	8b 45 10             	mov    0x10(%ebp),%eax
80102018:	25 ff 01 00 00       	and    $0x1ff,%eax
8010201d:	01 d0                	add    %edx,%eax
8010201f:	83 ec 04             	sub    $0x4,%esp
80102022:	ff 75 ec             	pushl  -0x14(%ebp)
80102025:	50                   	push   %eax
80102026:	ff 75 0c             	pushl  0xc(%ebp)
80102029:	e8 f9 33 00 00       	call   80105427 <memmove>
8010202e:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102031:	83 ec 0c             	sub    $0xc,%esp
80102034:	ff 75 f0             	pushl  -0x10(%ebp)
80102037:	e8 14 e2 ff ff       	call   80100250 <brelse>
8010203c:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010203f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102042:	01 45 f4             	add    %eax,-0xc(%ebp)
80102045:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102048:	01 45 10             	add    %eax,0x10(%ebp)
8010204b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010204e:	01 45 0c             	add    %eax,0xc(%ebp)
80102051:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102054:	3b 45 14             	cmp    0x14(%ebp),%eax
80102057:	0f 82 69 ff ff ff    	jb     80101fc6 <readi+0xbb>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
8010205d:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102060:	c9                   	leave  
80102061:	c3                   	ret    

80102062 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102062:	55                   	push   %ebp
80102063:	89 e5                	mov    %esp,%ebp
80102065:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102068:	8b 45 08             	mov    0x8(%ebp),%eax
8010206b:	0f b7 40 50          	movzwl 0x50(%eax),%eax
8010206f:	66 83 f8 03          	cmp    $0x3,%ax
80102073:	75 5c                	jne    801020d1 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102075:	8b 45 08             	mov    0x8(%ebp),%eax
80102078:	0f b7 40 52          	movzwl 0x52(%eax),%eax
8010207c:	66 85 c0             	test   %ax,%ax
8010207f:	78 20                	js     801020a1 <writei+0x3f>
80102081:	8b 45 08             	mov    0x8(%ebp),%eax
80102084:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102088:	66 83 f8 09          	cmp    $0x9,%ax
8010208c:	7f 13                	jg     801020a1 <writei+0x3f>
8010208e:	8b 45 08             	mov    0x8(%ebp),%eax
80102091:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102095:	98                   	cwtl   
80102096:	8b 04 c5 04 2a 11 80 	mov    -0x7feed5fc(,%eax,8),%eax
8010209d:	85 c0                	test   %eax,%eax
8010209f:	75 0a                	jne    801020ab <writei+0x49>
      return -1;
801020a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020a6:	e9 3d 01 00 00       	jmp    801021e8 <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
801020ab:	8b 45 08             	mov    0x8(%ebp),%eax
801020ae:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801020b2:	98                   	cwtl   
801020b3:	8b 04 c5 04 2a 11 80 	mov    -0x7feed5fc(,%eax,8),%eax
801020ba:	8b 55 14             	mov    0x14(%ebp),%edx
801020bd:	83 ec 04             	sub    $0x4,%esp
801020c0:	52                   	push   %edx
801020c1:	ff 75 0c             	pushl  0xc(%ebp)
801020c4:	ff 75 08             	pushl  0x8(%ebp)
801020c7:	ff d0                	call   *%eax
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	e9 17 01 00 00       	jmp    801021e8 <writei+0x186>
  }

  if(off > ip->size || off + n < off)
801020d1:	8b 45 08             	mov    0x8(%ebp),%eax
801020d4:	8b 40 58             	mov    0x58(%eax),%eax
801020d7:	3b 45 10             	cmp    0x10(%ebp),%eax
801020da:	72 0d                	jb     801020e9 <writei+0x87>
801020dc:	8b 55 10             	mov    0x10(%ebp),%edx
801020df:	8b 45 14             	mov    0x14(%ebp),%eax
801020e2:	01 d0                	add    %edx,%eax
801020e4:	3b 45 10             	cmp    0x10(%ebp),%eax
801020e7:	73 0a                	jae    801020f3 <writei+0x91>
    return -1;
801020e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020ee:	e9 f5 00 00 00       	jmp    801021e8 <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
801020f3:	8b 55 10             	mov    0x10(%ebp),%edx
801020f6:	8b 45 14             	mov    0x14(%ebp),%eax
801020f9:	01 d0                	add    %edx,%eax
801020fb:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102100:	76 0a                	jbe    8010210c <writei+0xaa>
    return -1;
80102102:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102107:	e9 dc 00 00 00       	jmp    801021e8 <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010210c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102113:	e9 99 00 00 00       	jmp    801021b1 <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102118:	8b 45 10             	mov    0x10(%ebp),%eax
8010211b:	c1 e8 09             	shr    $0x9,%eax
8010211e:	83 ec 08             	sub    $0x8,%esp
80102121:	50                   	push   %eax
80102122:	ff 75 08             	pushl  0x8(%ebp)
80102125:	e8 46 fb ff ff       	call   80101c70 <bmap>
8010212a:	83 c4 10             	add    $0x10,%esp
8010212d:	89 c2                	mov    %eax,%edx
8010212f:	8b 45 08             	mov    0x8(%ebp),%eax
80102132:	8b 00                	mov    (%eax),%eax
80102134:	83 ec 08             	sub    $0x8,%esp
80102137:	52                   	push   %edx
80102138:	50                   	push   %eax
80102139:	e8 90 e0 ff ff       	call   801001ce <bread>
8010213e:	83 c4 10             	add    $0x10,%esp
80102141:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102144:	8b 45 10             	mov    0x10(%ebp),%eax
80102147:	25 ff 01 00 00       	and    $0x1ff,%eax
8010214c:	ba 00 02 00 00       	mov    $0x200,%edx
80102151:	29 c2                	sub    %eax,%edx
80102153:	8b 45 14             	mov    0x14(%ebp),%eax
80102156:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102159:	39 c2                	cmp    %eax,%edx
8010215b:	0f 46 c2             	cmovbe %edx,%eax
8010215e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102161:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102164:	8d 50 5c             	lea    0x5c(%eax),%edx
80102167:	8b 45 10             	mov    0x10(%ebp),%eax
8010216a:	25 ff 01 00 00       	and    $0x1ff,%eax
8010216f:	01 d0                	add    %edx,%eax
80102171:	83 ec 04             	sub    $0x4,%esp
80102174:	ff 75 ec             	pushl  -0x14(%ebp)
80102177:	ff 75 0c             	pushl  0xc(%ebp)
8010217a:	50                   	push   %eax
8010217b:	e8 a7 32 00 00       	call   80105427 <memmove>
80102180:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
80102183:	83 ec 0c             	sub    $0xc,%esp
80102186:	ff 75 f0             	pushl  -0x10(%ebp)
80102189:	e8 9d 16 00 00       	call   8010382b <log_write>
8010218e:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102191:	83 ec 0c             	sub    $0xc,%esp
80102194:	ff 75 f0             	pushl  -0x10(%ebp)
80102197:	e8 b4 e0 ff ff       	call   80100250 <brelse>
8010219c:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010219f:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021a2:	01 45 f4             	add    %eax,-0xc(%ebp)
801021a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021a8:	01 45 10             	add    %eax,0x10(%ebp)
801021ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021ae:	01 45 0c             	add    %eax,0xc(%ebp)
801021b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021b4:	3b 45 14             	cmp    0x14(%ebp),%eax
801021b7:	0f 82 5b ff ff ff    	jb     80102118 <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
801021bd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801021c1:	74 22                	je     801021e5 <writei+0x183>
801021c3:	8b 45 08             	mov    0x8(%ebp),%eax
801021c6:	8b 40 58             	mov    0x58(%eax),%eax
801021c9:	3b 45 10             	cmp    0x10(%ebp),%eax
801021cc:	73 17                	jae    801021e5 <writei+0x183>
    ip->size = off;
801021ce:	8b 45 08             	mov    0x8(%ebp),%eax
801021d1:	8b 55 10             	mov    0x10(%ebp),%edx
801021d4:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
801021d7:	83 ec 0c             	sub    $0xc,%esp
801021da:	ff 75 08             	pushl  0x8(%ebp)
801021dd:	e8 76 f6 ff ff       	call   80101858 <iupdate>
801021e2:	83 c4 10             	add    $0x10,%esp
  }
  return n;
801021e5:	8b 45 14             	mov    0x14(%ebp),%eax
}
801021e8:	c9                   	leave  
801021e9:	c3                   	ret    

801021ea <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801021ea:	55                   	push   %ebp
801021eb:	89 e5                	mov    %esp,%ebp
801021ed:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
801021f0:	83 ec 04             	sub    $0x4,%esp
801021f3:	6a 0e                	push   $0xe
801021f5:	ff 75 0c             	pushl  0xc(%ebp)
801021f8:	ff 75 08             	pushl  0x8(%ebp)
801021fb:	e8 bd 32 00 00       	call   801054bd <strncmp>
80102200:	83 c4 10             	add    $0x10,%esp
}
80102203:	c9                   	leave  
80102204:	c3                   	ret    

80102205 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102205:	55                   	push   %ebp
80102206:	89 e5                	mov    %esp,%ebp
80102208:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010220b:	8b 45 08             	mov    0x8(%ebp),%eax
8010220e:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102212:	66 83 f8 01          	cmp    $0x1,%ax
80102216:	74 0d                	je     80102225 <dirlookup+0x20>
    panic("dirlookup not DIR");
80102218:	83 ec 0c             	sub    $0xc,%esp
8010221b:	68 a5 8a 10 80       	push   $0x80108aa5
80102220:	e8 7b e3 ff ff       	call   801005a0 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102225:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010222c:	eb 7b                	jmp    801022a9 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010222e:	6a 10                	push   $0x10
80102230:	ff 75 f4             	pushl  -0xc(%ebp)
80102233:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102236:	50                   	push   %eax
80102237:	ff 75 08             	pushl  0x8(%ebp)
8010223a:	e8 cc fc ff ff       	call   80101f0b <readi>
8010223f:	83 c4 10             	add    $0x10,%esp
80102242:	83 f8 10             	cmp    $0x10,%eax
80102245:	74 0d                	je     80102254 <dirlookup+0x4f>
      panic("dirlink read");
80102247:	83 ec 0c             	sub    $0xc,%esp
8010224a:	68 b7 8a 10 80       	push   $0x80108ab7
8010224f:	e8 4c e3 ff ff       	call   801005a0 <panic>
    if(de.inum == 0)
80102254:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102258:	66 85 c0             	test   %ax,%ax
8010225b:	74 47                	je     801022a4 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
8010225d:	83 ec 08             	sub    $0x8,%esp
80102260:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102263:	83 c0 02             	add    $0x2,%eax
80102266:	50                   	push   %eax
80102267:	ff 75 0c             	pushl  0xc(%ebp)
8010226a:	e8 7b ff ff ff       	call   801021ea <namecmp>
8010226f:	83 c4 10             	add    $0x10,%esp
80102272:	85 c0                	test   %eax,%eax
80102274:	75 2f                	jne    801022a5 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
80102276:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010227a:	74 08                	je     80102284 <dirlookup+0x7f>
        *poff = off;
8010227c:	8b 45 10             	mov    0x10(%ebp),%eax
8010227f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102282:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102284:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102288:	0f b7 c0             	movzwl %ax,%eax
8010228b:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
8010228e:	8b 45 08             	mov    0x8(%ebp),%eax
80102291:	8b 00                	mov    (%eax),%eax
80102293:	83 ec 08             	sub    $0x8,%esp
80102296:	ff 75 f0             	pushl  -0x10(%ebp)
80102299:	50                   	push   %eax
8010229a:	e8 7a f6 ff ff       	call   80101919 <iget>
8010229f:	83 c4 10             	add    $0x10,%esp
801022a2:	eb 19                	jmp    801022bd <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
801022a4:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801022a5:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801022a9:	8b 45 08             	mov    0x8(%ebp),%eax
801022ac:	8b 40 58             	mov    0x58(%eax),%eax
801022af:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801022b2:	0f 87 76 ff ff ff    	ja     8010222e <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
801022b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022bd:	c9                   	leave  
801022be:	c3                   	ret    

801022bf <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801022bf:	55                   	push   %ebp
801022c0:	89 e5                	mov    %esp,%ebp
801022c2:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801022c5:	83 ec 04             	sub    $0x4,%esp
801022c8:	6a 00                	push   $0x0
801022ca:	ff 75 0c             	pushl  0xc(%ebp)
801022cd:	ff 75 08             	pushl  0x8(%ebp)
801022d0:	e8 30 ff ff ff       	call   80102205 <dirlookup>
801022d5:	83 c4 10             	add    $0x10,%esp
801022d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801022db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801022df:	74 18                	je     801022f9 <dirlink+0x3a>
    iput(ip);
801022e1:	83 ec 0c             	sub    $0xc,%esp
801022e4:	ff 75 f0             	pushl  -0x10(%ebp)
801022e7:	e8 b4 f8 ff ff       	call   80101ba0 <iput>
801022ec:	83 c4 10             	add    $0x10,%esp
    return -1;
801022ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022f4:	e9 9c 00 00 00       	jmp    80102395 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102300:	eb 39                	jmp    8010233b <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102302:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102305:	6a 10                	push   $0x10
80102307:	50                   	push   %eax
80102308:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010230b:	50                   	push   %eax
8010230c:	ff 75 08             	pushl  0x8(%ebp)
8010230f:	e8 f7 fb ff ff       	call   80101f0b <readi>
80102314:	83 c4 10             	add    $0x10,%esp
80102317:	83 f8 10             	cmp    $0x10,%eax
8010231a:	74 0d                	je     80102329 <dirlink+0x6a>
      panic("dirlink read");
8010231c:	83 ec 0c             	sub    $0xc,%esp
8010231f:	68 b7 8a 10 80       	push   $0x80108ab7
80102324:	e8 77 e2 ff ff       	call   801005a0 <panic>
    if(de.inum == 0)
80102329:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010232d:	66 85 c0             	test   %ax,%ax
80102330:	74 18                	je     8010234a <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102332:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102335:	83 c0 10             	add    $0x10,%eax
80102338:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010233b:	8b 45 08             	mov    0x8(%ebp),%eax
8010233e:	8b 50 58             	mov    0x58(%eax),%edx
80102341:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102344:	39 c2                	cmp    %eax,%edx
80102346:	77 ba                	ja     80102302 <dirlink+0x43>
80102348:	eb 01                	jmp    8010234b <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
8010234a:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
8010234b:	83 ec 04             	sub    $0x4,%esp
8010234e:	6a 0e                	push   $0xe
80102350:	ff 75 0c             	pushl  0xc(%ebp)
80102353:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102356:	83 c0 02             	add    $0x2,%eax
80102359:	50                   	push   %eax
8010235a:	e8 b4 31 00 00       	call   80105513 <strncpy>
8010235f:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102362:	8b 45 10             	mov    0x10(%ebp),%eax
80102365:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102369:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010236c:	6a 10                	push   $0x10
8010236e:	50                   	push   %eax
8010236f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102372:	50                   	push   %eax
80102373:	ff 75 08             	pushl  0x8(%ebp)
80102376:	e8 e7 fc ff ff       	call   80102062 <writei>
8010237b:	83 c4 10             	add    $0x10,%esp
8010237e:	83 f8 10             	cmp    $0x10,%eax
80102381:	74 0d                	je     80102390 <dirlink+0xd1>
    panic("dirlink");
80102383:	83 ec 0c             	sub    $0xc,%esp
80102386:	68 c4 8a 10 80       	push   $0x80108ac4
8010238b:	e8 10 e2 ff ff       	call   801005a0 <panic>

  return 0;
80102390:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102395:	c9                   	leave  
80102396:	c3                   	ret    

80102397 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
80102397:	55                   	push   %ebp
80102398:	89 e5                	mov    %esp,%ebp
8010239a:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
8010239d:	eb 04                	jmp    801023a3 <skipelem+0xc>
    path++;
8010239f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801023a3:	8b 45 08             	mov    0x8(%ebp),%eax
801023a6:	0f b6 00             	movzbl (%eax),%eax
801023a9:	3c 2f                	cmp    $0x2f,%al
801023ab:	74 f2                	je     8010239f <skipelem+0x8>
    path++;
  if(*path == 0)
801023ad:	8b 45 08             	mov    0x8(%ebp),%eax
801023b0:	0f b6 00             	movzbl (%eax),%eax
801023b3:	84 c0                	test   %al,%al
801023b5:	75 07                	jne    801023be <skipelem+0x27>
    return 0;
801023b7:	b8 00 00 00 00       	mov    $0x0,%eax
801023bc:	eb 7b                	jmp    80102439 <skipelem+0xa2>
  s = path;
801023be:	8b 45 08             	mov    0x8(%ebp),%eax
801023c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
801023c4:	eb 04                	jmp    801023ca <skipelem+0x33>
    path++;
801023c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
801023ca:	8b 45 08             	mov    0x8(%ebp),%eax
801023cd:	0f b6 00             	movzbl (%eax),%eax
801023d0:	3c 2f                	cmp    $0x2f,%al
801023d2:	74 0a                	je     801023de <skipelem+0x47>
801023d4:	8b 45 08             	mov    0x8(%ebp),%eax
801023d7:	0f b6 00             	movzbl (%eax),%eax
801023da:	84 c0                	test   %al,%al
801023dc:	75 e8                	jne    801023c6 <skipelem+0x2f>
    path++;
  len = path - s;
801023de:	8b 55 08             	mov    0x8(%ebp),%edx
801023e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023e4:	29 c2                	sub    %eax,%edx
801023e6:	89 d0                	mov    %edx,%eax
801023e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801023eb:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801023ef:	7e 15                	jle    80102406 <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
801023f1:	83 ec 04             	sub    $0x4,%esp
801023f4:	6a 0e                	push   $0xe
801023f6:	ff 75 f4             	pushl  -0xc(%ebp)
801023f9:	ff 75 0c             	pushl  0xc(%ebp)
801023fc:	e8 26 30 00 00       	call   80105427 <memmove>
80102401:	83 c4 10             	add    $0x10,%esp
80102404:	eb 26                	jmp    8010242c <skipelem+0x95>
  else {
    memmove(name, s, len);
80102406:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102409:	83 ec 04             	sub    $0x4,%esp
8010240c:	50                   	push   %eax
8010240d:	ff 75 f4             	pushl  -0xc(%ebp)
80102410:	ff 75 0c             	pushl  0xc(%ebp)
80102413:	e8 0f 30 00 00       	call   80105427 <memmove>
80102418:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
8010241b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010241e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102421:	01 d0                	add    %edx,%eax
80102423:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102426:	eb 04                	jmp    8010242c <skipelem+0x95>
    path++;
80102428:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
8010242c:	8b 45 08             	mov    0x8(%ebp),%eax
8010242f:	0f b6 00             	movzbl (%eax),%eax
80102432:	3c 2f                	cmp    $0x2f,%al
80102434:	74 f2                	je     80102428 <skipelem+0x91>
    path++;
  return path;
80102436:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102439:	c9                   	leave  
8010243a:	c3                   	ret    

8010243b <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010243b:	55                   	push   %ebp
8010243c:	89 e5                	mov    %esp,%ebp
8010243e:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102441:	8b 45 08             	mov    0x8(%ebp),%eax
80102444:	0f b6 00             	movzbl (%eax),%eax
80102447:	3c 2f                	cmp    $0x2f,%al
80102449:	75 17                	jne    80102462 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
8010244b:	83 ec 08             	sub    $0x8,%esp
8010244e:	6a 01                	push   $0x1
80102450:	6a 01                	push   $0x1
80102452:	e8 c2 f4 ff ff       	call   80101919 <iget>
80102457:	83 c4 10             	add    $0x10,%esp
8010245a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010245d:	e9 bb 00 00 00       	jmp    8010251d <namex+0xe2>
  else
    ip = idup(proc->cwd);
80102462:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80102468:	8b 40 6c             	mov    0x6c(%eax),%eax
8010246b:	83 ec 0c             	sub    $0xc,%esp
8010246e:	50                   	push   %eax
8010246f:	e8 87 f5 ff ff       	call   801019fb <idup>
80102474:	83 c4 10             	add    $0x10,%esp
80102477:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010247a:	e9 9e 00 00 00       	jmp    8010251d <namex+0xe2>
    ilock(ip);
8010247f:	83 ec 0c             	sub    $0xc,%esp
80102482:	ff 75 f4             	pushl  -0xc(%ebp)
80102485:	e8 ab f5 ff ff       	call   80101a35 <ilock>
8010248a:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
8010248d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102490:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102494:	66 83 f8 01          	cmp    $0x1,%ax
80102498:	74 18                	je     801024b2 <namex+0x77>
      iunlockput(ip);
8010249a:	83 ec 0c             	sub    $0xc,%esp
8010249d:	ff 75 f4             	pushl  -0xc(%ebp)
801024a0:	e8 a6 f7 ff ff       	call   80101c4b <iunlockput>
801024a5:	83 c4 10             	add    $0x10,%esp
      return 0;
801024a8:	b8 00 00 00 00       	mov    $0x0,%eax
801024ad:	e9 a7 00 00 00       	jmp    80102559 <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
801024b2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024b6:	74 20                	je     801024d8 <namex+0x9d>
801024b8:	8b 45 08             	mov    0x8(%ebp),%eax
801024bb:	0f b6 00             	movzbl (%eax),%eax
801024be:	84 c0                	test   %al,%al
801024c0:	75 16                	jne    801024d8 <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
801024c2:	83 ec 0c             	sub    $0xc,%esp
801024c5:	ff 75 f4             	pushl  -0xc(%ebp)
801024c8:	e8 85 f6 ff ff       	call   80101b52 <iunlock>
801024cd:	83 c4 10             	add    $0x10,%esp
      return ip;
801024d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024d3:	e9 81 00 00 00       	jmp    80102559 <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801024d8:	83 ec 04             	sub    $0x4,%esp
801024db:	6a 00                	push   $0x0
801024dd:	ff 75 10             	pushl  0x10(%ebp)
801024e0:	ff 75 f4             	pushl  -0xc(%ebp)
801024e3:	e8 1d fd ff ff       	call   80102205 <dirlookup>
801024e8:	83 c4 10             	add    $0x10,%esp
801024eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
801024ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801024f2:	75 15                	jne    80102509 <namex+0xce>
      iunlockput(ip);
801024f4:	83 ec 0c             	sub    $0xc,%esp
801024f7:	ff 75 f4             	pushl  -0xc(%ebp)
801024fa:	e8 4c f7 ff ff       	call   80101c4b <iunlockput>
801024ff:	83 c4 10             	add    $0x10,%esp
      return 0;
80102502:	b8 00 00 00 00       	mov    $0x0,%eax
80102507:	eb 50                	jmp    80102559 <namex+0x11e>
    }
    iunlockput(ip);
80102509:	83 ec 0c             	sub    $0xc,%esp
8010250c:	ff 75 f4             	pushl  -0xc(%ebp)
8010250f:	e8 37 f7 ff ff       	call   80101c4b <iunlockput>
80102514:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102517:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010251a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
8010251d:	83 ec 08             	sub    $0x8,%esp
80102520:	ff 75 10             	pushl  0x10(%ebp)
80102523:	ff 75 08             	pushl  0x8(%ebp)
80102526:	e8 6c fe ff ff       	call   80102397 <skipelem>
8010252b:	83 c4 10             	add    $0x10,%esp
8010252e:	89 45 08             	mov    %eax,0x8(%ebp)
80102531:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102535:	0f 85 44 ff ff ff    	jne    8010247f <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
8010253b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010253f:	74 15                	je     80102556 <namex+0x11b>
    iput(ip);
80102541:	83 ec 0c             	sub    $0xc,%esp
80102544:	ff 75 f4             	pushl  -0xc(%ebp)
80102547:	e8 54 f6 ff ff       	call   80101ba0 <iput>
8010254c:	83 c4 10             	add    $0x10,%esp
    return 0;
8010254f:	b8 00 00 00 00       	mov    $0x0,%eax
80102554:	eb 03                	jmp    80102559 <namex+0x11e>
  }
  return ip;
80102556:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102559:	c9                   	leave  
8010255a:	c3                   	ret    

8010255b <namei>:

struct inode*
namei(char *path)
{
8010255b:	55                   	push   %ebp
8010255c:	89 e5                	mov    %esp,%ebp
8010255e:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102561:	83 ec 04             	sub    $0x4,%esp
80102564:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102567:	50                   	push   %eax
80102568:	6a 00                	push   $0x0
8010256a:	ff 75 08             	pushl  0x8(%ebp)
8010256d:	e8 c9 fe ff ff       	call   8010243b <namex>
80102572:	83 c4 10             	add    $0x10,%esp
}
80102575:	c9                   	leave  
80102576:	c3                   	ret    

80102577 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102577:	55                   	push   %ebp
80102578:	89 e5                	mov    %esp,%ebp
8010257a:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010257d:	83 ec 04             	sub    $0x4,%esp
80102580:	ff 75 0c             	pushl  0xc(%ebp)
80102583:	6a 01                	push   $0x1
80102585:	ff 75 08             	pushl  0x8(%ebp)
80102588:	e8 ae fe ff ff       	call   8010243b <namex>
8010258d:	83 c4 10             	add    $0x10,%esp
}
80102590:	c9                   	leave  
80102591:	c3                   	ret    

80102592 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102592:	55                   	push   %ebp
80102593:	89 e5                	mov    %esp,%ebp
80102595:	83 ec 14             	sub    $0x14,%esp
80102598:	8b 45 08             	mov    0x8(%ebp),%eax
8010259b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010259f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801025a3:	89 c2                	mov    %eax,%edx
801025a5:	ec                   	in     (%dx),%al
801025a6:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801025a9:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801025ad:	c9                   	leave  
801025ae:	c3                   	ret    

801025af <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
801025af:	55                   	push   %ebp
801025b0:	89 e5                	mov    %esp,%ebp
801025b2:	57                   	push   %edi
801025b3:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801025b4:	8b 55 08             	mov    0x8(%ebp),%edx
801025b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025ba:	8b 45 10             	mov    0x10(%ebp),%eax
801025bd:	89 cb                	mov    %ecx,%ebx
801025bf:	89 df                	mov    %ebx,%edi
801025c1:	89 c1                	mov    %eax,%ecx
801025c3:	fc                   	cld    
801025c4:	f3 6d                	rep insl (%dx),%es:(%edi)
801025c6:	89 c8                	mov    %ecx,%eax
801025c8:	89 fb                	mov    %edi,%ebx
801025ca:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025cd:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
801025d0:	90                   	nop
801025d1:	5b                   	pop    %ebx
801025d2:	5f                   	pop    %edi
801025d3:	5d                   	pop    %ebp
801025d4:	c3                   	ret    

801025d5 <outb>:

static inline void
outb(ushort port, uchar data)
{
801025d5:	55                   	push   %ebp
801025d6:	89 e5                	mov    %esp,%ebp
801025d8:	83 ec 08             	sub    $0x8,%esp
801025db:	8b 55 08             	mov    0x8(%ebp),%edx
801025de:	8b 45 0c             	mov    0xc(%ebp),%eax
801025e1:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801025e5:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025e8:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801025ec:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801025f0:	ee                   	out    %al,(%dx)
}
801025f1:	90                   	nop
801025f2:	c9                   	leave  
801025f3:	c3                   	ret    

801025f4 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801025f4:	55                   	push   %ebp
801025f5:	89 e5                	mov    %esp,%ebp
801025f7:	56                   	push   %esi
801025f8:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025f9:	8b 55 08             	mov    0x8(%ebp),%edx
801025fc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025ff:	8b 45 10             	mov    0x10(%ebp),%eax
80102602:	89 cb                	mov    %ecx,%ebx
80102604:	89 de                	mov    %ebx,%esi
80102606:	89 c1                	mov    %eax,%ecx
80102608:	fc                   	cld    
80102609:	f3 6f                	rep outsl %ds:(%esi),(%dx)
8010260b:	89 c8                	mov    %ecx,%eax
8010260d:	89 f3                	mov    %esi,%ebx
8010260f:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102612:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102615:	90                   	nop
80102616:	5b                   	pop    %ebx
80102617:	5e                   	pop    %esi
80102618:	5d                   	pop    %ebp
80102619:	c3                   	ret    

8010261a <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
8010261a:	55                   	push   %ebp
8010261b:	89 e5                	mov    %esp,%ebp
8010261d:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102620:	90                   	nop
80102621:	68 f7 01 00 00       	push   $0x1f7
80102626:	e8 67 ff ff ff       	call   80102592 <inb>
8010262b:	83 c4 04             	add    $0x4,%esp
8010262e:	0f b6 c0             	movzbl %al,%eax
80102631:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102634:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102637:	25 c0 00 00 00       	and    $0xc0,%eax
8010263c:	83 f8 40             	cmp    $0x40,%eax
8010263f:	75 e0                	jne    80102621 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102641:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102645:	74 11                	je     80102658 <idewait+0x3e>
80102647:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010264a:	83 e0 21             	and    $0x21,%eax
8010264d:	85 c0                	test   %eax,%eax
8010264f:	74 07                	je     80102658 <idewait+0x3e>
    return -1;
80102651:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102656:	eb 05                	jmp    8010265d <idewait+0x43>
  return 0;
80102658:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010265d:	c9                   	leave  
8010265e:	c3                   	ret    

8010265f <ideinit>:

void
ideinit(void)
{
8010265f:	55                   	push   %ebp
80102660:	89 e5                	mov    %esp,%ebp
80102662:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102665:	83 ec 08             	sub    $0x8,%esp
80102668:	68 cc 8a 10 80       	push   $0x80108acc
8010266d:	68 00 c6 10 80       	push   $0x8010c600
80102672:	e8 55 2a 00 00       	call   801050cc <initlock>
80102677:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
8010267a:	83 ec 0c             	sub    $0xc,%esp
8010267d:	6a 0e                	push   $0xe
8010267f:	e8 53 18 00 00       	call   80103ed7 <picenable>
80102684:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102687:	a1 00 4e 11 80       	mov    0x80114e00,%eax
8010268c:	83 e8 01             	sub    $0x1,%eax
8010268f:	83 ec 08             	sub    $0x8,%esp
80102692:	50                   	push   %eax
80102693:	6a 0e                	push   $0xe
80102695:	e8 b1 04 00 00       	call   80102b4b <ioapicenable>
8010269a:	83 c4 10             	add    $0x10,%esp
  idewait(0);
8010269d:	83 ec 0c             	sub    $0xc,%esp
801026a0:	6a 00                	push   $0x0
801026a2:	e8 73 ff ff ff       	call   8010261a <idewait>
801026a7:	83 c4 10             	add    $0x10,%esp

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801026aa:	83 ec 08             	sub    $0x8,%esp
801026ad:	68 f0 00 00 00       	push   $0xf0
801026b2:	68 f6 01 00 00       	push   $0x1f6
801026b7:	e8 19 ff ff ff       	call   801025d5 <outb>
801026bc:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801026bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026c6:	eb 24                	jmp    801026ec <ideinit+0x8d>
    if(inb(0x1f7) != 0){
801026c8:	83 ec 0c             	sub    $0xc,%esp
801026cb:	68 f7 01 00 00       	push   $0x1f7
801026d0:	e8 bd fe ff ff       	call   80102592 <inb>
801026d5:	83 c4 10             	add    $0x10,%esp
801026d8:	84 c0                	test   %al,%al
801026da:	74 0c                	je     801026e8 <ideinit+0x89>
      havedisk1 = 1;
801026dc:	c7 05 38 c6 10 80 01 	movl   $0x1,0x8010c638
801026e3:	00 00 00 
      break;
801026e6:	eb 0d                	jmp    801026f5 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801026e8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801026ec:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801026f3:	7e d3                	jle    801026c8 <ideinit+0x69>
      break;
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026f5:	83 ec 08             	sub    $0x8,%esp
801026f8:	68 e0 00 00 00       	push   $0xe0
801026fd:	68 f6 01 00 00       	push   $0x1f6
80102702:	e8 ce fe ff ff       	call   801025d5 <outb>
80102707:	83 c4 10             	add    $0x10,%esp
}
8010270a:	90                   	nop
8010270b:	c9                   	leave  
8010270c:	c3                   	ret    

8010270d <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
8010270d:	55                   	push   %ebp
8010270e:	89 e5                	mov    %esp,%ebp
80102710:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
80102713:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102717:	75 0d                	jne    80102726 <idestart+0x19>
    panic("idestart");
80102719:	83 ec 0c             	sub    $0xc,%esp
8010271c:	68 d0 8a 10 80       	push   $0x80108ad0
80102721:	e8 7a de ff ff       	call   801005a0 <panic>
  if(b->blockno >= FSSIZE)
80102726:	8b 45 08             	mov    0x8(%ebp),%eax
80102729:	8b 40 08             	mov    0x8(%eax),%eax
8010272c:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102731:	76 0d                	jbe    80102740 <idestart+0x33>
    panic("incorrect blockno");
80102733:	83 ec 0c             	sub    $0xc,%esp
80102736:	68 d9 8a 10 80       	push   $0x80108ad9
8010273b:	e8 60 de ff ff       	call   801005a0 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102740:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102747:	8b 45 08             	mov    0x8(%ebp),%eax
8010274a:	8b 50 08             	mov    0x8(%eax),%edx
8010274d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102750:	0f af c2             	imul   %edx,%eax
80102753:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
80102756:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
8010275a:	75 07                	jne    80102763 <idestart+0x56>
8010275c:	b8 20 00 00 00       	mov    $0x20,%eax
80102761:	eb 05                	jmp    80102768 <idestart+0x5b>
80102763:	b8 c4 00 00 00       	mov    $0xc4,%eax
80102768:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
8010276b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
8010276f:	75 07                	jne    80102778 <idestart+0x6b>
80102771:	b8 30 00 00 00       	mov    $0x30,%eax
80102776:	eb 05                	jmp    8010277d <idestart+0x70>
80102778:	b8 c5 00 00 00       	mov    $0xc5,%eax
8010277d:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102780:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102784:	7e 0d                	jle    80102793 <idestart+0x86>
80102786:	83 ec 0c             	sub    $0xc,%esp
80102789:	68 d0 8a 10 80       	push   $0x80108ad0
8010278e:	e8 0d de ff ff       	call   801005a0 <panic>

  idewait(0);
80102793:	83 ec 0c             	sub    $0xc,%esp
80102796:	6a 00                	push   $0x0
80102798:	e8 7d fe ff ff       	call   8010261a <idewait>
8010279d:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
801027a0:	83 ec 08             	sub    $0x8,%esp
801027a3:	6a 00                	push   $0x0
801027a5:	68 f6 03 00 00       	push   $0x3f6
801027aa:	e8 26 fe ff ff       	call   801025d5 <outb>
801027af:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
801027b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027b5:	0f b6 c0             	movzbl %al,%eax
801027b8:	83 ec 08             	sub    $0x8,%esp
801027bb:	50                   	push   %eax
801027bc:	68 f2 01 00 00       	push   $0x1f2
801027c1:	e8 0f fe ff ff       	call   801025d5 <outb>
801027c6:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
801027c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027cc:	0f b6 c0             	movzbl %al,%eax
801027cf:	83 ec 08             	sub    $0x8,%esp
801027d2:	50                   	push   %eax
801027d3:	68 f3 01 00 00       	push   $0x1f3
801027d8:	e8 f8 fd ff ff       	call   801025d5 <outb>
801027dd:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
801027e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027e3:	c1 f8 08             	sar    $0x8,%eax
801027e6:	0f b6 c0             	movzbl %al,%eax
801027e9:	83 ec 08             	sub    $0x8,%esp
801027ec:	50                   	push   %eax
801027ed:	68 f4 01 00 00       	push   $0x1f4
801027f2:	e8 de fd ff ff       	call   801025d5 <outb>
801027f7:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801027fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027fd:	c1 f8 10             	sar    $0x10,%eax
80102800:	0f b6 c0             	movzbl %al,%eax
80102803:	83 ec 08             	sub    $0x8,%esp
80102806:	50                   	push   %eax
80102807:	68 f5 01 00 00       	push   $0x1f5
8010280c:	e8 c4 fd ff ff       	call   801025d5 <outb>
80102811:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102814:	8b 45 08             	mov    0x8(%ebp),%eax
80102817:	8b 40 04             	mov    0x4(%eax),%eax
8010281a:	83 e0 01             	and    $0x1,%eax
8010281d:	c1 e0 04             	shl    $0x4,%eax
80102820:	89 c2                	mov    %eax,%edx
80102822:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102825:	c1 f8 18             	sar    $0x18,%eax
80102828:	83 e0 0f             	and    $0xf,%eax
8010282b:	09 d0                	or     %edx,%eax
8010282d:	83 c8 e0             	or     $0xffffffe0,%eax
80102830:	0f b6 c0             	movzbl %al,%eax
80102833:	83 ec 08             	sub    $0x8,%esp
80102836:	50                   	push   %eax
80102837:	68 f6 01 00 00       	push   $0x1f6
8010283c:	e8 94 fd ff ff       	call   801025d5 <outb>
80102841:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102844:	8b 45 08             	mov    0x8(%ebp),%eax
80102847:	8b 00                	mov    (%eax),%eax
80102849:	83 e0 04             	and    $0x4,%eax
8010284c:	85 c0                	test   %eax,%eax
8010284e:	74 35                	je     80102885 <idestart+0x178>
    outb(0x1f7, write_cmd);
80102850:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102853:	0f b6 c0             	movzbl %al,%eax
80102856:	83 ec 08             	sub    $0x8,%esp
80102859:	50                   	push   %eax
8010285a:	68 f7 01 00 00       	push   $0x1f7
8010285f:	e8 71 fd ff ff       	call   801025d5 <outb>
80102864:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102867:	8b 45 08             	mov    0x8(%ebp),%eax
8010286a:	83 c0 5c             	add    $0x5c,%eax
8010286d:	83 ec 04             	sub    $0x4,%esp
80102870:	68 80 00 00 00       	push   $0x80
80102875:	50                   	push   %eax
80102876:	68 f0 01 00 00       	push   $0x1f0
8010287b:	e8 74 fd ff ff       	call   801025f4 <outsl>
80102880:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102883:	eb 17                	jmp    8010289c <idestart+0x18f>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
80102885:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102888:	0f b6 c0             	movzbl %al,%eax
8010288b:	83 ec 08             	sub    $0x8,%esp
8010288e:	50                   	push   %eax
8010288f:	68 f7 01 00 00       	push   $0x1f7
80102894:	e8 3c fd ff ff       	call   801025d5 <outb>
80102899:	83 c4 10             	add    $0x10,%esp
  }
}
8010289c:	90                   	nop
8010289d:	c9                   	leave  
8010289e:	c3                   	ret    

8010289f <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
8010289f:	55                   	push   %ebp
801028a0:	89 e5                	mov    %esp,%ebp
801028a2:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801028a5:	83 ec 0c             	sub    $0xc,%esp
801028a8:	68 00 c6 10 80       	push   $0x8010c600
801028ad:	e8 3c 28 00 00       	call   801050ee <acquire>
801028b2:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
801028b5:	a1 34 c6 10 80       	mov    0x8010c634,%eax
801028ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028c1:	75 15                	jne    801028d8 <ideintr+0x39>
    release(&idelock);
801028c3:	83 ec 0c             	sub    $0xc,%esp
801028c6:	68 00 c6 10 80       	push   $0x8010c600
801028cb:	e8 8a 28 00 00       	call   8010515a <release>
801028d0:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
801028d3:	e9 9a 00 00 00       	jmp    80102972 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801028d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028db:	8b 40 58             	mov    0x58(%eax),%eax
801028de:	a3 34 c6 10 80       	mov    %eax,0x8010c634

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801028e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028e6:	8b 00                	mov    (%eax),%eax
801028e8:	83 e0 04             	and    $0x4,%eax
801028eb:	85 c0                	test   %eax,%eax
801028ed:	75 2d                	jne    8010291c <ideintr+0x7d>
801028ef:	83 ec 0c             	sub    $0xc,%esp
801028f2:	6a 01                	push   $0x1
801028f4:	e8 21 fd ff ff       	call   8010261a <idewait>
801028f9:	83 c4 10             	add    $0x10,%esp
801028fc:	85 c0                	test   %eax,%eax
801028fe:	78 1c                	js     8010291c <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
80102900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102903:	83 c0 5c             	add    $0x5c,%eax
80102906:	83 ec 04             	sub    $0x4,%esp
80102909:	68 80 00 00 00       	push   $0x80
8010290e:	50                   	push   %eax
8010290f:	68 f0 01 00 00       	push   $0x1f0
80102914:	e8 96 fc ff ff       	call   801025af <insl>
80102919:	83 c4 10             	add    $0x10,%esp

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010291c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010291f:	8b 00                	mov    (%eax),%eax
80102921:	83 c8 02             	or     $0x2,%eax
80102924:	89 c2                	mov    %eax,%edx
80102926:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102929:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010292b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010292e:	8b 00                	mov    (%eax),%eax
80102930:	83 e0 fb             	and    $0xfffffffb,%eax
80102933:	89 c2                	mov    %eax,%edx
80102935:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102938:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010293a:	83 ec 0c             	sub    $0xc,%esp
8010293d:	ff 75 f4             	pushl  -0xc(%ebp)
80102940:	e8 75 24 00 00       	call   80104dba <wakeup>
80102945:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102948:	a1 34 c6 10 80       	mov    0x8010c634,%eax
8010294d:	85 c0                	test   %eax,%eax
8010294f:	74 11                	je     80102962 <ideintr+0xc3>
    idestart(idequeue);
80102951:	a1 34 c6 10 80       	mov    0x8010c634,%eax
80102956:	83 ec 0c             	sub    $0xc,%esp
80102959:	50                   	push   %eax
8010295a:	e8 ae fd ff ff       	call   8010270d <idestart>
8010295f:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102962:	83 ec 0c             	sub    $0xc,%esp
80102965:	68 00 c6 10 80       	push   $0x8010c600
8010296a:	e8 eb 27 00 00       	call   8010515a <release>
8010296f:	83 c4 10             	add    $0x10,%esp
}
80102972:	c9                   	leave  
80102973:	c3                   	ret    

80102974 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102974:	55                   	push   %ebp
80102975:	89 e5                	mov    %esp,%ebp
80102977:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010297a:	8b 45 08             	mov    0x8(%ebp),%eax
8010297d:	83 c0 0c             	add    $0xc,%eax
80102980:	83 ec 0c             	sub    $0xc,%esp
80102983:	50                   	push   %eax
80102984:	e8 d4 26 00 00       	call   8010505d <holdingsleep>
80102989:	83 c4 10             	add    $0x10,%esp
8010298c:	85 c0                	test   %eax,%eax
8010298e:	75 0d                	jne    8010299d <iderw+0x29>
    panic("iderw: buf not locked");
80102990:	83 ec 0c             	sub    $0xc,%esp
80102993:	68 eb 8a 10 80       	push   $0x80108aeb
80102998:	e8 03 dc ff ff       	call   801005a0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010299d:	8b 45 08             	mov    0x8(%ebp),%eax
801029a0:	8b 00                	mov    (%eax),%eax
801029a2:	83 e0 06             	and    $0x6,%eax
801029a5:	83 f8 02             	cmp    $0x2,%eax
801029a8:	75 0d                	jne    801029b7 <iderw+0x43>
    panic("iderw: nothing to do");
801029aa:	83 ec 0c             	sub    $0xc,%esp
801029ad:	68 01 8b 10 80       	push   $0x80108b01
801029b2:	e8 e9 db ff ff       	call   801005a0 <panic>
  if(b->dev != 0 && !havedisk1)
801029b7:	8b 45 08             	mov    0x8(%ebp),%eax
801029ba:	8b 40 04             	mov    0x4(%eax),%eax
801029bd:	85 c0                	test   %eax,%eax
801029bf:	74 16                	je     801029d7 <iderw+0x63>
801029c1:	a1 38 c6 10 80       	mov    0x8010c638,%eax
801029c6:	85 c0                	test   %eax,%eax
801029c8:	75 0d                	jne    801029d7 <iderw+0x63>
    panic("iderw: ide disk 1 not present");
801029ca:	83 ec 0c             	sub    $0xc,%esp
801029cd:	68 16 8b 10 80       	push   $0x80108b16
801029d2:	e8 c9 db ff ff       	call   801005a0 <panic>

  acquire(&idelock);  //DOC:acquire-lock
801029d7:	83 ec 0c             	sub    $0xc,%esp
801029da:	68 00 c6 10 80       	push   $0x8010c600
801029df:	e8 0a 27 00 00       	call   801050ee <acquire>
801029e4:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801029e7:	8b 45 08             	mov    0x8(%ebp),%eax
801029ea:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029f1:	c7 45 f4 34 c6 10 80 	movl   $0x8010c634,-0xc(%ebp)
801029f8:	eb 0b                	jmp    80102a05 <iderw+0x91>
801029fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029fd:	8b 00                	mov    (%eax),%eax
801029ff:	83 c0 58             	add    $0x58,%eax
80102a02:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a08:	8b 00                	mov    (%eax),%eax
80102a0a:	85 c0                	test   %eax,%eax
80102a0c:	75 ec                	jne    801029fa <iderw+0x86>
    ;
  *pp = b;
80102a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a11:	8b 55 08             	mov    0x8(%ebp),%edx
80102a14:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
80102a16:	a1 34 c6 10 80       	mov    0x8010c634,%eax
80102a1b:	3b 45 08             	cmp    0x8(%ebp),%eax
80102a1e:	75 23                	jne    80102a43 <iderw+0xcf>
    idestart(b);
80102a20:	83 ec 0c             	sub    $0xc,%esp
80102a23:	ff 75 08             	pushl  0x8(%ebp)
80102a26:	e8 e2 fc ff ff       	call   8010270d <idestart>
80102a2b:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a2e:	eb 13                	jmp    80102a43 <iderw+0xcf>
    sleep(b, &idelock);
80102a30:	83 ec 08             	sub    $0x8,%esp
80102a33:	68 00 c6 10 80       	push   $0x8010c600
80102a38:	ff 75 08             	pushl  0x8(%ebp)
80102a3b:	e8 8f 22 00 00       	call   80104ccf <sleep>
80102a40:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a43:	8b 45 08             	mov    0x8(%ebp),%eax
80102a46:	8b 00                	mov    (%eax),%eax
80102a48:	83 e0 06             	and    $0x6,%eax
80102a4b:	83 f8 02             	cmp    $0x2,%eax
80102a4e:	75 e0                	jne    80102a30 <iderw+0xbc>
    sleep(b, &idelock);
  }

  release(&idelock);
80102a50:	83 ec 0c             	sub    $0xc,%esp
80102a53:	68 00 c6 10 80       	push   $0x8010c600
80102a58:	e8 fd 26 00 00       	call   8010515a <release>
80102a5d:	83 c4 10             	add    $0x10,%esp
}
80102a60:	90                   	nop
80102a61:	c9                   	leave  
80102a62:	c3                   	ret    

80102a63 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102a63:	55                   	push   %ebp
80102a64:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a66:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102a6b:	8b 55 08             	mov    0x8(%ebp),%edx
80102a6e:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a70:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102a75:	8b 40 10             	mov    0x10(%eax),%eax
}
80102a78:	5d                   	pop    %ebp
80102a79:	c3                   	ret    

80102a7a <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102a7a:	55                   	push   %ebp
80102a7b:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a7d:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102a82:	8b 55 08             	mov    0x8(%ebp),%edx
80102a85:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102a87:	a1 d4 46 11 80       	mov    0x801146d4,%eax
80102a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a8f:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a92:	90                   	nop
80102a93:	5d                   	pop    %ebp
80102a94:	c3                   	ret    

80102a95 <ioapicinit>:

void
ioapicinit(void)
{
80102a95:	55                   	push   %ebp
80102a96:	89 e5                	mov    %esp,%ebp
80102a98:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102a9b:	a1 04 48 11 80       	mov    0x80114804,%eax
80102aa0:	85 c0                	test   %eax,%eax
80102aa2:	0f 84 a0 00 00 00    	je     80102b48 <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102aa8:	c7 05 d4 46 11 80 00 	movl   $0xfec00000,0x801146d4
80102aaf:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102ab2:	6a 01                	push   $0x1
80102ab4:	e8 aa ff ff ff       	call   80102a63 <ioapicread>
80102ab9:	83 c4 04             	add    $0x4,%esp
80102abc:	c1 e8 10             	shr    $0x10,%eax
80102abf:	25 ff 00 00 00       	and    $0xff,%eax
80102ac4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102ac7:	6a 00                	push   $0x0
80102ac9:	e8 95 ff ff ff       	call   80102a63 <ioapicread>
80102ace:	83 c4 04             	add    $0x4,%esp
80102ad1:	c1 e8 18             	shr    $0x18,%eax
80102ad4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102ad7:	0f b6 05 00 48 11 80 	movzbl 0x80114800,%eax
80102ade:	0f b6 c0             	movzbl %al,%eax
80102ae1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102ae4:	74 10                	je     80102af6 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ae6:	83 ec 0c             	sub    $0xc,%esp
80102ae9:	68 34 8b 10 80       	push   $0x80108b34
80102aee:	e8 0d d9 ff ff       	call   80100400 <cprintf>
80102af3:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102af6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102afd:	eb 3f                	jmp    80102b3e <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102aff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b02:	83 c0 20             	add    $0x20,%eax
80102b05:	0d 00 00 01 00       	or     $0x10000,%eax
80102b0a:	89 c2                	mov    %eax,%edx
80102b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b0f:	83 c0 08             	add    $0x8,%eax
80102b12:	01 c0                	add    %eax,%eax
80102b14:	83 ec 08             	sub    $0x8,%esp
80102b17:	52                   	push   %edx
80102b18:	50                   	push   %eax
80102b19:	e8 5c ff ff ff       	call   80102a7a <ioapicwrite>
80102b1e:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102b21:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b24:	83 c0 08             	add    $0x8,%eax
80102b27:	01 c0                	add    %eax,%eax
80102b29:	83 c0 01             	add    $0x1,%eax
80102b2c:	83 ec 08             	sub    $0x8,%esp
80102b2f:	6a 00                	push   $0x0
80102b31:	50                   	push   %eax
80102b32:	e8 43 ff ff ff       	call   80102a7a <ioapicwrite>
80102b37:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102b3a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102b3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b41:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102b44:	7e b9                	jle    80102aff <ioapicinit+0x6a>
80102b46:	eb 01                	jmp    80102b49 <ioapicinit+0xb4>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102b48:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102b49:	c9                   	leave  
80102b4a:	c3                   	ret    

80102b4b <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102b4b:	55                   	push   %ebp
80102b4c:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102b4e:	a1 04 48 11 80       	mov    0x80114804,%eax
80102b53:	85 c0                	test   %eax,%eax
80102b55:	74 39                	je     80102b90 <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102b57:	8b 45 08             	mov    0x8(%ebp),%eax
80102b5a:	83 c0 20             	add    $0x20,%eax
80102b5d:	89 c2                	mov    %eax,%edx
80102b5f:	8b 45 08             	mov    0x8(%ebp),%eax
80102b62:	83 c0 08             	add    $0x8,%eax
80102b65:	01 c0                	add    %eax,%eax
80102b67:	52                   	push   %edx
80102b68:	50                   	push   %eax
80102b69:	e8 0c ff ff ff       	call   80102a7a <ioapicwrite>
80102b6e:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b71:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b74:	c1 e0 18             	shl    $0x18,%eax
80102b77:	89 c2                	mov    %eax,%edx
80102b79:	8b 45 08             	mov    0x8(%ebp),%eax
80102b7c:	83 c0 08             	add    $0x8,%eax
80102b7f:	01 c0                	add    %eax,%eax
80102b81:	83 c0 01             	add    $0x1,%eax
80102b84:	52                   	push   %edx
80102b85:	50                   	push   %eax
80102b86:	e8 ef fe ff ff       	call   80102a7a <ioapicwrite>
80102b8b:	83 c4 08             	add    $0x8,%esp
80102b8e:	eb 01                	jmp    80102b91 <ioapicenable+0x46>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102b90:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102b91:	c9                   	leave  
80102b92:	c3                   	ret    

80102b93 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102b93:	55                   	push   %ebp
80102b94:	89 e5                	mov    %esp,%ebp
80102b96:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102b99:	83 ec 08             	sub    $0x8,%esp
80102b9c:	68 66 8b 10 80       	push   $0x80108b66
80102ba1:	68 e0 46 11 80       	push   $0x801146e0
80102ba6:	e8 21 25 00 00       	call   801050cc <initlock>
80102bab:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102bae:	c7 05 14 47 11 80 00 	movl   $0x0,0x80114714
80102bb5:	00 00 00 
  freerange(vstart, vend);
80102bb8:	83 ec 08             	sub    $0x8,%esp
80102bbb:	ff 75 0c             	pushl  0xc(%ebp)
80102bbe:	ff 75 08             	pushl  0x8(%ebp)
80102bc1:	e8 2a 00 00 00       	call   80102bf0 <freerange>
80102bc6:	83 c4 10             	add    $0x10,%esp
}
80102bc9:	90                   	nop
80102bca:	c9                   	leave  
80102bcb:	c3                   	ret    

80102bcc <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102bcc:	55                   	push   %ebp
80102bcd:	89 e5                	mov    %esp,%ebp
80102bcf:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102bd2:	83 ec 08             	sub    $0x8,%esp
80102bd5:	ff 75 0c             	pushl  0xc(%ebp)
80102bd8:	ff 75 08             	pushl  0x8(%ebp)
80102bdb:	e8 10 00 00 00       	call   80102bf0 <freerange>
80102be0:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102be3:	c7 05 14 47 11 80 01 	movl   $0x1,0x80114714
80102bea:	00 00 00 
}
80102bed:	90                   	nop
80102bee:	c9                   	leave  
80102bef:	c3                   	ret    

80102bf0 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102bf6:	8b 45 08             	mov    0x8(%ebp),%eax
80102bf9:	05 ff 0f 00 00       	add    $0xfff,%eax
80102bfe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102c03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c06:	eb 15                	jmp    80102c1d <freerange+0x2d>
    kfree(p);
80102c08:	83 ec 0c             	sub    $0xc,%esp
80102c0b:	ff 75 f4             	pushl  -0xc(%ebp)
80102c0e:	e8 1a 00 00 00       	call   80102c2d <kfree>
80102c13:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102c16:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c20:	05 00 10 00 00       	add    $0x1000,%eax
80102c25:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102c28:	76 de                	jbe    80102c08 <freerange+0x18>
    kfree(p);
}
80102c2a:	90                   	nop
80102c2b:	c9                   	leave  
80102c2c:	c3                   	ret    

80102c2d <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102c2d:	55                   	push   %ebp
80102c2e:	89 e5                	mov    %esp,%ebp
80102c30:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102c33:	8b 45 08             	mov    0x8(%ebp),%eax
80102c36:	25 ff 0f 00 00       	and    $0xfff,%eax
80102c3b:	85 c0                	test   %eax,%eax
80102c3d:	75 18                	jne    80102c57 <kfree+0x2a>
80102c3f:	81 7d 08 a8 76 11 80 	cmpl   $0x801176a8,0x8(%ebp)
80102c46:	72 0f                	jb     80102c57 <kfree+0x2a>
80102c48:	8b 45 08             	mov    0x8(%ebp),%eax
80102c4b:	05 00 00 00 80       	add    $0x80000000,%eax
80102c50:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c55:	76 0d                	jbe    80102c64 <kfree+0x37>
    panic("kfree");
80102c57:	83 ec 0c             	sub    $0xc,%esp
80102c5a:	68 6b 8b 10 80       	push   $0x80108b6b
80102c5f:	e8 3c d9 ff ff       	call   801005a0 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c64:	83 ec 04             	sub    $0x4,%esp
80102c67:	68 00 10 00 00       	push   $0x1000
80102c6c:	6a 01                	push   $0x1
80102c6e:	ff 75 08             	pushl  0x8(%ebp)
80102c71:	e8 f2 26 00 00       	call   80105368 <memset>
80102c76:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102c79:	a1 14 47 11 80       	mov    0x80114714,%eax
80102c7e:	85 c0                	test   %eax,%eax
80102c80:	74 10                	je     80102c92 <kfree+0x65>
    acquire(&kmem.lock);
80102c82:	83 ec 0c             	sub    $0xc,%esp
80102c85:	68 e0 46 11 80       	push   $0x801146e0
80102c8a:	e8 5f 24 00 00       	call   801050ee <acquire>
80102c8f:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102c92:	8b 45 08             	mov    0x8(%ebp),%eax
80102c95:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102c98:	8b 15 18 47 11 80    	mov    0x80114718,%edx
80102c9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ca1:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102ca3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ca6:	a3 18 47 11 80       	mov    %eax,0x80114718
  if(kmem.use_lock)
80102cab:	a1 14 47 11 80       	mov    0x80114714,%eax
80102cb0:	85 c0                	test   %eax,%eax
80102cb2:	74 10                	je     80102cc4 <kfree+0x97>
    release(&kmem.lock);
80102cb4:	83 ec 0c             	sub    $0xc,%esp
80102cb7:	68 e0 46 11 80       	push   $0x801146e0
80102cbc:	e8 99 24 00 00       	call   8010515a <release>
80102cc1:	83 c4 10             	add    $0x10,%esp
}
80102cc4:	90                   	nop
80102cc5:	c9                   	leave  
80102cc6:	c3                   	ret    

80102cc7 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102cc7:	55                   	push   %ebp
80102cc8:	89 e5                	mov    %esp,%ebp
80102cca:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102ccd:	a1 14 47 11 80       	mov    0x80114714,%eax
80102cd2:	85 c0                	test   %eax,%eax
80102cd4:	74 10                	je     80102ce6 <kalloc+0x1f>
    acquire(&kmem.lock);
80102cd6:	83 ec 0c             	sub    $0xc,%esp
80102cd9:	68 e0 46 11 80       	push   $0x801146e0
80102cde:	e8 0b 24 00 00       	call   801050ee <acquire>
80102ce3:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102ce6:	a1 18 47 11 80       	mov    0x80114718,%eax
80102ceb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102cee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102cf2:	74 0a                	je     80102cfe <kalloc+0x37>
    kmem.freelist = r->next;
80102cf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cf7:	8b 00                	mov    (%eax),%eax
80102cf9:	a3 18 47 11 80       	mov    %eax,0x80114718
  if(kmem.use_lock)
80102cfe:	a1 14 47 11 80       	mov    0x80114714,%eax
80102d03:	85 c0                	test   %eax,%eax
80102d05:	74 10                	je     80102d17 <kalloc+0x50>
    release(&kmem.lock);
80102d07:	83 ec 0c             	sub    $0xc,%esp
80102d0a:	68 e0 46 11 80       	push   $0x801146e0
80102d0f:	e8 46 24 00 00       	call   8010515a <release>
80102d14:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102d1a:	c9                   	leave  
80102d1b:	c3                   	ret    

80102d1c <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102d1c:	55                   	push   %ebp
80102d1d:	89 e5                	mov    %esp,%ebp
80102d1f:	83 ec 14             	sub    $0x14,%esp
80102d22:	8b 45 08             	mov    0x8(%ebp),%eax
80102d25:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d29:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102d2d:	89 c2                	mov    %eax,%edx
80102d2f:	ec                   	in     (%dx),%al
80102d30:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d33:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102d37:	c9                   	leave  
80102d38:	c3                   	ret    

80102d39 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102d39:	55                   	push   %ebp
80102d3a:	89 e5                	mov    %esp,%ebp
80102d3c:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102d3f:	6a 64                	push   $0x64
80102d41:	e8 d6 ff ff ff       	call   80102d1c <inb>
80102d46:	83 c4 04             	add    $0x4,%esp
80102d49:	0f b6 c0             	movzbl %al,%eax
80102d4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102d4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d52:	83 e0 01             	and    $0x1,%eax
80102d55:	85 c0                	test   %eax,%eax
80102d57:	75 0a                	jne    80102d63 <kbdgetc+0x2a>
    return -1;
80102d59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d5e:	e9 23 01 00 00       	jmp    80102e86 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102d63:	6a 60                	push   $0x60
80102d65:	e8 b2 ff ff ff       	call   80102d1c <inb>
80102d6a:	83 c4 04             	add    $0x4,%esp
80102d6d:	0f b6 c0             	movzbl %al,%eax
80102d70:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102d73:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102d7a:	75 17                	jne    80102d93 <kbdgetc+0x5a>
    shift |= E0ESC;
80102d7c:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102d81:	83 c8 40             	or     $0x40,%eax
80102d84:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
    return 0;
80102d89:	b8 00 00 00 00       	mov    $0x0,%eax
80102d8e:	e9 f3 00 00 00       	jmp    80102e86 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102d93:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d96:	25 80 00 00 00       	and    $0x80,%eax
80102d9b:	85 c0                	test   %eax,%eax
80102d9d:	74 45                	je     80102de4 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102d9f:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102da4:	83 e0 40             	and    $0x40,%eax
80102da7:	85 c0                	test   %eax,%eax
80102da9:	75 08                	jne    80102db3 <kbdgetc+0x7a>
80102dab:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dae:	83 e0 7f             	and    $0x7f,%eax
80102db1:	eb 03                	jmp    80102db6 <kbdgetc+0x7d>
80102db3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102db6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102db9:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dbc:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102dc1:	0f b6 00             	movzbl (%eax),%eax
80102dc4:	83 c8 40             	or     $0x40,%eax
80102dc7:	0f b6 c0             	movzbl %al,%eax
80102dca:	f7 d0                	not    %eax
80102dcc:	89 c2                	mov    %eax,%edx
80102dce:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102dd3:	21 d0                	and    %edx,%eax
80102dd5:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
    return 0;
80102dda:	b8 00 00 00 00       	mov    $0x0,%eax
80102ddf:	e9 a2 00 00 00       	jmp    80102e86 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102de4:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102de9:	83 e0 40             	and    $0x40,%eax
80102dec:	85 c0                	test   %eax,%eax
80102dee:	74 14                	je     80102e04 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102df0:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102df7:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102dfc:	83 e0 bf             	and    $0xffffffbf,%eax
80102dff:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
  }

  shift |= shiftcode[data];
80102e04:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e07:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102e0c:	0f b6 00             	movzbl (%eax),%eax
80102e0f:	0f b6 d0             	movzbl %al,%edx
80102e12:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102e17:	09 d0                	or     %edx,%eax
80102e19:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
  shift ^= togglecode[data];
80102e1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e21:	05 20 a1 10 80       	add    $0x8010a120,%eax
80102e26:	0f b6 00             	movzbl (%eax),%eax
80102e29:	0f b6 d0             	movzbl %al,%edx
80102e2c:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102e31:	31 d0                	xor    %edx,%eax
80102e33:	a3 3c c6 10 80       	mov    %eax,0x8010c63c
  c = charcode[shift & (CTL | SHIFT)][data];
80102e38:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102e3d:	83 e0 03             	and    $0x3,%eax
80102e40:	8b 14 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%edx
80102e47:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e4a:	01 d0                	add    %edx,%eax
80102e4c:	0f b6 00             	movzbl (%eax),%eax
80102e4f:	0f b6 c0             	movzbl %al,%eax
80102e52:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102e55:	a1 3c c6 10 80       	mov    0x8010c63c,%eax
80102e5a:	83 e0 08             	and    $0x8,%eax
80102e5d:	85 c0                	test   %eax,%eax
80102e5f:	74 22                	je     80102e83 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102e61:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102e65:	76 0c                	jbe    80102e73 <kbdgetc+0x13a>
80102e67:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102e6b:	77 06                	ja     80102e73 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102e6d:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102e71:	eb 10                	jmp    80102e83 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102e73:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102e77:	76 0a                	jbe    80102e83 <kbdgetc+0x14a>
80102e79:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e7d:	77 04                	ja     80102e83 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102e7f:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102e83:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102e86:	c9                   	leave  
80102e87:	c3                   	ret    

80102e88 <kbdintr>:

void
kbdintr(void)
{
80102e88:	55                   	push   %ebp
80102e89:	89 e5                	mov    %esp,%ebp
80102e8b:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102e8e:	83 ec 0c             	sub    $0xc,%esp
80102e91:	68 39 2d 10 80       	push   $0x80102d39
80102e96:	e8 98 d9 ff ff       	call   80100833 <consoleintr>
80102e9b:	83 c4 10             	add    $0x10,%esp
}
80102e9e:	90                   	nop
80102e9f:	c9                   	leave  
80102ea0:	c3                   	ret    

80102ea1 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102ea1:	55                   	push   %ebp
80102ea2:	89 e5                	mov    %esp,%ebp
80102ea4:	83 ec 14             	sub    $0x14,%esp
80102ea7:	8b 45 08             	mov    0x8(%ebp),%eax
80102eaa:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eae:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102eb2:	89 c2                	mov    %eax,%edx
80102eb4:	ec                   	in     (%dx),%al
80102eb5:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102eb8:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102ebc:	c9                   	leave  
80102ebd:	c3                   	ret    

80102ebe <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102ebe:	55                   	push   %ebp
80102ebf:	89 e5                	mov    %esp,%ebp
80102ec1:	83 ec 08             	sub    $0x8,%esp
80102ec4:	8b 55 08             	mov    0x8(%ebp),%edx
80102ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
80102eca:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102ece:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ed1:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102ed5:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102ed9:	ee                   	out    %al,(%dx)
}
80102eda:	90                   	nop
80102edb:	c9                   	leave  
80102edc:	c3                   	ret    

80102edd <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102edd:	55                   	push   %ebp
80102ede:	89 e5                	mov    %esp,%ebp
80102ee0:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102ee3:	9c                   	pushf  
80102ee4:	58                   	pop    %eax
80102ee5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102ee8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102eeb:	c9                   	leave  
80102eec:	c3                   	ret    

80102eed <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102eed:	55                   	push   %ebp
80102eee:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102ef0:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102ef5:	8b 55 08             	mov    0x8(%ebp),%edx
80102ef8:	c1 e2 02             	shl    $0x2,%edx
80102efb:	01 c2                	add    %eax,%edx
80102efd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f00:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102f02:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102f07:	83 c0 20             	add    $0x20,%eax
80102f0a:	8b 00                	mov    (%eax),%eax
}
80102f0c:	90                   	nop
80102f0d:	5d                   	pop    %ebp
80102f0e:	c3                   	ret    

80102f0f <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102f0f:	55                   	push   %ebp
80102f10:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102f12:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102f17:	85 c0                	test   %eax,%eax
80102f19:	0f 84 0b 01 00 00    	je     8010302a <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102f1f:	68 3f 01 00 00       	push   $0x13f
80102f24:	6a 3c                	push   $0x3c
80102f26:	e8 c2 ff ff ff       	call   80102eed <lapicw>
80102f2b:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102f2e:	6a 0b                	push   $0xb
80102f30:	68 f8 00 00 00       	push   $0xf8
80102f35:	e8 b3 ff ff ff       	call   80102eed <lapicw>
80102f3a:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102f3d:	68 20 00 02 00       	push   $0x20020
80102f42:	68 c8 00 00 00       	push   $0xc8
80102f47:	e8 a1 ff ff ff       	call   80102eed <lapicw>
80102f4c:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
80102f4f:	68 80 96 98 00       	push   $0x989680
80102f54:	68 e0 00 00 00       	push   $0xe0
80102f59:	e8 8f ff ff ff       	call   80102eed <lapicw>
80102f5e:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102f61:	68 00 00 01 00       	push   $0x10000
80102f66:	68 d4 00 00 00       	push   $0xd4
80102f6b:	e8 7d ff ff ff       	call   80102eed <lapicw>
80102f70:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102f73:	68 00 00 01 00       	push   $0x10000
80102f78:	68 d8 00 00 00       	push   $0xd8
80102f7d:	e8 6b ff ff ff       	call   80102eed <lapicw>
80102f82:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f85:	a1 1c 47 11 80       	mov    0x8011471c,%eax
80102f8a:	83 c0 30             	add    $0x30,%eax
80102f8d:	8b 00                	mov    (%eax),%eax
80102f8f:	c1 e8 10             	shr    $0x10,%eax
80102f92:	0f b6 c0             	movzbl %al,%eax
80102f95:	83 f8 03             	cmp    $0x3,%eax
80102f98:	76 12                	jbe    80102fac <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
80102f9a:	68 00 00 01 00       	push   $0x10000
80102f9f:	68 d0 00 00 00       	push   $0xd0
80102fa4:	e8 44 ff ff ff       	call   80102eed <lapicw>
80102fa9:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102fac:	6a 33                	push   $0x33
80102fae:	68 dc 00 00 00       	push   $0xdc
80102fb3:	e8 35 ff ff ff       	call   80102eed <lapicw>
80102fb8:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102fbb:	6a 00                	push   $0x0
80102fbd:	68 a0 00 00 00       	push   $0xa0
80102fc2:	e8 26 ff ff ff       	call   80102eed <lapicw>
80102fc7:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102fca:	6a 00                	push   $0x0
80102fcc:	68 a0 00 00 00       	push   $0xa0
80102fd1:	e8 17 ff ff ff       	call   80102eed <lapicw>
80102fd6:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102fd9:	6a 00                	push   $0x0
80102fdb:	6a 2c                	push   $0x2c
80102fdd:	e8 0b ff ff ff       	call   80102eed <lapicw>
80102fe2:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102fe5:	6a 00                	push   $0x0
80102fe7:	68 c4 00 00 00       	push   $0xc4
80102fec:	e8 fc fe ff ff       	call   80102eed <lapicw>
80102ff1:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102ff4:	68 00 85 08 00       	push   $0x88500
80102ff9:	68 c0 00 00 00       	push   $0xc0
80102ffe:	e8 ea fe ff ff       	call   80102eed <lapicw>
80103003:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80103006:	90                   	nop
80103007:	a1 1c 47 11 80       	mov    0x8011471c,%eax
8010300c:	05 00 03 00 00       	add    $0x300,%eax
80103011:	8b 00                	mov    (%eax),%eax
80103013:	25 00 10 00 00       	and    $0x1000,%eax
80103018:	85 c0                	test   %eax,%eax
8010301a:	75 eb                	jne    80103007 <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010301c:	6a 00                	push   $0x0
8010301e:	6a 20                	push   $0x20
80103020:	e8 c8 fe ff ff       	call   80102eed <lapicw>
80103025:	83 c4 08             	add    $0x8,%esp
80103028:	eb 01                	jmp    8010302b <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic)
    return;
8010302a:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
8010302b:	c9                   	leave  
8010302c:	c3                   	ret    

8010302d <cpunum>:

int
cpunum(void)
{
8010302d:	55                   	push   %ebp
8010302e:	89 e5                	mov    %esp,%ebp
80103030:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103033:	e8 a5 fe ff ff       	call   80102edd <readeflags>
80103038:	25 00 02 00 00       	and    $0x200,%eax
8010303d:	85 c0                	test   %eax,%eax
8010303f:	74 26                	je     80103067 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80103041:	a1 40 c6 10 80       	mov    0x8010c640,%eax
80103046:	8d 50 01             	lea    0x1(%eax),%edx
80103049:	89 15 40 c6 10 80    	mov    %edx,0x8010c640
8010304f:	85 c0                	test   %eax,%eax
80103051:	75 14                	jne    80103067 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80103053:	8b 45 04             	mov    0x4(%ebp),%eax
80103056:	83 ec 08             	sub    $0x8,%esp
80103059:	50                   	push   %eax
8010305a:	68 74 8b 10 80       	push   $0x80108b74
8010305f:	e8 9c d3 ff ff       	call   80100400 <cprintf>
80103064:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
80103067:	a1 1c 47 11 80       	mov    0x8011471c,%eax
8010306c:	85 c0                	test   %eax,%eax
8010306e:	75 07                	jne    80103077 <cpunum+0x4a>
    return 0;
80103070:	b8 00 00 00 00       	mov    $0x0,%eax
80103075:	eb 52                	jmp    801030c9 <cpunum+0x9c>

  apicid = lapic[ID] >> 24;
80103077:	a1 1c 47 11 80       	mov    0x8011471c,%eax
8010307c:	83 c0 20             	add    $0x20,%eax
8010307f:	8b 00                	mov    (%eax),%eax
80103081:	c1 e8 18             	shr    $0x18,%eax
80103084:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < ncpu; ++i) {
80103087:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010308e:	eb 22                	jmp    801030b2 <cpunum+0x85>
    if (cpus[i].apicid == apicid)
80103090:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103093:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103099:	05 20 48 11 80       	add    $0x80114820,%eax
8010309e:	0f b6 00             	movzbl (%eax),%eax
801030a1:	0f b6 c0             	movzbl %al,%eax
801030a4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801030a7:	75 05                	jne    801030ae <cpunum+0x81>
      return i;
801030a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030ac:	eb 1b                	jmp    801030c9 <cpunum+0x9c>

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
801030ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801030b2:	a1 00 4e 11 80       	mov    0x80114e00,%eax
801030b7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801030ba:	7c d4                	jl     80103090 <cpunum+0x63>
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
801030bc:	83 ec 0c             	sub    $0xc,%esp
801030bf:	68 a0 8b 10 80       	push   $0x80108ba0
801030c4:	e8 d7 d4 ff ff       	call   801005a0 <panic>
}
801030c9:	c9                   	leave  
801030ca:	c3                   	ret    

801030cb <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
801030cb:	55                   	push   %ebp
801030cc:	89 e5                	mov    %esp,%ebp
  if(lapic)
801030ce:	a1 1c 47 11 80       	mov    0x8011471c,%eax
801030d3:	85 c0                	test   %eax,%eax
801030d5:	74 0c                	je     801030e3 <lapiceoi+0x18>
    lapicw(EOI, 0);
801030d7:	6a 00                	push   $0x0
801030d9:	6a 2c                	push   $0x2c
801030db:	e8 0d fe ff ff       	call   80102eed <lapicw>
801030e0:	83 c4 08             	add    $0x8,%esp
}
801030e3:	90                   	nop
801030e4:	c9                   	leave  
801030e5:	c3                   	ret    

801030e6 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801030e6:	55                   	push   %ebp
801030e7:	89 e5                	mov    %esp,%ebp
}
801030e9:	90                   	nop
801030ea:	5d                   	pop    %ebp
801030eb:	c3                   	ret    

801030ec <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801030ec:	55                   	push   %ebp
801030ed:	89 e5                	mov    %esp,%ebp
801030ef:	83 ec 14             	sub    $0x14,%esp
801030f2:	8b 45 08             	mov    0x8(%ebp),%eax
801030f5:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
801030f8:	6a 0f                	push   $0xf
801030fa:	6a 70                	push   $0x70
801030fc:	e8 bd fd ff ff       	call   80102ebe <outb>
80103101:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
80103104:	6a 0a                	push   $0xa
80103106:	6a 71                	push   $0x71
80103108:	e8 b1 fd ff ff       	call   80102ebe <outb>
8010310d:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103110:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80103117:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010311a:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
8010311f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103122:	83 c0 02             	add    $0x2,%eax
80103125:	8b 55 0c             	mov    0xc(%ebp),%edx
80103128:	c1 ea 04             	shr    $0x4,%edx
8010312b:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010312e:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103132:	c1 e0 18             	shl    $0x18,%eax
80103135:	50                   	push   %eax
80103136:	68 c4 00 00 00       	push   $0xc4
8010313b:	e8 ad fd ff ff       	call   80102eed <lapicw>
80103140:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103143:	68 00 c5 00 00       	push   $0xc500
80103148:	68 c0 00 00 00       	push   $0xc0
8010314d:	e8 9b fd ff ff       	call   80102eed <lapicw>
80103152:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103155:	68 c8 00 00 00       	push   $0xc8
8010315a:	e8 87 ff ff ff       	call   801030e6 <microdelay>
8010315f:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80103162:	68 00 85 00 00       	push   $0x8500
80103167:	68 c0 00 00 00       	push   $0xc0
8010316c:	e8 7c fd ff ff       	call   80102eed <lapicw>
80103171:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103174:	6a 64                	push   $0x64
80103176:	e8 6b ff ff ff       	call   801030e6 <microdelay>
8010317b:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010317e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103185:	eb 3d                	jmp    801031c4 <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
80103187:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010318b:	c1 e0 18             	shl    $0x18,%eax
8010318e:	50                   	push   %eax
8010318f:	68 c4 00 00 00       	push   $0xc4
80103194:	e8 54 fd ff ff       	call   80102eed <lapicw>
80103199:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
8010319c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010319f:	c1 e8 0c             	shr    $0xc,%eax
801031a2:	80 cc 06             	or     $0x6,%ah
801031a5:	50                   	push   %eax
801031a6:	68 c0 00 00 00       	push   $0xc0
801031ab:	e8 3d fd ff ff       	call   80102eed <lapicw>
801031b0:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801031b3:	68 c8 00 00 00       	push   $0xc8
801031b8:	e8 29 ff ff ff       	call   801030e6 <microdelay>
801031bd:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801031c0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801031c4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801031c8:	7e bd                	jle    80103187 <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801031ca:	90                   	nop
801031cb:	c9                   	leave  
801031cc:	c3                   	ret    

801031cd <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
801031cd:	55                   	push   %ebp
801031ce:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
801031d0:	8b 45 08             	mov    0x8(%ebp),%eax
801031d3:	0f b6 c0             	movzbl %al,%eax
801031d6:	50                   	push   %eax
801031d7:	6a 70                	push   $0x70
801031d9:	e8 e0 fc ff ff       	call   80102ebe <outb>
801031de:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801031e1:	68 c8 00 00 00       	push   $0xc8
801031e6:	e8 fb fe ff ff       	call   801030e6 <microdelay>
801031eb:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
801031ee:	6a 71                	push   $0x71
801031f0:	e8 ac fc ff ff       	call   80102ea1 <inb>
801031f5:	83 c4 04             	add    $0x4,%esp
801031f8:	0f b6 c0             	movzbl %al,%eax
}
801031fb:	c9                   	leave  
801031fc:	c3                   	ret    

801031fd <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
801031fd:	55                   	push   %ebp
801031fe:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
80103200:	6a 00                	push   $0x0
80103202:	e8 c6 ff ff ff       	call   801031cd <cmos_read>
80103207:	83 c4 04             	add    $0x4,%esp
8010320a:	89 c2                	mov    %eax,%edx
8010320c:	8b 45 08             	mov    0x8(%ebp),%eax
8010320f:	89 10                	mov    %edx,(%eax)
  r->minute = cmos_read(MINS);
80103211:	6a 02                	push   $0x2
80103213:	e8 b5 ff ff ff       	call   801031cd <cmos_read>
80103218:	83 c4 04             	add    $0x4,%esp
8010321b:	89 c2                	mov    %eax,%edx
8010321d:	8b 45 08             	mov    0x8(%ebp),%eax
80103220:	89 50 04             	mov    %edx,0x4(%eax)
  r->hour   = cmos_read(HOURS);
80103223:	6a 04                	push   $0x4
80103225:	e8 a3 ff ff ff       	call   801031cd <cmos_read>
8010322a:	83 c4 04             	add    $0x4,%esp
8010322d:	89 c2                	mov    %eax,%edx
8010322f:	8b 45 08             	mov    0x8(%ebp),%eax
80103232:	89 50 08             	mov    %edx,0x8(%eax)
  r->day    = cmos_read(DAY);
80103235:	6a 07                	push   $0x7
80103237:	e8 91 ff ff ff       	call   801031cd <cmos_read>
8010323c:	83 c4 04             	add    $0x4,%esp
8010323f:	89 c2                	mov    %eax,%edx
80103241:	8b 45 08             	mov    0x8(%ebp),%eax
80103244:	89 50 0c             	mov    %edx,0xc(%eax)
  r->month  = cmos_read(MONTH);
80103247:	6a 08                	push   $0x8
80103249:	e8 7f ff ff ff       	call   801031cd <cmos_read>
8010324e:	83 c4 04             	add    $0x4,%esp
80103251:	89 c2                	mov    %eax,%edx
80103253:	8b 45 08             	mov    0x8(%ebp),%eax
80103256:	89 50 10             	mov    %edx,0x10(%eax)
  r->year   = cmos_read(YEAR);
80103259:	6a 09                	push   $0x9
8010325b:	e8 6d ff ff ff       	call   801031cd <cmos_read>
80103260:	83 c4 04             	add    $0x4,%esp
80103263:	89 c2                	mov    %eax,%edx
80103265:	8b 45 08             	mov    0x8(%ebp),%eax
80103268:	89 50 14             	mov    %edx,0x14(%eax)
}
8010326b:	90                   	nop
8010326c:	c9                   	leave  
8010326d:	c3                   	ret    

8010326e <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
8010326e:	55                   	push   %ebp
8010326f:	89 e5                	mov    %esp,%ebp
80103271:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
80103274:	6a 0b                	push   $0xb
80103276:	e8 52 ff ff ff       	call   801031cd <cmos_read>
8010327b:	83 c4 04             	add    $0x4,%esp
8010327e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
80103281:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103284:	83 e0 04             	and    $0x4,%eax
80103287:	85 c0                	test   %eax,%eax
80103289:	0f 94 c0             	sete   %al
8010328c:	0f b6 c0             	movzbl %al,%eax
8010328f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
80103292:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103295:	50                   	push   %eax
80103296:	e8 62 ff ff ff       	call   801031fd <fill_rtcdate>
8010329b:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010329e:	6a 0a                	push   $0xa
801032a0:	e8 28 ff ff ff       	call   801031cd <cmos_read>
801032a5:	83 c4 04             	add    $0x4,%esp
801032a8:	25 80 00 00 00       	and    $0x80,%eax
801032ad:	85 c0                	test   %eax,%eax
801032af:	75 27                	jne    801032d8 <cmostime+0x6a>
        continue;
    fill_rtcdate(&t2);
801032b1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801032b4:	50                   	push   %eax
801032b5:	e8 43 ff ff ff       	call   801031fd <fill_rtcdate>
801032ba:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801032bd:	83 ec 04             	sub    $0x4,%esp
801032c0:	6a 18                	push   $0x18
801032c2:	8d 45 c0             	lea    -0x40(%ebp),%eax
801032c5:	50                   	push   %eax
801032c6:	8d 45 d8             	lea    -0x28(%ebp),%eax
801032c9:	50                   	push   %eax
801032ca:	e8 00 21 00 00       	call   801053cf <memcmp>
801032cf:	83 c4 10             	add    $0x10,%esp
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 05                	je     801032db <cmostime+0x6d>
801032d6:	eb ba                	jmp    80103292 <cmostime+0x24>

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
801032d8:	90                   	nop
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
  }
801032d9:	eb b7                	jmp    80103292 <cmostime+0x24>
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
      break;
801032db:	90                   	nop
  }

  // convert
  if(bcd) {
801032dc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801032e0:	0f 84 b4 00 00 00    	je     8010339a <cmostime+0x12c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801032e6:	8b 45 d8             	mov    -0x28(%ebp),%eax
801032e9:	c1 e8 04             	shr    $0x4,%eax
801032ec:	89 c2                	mov    %eax,%edx
801032ee:	89 d0                	mov    %edx,%eax
801032f0:	c1 e0 02             	shl    $0x2,%eax
801032f3:	01 d0                	add    %edx,%eax
801032f5:	01 c0                	add    %eax,%eax
801032f7:	89 c2                	mov    %eax,%edx
801032f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801032fc:	83 e0 0f             	and    $0xf,%eax
801032ff:	01 d0                	add    %edx,%eax
80103301:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103304:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103307:	c1 e8 04             	shr    $0x4,%eax
8010330a:	89 c2                	mov    %eax,%edx
8010330c:	89 d0                	mov    %edx,%eax
8010330e:	c1 e0 02             	shl    $0x2,%eax
80103311:	01 d0                	add    %edx,%eax
80103313:	01 c0                	add    %eax,%eax
80103315:	89 c2                	mov    %eax,%edx
80103317:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010331a:	83 e0 0f             	and    $0xf,%eax
8010331d:	01 d0                	add    %edx,%eax
8010331f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103322:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103325:	c1 e8 04             	shr    $0x4,%eax
80103328:	89 c2                	mov    %eax,%edx
8010332a:	89 d0                	mov    %edx,%eax
8010332c:	c1 e0 02             	shl    $0x2,%eax
8010332f:	01 d0                	add    %edx,%eax
80103331:	01 c0                	add    %eax,%eax
80103333:	89 c2                	mov    %eax,%edx
80103335:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103338:	83 e0 0f             	and    $0xf,%eax
8010333b:	01 d0                	add    %edx,%eax
8010333d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
80103340:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103343:	c1 e8 04             	shr    $0x4,%eax
80103346:	89 c2                	mov    %eax,%edx
80103348:	89 d0                	mov    %edx,%eax
8010334a:	c1 e0 02             	shl    $0x2,%eax
8010334d:	01 d0                	add    %edx,%eax
8010334f:	01 c0                	add    %eax,%eax
80103351:	89 c2                	mov    %eax,%edx
80103353:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103356:	83 e0 0f             	and    $0xf,%eax
80103359:	01 d0                	add    %edx,%eax
8010335b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
8010335e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103361:	c1 e8 04             	shr    $0x4,%eax
80103364:	89 c2                	mov    %eax,%edx
80103366:	89 d0                	mov    %edx,%eax
80103368:	c1 e0 02             	shl    $0x2,%eax
8010336b:	01 d0                	add    %edx,%eax
8010336d:	01 c0                	add    %eax,%eax
8010336f:	89 c2                	mov    %eax,%edx
80103371:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103374:	83 e0 0f             	and    $0xf,%eax
80103377:	01 d0                	add    %edx,%eax
80103379:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
8010337c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010337f:	c1 e8 04             	shr    $0x4,%eax
80103382:	89 c2                	mov    %eax,%edx
80103384:	89 d0                	mov    %edx,%eax
80103386:	c1 e0 02             	shl    $0x2,%eax
80103389:	01 d0                	add    %edx,%eax
8010338b:	01 c0                	add    %eax,%eax
8010338d:	89 c2                	mov    %eax,%edx
8010338f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103392:	83 e0 0f             	and    $0xf,%eax
80103395:	01 d0                	add    %edx,%eax
80103397:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
8010339a:	8b 45 08             	mov    0x8(%ebp),%eax
8010339d:	8b 55 d8             	mov    -0x28(%ebp),%edx
801033a0:	89 10                	mov    %edx,(%eax)
801033a2:	8b 55 dc             	mov    -0x24(%ebp),%edx
801033a5:	89 50 04             	mov    %edx,0x4(%eax)
801033a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
801033ab:	89 50 08             	mov    %edx,0x8(%eax)
801033ae:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801033b1:	89 50 0c             	mov    %edx,0xc(%eax)
801033b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801033b7:	89 50 10             	mov    %edx,0x10(%eax)
801033ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
801033bd:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
801033c0:	8b 45 08             	mov    0x8(%ebp),%eax
801033c3:	8b 40 14             	mov    0x14(%eax),%eax
801033c6:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801033cc:	8b 45 08             	mov    0x8(%ebp),%eax
801033cf:	89 50 14             	mov    %edx,0x14(%eax)
}
801033d2:	90                   	nop
801033d3:	c9                   	leave  
801033d4:	c3                   	ret    

801033d5 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801033d5:	55                   	push   %ebp
801033d6:	89 e5                	mov    %esp,%ebp
801033d8:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801033db:	83 ec 08             	sub    $0x8,%esp
801033de:	68 b0 8b 10 80       	push   $0x80108bb0
801033e3:	68 20 47 11 80       	push   $0x80114720
801033e8:	e8 df 1c 00 00       	call   801050cc <initlock>
801033ed:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
801033f0:	83 ec 08             	sub    $0x8,%esp
801033f3:	8d 45 dc             	lea    -0x24(%ebp),%eax
801033f6:	50                   	push   %eax
801033f7:	ff 75 08             	pushl  0x8(%ebp)
801033fa:	e8 0a e0 ff ff       	call   80101409 <readsb>
801033ff:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80103402:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103405:	a3 54 47 11 80       	mov    %eax,0x80114754
  log.size = sb.nlog;
8010340a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010340d:	a3 58 47 11 80       	mov    %eax,0x80114758
  log.dev = dev;
80103412:	8b 45 08             	mov    0x8(%ebp),%eax
80103415:	a3 64 47 11 80       	mov    %eax,0x80114764
  recover_from_log();
8010341a:	e8 b2 01 00 00       	call   801035d1 <recover_from_log>
}
8010341f:	90                   	nop
80103420:	c9                   	leave  
80103421:	c3                   	ret    

80103422 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80103422:	55                   	push   %ebp
80103423:	89 e5                	mov    %esp,%ebp
80103425:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103428:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010342f:	e9 95 00 00 00       	jmp    801034c9 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103434:	8b 15 54 47 11 80    	mov    0x80114754,%edx
8010343a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010343d:	01 d0                	add    %edx,%eax
8010343f:	83 c0 01             	add    $0x1,%eax
80103442:	89 c2                	mov    %eax,%edx
80103444:	a1 64 47 11 80       	mov    0x80114764,%eax
80103449:	83 ec 08             	sub    $0x8,%esp
8010344c:	52                   	push   %edx
8010344d:	50                   	push   %eax
8010344e:	e8 7b cd ff ff       	call   801001ce <bread>
80103453:	83 c4 10             	add    $0x10,%esp
80103456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103459:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010345c:	83 c0 10             	add    $0x10,%eax
8010345f:	8b 04 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%eax
80103466:	89 c2                	mov    %eax,%edx
80103468:	a1 64 47 11 80       	mov    0x80114764,%eax
8010346d:	83 ec 08             	sub    $0x8,%esp
80103470:	52                   	push   %edx
80103471:	50                   	push   %eax
80103472:	e8 57 cd ff ff       	call   801001ce <bread>
80103477:	83 c4 10             	add    $0x10,%esp
8010347a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
8010347d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103480:	8d 50 5c             	lea    0x5c(%eax),%edx
80103483:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103486:	83 c0 5c             	add    $0x5c,%eax
80103489:	83 ec 04             	sub    $0x4,%esp
8010348c:	68 00 02 00 00       	push   $0x200
80103491:	52                   	push   %edx
80103492:	50                   	push   %eax
80103493:	e8 8f 1f 00 00       	call   80105427 <memmove>
80103498:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
8010349b:	83 ec 0c             	sub    $0xc,%esp
8010349e:	ff 75 ec             	pushl  -0x14(%ebp)
801034a1:	e8 61 cd ff ff       	call   80100207 <bwrite>
801034a6:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
801034a9:	83 ec 0c             	sub    $0xc,%esp
801034ac:	ff 75 f0             	pushl  -0x10(%ebp)
801034af:	e8 9c cd ff ff       	call   80100250 <brelse>
801034b4:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801034b7:	83 ec 0c             	sub    $0xc,%esp
801034ba:	ff 75 ec             	pushl  -0x14(%ebp)
801034bd:	e8 8e cd ff ff       	call   80100250 <brelse>
801034c2:	83 c4 10             	add    $0x10,%esp
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801034c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034c9:	a1 68 47 11 80       	mov    0x80114768,%eax
801034ce:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034d1:	0f 8f 5d ff ff ff    	jg     80103434 <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
801034d7:	90                   	nop
801034d8:	c9                   	leave  
801034d9:	c3                   	ret    

801034da <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801034da:	55                   	push   %ebp
801034db:	89 e5                	mov    %esp,%ebp
801034dd:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801034e0:	a1 54 47 11 80       	mov    0x80114754,%eax
801034e5:	89 c2                	mov    %eax,%edx
801034e7:	a1 64 47 11 80       	mov    0x80114764,%eax
801034ec:	83 ec 08             	sub    $0x8,%esp
801034ef:	52                   	push   %edx
801034f0:	50                   	push   %eax
801034f1:	e8 d8 cc ff ff       	call   801001ce <bread>
801034f6:	83 c4 10             	add    $0x10,%esp
801034f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801034fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034ff:	83 c0 5c             	add    $0x5c,%eax
80103502:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103505:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103508:	8b 00                	mov    (%eax),%eax
8010350a:	a3 68 47 11 80       	mov    %eax,0x80114768
  for (i = 0; i < log.lh.n; i++) {
8010350f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103516:	eb 1b                	jmp    80103533 <read_head+0x59>
    log.lh.block[i] = lh->block[i];
80103518:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010351b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010351e:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103522:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103525:	83 c2 10             	add    $0x10,%edx
80103528:	89 04 95 2c 47 11 80 	mov    %eax,-0x7feeb8d4(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010352f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103533:	a1 68 47 11 80       	mov    0x80114768,%eax
80103538:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010353b:	7f db                	jg     80103518 <read_head+0x3e>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
8010353d:	83 ec 0c             	sub    $0xc,%esp
80103540:	ff 75 f0             	pushl  -0x10(%ebp)
80103543:	e8 08 cd ff ff       	call   80100250 <brelse>
80103548:	83 c4 10             	add    $0x10,%esp
}
8010354b:	90                   	nop
8010354c:	c9                   	leave  
8010354d:	c3                   	ret    

8010354e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010354e:	55                   	push   %ebp
8010354f:	89 e5                	mov    %esp,%ebp
80103551:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103554:	a1 54 47 11 80       	mov    0x80114754,%eax
80103559:	89 c2                	mov    %eax,%edx
8010355b:	a1 64 47 11 80       	mov    0x80114764,%eax
80103560:	83 ec 08             	sub    $0x8,%esp
80103563:	52                   	push   %edx
80103564:	50                   	push   %eax
80103565:	e8 64 cc ff ff       	call   801001ce <bread>
8010356a:	83 c4 10             	add    $0x10,%esp
8010356d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103570:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103573:	83 c0 5c             	add    $0x5c,%eax
80103576:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103579:	8b 15 68 47 11 80    	mov    0x80114768,%edx
8010357f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103582:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103584:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010358b:	eb 1b                	jmp    801035a8 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
8010358d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103590:	83 c0 10             	add    $0x10,%eax
80103593:	8b 0c 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%ecx
8010359a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010359d:	8b 55 f4             	mov    -0xc(%ebp),%edx
801035a0:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801035a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801035a8:	a1 68 47 11 80       	mov    0x80114768,%eax
801035ad:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801035b0:	7f db                	jg     8010358d <write_head+0x3f>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801035b2:	83 ec 0c             	sub    $0xc,%esp
801035b5:	ff 75 f0             	pushl  -0x10(%ebp)
801035b8:	e8 4a cc ff ff       	call   80100207 <bwrite>
801035bd:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801035c0:	83 ec 0c             	sub    $0xc,%esp
801035c3:	ff 75 f0             	pushl  -0x10(%ebp)
801035c6:	e8 85 cc ff ff       	call   80100250 <brelse>
801035cb:	83 c4 10             	add    $0x10,%esp
}
801035ce:	90                   	nop
801035cf:	c9                   	leave  
801035d0:	c3                   	ret    

801035d1 <recover_from_log>:

static void
recover_from_log(void)
{
801035d1:	55                   	push   %ebp
801035d2:	89 e5                	mov    %esp,%ebp
801035d4:	83 ec 08             	sub    $0x8,%esp
  read_head();
801035d7:	e8 fe fe ff ff       	call   801034da <read_head>
  install_trans(); // if committed, copy from log to disk
801035dc:	e8 41 fe ff ff       	call   80103422 <install_trans>
  log.lh.n = 0;
801035e1:	c7 05 68 47 11 80 00 	movl   $0x0,0x80114768
801035e8:	00 00 00 
  write_head(); // clear the log
801035eb:	e8 5e ff ff ff       	call   8010354e <write_head>
}
801035f0:	90                   	nop
801035f1:	c9                   	leave  
801035f2:	c3                   	ret    

801035f3 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
801035f3:	55                   	push   %ebp
801035f4:	89 e5                	mov    %esp,%ebp
801035f6:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801035f9:	83 ec 0c             	sub    $0xc,%esp
801035fc:	68 20 47 11 80       	push   $0x80114720
80103601:	e8 e8 1a 00 00       	call   801050ee <acquire>
80103606:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103609:	a1 60 47 11 80       	mov    0x80114760,%eax
8010360e:	85 c0                	test   %eax,%eax
80103610:	74 17                	je     80103629 <begin_op+0x36>
      sleep(&log, &log.lock);
80103612:	83 ec 08             	sub    $0x8,%esp
80103615:	68 20 47 11 80       	push   $0x80114720
8010361a:	68 20 47 11 80       	push   $0x80114720
8010361f:	e8 ab 16 00 00       	call   80104ccf <sleep>
80103624:	83 c4 10             	add    $0x10,%esp
80103627:	eb e0                	jmp    80103609 <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103629:	8b 0d 68 47 11 80    	mov    0x80114768,%ecx
8010362f:	a1 5c 47 11 80       	mov    0x8011475c,%eax
80103634:	8d 50 01             	lea    0x1(%eax),%edx
80103637:	89 d0                	mov    %edx,%eax
80103639:	c1 e0 02             	shl    $0x2,%eax
8010363c:	01 d0                	add    %edx,%eax
8010363e:	01 c0                	add    %eax,%eax
80103640:	01 c8                	add    %ecx,%eax
80103642:	83 f8 1e             	cmp    $0x1e,%eax
80103645:	7e 17                	jle    8010365e <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103647:	83 ec 08             	sub    $0x8,%esp
8010364a:	68 20 47 11 80       	push   $0x80114720
8010364f:	68 20 47 11 80       	push   $0x80114720
80103654:	e8 76 16 00 00       	call   80104ccf <sleep>
80103659:	83 c4 10             	add    $0x10,%esp
8010365c:	eb ab                	jmp    80103609 <begin_op+0x16>
    } else {
      log.outstanding += 1;
8010365e:	a1 5c 47 11 80       	mov    0x8011475c,%eax
80103663:	83 c0 01             	add    $0x1,%eax
80103666:	a3 5c 47 11 80       	mov    %eax,0x8011475c
      release(&log.lock);
8010366b:	83 ec 0c             	sub    $0xc,%esp
8010366e:	68 20 47 11 80       	push   $0x80114720
80103673:	e8 e2 1a 00 00       	call   8010515a <release>
80103678:	83 c4 10             	add    $0x10,%esp
      break;
8010367b:	90                   	nop
    }
  }
}
8010367c:	90                   	nop
8010367d:	c9                   	leave  
8010367e:	c3                   	ret    

8010367f <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
8010367f:	55                   	push   %ebp
80103680:	89 e5                	mov    %esp,%ebp
80103682:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
80103685:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
8010368c:	83 ec 0c             	sub    $0xc,%esp
8010368f:	68 20 47 11 80       	push   $0x80114720
80103694:	e8 55 1a 00 00       	call   801050ee <acquire>
80103699:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
8010369c:	a1 5c 47 11 80       	mov    0x8011475c,%eax
801036a1:	83 e8 01             	sub    $0x1,%eax
801036a4:	a3 5c 47 11 80       	mov    %eax,0x8011475c
  if(log.committing)
801036a9:	a1 60 47 11 80       	mov    0x80114760,%eax
801036ae:	85 c0                	test   %eax,%eax
801036b0:	74 0d                	je     801036bf <end_op+0x40>
    panic("log.committing");
801036b2:	83 ec 0c             	sub    $0xc,%esp
801036b5:	68 b4 8b 10 80       	push   $0x80108bb4
801036ba:	e8 e1 ce ff ff       	call   801005a0 <panic>
  if(log.outstanding == 0){
801036bf:	a1 5c 47 11 80       	mov    0x8011475c,%eax
801036c4:	85 c0                	test   %eax,%eax
801036c6:	75 13                	jne    801036db <end_op+0x5c>
    do_commit = 1;
801036c8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
801036cf:	c7 05 60 47 11 80 01 	movl   $0x1,0x80114760
801036d6:	00 00 00 
801036d9:	eb 10                	jmp    801036eb <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
801036db:	83 ec 0c             	sub    $0xc,%esp
801036de:	68 20 47 11 80       	push   $0x80114720
801036e3:	e8 d2 16 00 00       	call   80104dba <wakeup>
801036e8:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
801036eb:	83 ec 0c             	sub    $0xc,%esp
801036ee:	68 20 47 11 80       	push   $0x80114720
801036f3:	e8 62 1a 00 00       	call   8010515a <release>
801036f8:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
801036fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801036ff:	74 3f                	je     80103740 <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103701:	e8 f5 00 00 00       	call   801037fb <commit>
    acquire(&log.lock);
80103706:	83 ec 0c             	sub    $0xc,%esp
80103709:	68 20 47 11 80       	push   $0x80114720
8010370e:	e8 db 19 00 00       	call   801050ee <acquire>
80103713:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103716:	c7 05 60 47 11 80 00 	movl   $0x0,0x80114760
8010371d:	00 00 00 
    wakeup(&log);
80103720:	83 ec 0c             	sub    $0xc,%esp
80103723:	68 20 47 11 80       	push   $0x80114720
80103728:	e8 8d 16 00 00       	call   80104dba <wakeup>
8010372d:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
80103730:	83 ec 0c             	sub    $0xc,%esp
80103733:	68 20 47 11 80       	push   $0x80114720
80103738:	e8 1d 1a 00 00       	call   8010515a <release>
8010373d:	83 c4 10             	add    $0x10,%esp
  }
}
80103740:	90                   	nop
80103741:	c9                   	leave  
80103742:	c3                   	ret    

80103743 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80103743:	55                   	push   %ebp
80103744:	89 e5                	mov    %esp,%ebp
80103746:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103749:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103750:	e9 95 00 00 00       	jmp    801037ea <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103755:	8b 15 54 47 11 80    	mov    0x80114754,%edx
8010375b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010375e:	01 d0                	add    %edx,%eax
80103760:	83 c0 01             	add    $0x1,%eax
80103763:	89 c2                	mov    %eax,%edx
80103765:	a1 64 47 11 80       	mov    0x80114764,%eax
8010376a:	83 ec 08             	sub    $0x8,%esp
8010376d:	52                   	push   %edx
8010376e:	50                   	push   %eax
8010376f:	e8 5a ca ff ff       	call   801001ce <bread>
80103774:	83 c4 10             	add    $0x10,%esp
80103777:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010377a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010377d:	83 c0 10             	add    $0x10,%eax
80103780:	8b 04 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%eax
80103787:	89 c2                	mov    %eax,%edx
80103789:	a1 64 47 11 80       	mov    0x80114764,%eax
8010378e:	83 ec 08             	sub    $0x8,%esp
80103791:	52                   	push   %edx
80103792:	50                   	push   %eax
80103793:	e8 36 ca ff ff       	call   801001ce <bread>
80103798:	83 c4 10             	add    $0x10,%esp
8010379b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
8010379e:	8b 45 ec             	mov    -0x14(%ebp),%eax
801037a1:	8d 50 5c             	lea    0x5c(%eax),%edx
801037a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037a7:	83 c0 5c             	add    $0x5c,%eax
801037aa:	83 ec 04             	sub    $0x4,%esp
801037ad:	68 00 02 00 00       	push   $0x200
801037b2:	52                   	push   %edx
801037b3:	50                   	push   %eax
801037b4:	e8 6e 1c 00 00       	call   80105427 <memmove>
801037b9:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
801037bc:	83 ec 0c             	sub    $0xc,%esp
801037bf:	ff 75 f0             	pushl  -0x10(%ebp)
801037c2:	e8 40 ca ff ff       	call   80100207 <bwrite>
801037c7:	83 c4 10             	add    $0x10,%esp
    brelse(from);
801037ca:	83 ec 0c             	sub    $0xc,%esp
801037cd:	ff 75 ec             	pushl  -0x14(%ebp)
801037d0:	e8 7b ca ff ff       	call   80100250 <brelse>
801037d5:	83 c4 10             	add    $0x10,%esp
    brelse(to);
801037d8:	83 ec 0c             	sub    $0xc,%esp
801037db:	ff 75 f0             	pushl  -0x10(%ebp)
801037de:	e8 6d ca ff ff       	call   80100250 <brelse>
801037e3:	83 c4 10             	add    $0x10,%esp
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037e6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037ea:	a1 68 47 11 80       	mov    0x80114768,%eax
801037ef:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037f2:	0f 8f 5d ff ff ff    	jg     80103755 <write_log+0x12>
    memmove(to->data, from->data, BSIZE);
    bwrite(to);  // write the log
    brelse(from);
    brelse(to);
  }
}
801037f8:	90                   	nop
801037f9:	c9                   	leave  
801037fa:	c3                   	ret    

801037fb <commit>:

static void
commit()
{
801037fb:	55                   	push   %ebp
801037fc:	89 e5                	mov    %esp,%ebp
801037fe:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103801:	a1 68 47 11 80       	mov    0x80114768,%eax
80103806:	85 c0                	test   %eax,%eax
80103808:	7e 1e                	jle    80103828 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
8010380a:	e8 34 ff ff ff       	call   80103743 <write_log>
    write_head();    // Write header to disk -- the real commit
8010380f:	e8 3a fd ff ff       	call   8010354e <write_head>
    install_trans(); // Now install writes to home locations
80103814:	e8 09 fc ff ff       	call   80103422 <install_trans>
    log.lh.n = 0;
80103819:	c7 05 68 47 11 80 00 	movl   $0x0,0x80114768
80103820:	00 00 00 
    write_head();    // Erase the transaction from the log
80103823:	e8 26 fd ff ff       	call   8010354e <write_head>
  }
}
80103828:	90                   	nop
80103829:	c9                   	leave  
8010382a:	c3                   	ret    

8010382b <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010382b:	55                   	push   %ebp
8010382c:	89 e5                	mov    %esp,%ebp
8010382e:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103831:	a1 68 47 11 80       	mov    0x80114768,%eax
80103836:	83 f8 1d             	cmp    $0x1d,%eax
80103839:	7f 12                	jg     8010384d <log_write+0x22>
8010383b:	a1 68 47 11 80       	mov    0x80114768,%eax
80103840:	8b 15 58 47 11 80    	mov    0x80114758,%edx
80103846:	83 ea 01             	sub    $0x1,%edx
80103849:	39 d0                	cmp    %edx,%eax
8010384b:	7c 0d                	jl     8010385a <log_write+0x2f>
    panic("too big a transaction");
8010384d:	83 ec 0c             	sub    $0xc,%esp
80103850:	68 c3 8b 10 80       	push   $0x80108bc3
80103855:	e8 46 cd ff ff       	call   801005a0 <panic>
  if (log.outstanding < 1)
8010385a:	a1 5c 47 11 80       	mov    0x8011475c,%eax
8010385f:	85 c0                	test   %eax,%eax
80103861:	7f 0d                	jg     80103870 <log_write+0x45>
    panic("log_write outside of trans");
80103863:	83 ec 0c             	sub    $0xc,%esp
80103866:	68 d9 8b 10 80       	push   $0x80108bd9
8010386b:	e8 30 cd ff ff       	call   801005a0 <panic>

  acquire(&log.lock);
80103870:	83 ec 0c             	sub    $0xc,%esp
80103873:	68 20 47 11 80       	push   $0x80114720
80103878:	e8 71 18 00 00       	call   801050ee <acquire>
8010387d:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
80103880:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103887:	eb 1d                	jmp    801038a6 <log_write+0x7b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103889:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010388c:	83 c0 10             	add    $0x10,%eax
8010388f:	8b 04 85 2c 47 11 80 	mov    -0x7feeb8d4(,%eax,4),%eax
80103896:	89 c2                	mov    %eax,%edx
80103898:	8b 45 08             	mov    0x8(%ebp),%eax
8010389b:	8b 40 08             	mov    0x8(%eax),%eax
8010389e:	39 c2                	cmp    %eax,%edx
801038a0:	74 10                	je     801038b2 <log_write+0x87>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
801038a2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801038a6:	a1 68 47 11 80       	mov    0x80114768,%eax
801038ab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038ae:	7f d9                	jg     80103889 <log_write+0x5e>
801038b0:	eb 01                	jmp    801038b3 <log_write+0x88>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
801038b2:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
801038b3:	8b 45 08             	mov    0x8(%ebp),%eax
801038b6:	8b 40 08             	mov    0x8(%eax),%eax
801038b9:	89 c2                	mov    %eax,%edx
801038bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801038be:	83 c0 10             	add    $0x10,%eax
801038c1:	89 14 85 2c 47 11 80 	mov    %edx,-0x7feeb8d4(,%eax,4)
  if (i == log.lh.n)
801038c8:	a1 68 47 11 80       	mov    0x80114768,%eax
801038cd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801038d0:	75 0d                	jne    801038df <log_write+0xb4>
    log.lh.n++;
801038d2:	a1 68 47 11 80       	mov    0x80114768,%eax
801038d7:	83 c0 01             	add    $0x1,%eax
801038da:	a3 68 47 11 80       	mov    %eax,0x80114768
  b->flags |= B_DIRTY; // prevent eviction
801038df:	8b 45 08             	mov    0x8(%ebp),%eax
801038e2:	8b 00                	mov    (%eax),%eax
801038e4:	83 c8 04             	or     $0x4,%eax
801038e7:	89 c2                	mov    %eax,%edx
801038e9:	8b 45 08             	mov    0x8(%ebp),%eax
801038ec:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
801038ee:	83 ec 0c             	sub    $0xc,%esp
801038f1:	68 20 47 11 80       	push   $0x80114720
801038f6:	e8 5f 18 00 00       	call   8010515a <release>
801038fb:	83 c4 10             	add    $0x10,%esp
}
801038fe:	90                   	nop
801038ff:	c9                   	leave  
80103900:	c3                   	ret    

80103901 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103901:	55                   	push   %ebp
80103902:	89 e5                	mov    %esp,%ebp
80103904:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103907:	8b 55 08             	mov    0x8(%ebp),%edx
8010390a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010390d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103910:	f0 87 02             	lock xchg %eax,(%edx)
80103913:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103916:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103919:	c9                   	leave  
8010391a:	c3                   	ret    

8010391b <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010391b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010391f:	83 e4 f0             	and    $0xfffffff0,%esp
80103922:	ff 71 fc             	pushl  -0x4(%ecx)
80103925:	55                   	push   %ebp
80103926:	89 e5                	mov    %esp,%ebp
80103928:	51                   	push   %ecx
80103929:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010392c:	83 ec 08             	sub    $0x8,%esp
8010392f:	68 00 00 40 80       	push   $0x80400000
80103934:	68 a8 76 11 80       	push   $0x801176a8
80103939:	e8 55 f2 ff ff       	call   80102b93 <kinit1>
8010393e:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103941:	e8 7c 48 00 00       	call   801081c2 <kvmalloc>
  mpinit();        // detect other processors
80103946:	e8 e4 03 00 00       	call   80103d2f <mpinit>
  lapicinit();     // interrupt controller
8010394b:	e8 bf f5 ff ff       	call   80102f0f <lapicinit>
  seginit();       // segment descriptors
80103950:	e8 47 42 00 00       	call   80107b9c <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80103955:	e8 d3 f6 ff ff       	call   8010302d <cpunum>
8010395a:	83 ec 08             	sub    $0x8,%esp
8010395d:	50                   	push   %eax
8010395e:	68 f4 8b 10 80       	push   $0x80108bf4
80103963:	e8 98 ca ff ff       	call   80100400 <cprintf>
80103968:	83 c4 10             	add    $0x10,%esp
  picinit();       // another interrupt controller
8010396b:	e8 94 05 00 00       	call   80103f04 <picinit>
  ioapicinit();    // another interrupt controller
80103970:	e8 20 f1 ff ff       	call   80102a95 <ioapicinit>
  consoleinit();   // console hardware
80103975:	e8 d9 d1 ff ff       	call   80100b53 <consoleinit>
  uartinit();      // serial port
8010397a:	e8 93 35 00 00       	call   80106f12 <uartinit>
  pinit();         // process table
8010397f:	e8 7d 0a 00 00       	call   80104401 <pinit>
  tvinit();        // trap vectors
80103984:	e8 59 2f 00 00       	call   801068e2 <tvinit>
  binit();         // buffer cache
80103989:	e8 a6 c6 ff ff       	call   80100034 <binit>
  fileinit();      // file table
8010398e:	e8 67 d6 ff ff       	call   80100ffa <fileinit>
  ideinit();       // disk
80103993:	e8 c7 ec ff ff       	call   8010265f <ideinit>
  if(!ismp)
80103998:	a1 04 48 11 80       	mov    0x80114804,%eax
8010399d:	85 c0                	test   %eax,%eax
8010399f:	75 05                	jne    801039a6 <main+0x8b>
    timerinit();   // uniprocessor timer
801039a1:	e8 99 2e 00 00       	call   8010683f <timerinit>
  startothers();   // start other processors
801039a6:	e8 78 00 00 00       	call   80103a23 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801039ab:	83 ec 08             	sub    $0x8,%esp
801039ae:	68 00 00 00 8e       	push   $0x8e000000
801039b3:	68 00 00 40 80       	push   $0x80400000
801039b8:	e8 0f f2 ff ff       	call   80102bcc <kinit2>
801039bd:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801039c0:	e8 60 0b 00 00       	call   80104525 <userinit>
  mpmain();        // finish this processor's setup
801039c5:	e8 1a 00 00 00       	call   801039e4 <mpmain>

801039ca <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801039ca:	55                   	push   %ebp
801039cb:	89 e5                	mov    %esp,%ebp
801039cd:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801039d0:	e8 05 48 00 00       	call   801081da <switchkvm>
  seginit();
801039d5:	e8 c2 41 00 00       	call   80107b9c <seginit>
  lapicinit();
801039da:	e8 30 f5 ff ff       	call   80102f0f <lapicinit>
  mpmain();
801039df:	e8 00 00 00 00       	call   801039e4 <mpmain>

801039e4 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801039e4:	55                   	push   %ebp
801039e5:	89 e5                	mov    %esp,%ebp
801039e7:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
801039ea:	e8 3e f6 ff ff       	call   8010302d <cpunum>
801039ef:	83 ec 08             	sub    $0x8,%esp
801039f2:	50                   	push   %eax
801039f3:	68 0b 8c 10 80       	push   $0x80108c0b
801039f8:	e8 03 ca ff ff       	call   80100400 <cprintf>
801039fd:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103a00:	e8 53 30 00 00       	call   80106a58 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103a05:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103a0b:	05 a8 00 00 00       	add    $0xa8,%eax
80103a10:	83 ec 08             	sub    $0x8,%esp
80103a13:	6a 01                	push   $0x1
80103a15:	50                   	push   %eax
80103a16:	e8 e6 fe ff ff       	call   80103901 <xchg>
80103a1b:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103a1e:	e8 cd 10 00 00       	call   80104af0 <scheduler>

80103a23 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103a23:	55                   	push   %ebp
80103a24:	89 e5                	mov    %esp,%ebp
80103a26:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
80103a29:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103a30:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103a35:	83 ec 04             	sub    $0x4,%esp
80103a38:	50                   	push   %eax
80103a39:	68 0c c5 10 80       	push   $0x8010c50c
80103a3e:	ff 75 f0             	pushl  -0x10(%ebp)
80103a41:	e8 e1 19 00 00       	call   80105427 <memmove>
80103a46:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103a49:	c7 45 f4 20 48 11 80 	movl   $0x80114820,-0xc(%ebp)
80103a50:	e9 84 00 00 00       	jmp    80103ad9 <startothers+0xb6>
    if(c == cpus+cpunum())  // We've started already.
80103a55:	e8 d3 f5 ff ff       	call   8010302d <cpunum>
80103a5a:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a60:	05 20 48 11 80       	add    $0x80114820,%eax
80103a65:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a68:	74 67                	je     80103ad1 <startothers+0xae>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103a6a:	e8 58 f2 ff ff       	call   80102cc7 <kalloc>
80103a6f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a75:	83 e8 04             	sub    $0x4,%eax
80103a78:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103a7b:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103a81:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a86:	83 e8 08             	sub    $0x8,%eax
80103a89:	c7 00 ca 39 10 80    	movl   $0x801039ca,(%eax)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a92:	83 e8 0c             	sub    $0xc,%eax
80103a95:	ba 00 b0 10 80       	mov    $0x8010b000,%edx
80103a9a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80103aa0:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
80103aa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aa5:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80103aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103aae:	0f b6 00             	movzbl (%eax),%eax
80103ab1:	0f b6 c0             	movzbl %al,%eax
80103ab4:	83 ec 08             	sub    $0x8,%esp
80103ab7:	52                   	push   %edx
80103ab8:	50                   	push   %eax
80103ab9:	e8 2e f6 ff ff       	call   801030ec <lapicstartap>
80103abe:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103ac1:	90                   	nop
80103ac2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ac5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103acb:	85 c0                	test   %eax,%eax
80103acd:	74 f3                	je     80103ac2 <startothers+0x9f>
80103acf:	eb 01                	jmp    80103ad2 <startothers+0xaf>
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
80103ad1:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103ad2:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103ad9:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103ade:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103ae4:	05 20 48 11 80       	add    $0x80114820,%eax
80103ae9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103aec:	0f 87 63 ff ff ff    	ja     80103a55 <startothers+0x32>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
80103af2:	90                   	nop
80103af3:	c9                   	leave  
80103af4:	c3                   	ret    

80103af5 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103af5:	55                   	push   %ebp
80103af6:	89 e5                	mov    %esp,%ebp
80103af8:	83 ec 14             	sub    $0x14,%esp
80103afb:	8b 45 08             	mov    0x8(%ebp),%eax
80103afe:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103b02:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103b06:	89 c2                	mov    %eax,%edx
80103b08:	ec                   	in     (%dx),%al
80103b09:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103b0c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103b10:	c9                   	leave  
80103b11:	c3                   	ret    

80103b12 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103b12:	55                   	push   %ebp
80103b13:	89 e5                	mov    %esp,%ebp
80103b15:	83 ec 08             	sub    $0x8,%esp
80103b18:	8b 55 08             	mov    0x8(%ebp),%edx
80103b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80103b1e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103b22:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103b25:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103b29:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103b2d:	ee                   	out    %al,(%dx)
}
80103b2e:	90                   	nop
80103b2f:	c9                   	leave  
80103b30:	c3                   	ret    

80103b31 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80103b31:	55                   	push   %ebp
80103b32:	89 e5                	mov    %esp,%ebp
80103b34:	83 ec 10             	sub    $0x10,%esp
  int i, sum;

  sum = 0;
80103b37:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103b3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103b45:	eb 15                	jmp    80103b5c <sum+0x2b>
    sum += addr[i];
80103b47:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103b4a:	8b 45 08             	mov    0x8(%ebp),%eax
80103b4d:	01 d0                	add    %edx,%eax
80103b4f:	0f b6 00             	movzbl (%eax),%eax
80103b52:	0f b6 c0             	movzbl %al,%eax
80103b55:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103b58:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103b5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103b5f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103b62:	7c e3                	jl     80103b47 <sum+0x16>
    sum += addr[i];
  return sum;
80103b64:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103b67:	c9                   	leave  
80103b68:	c3                   	ret    

80103b69 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103b69:	55                   	push   %ebp
80103b6a:	89 e5                	mov    %esp,%ebp
80103b6c:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80103b6f:	8b 45 08             	mov    0x8(%ebp),%eax
80103b72:	05 00 00 00 80       	add    $0x80000000,%eax
80103b77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103b7a:	8b 55 0c             	mov    0xc(%ebp),%edx
80103b7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b80:	01 d0                	add    %edx,%eax
80103b82:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b88:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103b8b:	eb 36                	jmp    80103bc3 <mpsearch1+0x5a>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103b8d:	83 ec 04             	sub    $0x4,%esp
80103b90:	6a 04                	push   $0x4
80103b92:	68 1c 8c 10 80       	push   $0x80108c1c
80103b97:	ff 75 f4             	pushl  -0xc(%ebp)
80103b9a:	e8 30 18 00 00       	call   801053cf <memcmp>
80103b9f:	83 c4 10             	add    $0x10,%esp
80103ba2:	85 c0                	test   %eax,%eax
80103ba4:	75 19                	jne    80103bbf <mpsearch1+0x56>
80103ba6:	83 ec 08             	sub    $0x8,%esp
80103ba9:	6a 10                	push   $0x10
80103bab:	ff 75 f4             	pushl  -0xc(%ebp)
80103bae:	e8 7e ff ff ff       	call   80103b31 <sum>
80103bb3:	83 c4 10             	add    $0x10,%esp
80103bb6:	84 c0                	test   %al,%al
80103bb8:	75 05                	jne    80103bbf <mpsearch1+0x56>
      return (struct mp*)p;
80103bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbd:	eb 11                	jmp    80103bd0 <mpsearch1+0x67>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103bbf:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bc6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103bc9:	72 c2                	jb     80103b8d <mpsearch1+0x24>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103bcb:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103bd0:	c9                   	leave  
80103bd1:	c3                   	ret    

80103bd2 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103bd2:	55                   	push   %ebp
80103bd3:	89 e5                	mov    %esp,%ebp
80103bd5:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103bd8:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103be2:	83 c0 0f             	add    $0xf,%eax
80103be5:	0f b6 00             	movzbl (%eax),%eax
80103be8:	0f b6 c0             	movzbl %al,%eax
80103beb:	c1 e0 08             	shl    $0x8,%eax
80103bee:	89 c2                	mov    %eax,%edx
80103bf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bf3:	83 c0 0e             	add    $0xe,%eax
80103bf6:	0f b6 00             	movzbl (%eax),%eax
80103bf9:	0f b6 c0             	movzbl %al,%eax
80103bfc:	09 d0                	or     %edx,%eax
80103bfe:	c1 e0 04             	shl    $0x4,%eax
80103c01:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c04:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103c08:	74 21                	je     80103c2b <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103c0a:	83 ec 08             	sub    $0x8,%esp
80103c0d:	68 00 04 00 00       	push   $0x400
80103c12:	ff 75 f0             	pushl  -0x10(%ebp)
80103c15:	e8 4f ff ff ff       	call   80103b69 <mpsearch1>
80103c1a:	83 c4 10             	add    $0x10,%esp
80103c1d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c20:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c24:	74 51                	je     80103c77 <mpsearch+0xa5>
      return mp;
80103c26:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c29:	eb 61                	jmp    80103c8c <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c2e:	83 c0 14             	add    $0x14,%eax
80103c31:	0f b6 00             	movzbl (%eax),%eax
80103c34:	0f b6 c0             	movzbl %al,%eax
80103c37:	c1 e0 08             	shl    $0x8,%eax
80103c3a:	89 c2                	mov    %eax,%edx
80103c3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c3f:	83 c0 13             	add    $0x13,%eax
80103c42:	0f b6 00             	movzbl (%eax),%eax
80103c45:	0f b6 c0             	movzbl %al,%eax
80103c48:	09 d0                	or     %edx,%eax
80103c4a:	c1 e0 0a             	shl    $0xa,%eax
80103c4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103c50:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c53:	2d 00 04 00 00       	sub    $0x400,%eax
80103c58:	83 ec 08             	sub    $0x8,%esp
80103c5b:	68 00 04 00 00       	push   $0x400
80103c60:	50                   	push   %eax
80103c61:	e8 03 ff ff ff       	call   80103b69 <mpsearch1>
80103c66:	83 c4 10             	add    $0x10,%esp
80103c69:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c6c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c70:	74 05                	je     80103c77 <mpsearch+0xa5>
      return mp;
80103c72:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c75:	eb 15                	jmp    80103c8c <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103c77:	83 ec 08             	sub    $0x8,%esp
80103c7a:	68 00 00 01 00       	push   $0x10000
80103c7f:	68 00 00 0f 00       	push   $0xf0000
80103c84:	e8 e0 fe ff ff       	call   80103b69 <mpsearch1>
80103c89:	83 c4 10             	add    $0x10,%esp
}
80103c8c:	c9                   	leave  
80103c8d:	c3                   	ret    

80103c8e <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103c8e:	55                   	push   %ebp
80103c8f:	89 e5                	mov    %esp,%ebp
80103c91:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c94:	e8 39 ff ff ff       	call   80103bd2 <mpsearch>
80103c99:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c9c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103ca0:	74 0a                	je     80103cac <mpconfig+0x1e>
80103ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca5:	8b 40 04             	mov    0x4(%eax),%eax
80103ca8:	85 c0                	test   %eax,%eax
80103caa:	75 07                	jne    80103cb3 <mpconfig+0x25>
    return 0;
80103cac:	b8 00 00 00 00       	mov    $0x0,%eax
80103cb1:	eb 7a                	jmp    80103d2d <mpconfig+0x9f>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103cb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cb6:	8b 40 04             	mov    0x4(%eax),%eax
80103cb9:	05 00 00 00 80       	add    $0x80000000,%eax
80103cbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103cc1:	83 ec 04             	sub    $0x4,%esp
80103cc4:	6a 04                	push   $0x4
80103cc6:	68 21 8c 10 80       	push   $0x80108c21
80103ccb:	ff 75 f0             	pushl  -0x10(%ebp)
80103cce:	e8 fc 16 00 00       	call   801053cf <memcmp>
80103cd3:	83 c4 10             	add    $0x10,%esp
80103cd6:	85 c0                	test   %eax,%eax
80103cd8:	74 07                	je     80103ce1 <mpconfig+0x53>
    return 0;
80103cda:	b8 00 00 00 00       	mov    $0x0,%eax
80103cdf:	eb 4c                	jmp    80103d2d <mpconfig+0x9f>
  if(conf->version != 1 && conf->version != 4)
80103ce1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ce4:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103ce8:	3c 01                	cmp    $0x1,%al
80103cea:	74 12                	je     80103cfe <mpconfig+0x70>
80103cec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cef:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103cf3:	3c 04                	cmp    $0x4,%al
80103cf5:	74 07                	je     80103cfe <mpconfig+0x70>
    return 0;
80103cf7:	b8 00 00 00 00       	mov    $0x0,%eax
80103cfc:	eb 2f                	jmp    80103d2d <mpconfig+0x9f>
  if(sum((uchar*)conf, conf->length) != 0)
80103cfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d01:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d05:	0f b7 c0             	movzwl %ax,%eax
80103d08:	83 ec 08             	sub    $0x8,%esp
80103d0b:	50                   	push   %eax
80103d0c:	ff 75 f0             	pushl  -0x10(%ebp)
80103d0f:	e8 1d fe ff ff       	call   80103b31 <sum>
80103d14:	83 c4 10             	add    $0x10,%esp
80103d17:	84 c0                	test   %al,%al
80103d19:	74 07                	je     80103d22 <mpconfig+0x94>
    return 0;
80103d1b:	b8 00 00 00 00       	mov    $0x0,%eax
80103d20:	eb 0b                	jmp    80103d2d <mpconfig+0x9f>
  *pmp = mp;
80103d22:	8b 45 08             	mov    0x8(%ebp),%eax
80103d25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d28:	89 10                	mov    %edx,(%eax)
  return conf;
80103d2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103d2d:	c9                   	leave  
80103d2e:	c3                   	ret    

80103d2f <mpinit>:

void
mpinit(void)
{
80103d2f:	55                   	push   %ebp
80103d30:	89 e5                	mov    %esp,%ebp
80103d32:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103d35:	83 ec 0c             	sub    $0xc,%esp
80103d38:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103d3b:	50                   	push   %eax
80103d3c:	e8 4d ff ff ff       	call   80103c8e <mpconfig>
80103d41:	83 c4 10             	add    $0x10,%esp
80103d44:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103d47:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d4b:	0f 84 1f 01 00 00    	je     80103e70 <mpinit+0x141>
    return;
  ismp = 1;
80103d51:	c7 05 04 48 11 80 01 	movl   $0x1,0x80114804
80103d58:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103d5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d5e:	8b 40 24             	mov    0x24(%eax),%eax
80103d61:	a3 1c 47 11 80       	mov    %eax,0x8011471c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d66:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d69:	83 c0 2c             	add    $0x2c,%eax
80103d6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103d6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d72:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103d76:	0f b7 d0             	movzwl %ax,%edx
80103d79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103d7c:	01 d0                	add    %edx,%eax
80103d7e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103d81:	eb 7e                	jmp    80103e01 <mpinit+0xd2>
    switch(*p){
80103d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d86:	0f b6 00             	movzbl (%eax),%eax
80103d89:	0f b6 c0             	movzbl %al,%eax
80103d8c:	83 f8 04             	cmp    $0x4,%eax
80103d8f:	77 65                	ja     80103df6 <mpinit+0xc7>
80103d91:	8b 04 85 28 8c 10 80 	mov    -0x7fef73d8(,%eax,4),%eax
80103d98:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103d9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d9d:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu < NCPU) {
80103da0:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103da5:	83 f8 07             	cmp    $0x7,%eax
80103da8:	7f 28                	jg     80103dd2 <mpinit+0xa3>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103daa:	8b 15 00 4e 11 80    	mov    0x80114e00,%edx
80103db0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103db3:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103db7:	69 d2 bc 00 00 00    	imul   $0xbc,%edx,%edx
80103dbd:	81 c2 20 48 11 80    	add    $0x80114820,%edx
80103dc3:	88 02                	mov    %al,(%edx)
        ncpu++;
80103dc5:	a1 00 4e 11 80       	mov    0x80114e00,%eax
80103dca:	83 c0 01             	add    $0x1,%eax
80103dcd:	a3 00 4e 11 80       	mov    %eax,0x80114e00
      }
      p += sizeof(struct mpproc);
80103dd2:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103dd6:	eb 29                	jmp    80103e01 <mpinit+0xd2>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103dd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ddb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103dde:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103de1:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103de5:	a2 00 48 11 80       	mov    %al,0x80114800
      p += sizeof(struct mpioapic);
80103dea:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103dee:	eb 11                	jmp    80103e01 <mpinit+0xd2>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103df0:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103df4:	eb 0b                	jmp    80103e01 <mpinit+0xd2>
    default:
      ismp = 0;
80103df6:	c7 05 04 48 11 80 00 	movl   $0x0,0x80114804
80103dfd:	00 00 00 
      break;
80103e00:	90                   	nop

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e04:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103e07:	0f 82 76 ff ff ff    	jb     80103d83 <mpinit+0x54>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
80103e0d:	a1 04 48 11 80       	mov    0x80114804,%eax
80103e12:	85 c0                	test   %eax,%eax
80103e14:	75 1d                	jne    80103e33 <mpinit+0x104>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103e16:	c7 05 00 4e 11 80 01 	movl   $0x1,0x80114e00
80103e1d:	00 00 00 
    lapic = 0;
80103e20:	c7 05 1c 47 11 80 00 	movl   $0x0,0x8011471c
80103e27:	00 00 00 
    ioapicid = 0;
80103e2a:	c6 05 00 48 11 80 00 	movb   $0x0,0x80114800
    return;
80103e31:	eb 3e                	jmp    80103e71 <mpinit+0x142>
  }

  if(mp->imcrp){
80103e33:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e36:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e3a:	84 c0                	test   %al,%al
80103e3c:	74 33                	je     80103e71 <mpinit+0x142>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103e3e:	83 ec 08             	sub    $0x8,%esp
80103e41:	6a 70                	push   $0x70
80103e43:	6a 22                	push   $0x22
80103e45:	e8 c8 fc ff ff       	call   80103b12 <outb>
80103e4a:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103e4d:	83 ec 0c             	sub    $0xc,%esp
80103e50:	6a 23                	push   $0x23
80103e52:	e8 9e fc ff ff       	call   80103af5 <inb>
80103e57:	83 c4 10             	add    $0x10,%esp
80103e5a:	83 c8 01             	or     $0x1,%eax
80103e5d:	0f b6 c0             	movzbl %al,%eax
80103e60:	83 ec 08             	sub    $0x8,%esp
80103e63:	50                   	push   %eax
80103e64:	6a 23                	push   $0x23
80103e66:	e8 a7 fc ff ff       	call   80103b12 <outb>
80103e6b:	83 c4 10             	add    $0x10,%esp
80103e6e:	eb 01                	jmp    80103e71 <mpinit+0x142>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
80103e70:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103e71:	c9                   	leave  
80103e72:	c3                   	ret    

80103e73 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103e73:	55                   	push   %ebp
80103e74:	89 e5                	mov    %esp,%ebp
80103e76:	83 ec 08             	sub    $0x8,%esp
80103e79:	8b 55 08             	mov    0x8(%ebp),%edx
80103e7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e7f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e83:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e86:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e8a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e8e:	ee                   	out    %al,(%dx)
}
80103e8f:	90                   	nop
80103e90:	c9                   	leave  
80103e91:	c3                   	ret    

80103e92 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103e92:	55                   	push   %ebp
80103e93:	89 e5                	mov    %esp,%ebp
80103e95:	83 ec 04             	sub    $0x4,%esp
80103e98:	8b 45 08             	mov    0x8(%ebp),%eax
80103e9b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103e9f:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ea3:	66 a3 00 c0 10 80    	mov    %ax,0x8010c000
  outb(IO_PIC1+1, mask);
80103ea9:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ead:	0f b6 c0             	movzbl %al,%eax
80103eb0:	50                   	push   %eax
80103eb1:	6a 21                	push   $0x21
80103eb3:	e8 bb ff ff ff       	call   80103e73 <outb>
80103eb8:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103ebb:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103ebf:	66 c1 e8 08          	shr    $0x8,%ax
80103ec3:	0f b6 c0             	movzbl %al,%eax
80103ec6:	50                   	push   %eax
80103ec7:	68 a1 00 00 00       	push   $0xa1
80103ecc:	e8 a2 ff ff ff       	call   80103e73 <outb>
80103ed1:	83 c4 08             	add    $0x8,%esp
}
80103ed4:	90                   	nop
80103ed5:	c9                   	leave  
80103ed6:	c3                   	ret    

80103ed7 <picenable>:

void
picenable(int irq)
{
80103ed7:	55                   	push   %ebp
80103ed8:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103eda:	8b 45 08             	mov    0x8(%ebp),%eax
80103edd:	ba 01 00 00 00       	mov    $0x1,%edx
80103ee2:	89 c1                	mov    %eax,%ecx
80103ee4:	d3 e2                	shl    %cl,%edx
80103ee6:	89 d0                	mov    %edx,%eax
80103ee8:	f7 d0                	not    %eax
80103eea:	89 c2                	mov    %eax,%edx
80103eec:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103ef3:	21 d0                	and    %edx,%eax
80103ef5:	0f b7 c0             	movzwl %ax,%eax
80103ef8:	50                   	push   %eax
80103ef9:	e8 94 ff ff ff       	call   80103e92 <picsetmask>
80103efe:	83 c4 04             	add    $0x4,%esp
}
80103f01:	90                   	nop
80103f02:	c9                   	leave  
80103f03:	c3                   	ret    

80103f04 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103f04:	55                   	push   %ebp
80103f05:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103f07:	68 ff 00 00 00       	push   $0xff
80103f0c:	6a 21                	push   $0x21
80103f0e:	e8 60 ff ff ff       	call   80103e73 <outb>
80103f13:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103f16:	68 ff 00 00 00       	push   $0xff
80103f1b:	68 a1 00 00 00       	push   $0xa1
80103f20:	e8 4e ff ff ff       	call   80103e73 <outb>
80103f25:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103f28:	6a 11                	push   $0x11
80103f2a:	6a 20                	push   $0x20
80103f2c:	e8 42 ff ff ff       	call   80103e73 <outb>
80103f31:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103f34:	6a 20                	push   $0x20
80103f36:	6a 21                	push   $0x21
80103f38:	e8 36 ff ff ff       	call   80103e73 <outb>
80103f3d:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103f40:	6a 04                	push   $0x4
80103f42:	6a 21                	push   $0x21
80103f44:	e8 2a ff ff ff       	call   80103e73 <outb>
80103f49:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103f4c:	6a 03                	push   $0x3
80103f4e:	6a 21                	push   $0x21
80103f50:	e8 1e ff ff ff       	call   80103e73 <outb>
80103f55:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103f58:	6a 11                	push   $0x11
80103f5a:	68 a0 00 00 00       	push   $0xa0
80103f5f:	e8 0f ff ff ff       	call   80103e73 <outb>
80103f64:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103f67:	6a 28                	push   $0x28
80103f69:	68 a1 00 00 00       	push   $0xa1
80103f6e:	e8 00 ff ff ff       	call   80103e73 <outb>
80103f73:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103f76:	6a 02                	push   $0x2
80103f78:	68 a1 00 00 00       	push   $0xa1
80103f7d:	e8 f1 fe ff ff       	call   80103e73 <outb>
80103f82:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103f85:	6a 03                	push   $0x3
80103f87:	68 a1 00 00 00       	push   $0xa1
80103f8c:	e8 e2 fe ff ff       	call   80103e73 <outb>
80103f91:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103f94:	6a 68                	push   $0x68
80103f96:	6a 20                	push   $0x20
80103f98:	e8 d6 fe ff ff       	call   80103e73 <outb>
80103f9d:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103fa0:	6a 0a                	push   $0xa
80103fa2:	6a 20                	push   $0x20
80103fa4:	e8 ca fe ff ff       	call   80103e73 <outb>
80103fa9:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103fac:	6a 68                	push   $0x68
80103fae:	68 a0 00 00 00       	push   $0xa0
80103fb3:	e8 bb fe ff ff       	call   80103e73 <outb>
80103fb8:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103fbb:	6a 0a                	push   $0xa
80103fbd:	68 a0 00 00 00       	push   $0xa0
80103fc2:	e8 ac fe ff ff       	call   80103e73 <outb>
80103fc7:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103fca:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103fd1:	66 83 f8 ff          	cmp    $0xffff,%ax
80103fd5:	74 13                	je     80103fea <picinit+0xe6>
    picsetmask(irqmask);
80103fd7:	0f b7 05 00 c0 10 80 	movzwl 0x8010c000,%eax
80103fde:	0f b7 c0             	movzwl %ax,%eax
80103fe1:	50                   	push   %eax
80103fe2:	e8 ab fe ff ff       	call   80103e92 <picsetmask>
80103fe7:	83 c4 04             	add    $0x4,%esp
}
80103fea:	90                   	nop
80103feb:	c9                   	leave  
80103fec:	c3                   	ret    

80103fed <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103fed:	55                   	push   %ebp
80103fee:	89 e5                	mov    %esp,%ebp
80103ff0:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103ff3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ffd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104003:	8b 45 0c             	mov    0xc(%ebp),%eax
80104006:	8b 10                	mov    (%eax),%edx
80104008:	8b 45 08             	mov    0x8(%ebp),%eax
8010400b:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010400d:	e8 06 d0 ff ff       	call   80101018 <filealloc>
80104012:	89 c2                	mov    %eax,%edx
80104014:	8b 45 08             	mov    0x8(%ebp),%eax
80104017:	89 10                	mov    %edx,(%eax)
80104019:	8b 45 08             	mov    0x8(%ebp),%eax
8010401c:	8b 00                	mov    (%eax),%eax
8010401e:	85 c0                	test   %eax,%eax
80104020:	0f 84 cb 00 00 00    	je     801040f1 <pipealloc+0x104>
80104026:	e8 ed cf ff ff       	call   80101018 <filealloc>
8010402b:	89 c2                	mov    %eax,%edx
8010402d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104030:	89 10                	mov    %edx,(%eax)
80104032:	8b 45 0c             	mov    0xc(%ebp),%eax
80104035:	8b 00                	mov    (%eax),%eax
80104037:	85 c0                	test   %eax,%eax
80104039:	0f 84 b2 00 00 00    	je     801040f1 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010403f:	e8 83 ec ff ff       	call   80102cc7 <kalloc>
80104044:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104047:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010404b:	0f 84 9f 00 00 00    	je     801040f0 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80104051:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104054:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010405b:	00 00 00 
  p->writeopen = 1;
8010405e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104061:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104068:	00 00 00 
  p->nwrite = 0;
8010406b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010406e:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104075:	00 00 00 
  p->nread = 0;
80104078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010407b:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104082:	00 00 00 
  initlock(&p->lock, "pipe");
80104085:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104088:	83 ec 08             	sub    $0x8,%esp
8010408b:	68 3c 8c 10 80       	push   $0x80108c3c
80104090:	50                   	push   %eax
80104091:	e8 36 10 00 00       	call   801050cc <initlock>
80104096:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104099:	8b 45 08             	mov    0x8(%ebp),%eax
8010409c:	8b 00                	mov    (%eax),%eax
8010409e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801040a4:	8b 45 08             	mov    0x8(%ebp),%eax
801040a7:	8b 00                	mov    (%eax),%eax
801040a9:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801040ad:	8b 45 08             	mov    0x8(%ebp),%eax
801040b0:	8b 00                	mov    (%eax),%eax
801040b2:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801040b6:	8b 45 08             	mov    0x8(%ebp),%eax
801040b9:	8b 00                	mov    (%eax),%eax
801040bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040be:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801040c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801040c4:	8b 00                	mov    (%eax),%eax
801040c6:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801040cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801040cf:	8b 00                	mov    (%eax),%eax
801040d1:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801040d5:	8b 45 0c             	mov    0xc(%ebp),%eax
801040d8:	8b 00                	mov    (%eax),%eax
801040da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801040de:	8b 45 0c             	mov    0xc(%ebp),%eax
801040e1:	8b 00                	mov    (%eax),%eax
801040e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040e6:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
801040e9:	b8 00 00 00 00       	mov    $0x0,%eax
801040ee:	eb 4e                	jmp    8010413e <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
801040f0:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
801040f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040f5:	74 0e                	je     80104105 <pipealloc+0x118>
    kfree((char*)p);
801040f7:	83 ec 0c             	sub    $0xc,%esp
801040fa:	ff 75 f4             	pushl  -0xc(%ebp)
801040fd:	e8 2b eb ff ff       	call   80102c2d <kfree>
80104102:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80104105:	8b 45 08             	mov    0x8(%ebp),%eax
80104108:	8b 00                	mov    (%eax),%eax
8010410a:	85 c0                	test   %eax,%eax
8010410c:	74 11                	je     8010411f <pipealloc+0x132>
    fileclose(*f0);
8010410e:	8b 45 08             	mov    0x8(%ebp),%eax
80104111:	8b 00                	mov    (%eax),%eax
80104113:	83 ec 0c             	sub    $0xc,%esp
80104116:	50                   	push   %eax
80104117:	e8 ba cf ff ff       	call   801010d6 <fileclose>
8010411c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010411f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104122:	8b 00                	mov    (%eax),%eax
80104124:	85 c0                	test   %eax,%eax
80104126:	74 11                	je     80104139 <pipealloc+0x14c>
    fileclose(*f1);
80104128:	8b 45 0c             	mov    0xc(%ebp),%eax
8010412b:	8b 00                	mov    (%eax),%eax
8010412d:	83 ec 0c             	sub    $0xc,%esp
80104130:	50                   	push   %eax
80104131:	e8 a0 cf ff ff       	call   801010d6 <fileclose>
80104136:	83 c4 10             	add    $0x10,%esp
  return -1;
80104139:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010413e:	c9                   	leave  
8010413f:	c3                   	ret    

80104140 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80104146:	8b 45 08             	mov    0x8(%ebp),%eax
80104149:	83 ec 0c             	sub    $0xc,%esp
8010414c:	50                   	push   %eax
8010414d:	e8 9c 0f 00 00       	call   801050ee <acquire>
80104152:	83 c4 10             	add    $0x10,%esp
  if(writable){
80104155:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104159:	74 23                	je     8010417e <pipeclose+0x3e>
    p->writeopen = 0;
8010415b:	8b 45 08             	mov    0x8(%ebp),%eax
8010415e:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104165:	00 00 00 
    wakeup(&p->nread);
80104168:	8b 45 08             	mov    0x8(%ebp),%eax
8010416b:	05 34 02 00 00       	add    $0x234,%eax
80104170:	83 ec 0c             	sub    $0xc,%esp
80104173:	50                   	push   %eax
80104174:	e8 41 0c 00 00       	call   80104dba <wakeup>
80104179:	83 c4 10             	add    $0x10,%esp
8010417c:	eb 21                	jmp    8010419f <pipeclose+0x5f>
  } else {
    p->readopen = 0;
8010417e:	8b 45 08             	mov    0x8(%ebp),%eax
80104181:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104188:	00 00 00 
    wakeup(&p->nwrite);
8010418b:	8b 45 08             	mov    0x8(%ebp),%eax
8010418e:	05 38 02 00 00       	add    $0x238,%eax
80104193:	83 ec 0c             	sub    $0xc,%esp
80104196:	50                   	push   %eax
80104197:	e8 1e 0c 00 00       	call   80104dba <wakeup>
8010419c:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010419f:	8b 45 08             	mov    0x8(%ebp),%eax
801041a2:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
801041a8:	85 c0                	test   %eax,%eax
801041aa:	75 2c                	jne    801041d8 <pipeclose+0x98>
801041ac:	8b 45 08             	mov    0x8(%ebp),%eax
801041af:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801041b5:	85 c0                	test   %eax,%eax
801041b7:	75 1f                	jne    801041d8 <pipeclose+0x98>
    release(&p->lock);
801041b9:	8b 45 08             	mov    0x8(%ebp),%eax
801041bc:	83 ec 0c             	sub    $0xc,%esp
801041bf:	50                   	push   %eax
801041c0:	e8 95 0f 00 00       	call   8010515a <release>
801041c5:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
801041c8:	83 ec 0c             	sub    $0xc,%esp
801041cb:	ff 75 08             	pushl  0x8(%ebp)
801041ce:	e8 5a ea ff ff       	call   80102c2d <kfree>
801041d3:	83 c4 10             	add    $0x10,%esp
801041d6:	eb 0f                	jmp    801041e7 <pipeclose+0xa7>
  } else
    release(&p->lock);
801041d8:	8b 45 08             	mov    0x8(%ebp),%eax
801041db:	83 ec 0c             	sub    $0xc,%esp
801041de:	50                   	push   %eax
801041df:	e8 76 0f 00 00       	call   8010515a <release>
801041e4:	83 c4 10             	add    $0x10,%esp
}
801041e7:	90                   	nop
801041e8:	c9                   	leave  
801041e9:	c3                   	ret    

801041ea <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801041ea:	55                   	push   %ebp
801041eb:	89 e5                	mov    %esp,%ebp
801041ed:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801041f0:	8b 45 08             	mov    0x8(%ebp),%eax
801041f3:	83 ec 0c             	sub    $0xc,%esp
801041f6:	50                   	push   %eax
801041f7:	e8 f2 0e 00 00       	call   801050ee <acquire>
801041fc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801041ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104206:	e9 ad 00 00 00       	jmp    801042b8 <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
8010420b:	8b 45 08             	mov    0x8(%ebp),%eax
8010420e:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104214:	85 c0                	test   %eax,%eax
80104216:	74 0d                	je     80104225 <pipewrite+0x3b>
80104218:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010421e:	8b 40 28             	mov    0x28(%eax),%eax
80104221:	85 c0                	test   %eax,%eax
80104223:	74 19                	je     8010423e <pipewrite+0x54>
        release(&p->lock);
80104225:	8b 45 08             	mov    0x8(%ebp),%eax
80104228:	83 ec 0c             	sub    $0xc,%esp
8010422b:	50                   	push   %eax
8010422c:	e8 29 0f 00 00       	call   8010515a <release>
80104231:	83 c4 10             	add    $0x10,%esp
        return -1;
80104234:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104239:	e9 a8 00 00 00       	jmp    801042e6 <pipewrite+0xfc>
      }
      wakeup(&p->nread);
8010423e:	8b 45 08             	mov    0x8(%ebp),%eax
80104241:	05 34 02 00 00       	add    $0x234,%eax
80104246:	83 ec 0c             	sub    $0xc,%esp
80104249:	50                   	push   %eax
8010424a:	e8 6b 0b 00 00       	call   80104dba <wakeup>
8010424f:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104252:	8b 45 08             	mov    0x8(%ebp),%eax
80104255:	8b 55 08             	mov    0x8(%ebp),%edx
80104258:	81 c2 38 02 00 00    	add    $0x238,%edx
8010425e:	83 ec 08             	sub    $0x8,%esp
80104261:	50                   	push   %eax
80104262:	52                   	push   %edx
80104263:	e8 67 0a 00 00       	call   80104ccf <sleep>
80104268:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010426b:	8b 45 08             	mov    0x8(%ebp),%eax
8010426e:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104274:	8b 45 08             	mov    0x8(%ebp),%eax
80104277:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010427d:	05 00 02 00 00       	add    $0x200,%eax
80104282:	39 c2                	cmp    %eax,%edx
80104284:	74 85                	je     8010420b <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104286:	8b 45 08             	mov    0x8(%ebp),%eax
80104289:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010428f:	8d 48 01             	lea    0x1(%eax),%ecx
80104292:	8b 55 08             	mov    0x8(%ebp),%edx
80104295:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010429b:	25 ff 01 00 00       	and    $0x1ff,%eax
801042a0:	89 c1                	mov    %eax,%ecx
801042a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042a5:	8b 45 0c             	mov    0xc(%ebp),%eax
801042a8:	01 d0                	add    %edx,%eax
801042aa:	0f b6 10             	movzbl (%eax),%edx
801042ad:	8b 45 08             	mov    0x8(%ebp),%eax
801042b0:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801042b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042bb:	3b 45 10             	cmp    0x10(%ebp),%eax
801042be:	7c ab                	jl     8010426b <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801042c0:	8b 45 08             	mov    0x8(%ebp),%eax
801042c3:	05 34 02 00 00       	add    $0x234,%eax
801042c8:	83 ec 0c             	sub    $0xc,%esp
801042cb:	50                   	push   %eax
801042cc:	e8 e9 0a 00 00       	call   80104dba <wakeup>
801042d1:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801042d4:	8b 45 08             	mov    0x8(%ebp),%eax
801042d7:	83 ec 0c             	sub    $0xc,%esp
801042da:	50                   	push   %eax
801042db:	e8 7a 0e 00 00       	call   8010515a <release>
801042e0:	83 c4 10             	add    $0x10,%esp
  return n;
801042e3:	8b 45 10             	mov    0x10(%ebp),%eax
}
801042e6:	c9                   	leave  
801042e7:	c3                   	ret    

801042e8 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801042e8:	55                   	push   %ebp
801042e9:	89 e5                	mov    %esp,%ebp
801042eb:	53                   	push   %ebx
801042ec:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
801042ef:	8b 45 08             	mov    0x8(%ebp),%eax
801042f2:	83 ec 0c             	sub    $0xc,%esp
801042f5:	50                   	push   %eax
801042f6:	e8 f3 0d 00 00       	call   801050ee <acquire>
801042fb:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042fe:	eb 3f                	jmp    8010433f <piperead+0x57>
    if(proc->killed){
80104300:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104306:	8b 40 28             	mov    0x28(%eax),%eax
80104309:	85 c0                	test   %eax,%eax
8010430b:	74 19                	je     80104326 <piperead+0x3e>
      release(&p->lock);
8010430d:	8b 45 08             	mov    0x8(%ebp),%eax
80104310:	83 ec 0c             	sub    $0xc,%esp
80104313:	50                   	push   %eax
80104314:	e8 41 0e 00 00       	call   8010515a <release>
80104319:	83 c4 10             	add    $0x10,%esp
      return -1;
8010431c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104321:	e9 bf 00 00 00       	jmp    801043e5 <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104326:	8b 45 08             	mov    0x8(%ebp),%eax
80104329:	8b 55 08             	mov    0x8(%ebp),%edx
8010432c:	81 c2 34 02 00 00    	add    $0x234,%edx
80104332:	83 ec 08             	sub    $0x8,%esp
80104335:	50                   	push   %eax
80104336:	52                   	push   %edx
80104337:	e8 93 09 00 00       	call   80104ccf <sleep>
8010433c:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010433f:	8b 45 08             	mov    0x8(%ebp),%eax
80104342:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104348:	8b 45 08             	mov    0x8(%ebp),%eax
8010434b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104351:	39 c2                	cmp    %eax,%edx
80104353:	75 0d                	jne    80104362 <piperead+0x7a>
80104355:	8b 45 08             	mov    0x8(%ebp),%eax
80104358:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010435e:	85 c0                	test   %eax,%eax
80104360:	75 9e                	jne    80104300 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104362:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104369:	eb 49                	jmp    801043b4 <piperead+0xcc>
    if(p->nread == p->nwrite)
8010436b:	8b 45 08             	mov    0x8(%ebp),%eax
8010436e:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104374:	8b 45 08             	mov    0x8(%ebp),%eax
80104377:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010437d:	39 c2                	cmp    %eax,%edx
8010437f:	74 3d                	je     801043be <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104381:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104384:	8b 45 0c             	mov    0xc(%ebp),%eax
80104387:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010438a:	8b 45 08             	mov    0x8(%ebp),%eax
8010438d:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104393:	8d 48 01             	lea    0x1(%eax),%ecx
80104396:	8b 55 08             	mov    0x8(%ebp),%edx
80104399:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010439f:	25 ff 01 00 00       	and    $0x1ff,%eax
801043a4:	89 c2                	mov    %eax,%edx
801043a6:	8b 45 08             	mov    0x8(%ebp),%eax
801043a9:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
801043ae:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801043b0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801043b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043b7:	3b 45 10             	cmp    0x10(%ebp),%eax
801043ba:	7c af                	jl     8010436b <piperead+0x83>
801043bc:	eb 01                	jmp    801043bf <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
801043be:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801043bf:	8b 45 08             	mov    0x8(%ebp),%eax
801043c2:	05 38 02 00 00       	add    $0x238,%eax
801043c7:	83 ec 0c             	sub    $0xc,%esp
801043ca:	50                   	push   %eax
801043cb:	e8 ea 09 00 00       	call   80104dba <wakeup>
801043d0:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801043d3:	8b 45 08             	mov    0x8(%ebp),%eax
801043d6:	83 ec 0c             	sub    $0xc,%esp
801043d9:	50                   	push   %eax
801043da:	e8 7b 0d 00 00       	call   8010515a <release>
801043df:	83 c4 10             	add    $0x10,%esp
  return i;
801043e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801043e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043e8:	c9                   	leave  
801043e9:	c3                   	ret    

801043ea <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
801043ea:	55                   	push   %ebp
801043eb:	89 e5                	mov    %esp,%ebp
801043ed:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043f0:	9c                   	pushf  
801043f1:	58                   	pop    %eax
801043f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801043f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801043f8:	c9                   	leave  
801043f9:	c3                   	ret    

801043fa <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
801043fa:	55                   	push   %ebp
801043fb:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801043fd:	fb                   	sti    
}
801043fe:	90                   	nop
801043ff:	5d                   	pop    %ebp
80104400:	c3                   	ret    

80104401 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104401:	55                   	push   %ebp
80104402:	89 e5                	mov    %esp,%ebp
80104404:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
80104407:	83 ec 08             	sub    $0x8,%esp
8010440a:	68 41 8c 10 80       	push   $0x80108c41
8010440f:	68 20 4e 11 80       	push   $0x80114e20
80104414:	e8 b3 0c 00 00       	call   801050cc <initlock>
80104419:	83 c4 10             	add    $0x10,%esp
}
8010441c:	90                   	nop
8010441d:	c9                   	leave  
8010441e:	c3                   	ret    

8010441f <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
8010441f:	55                   	push   %ebp
80104420:	89 e5                	mov    %esp,%ebp
80104422:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104425:	83 ec 0c             	sub    $0xc,%esp
80104428:	68 20 4e 11 80       	push   $0x80114e20
8010442d:	e8 bc 0c 00 00       	call   801050ee <acquire>
80104432:	83 c4 10             	add    $0x10,%esp

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104435:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
8010443c:	eb 0e                	jmp    8010444c <allocproc+0x2d>
    if(p->state == UNUSED)
8010443e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104441:	8b 40 10             	mov    0x10(%eax),%eax
80104444:	85 c0                	test   %eax,%eax
80104446:	74 27                	je     8010446f <allocproc+0x50>
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104448:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
8010444c:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104453:	72 e9                	jb     8010443e <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104455:	83 ec 0c             	sub    $0xc,%esp
80104458:	68 20 4e 11 80       	push   $0x80114e20
8010445d:	e8 f8 0c 00 00       	call   8010515a <release>
80104462:	83 c4 10             	add    $0x10,%esp
  return 0;
80104465:	b8 00 00 00 00       	mov    $0x0,%eax
8010446a:	e9 b4 00 00 00       	jmp    80104523 <allocproc+0x104>

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
8010446f:	90                   	nop

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
80104470:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104473:	c7 40 10 01 00 00 00 	movl   $0x1,0x10(%eax)
  p->pid = nextpid++;
8010447a:	a1 04 c0 10 80       	mov    0x8010c004,%eax
8010447f:	8d 50 01             	lea    0x1(%eax),%edx
80104482:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
80104488:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010448b:	89 42 14             	mov    %eax,0x14(%edx)

  release(&ptable.lock);
8010448e:	83 ec 0c             	sub    $0xc,%esp
80104491:	68 20 4e 11 80       	push   $0x80114e20
80104496:	e8 bf 0c 00 00       	call   8010515a <release>
8010449b:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010449e:	e8 24 e8 ff ff       	call   80102cc7 <kalloc>
801044a3:	89 c2                	mov    %eax,%edx
801044a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a8:	89 50 08             	mov    %edx,0x8(%eax)
801044ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ae:	8b 40 08             	mov    0x8(%eax),%eax
801044b1:	85 c0                	test   %eax,%eax
801044b3:	75 11                	jne    801044c6 <allocproc+0xa7>
    p->state = UNUSED;
801044b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044b8:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
    return 0;
801044bf:	b8 00 00 00 00       	mov    $0x0,%eax
801044c4:	eb 5d                	jmp    80104523 <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
801044c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c9:	8b 40 08             	mov    0x8(%eax),%eax
801044cc:	05 00 10 00 00       	add    $0x1000,%eax
801044d1:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801044d4:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
801044d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044db:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044de:	89 50 1c             	mov    %edx,0x1c(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
801044e1:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
801044e5:	ba 9c 68 10 80       	mov    $0x8010689c,%edx
801044ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801044ed:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
801044ef:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
801044f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044f9:	89 50 20             	mov    %edx,0x20(%eax)
  memset(p->context, 0, sizeof *p->context);
801044fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ff:	8b 40 20             	mov    0x20(%eax),%eax
80104502:	83 ec 04             	sub    $0x4,%esp
80104505:	6a 14                	push   $0x14
80104507:	6a 00                	push   $0x0
80104509:	50                   	push   %eax
8010450a:	e8 59 0e 00 00       	call   80105368 <memset>
8010450f:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104515:	8b 40 20             	mov    0x20(%eax),%eax
80104518:	ba 89 4c 10 80       	mov    $0x80104c89,%edx
8010451d:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104520:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104523:	c9                   	leave  
80104524:	c3                   	ret    

80104525 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104525:	55                   	push   %ebp
80104526:	89 e5                	mov    %esp,%ebp
80104528:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
8010452b:	e8 ef fe ff ff       	call   8010441f <allocproc>
80104530:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  initproc = p;
80104533:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104536:	a3 44 c6 10 80       	mov    %eax,0x8010c644
  if((p->pgdir = setupkvm()) == 0)
8010453b:	e8 f7 3b 00 00       	call   80108137 <setupkvm>
80104540:	89 c2                	mov    %eax,%edx
80104542:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104545:	89 50 04             	mov    %edx,0x4(%eax)
80104548:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010454b:	8b 40 04             	mov    0x4(%eax),%eax
8010454e:	85 c0                	test   %eax,%eax
80104550:	75 0d                	jne    8010455f <userinit+0x3a>
    panic("userinit: out of memory?");
80104552:	83 ec 0c             	sub    $0xc,%esp
80104555:	68 48 8c 10 80       	push   $0x80108c48
8010455a:	e8 41 c0 ff ff       	call   801005a0 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010455f:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104564:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104567:	8b 40 04             	mov    0x4(%eax),%eax
8010456a:	83 ec 04             	sub    $0x4,%esp
8010456d:	52                   	push   %edx
8010456e:	68 e0 c4 10 80       	push   $0x8010c4e0
80104573:	50                   	push   %eax
80104574:	e8 f2 3d 00 00       	call   8010836b <inituvm>
80104579:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
8010457c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010457f:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
80104585:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104588:	8b 40 1c             	mov    0x1c(%eax),%eax
8010458b:	83 ec 04             	sub    $0x4,%esp
8010458e:	6a 4c                	push   $0x4c
80104590:	6a 00                	push   $0x0
80104592:	50                   	push   %eax
80104593:	e8 d0 0d 00 00       	call   80105368 <memset>
80104598:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010459b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010459e:	8b 40 1c             	mov    0x1c(%eax),%eax
801045a1:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045aa:	8b 40 1c             	mov    0x1c(%eax),%eax
801045ad:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801045b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045b6:	8b 40 1c             	mov    0x1c(%eax),%eax
801045b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045bc:	8b 52 1c             	mov    0x1c(%edx),%edx
801045bf:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045c3:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801045c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ca:	8b 40 1c             	mov    0x1c(%eax),%eax
801045cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045d0:	8b 52 1c             	mov    0x1c(%edx),%edx
801045d3:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045d7:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801045db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045de:	8b 40 1c             	mov    0x1c(%eax),%eax
801045e1:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801045e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045eb:	8b 40 1c             	mov    0x1c(%eax),%eax
801045ee:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801045f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f8:	8b 40 1c             	mov    0x1c(%eax),%eax
801045fb:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104602:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104605:	83 c0 70             	add    $0x70,%eax
80104608:	83 ec 04             	sub    $0x4,%esp
8010460b:	6a 10                	push   $0x10
8010460d:	68 61 8c 10 80       	push   $0x80108c61
80104612:	50                   	push   %eax
80104613:	e8 53 0f 00 00       	call   8010556b <safestrcpy>
80104618:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010461b:	83 ec 0c             	sub    $0xc,%esp
8010461e:	68 6a 8c 10 80       	push   $0x80108c6a
80104623:	e8 33 df ff ff       	call   8010255b <namei>
80104628:	83 c4 10             	add    $0x10,%esp
8010462b:	89 c2                	mov    %eax,%edx
8010462d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104630:	89 50 6c             	mov    %edx,0x6c(%eax)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104633:	83 ec 0c             	sub    $0xc,%esp
80104636:	68 20 4e 11 80       	push   $0x80114e20
8010463b:	e8 ae 0a 00 00       	call   801050ee <acquire>
80104640:	83 c4 10             	add    $0x10,%esp

  p->state = RUNNABLE;
80104643:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104646:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

  release(&ptable.lock);
8010464d:	83 ec 0c             	sub    $0xc,%esp
80104650:	68 20 4e 11 80       	push   $0x80114e20
80104655:	e8 00 0b 00 00       	call   8010515a <release>
8010465a:	83 c4 10             	add    $0x10,%esp
}
8010465d:	90                   	nop
8010465e:	c9                   	leave  
8010465f:	c3                   	ret    

80104660 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
80104666:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010466c:	8b 00                	mov    (%eax),%eax
8010466e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104671:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104675:	7e 31                	jle    801046a8 <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104677:	8b 55 08             	mov    0x8(%ebp),%edx
8010467a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010467d:	01 c2                	add    %eax,%edx
8010467f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104685:	8b 40 04             	mov    0x4(%eax),%eax
80104688:	83 ec 04             	sub    $0x4,%esp
8010468b:	52                   	push   %edx
8010468c:	ff 75 f4             	pushl  -0xc(%ebp)
8010468f:	50                   	push   %eax
80104690:	e8 13 3e 00 00       	call   801084a8 <allocuvm>
80104695:	83 c4 10             	add    $0x10,%esp
80104698:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010469b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010469f:	75 3e                	jne    801046df <growproc+0x7f>
      return -1;
801046a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046a6:	eb 59                	jmp    80104701 <growproc+0xa1>
  } else if(n < 0){
801046a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801046ac:	79 31                	jns    801046df <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801046ae:	8b 55 08             	mov    0x8(%ebp),%edx
801046b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801046b4:	01 c2                	add    %eax,%edx
801046b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046bc:	8b 40 04             	mov    0x4(%eax),%eax
801046bf:	83 ec 04             	sub    $0x4,%esp
801046c2:	52                   	push   %edx
801046c3:	ff 75 f4             	pushl  -0xc(%ebp)
801046c6:	50                   	push   %eax
801046c7:	e8 e1 3e 00 00       	call   801085ad <deallocuvm>
801046cc:	83 c4 10             	add    $0x10,%esp
801046cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801046d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801046d6:	75 07                	jne    801046df <growproc+0x7f>
      return -1;
801046d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046dd:	eb 22                	jmp    80104701 <growproc+0xa1>
  }
  proc->sz = sz;
801046df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046e8:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
801046ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f0:	83 ec 0c             	sub    $0xc,%esp
801046f3:	50                   	push   %eax
801046f4:	e8 fa 3a 00 00       	call   801081f3 <switchuvm>
801046f9:	83 c4 10             	add    $0x10,%esp
  return 0;
801046fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104701:	c9                   	leave  
80104702:	c3                   	ret    

80104703 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104703:	55                   	push   %ebp
80104704:	89 e5                	mov    %esp,%ebp
80104706:	57                   	push   %edi
80104707:	56                   	push   %esi
80104708:	53                   	push   %ebx
80104709:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
8010470c:	e8 0e fd ff ff       	call   8010441f <allocproc>
80104711:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104714:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104718:	75 0a                	jne    80104724 <fork+0x21>
    return -1;
8010471a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010471f:	e9 68 01 00 00       	jmp    8010488c <fork+0x189>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104724:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472a:	8b 10                	mov    (%eax),%edx
8010472c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104732:	8b 40 04             	mov    0x4(%eax),%eax
80104735:	83 ec 08             	sub    $0x8,%esp
80104738:	52                   	push   %edx
80104739:	50                   	push   %eax
8010473a:	e8 e2 3f 00 00       	call   80108721 <copyuvm>
8010473f:	83 c4 10             	add    $0x10,%esp
80104742:	89 c2                	mov    %eax,%edx
80104744:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104747:	89 50 04             	mov    %edx,0x4(%eax)
8010474a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010474d:	8b 40 04             	mov    0x4(%eax),%eax
80104750:	85 c0                	test   %eax,%eax
80104752:	75 30                	jne    80104784 <fork+0x81>
    kfree(np->kstack);
80104754:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104757:	8b 40 08             	mov    0x8(%eax),%eax
8010475a:	83 ec 0c             	sub    $0xc,%esp
8010475d:	50                   	push   %eax
8010475e:	e8 ca e4 ff ff       	call   80102c2d <kfree>
80104763:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
80104766:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104769:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104770:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104773:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
    return -1;
8010477a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010477f:	e9 08 01 00 00       	jmp    8010488c <fork+0x189>
  }
  np->sz = proc->sz;
80104784:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478a:	8b 10                	mov    (%eax),%edx
8010478c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010478f:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
80104791:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104798:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010479b:	89 50 18             	mov    %edx,0x18(%eax)
  *np->tf = *proc->tf;
8010479e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047a1:	8b 50 1c             	mov    0x1c(%eax),%edx
801047a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047aa:	8b 40 1c             	mov    0x1c(%eax),%eax
801047ad:	89 c3                	mov    %eax,%ebx
801047af:	b8 13 00 00 00       	mov    $0x13,%eax
801047b4:	89 d7                	mov    %edx,%edi
801047b6:	89 de                	mov    %ebx,%esi
801047b8:	89 c1                	mov    %eax,%ecx
801047ba:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801047bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047bf:	8b 40 1c             	mov    0x1c(%eax),%eax
801047c2:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801047c9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801047d0:	eb 43                	jmp    80104815 <fork+0x112>
    if(proc->ofile[i])
801047d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047db:	83 c2 08             	add    $0x8,%edx
801047de:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801047e2:	85 c0                	test   %eax,%eax
801047e4:	74 2b                	je     80104811 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
801047e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047ef:	83 c2 08             	add    $0x8,%edx
801047f2:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801047f6:	83 ec 0c             	sub    $0xc,%esp
801047f9:	50                   	push   %eax
801047fa:	e8 86 c8 ff ff       	call   80101085 <filedup>
801047ff:	83 c4 10             	add    $0x10,%esp
80104802:	89 c1                	mov    %eax,%ecx
80104804:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104807:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010480a:	83 c2 08             	add    $0x8,%edx
8010480d:	89 4c 90 0c          	mov    %ecx,0xc(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104811:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104815:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104819:	7e b7                	jle    801047d2 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
8010481b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104821:	8b 40 6c             	mov    0x6c(%eax),%eax
80104824:	83 ec 0c             	sub    $0xc,%esp
80104827:	50                   	push   %eax
80104828:	e8 ce d1 ff ff       	call   801019fb <idup>
8010482d:	83 c4 10             	add    $0x10,%esp
80104830:	89 c2                	mov    %eax,%edx
80104832:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104835:	89 50 6c             	mov    %edx,0x6c(%eax)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104838:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010483e:	8d 50 70             	lea    0x70(%eax),%edx
80104841:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104844:	83 c0 70             	add    $0x70,%eax
80104847:	83 ec 04             	sub    $0x4,%esp
8010484a:	6a 10                	push   $0x10
8010484c:	52                   	push   %edx
8010484d:	50                   	push   %eax
8010484e:	e8 18 0d 00 00       	call   8010556b <safestrcpy>
80104853:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
80104856:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104859:	8b 40 14             	mov    0x14(%eax),%eax
8010485c:	89 45 dc             	mov    %eax,-0x24(%ebp)

  acquire(&ptable.lock);
8010485f:	83 ec 0c             	sub    $0xc,%esp
80104862:	68 20 4e 11 80       	push   $0x80114e20
80104867:	e8 82 08 00 00       	call   801050ee <acquire>
8010486c:	83 c4 10             	add    $0x10,%esp

  np->state = RUNNABLE;
8010486f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104872:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)

  release(&ptable.lock);
80104879:	83 ec 0c             	sub    $0xc,%esp
8010487c:	68 20 4e 11 80       	push   $0x80114e20
80104881:	e8 d4 08 00 00       	call   8010515a <release>
80104886:	83 c4 10             	add    $0x10,%esp

  return pid;
80104889:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
8010488c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010488f:	5b                   	pop    %ebx
80104890:	5e                   	pop    %esi
80104891:	5f                   	pop    %edi
80104892:	5d                   	pop    %ebp
80104893:	c3                   	ret    

80104894 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104894:	55                   	push   %ebp
80104895:	89 e5                	mov    %esp,%ebp
80104897:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
8010489a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801048a1:	a1 44 c6 10 80       	mov    0x8010c644,%eax
801048a6:	39 c2                	cmp    %eax,%edx
801048a8:	75 0d                	jne    801048b7 <exit+0x23>
    panic("init exiting");
801048aa:	83 ec 0c             	sub    $0xc,%esp
801048ad:	68 6c 8c 10 80       	push   $0x80108c6c
801048b2:	e8 e9 bc ff ff       	call   801005a0 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801048b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801048be:	eb 48                	jmp    80104908 <exit+0x74>
    if(proc->ofile[fd]){
801048c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048c9:	83 c2 08             	add    $0x8,%edx
801048cc:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801048d0:	85 c0                	test   %eax,%eax
801048d2:	74 30                	je     80104904 <exit+0x70>
      fileclose(proc->ofile[fd]);
801048d4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048da:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048dd:	83 c2 08             	add    $0x8,%edx
801048e0:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801048e4:	83 ec 0c             	sub    $0xc,%esp
801048e7:	50                   	push   %eax
801048e8:	e8 e9 c7 ff ff       	call   801010d6 <fileclose>
801048ed:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801048f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048f9:	83 c2 08             	add    $0x8,%edx
801048fc:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80104903:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104904:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104908:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
8010490c:	7e b2                	jle    801048c0 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
8010490e:	e8 e0 ec ff ff       	call   801035f3 <begin_op>
  iput(proc->cwd);
80104913:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104919:	8b 40 6c             	mov    0x6c(%eax),%eax
8010491c:	83 ec 0c             	sub    $0xc,%esp
8010491f:	50                   	push   %eax
80104920:	e8 7b d2 ff ff       	call   80101ba0 <iput>
80104925:	83 c4 10             	add    $0x10,%esp
  end_op();
80104928:	e8 52 ed ff ff       	call   8010367f <end_op>
  proc->cwd = 0;
8010492d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104933:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%eax)

  acquire(&ptable.lock);
8010493a:	83 ec 0c             	sub    $0xc,%esp
8010493d:	68 20 4e 11 80       	push   $0x80114e20
80104942:	e8 a7 07 00 00       	call   801050ee <acquire>
80104947:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
8010494a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104950:	8b 40 18             	mov    0x18(%eax),%eax
80104953:	83 ec 0c             	sub    $0xc,%esp
80104956:	50                   	push   %eax
80104957:	e8 1f 04 00 00       	call   80104d7b <wakeup1>
8010495c:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010495f:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
80104966:	eb 3c                	jmp    801049a4 <exit+0x110>
    if(p->parent == proc){
80104968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010496b:	8b 50 18             	mov    0x18(%eax),%edx
8010496e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104974:	39 c2                	cmp    %eax,%edx
80104976:	75 28                	jne    801049a0 <exit+0x10c>
      p->parent = initproc;
80104978:	8b 15 44 c6 10 80    	mov    0x8010c644,%edx
8010497e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104981:	89 50 18             	mov    %edx,0x18(%eax)
      if(p->state == ZOMBIE)
80104984:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104987:	8b 40 10             	mov    0x10(%eax),%eax
8010498a:	83 f8 05             	cmp    $0x5,%eax
8010498d:	75 11                	jne    801049a0 <exit+0x10c>
        wakeup1(initproc);
8010498f:	a1 44 c6 10 80       	mov    0x8010c644,%eax
80104994:	83 ec 0c             	sub    $0xc,%esp
80104997:	50                   	push   %eax
80104998:	e8 de 03 00 00       	call   80104d7b <wakeup1>
8010499d:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049a0:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
801049a4:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
801049ab:	72 bb                	jb     80104968 <exit+0xd4>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
801049ad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049b3:	c7 40 10 05 00 00 00 	movl   $0x5,0x10(%eax)
  sched();
801049ba:	e8 d3 01 00 00       	call   80104b92 <sched>
  panic("zombie exit");
801049bf:	83 ec 0c             	sub    $0xc,%esp
801049c2:	68 79 8c 10 80       	push   $0x80108c79
801049c7:	e8 d4 bb ff ff       	call   801005a0 <panic>

801049cc <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801049cc:	55                   	push   %ebp
801049cd:	89 e5                	mov    %esp,%ebp
801049cf:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801049d2:	83 ec 0c             	sub    $0xc,%esp
801049d5:	68 20 4e 11 80       	push   $0x80114e20
801049da:	e8 0f 07 00 00       	call   801050ee <acquire>
801049df:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
801049e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049e9:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
801049f0:	e9 a6 00 00 00       	jmp    80104a9b <wait+0xcf>
      if(p->parent != proc)
801049f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f8:	8b 50 18             	mov    0x18(%eax),%edx
801049fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a01:	39 c2                	cmp    %eax,%edx
80104a03:	0f 85 8d 00 00 00    	jne    80104a96 <wait+0xca>
        continue;
      havekids = 1;
80104a09:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
80104a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a13:	8b 40 10             	mov    0x10(%eax),%eax
80104a16:	83 f8 05             	cmp    $0x5,%eax
80104a19:	75 7c                	jne    80104a97 <wait+0xcb>
        // Found one.
        pid = p->pid;
80104a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a1e:	8b 40 14             	mov    0x14(%eax),%eax
80104a21:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a27:	8b 40 08             	mov    0x8(%eax),%eax
80104a2a:	83 ec 0c             	sub    $0xc,%esp
80104a2d:	50                   	push   %eax
80104a2e:	e8 fa e1 ff ff       	call   80102c2d <kfree>
80104a33:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a39:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104a40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a43:	8b 40 04             	mov    0x4(%eax),%eax
80104a46:	83 ec 0c             	sub    $0xc,%esp
80104a49:	50                   	push   %eax
80104a4a:	e8 f8 3b 00 00       	call   80108647 <freevm>
80104a4f:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80104a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a55:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->parent = 0;
80104a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a5f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
        p->name[0] = 0;
80104a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a69:	c6 40 70 00          	movb   $0x0,0x70(%eax)
        p->killed = 0;
80104a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a70:	c7 40 28 00 00 00 00 	movl   $0x0,0x28(%eax)
        p->state = UNUSED;
80104a77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a7a:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        release(&ptable.lock);
80104a81:	83 ec 0c             	sub    $0xc,%esp
80104a84:	68 20 4e 11 80       	push   $0x80114e20
80104a89:	e8 cc 06 00 00       	call   8010515a <release>
80104a8e:	83 c4 10             	add    $0x10,%esp
        return pid;
80104a91:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a94:	eb 58                	jmp    80104aee <wait+0x122>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104a96:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a97:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104a9b:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104aa2:	0f 82 4d ff ff ff    	jb     801049f5 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104aa8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104aac:	74 0d                	je     80104abb <wait+0xef>
80104aae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ab4:	8b 40 28             	mov    0x28(%eax),%eax
80104ab7:	85 c0                	test   %eax,%eax
80104ab9:	74 17                	je     80104ad2 <wait+0x106>
      release(&ptable.lock);
80104abb:	83 ec 0c             	sub    $0xc,%esp
80104abe:	68 20 4e 11 80       	push   $0x80114e20
80104ac3:	e8 92 06 00 00       	call   8010515a <release>
80104ac8:	83 c4 10             	add    $0x10,%esp
      return -1;
80104acb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad0:	eb 1c                	jmp    80104aee <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104ad2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ad8:	83 ec 08             	sub    $0x8,%esp
80104adb:	68 20 4e 11 80       	push   $0x80114e20
80104ae0:	50                   	push   %eax
80104ae1:	e8 e9 01 00 00       	call   80104ccf <sleep>
80104ae6:	83 c4 10             	add    $0x10,%esp
  }
80104ae9:	e9 f4 fe ff ff       	jmp    801049e2 <wait+0x16>
}
80104aee:	c9                   	leave  
80104aef:	c3                   	ret    

80104af0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
80104af6:	e8 ff f8 ff ff       	call   801043fa <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104afb:	83 ec 0c             	sub    $0xc,%esp
80104afe:	68 20 4e 11 80       	push   $0x80114e20
80104b03:	e8 e6 05 00 00       	call   801050ee <acquire>
80104b08:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b0b:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
80104b12:	eb 60                	jmp    80104b74 <scheduler+0x84>
      if(p->state != RUNNABLE)
80104b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b17:	8b 40 10             	mov    0x10(%eax),%eax
80104b1a:	83 f8 03             	cmp    $0x3,%eax
80104b1d:	75 50                	jne    80104b6f <scheduler+0x7f>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80104b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b22:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104b28:	83 ec 0c             	sub    $0xc,%esp
80104b2b:	ff 75 f4             	pushl  -0xc(%ebp)
80104b2e:	e8 c0 36 00 00       	call   801081f3 <switchuvm>
80104b33:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b39:	c7 40 10 04 00 00 00 	movl   $0x4,0x10(%eax)
      swtch(&cpu->scheduler, p->context);
80104b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b43:	8b 40 20             	mov    0x20(%eax),%eax
80104b46:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104b4d:	83 c2 04             	add    $0x4,%edx
80104b50:	83 ec 08             	sub    $0x8,%esp
80104b53:	50                   	push   %eax
80104b54:	52                   	push   %edx
80104b55:	e8 82 0a 00 00       	call   801055dc <swtch>
80104b5a:	83 c4 10             	add    $0x10,%esp
      switchkvm();
80104b5d:	e8 78 36 00 00       	call   801081da <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104b62:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104b69:	00 00 00 00 
80104b6d:	eb 01                	jmp    80104b70 <scheduler+0x80>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
80104b6f:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b70:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104b74:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104b7b:	72 97                	jb     80104b14 <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80104b7d:	83 ec 0c             	sub    $0xc,%esp
80104b80:	68 20 4e 11 80       	push   $0x80114e20
80104b85:	e8 d0 05 00 00       	call   8010515a <release>
80104b8a:	83 c4 10             	add    $0x10,%esp

  }
80104b8d:	e9 64 ff ff ff       	jmp    80104af6 <scheduler+0x6>

80104b92 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104b92:	55                   	push   %ebp
80104b93:	89 e5                	mov    %esp,%ebp
80104b95:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104b98:	83 ec 0c             	sub    $0xc,%esp
80104b9b:	68 20 4e 11 80       	push   $0x80114e20
80104ba0:	e8 81 06 00 00       	call   80105226 <holding>
80104ba5:	83 c4 10             	add    $0x10,%esp
80104ba8:	85 c0                	test   %eax,%eax
80104baa:	75 0d                	jne    80104bb9 <sched+0x27>
    panic("sched ptable.lock");
80104bac:	83 ec 0c             	sub    $0xc,%esp
80104baf:	68 85 8c 10 80       	push   $0x80108c85
80104bb4:	e8 e7 b9 ff ff       	call   801005a0 <panic>
  if(cpu->ncli != 1)
80104bb9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bbf:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104bc5:	83 f8 01             	cmp    $0x1,%eax
80104bc8:	74 0d                	je     80104bd7 <sched+0x45>
    panic("sched locks");
80104bca:	83 ec 0c             	sub    $0xc,%esp
80104bcd:	68 97 8c 10 80       	push   $0x80108c97
80104bd2:	e8 c9 b9 ff ff       	call   801005a0 <panic>
  if(proc->state == RUNNING)
80104bd7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bdd:	8b 40 10             	mov    0x10(%eax),%eax
80104be0:	83 f8 04             	cmp    $0x4,%eax
80104be3:	75 0d                	jne    80104bf2 <sched+0x60>
    panic("sched running");
80104be5:	83 ec 0c             	sub    $0xc,%esp
80104be8:	68 a3 8c 10 80       	push   $0x80108ca3
80104bed:	e8 ae b9 ff ff       	call   801005a0 <panic>
  if(readeflags()&FL_IF)
80104bf2:	e8 f3 f7 ff ff       	call   801043ea <readeflags>
80104bf7:	25 00 02 00 00       	and    $0x200,%eax
80104bfc:	85 c0                	test   %eax,%eax
80104bfe:	74 0d                	je     80104c0d <sched+0x7b>
    panic("sched interruptible");
80104c00:	83 ec 0c             	sub    $0xc,%esp
80104c03:	68 b1 8c 10 80       	push   $0x80108cb1
80104c08:	e8 93 b9 ff ff       	call   801005a0 <panic>
  intena = cpu->intena;
80104c0d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c13:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104c19:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
80104c1c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c22:	8b 40 04             	mov    0x4(%eax),%eax
80104c25:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c2c:	83 c2 20             	add    $0x20,%edx
80104c2f:	83 ec 08             	sub    $0x8,%esp
80104c32:	50                   	push   %eax
80104c33:	52                   	push   %edx
80104c34:	e8 a3 09 00 00       	call   801055dc <swtch>
80104c39:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80104c3c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c42:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c45:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104c4b:	90                   	nop
80104c4c:	c9                   	leave  
80104c4d:	c3                   	ret    

80104c4e <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104c4e:	55                   	push   %ebp
80104c4f:	89 e5                	mov    %esp,%ebp
80104c51:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104c54:	83 ec 0c             	sub    $0xc,%esp
80104c57:	68 20 4e 11 80       	push   $0x80114e20
80104c5c:	e8 8d 04 00 00       	call   801050ee <acquire>
80104c61:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104c64:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c6a:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
  sched();
80104c71:	e8 1c ff ff ff       	call   80104b92 <sched>
  release(&ptable.lock);
80104c76:	83 ec 0c             	sub    $0xc,%esp
80104c79:	68 20 4e 11 80       	push   $0x80114e20
80104c7e:	e8 d7 04 00 00       	call   8010515a <release>
80104c83:	83 c4 10             	add    $0x10,%esp
}
80104c86:	90                   	nop
80104c87:	c9                   	leave  
80104c88:	c3                   	ret    

80104c89 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104c89:	55                   	push   %ebp
80104c8a:	89 e5                	mov    %esp,%ebp
80104c8c:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104c8f:	83 ec 0c             	sub    $0xc,%esp
80104c92:	68 20 4e 11 80       	push   $0x80114e20
80104c97:	e8 be 04 00 00       	call   8010515a <release>
80104c9c:	83 c4 10             	add    $0x10,%esp

  if (first) {
80104c9f:	a1 08 c0 10 80       	mov    0x8010c008,%eax
80104ca4:	85 c0                	test   %eax,%eax
80104ca6:	74 24                	je     80104ccc <forkret+0x43>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80104ca8:	c7 05 08 c0 10 80 00 	movl   $0x0,0x8010c008
80104caf:	00 00 00 
    iinit(ROOTDEV);
80104cb2:	83 ec 0c             	sub    $0xc,%esp
80104cb5:	6a 01                	push   $0x1
80104cb7:	e8 07 ca ff ff       	call   801016c3 <iinit>
80104cbc:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80104cbf:	83 ec 0c             	sub    $0xc,%esp
80104cc2:	6a 01                	push   $0x1
80104cc4:	e8 0c e7 ff ff       	call   801033d5 <initlog>
80104cc9:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104ccc:	90                   	nop
80104ccd:	c9                   	leave  
80104cce:	c3                   	ret    

80104ccf <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104ccf:	55                   	push   %ebp
80104cd0:	89 e5                	mov    %esp,%ebp
80104cd2:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
80104cd5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cdb:	85 c0                	test   %eax,%eax
80104cdd:	75 0d                	jne    80104cec <sleep+0x1d>
    panic("sleep");
80104cdf:	83 ec 0c             	sub    $0xc,%esp
80104ce2:	68 c5 8c 10 80       	push   $0x80108cc5
80104ce7:	e8 b4 b8 ff ff       	call   801005a0 <panic>

  if(lk == 0)
80104cec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104cf0:	75 0d                	jne    80104cff <sleep+0x30>
    panic("sleep without lk");
80104cf2:	83 ec 0c             	sub    $0xc,%esp
80104cf5:	68 cb 8c 10 80       	push   $0x80108ccb
80104cfa:	e8 a1 b8 ff ff       	call   801005a0 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104cff:	81 7d 0c 20 4e 11 80 	cmpl   $0x80114e20,0xc(%ebp)
80104d06:	74 1e                	je     80104d26 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104d08:	83 ec 0c             	sub    $0xc,%esp
80104d0b:	68 20 4e 11 80       	push   $0x80114e20
80104d10:	e8 d9 03 00 00       	call   801050ee <acquire>
80104d15:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104d18:	83 ec 0c             	sub    $0xc,%esp
80104d1b:	ff 75 0c             	pushl  0xc(%ebp)
80104d1e:	e8 37 04 00 00       	call   8010515a <release>
80104d23:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104d26:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d2c:	8b 55 08             	mov    0x8(%ebp),%edx
80104d2f:	89 50 24             	mov    %edx,0x24(%eax)
  proc->state = SLEEPING;
80104d32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d38:	c7 40 10 02 00 00 00 	movl   $0x2,0x10(%eax)
  sched();
80104d3f:	e8 4e fe ff ff       	call   80104b92 <sched>

  // Tidy up.
  proc->chan = 0;
80104d44:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d4a:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
80104d51:	81 7d 0c 20 4e 11 80 	cmpl   $0x80114e20,0xc(%ebp)
80104d58:	74 1e                	je     80104d78 <sleep+0xa9>
    release(&ptable.lock);
80104d5a:	83 ec 0c             	sub    $0xc,%esp
80104d5d:	68 20 4e 11 80       	push   $0x80114e20
80104d62:	e8 f3 03 00 00       	call   8010515a <release>
80104d67:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104d6a:	83 ec 0c             	sub    $0xc,%esp
80104d6d:	ff 75 0c             	pushl  0xc(%ebp)
80104d70:	e8 79 03 00 00       	call   801050ee <acquire>
80104d75:	83 c4 10             	add    $0x10,%esp
  }
}
80104d78:	90                   	nop
80104d79:	c9                   	leave  
80104d7a:	c3                   	ret    

80104d7b <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104d7b:	55                   	push   %ebp
80104d7c:	89 e5                	mov    %esp,%ebp
80104d7e:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d81:	c7 45 fc 54 4e 11 80 	movl   $0x80114e54,-0x4(%ebp)
80104d88:	eb 24                	jmp    80104dae <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104d8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d8d:	8b 40 10             	mov    0x10(%eax),%eax
80104d90:	83 f8 02             	cmp    $0x2,%eax
80104d93:	75 15                	jne    80104daa <wakeup1+0x2f>
80104d95:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d98:	8b 40 24             	mov    0x24(%eax),%eax
80104d9b:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d9e:	75 0a                	jne    80104daa <wakeup1+0x2f>
      p->state = RUNNABLE;
80104da0:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104da3:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104daa:	83 6d fc 80          	subl   $0xffffff80,-0x4(%ebp)
80104dae:	81 7d fc 54 6e 11 80 	cmpl   $0x80116e54,-0x4(%ebp)
80104db5:	72 d3                	jb     80104d8a <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
80104db7:	90                   	nop
80104db8:	c9                   	leave  
80104db9:	c3                   	ret    

80104dba <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104dba:	55                   	push   %ebp
80104dbb:	89 e5                	mov    %esp,%ebp
80104dbd:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
80104dc0:	83 ec 0c             	sub    $0xc,%esp
80104dc3:	68 20 4e 11 80       	push   $0x80114e20
80104dc8:	e8 21 03 00 00       	call   801050ee <acquire>
80104dcd:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
80104dd0:	83 ec 0c             	sub    $0xc,%esp
80104dd3:	ff 75 08             	pushl  0x8(%ebp)
80104dd6:	e8 a0 ff ff ff       	call   80104d7b <wakeup1>
80104ddb:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
80104dde:	83 ec 0c             	sub    $0xc,%esp
80104de1:	68 20 4e 11 80       	push   $0x80114e20
80104de6:	e8 6f 03 00 00       	call   8010515a <release>
80104deb:	83 c4 10             	add    $0x10,%esp
}
80104dee:	90                   	nop
80104def:	c9                   	leave  
80104df0:	c3                   	ret    

80104df1 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104df1:	55                   	push   %ebp
80104df2:	89 e5                	mov    %esp,%ebp
80104df4:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104df7:	83 ec 0c             	sub    $0xc,%esp
80104dfa:	68 20 4e 11 80       	push   $0x80114e20
80104dff:	e8 ea 02 00 00       	call   801050ee <acquire>
80104e04:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e07:	c7 45 f4 54 4e 11 80 	movl   $0x80114e54,-0xc(%ebp)
80104e0e:	eb 45                	jmp    80104e55 <kill+0x64>
    if(p->pid == pid){
80104e10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e13:	8b 40 14             	mov    0x14(%eax),%eax
80104e16:	3b 45 08             	cmp    0x8(%ebp),%eax
80104e19:	75 36                	jne    80104e51 <kill+0x60>
      p->killed = 1;
80104e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e1e:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104e25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e28:	8b 40 10             	mov    0x10(%eax),%eax
80104e2b:	83 f8 02             	cmp    $0x2,%eax
80104e2e:	75 0a                	jne    80104e3a <kill+0x49>
        p->state = RUNNABLE;
80104e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e33:	c7 40 10 03 00 00 00 	movl   $0x3,0x10(%eax)
      release(&ptable.lock);
80104e3a:	83 ec 0c             	sub    $0xc,%esp
80104e3d:	68 20 4e 11 80       	push   $0x80114e20
80104e42:	e8 13 03 00 00       	call   8010515a <release>
80104e47:	83 c4 10             	add    $0x10,%esp
      return 0;
80104e4a:	b8 00 00 00 00       	mov    $0x0,%eax
80104e4f:	eb 22                	jmp    80104e73 <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e51:	83 6d f4 80          	subl   $0xffffff80,-0xc(%ebp)
80104e55:	81 7d f4 54 6e 11 80 	cmpl   $0x80116e54,-0xc(%ebp)
80104e5c:	72 b2                	jb     80104e10 <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104e5e:	83 ec 0c             	sub    $0xc,%esp
80104e61:	68 20 4e 11 80       	push   $0x80114e20
80104e66:	e8 ef 02 00 00       	call   8010515a <release>
80104e6b:	83 c4 10             	add    $0x10,%esp
  return -1;
80104e6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e73:	c9                   	leave  
80104e74:	c3                   	ret    

80104e75 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104e75:	55                   	push   %ebp
80104e76:	89 e5                	mov    %esp,%ebp
80104e78:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e7b:	c7 45 f0 54 4e 11 80 	movl   $0x80114e54,-0x10(%ebp)
80104e82:	e9 d7 00 00 00       	jmp    80104f5e <procdump+0xe9>
    if(p->state == UNUSED)
80104e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e8a:	8b 40 10             	mov    0x10(%eax),%eax
80104e8d:	85 c0                	test   %eax,%eax
80104e8f:	0f 84 c4 00 00 00    	je     80104f59 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e95:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e98:	8b 40 10             	mov    0x10(%eax),%eax
80104e9b:	83 f8 05             	cmp    $0x5,%eax
80104e9e:	77 23                	ja     80104ec3 <procdump+0x4e>
80104ea0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ea3:	8b 40 10             	mov    0x10(%eax),%eax
80104ea6:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
80104ead:	85 c0                	test   %eax,%eax
80104eaf:	74 12                	je     80104ec3 <procdump+0x4e>
      state = states[p->state];
80104eb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eb4:	8b 40 10             	mov    0x10(%eax),%eax
80104eb7:	8b 04 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%eax
80104ebe:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104ec1:	eb 07                	jmp    80104eca <procdump+0x55>
    else
      state = "???";
80104ec3:	c7 45 ec dc 8c 10 80 	movl   $0x80108cdc,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104eca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ecd:	8d 50 70             	lea    0x70(%eax),%edx
80104ed0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ed3:	8b 40 14             	mov    0x14(%eax),%eax
80104ed6:	52                   	push   %edx
80104ed7:	ff 75 ec             	pushl  -0x14(%ebp)
80104eda:	50                   	push   %eax
80104edb:	68 e0 8c 10 80       	push   $0x80108ce0
80104ee0:	e8 1b b5 ff ff       	call   80100400 <cprintf>
80104ee5:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104ee8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104eeb:	8b 40 10             	mov    0x10(%eax),%eax
80104eee:	83 f8 02             	cmp    $0x2,%eax
80104ef1:	75 54                	jne    80104f47 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ef3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ef6:	8b 40 20             	mov    0x20(%eax),%eax
80104ef9:	8b 40 0c             	mov    0xc(%eax),%eax
80104efc:	83 c0 08             	add    $0x8,%eax
80104eff:	89 c2                	mov    %eax,%edx
80104f01:	83 ec 08             	sub    $0x8,%esp
80104f04:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f07:	50                   	push   %eax
80104f08:	52                   	push   %edx
80104f09:	e8 9e 02 00 00       	call   801051ac <getcallerpcs>
80104f0e:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104f11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104f18:	eb 1c                	jmp    80104f36 <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104f1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f1d:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f21:	83 ec 08             	sub    $0x8,%esp
80104f24:	50                   	push   %eax
80104f25:	68 e9 8c 10 80       	push   $0x80108ce9
80104f2a:	e8 d1 b4 ff ff       	call   80100400 <cprintf>
80104f2f:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104f32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104f36:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104f3a:	7f 0b                	jg     80104f47 <procdump+0xd2>
80104f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f3f:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f43:	85 c0                	test   %eax,%eax
80104f45:	75 d3                	jne    80104f1a <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104f47:	83 ec 0c             	sub    $0xc,%esp
80104f4a:	68 ed 8c 10 80       	push   $0x80108ced
80104f4f:	e8 ac b4 ff ff       	call   80100400 <cprintf>
80104f54:	83 c4 10             	add    $0x10,%esp
80104f57:	eb 01                	jmp    80104f5a <procdump+0xe5>
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104f59:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f5a:	83 6d f0 80          	subl   $0xffffff80,-0x10(%ebp)
80104f5e:	81 7d f0 54 6e 11 80 	cmpl   $0x80116e54,-0x10(%ebp)
80104f65:	0f 82 1c ff ff ff    	jb     80104e87 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104f6b:	90                   	nop
80104f6c:	c9                   	leave  
80104f6d:	c3                   	ret    

80104f6e <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104f6e:	55                   	push   %ebp
80104f6f:	89 e5                	mov    %esp,%ebp
80104f71:	83 ec 08             	sub    $0x8,%esp
  initlock(&lk->lk, "sleep lock");
80104f74:	8b 45 08             	mov    0x8(%ebp),%eax
80104f77:	83 c0 04             	add    $0x4,%eax
80104f7a:	83 ec 08             	sub    $0x8,%esp
80104f7d:	68 19 8d 10 80       	push   $0x80108d19
80104f82:	50                   	push   %eax
80104f83:	e8 44 01 00 00       	call   801050cc <initlock>
80104f88:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80104f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f8e:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f91:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
80104f94:	8b 45 08             	mov    0x8(%ebp),%eax
80104f97:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80104f9d:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa0:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80104fa7:	90                   	nop
80104fa8:	c9                   	leave  
80104fa9:	c3                   	ret    

80104faa <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104faa:	55                   	push   %ebp
80104fab:	89 e5                	mov    %esp,%ebp
80104fad:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80104fb0:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb3:	83 c0 04             	add    $0x4,%eax
80104fb6:	83 ec 0c             	sub    $0xc,%esp
80104fb9:	50                   	push   %eax
80104fba:	e8 2f 01 00 00       	call   801050ee <acquire>
80104fbf:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80104fc2:	eb 15                	jmp    80104fd9 <acquiresleep+0x2f>
    sleep(lk, &lk->lk);
80104fc4:	8b 45 08             	mov    0x8(%ebp),%eax
80104fc7:	83 c0 04             	add    $0x4,%eax
80104fca:	83 ec 08             	sub    $0x8,%esp
80104fcd:	50                   	push   %eax
80104fce:	ff 75 08             	pushl  0x8(%ebp)
80104fd1:	e8 f9 fc ff ff       	call   80104ccf <sleep>
80104fd6:	83 c4 10             	add    $0x10,%esp

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80104fd9:	8b 45 08             	mov    0x8(%ebp),%eax
80104fdc:	8b 00                	mov    (%eax),%eax
80104fde:	85 c0                	test   %eax,%eax
80104fe0:	75 e2                	jne    80104fc4 <acquiresleep+0x1a>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = proc->pid;
80104feb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ff1:	8b 50 14             	mov    0x14(%eax),%edx
80104ff4:	8b 45 08             	mov    0x8(%ebp),%eax
80104ff7:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80104ffa:	8b 45 08             	mov    0x8(%ebp),%eax
80104ffd:	83 c0 04             	add    $0x4,%eax
80105000:	83 ec 0c             	sub    $0xc,%esp
80105003:	50                   	push   %eax
80105004:	e8 51 01 00 00       	call   8010515a <release>
80105009:	83 c4 10             	add    $0x10,%esp
}
8010500c:	90                   	nop
8010500d:	c9                   	leave  
8010500e:	c3                   	ret    

8010500f <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
8010500f:	55                   	push   %ebp
80105010:	89 e5                	mov    %esp,%ebp
80105012:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80105015:	8b 45 08             	mov    0x8(%ebp),%eax
80105018:	83 c0 04             	add    $0x4,%eax
8010501b:	83 ec 0c             	sub    $0xc,%esp
8010501e:	50                   	push   %eax
8010501f:	e8 ca 00 00 00       	call   801050ee <acquire>
80105024:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
80105027:	8b 45 08             	mov    0x8(%ebp),%eax
8010502a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80105030:	8b 45 08             	mov    0x8(%ebp),%eax
80105033:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
8010503a:	83 ec 0c             	sub    $0xc,%esp
8010503d:	ff 75 08             	pushl  0x8(%ebp)
80105040:	e8 75 fd ff ff       	call   80104dba <wakeup>
80105045:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
80105048:	8b 45 08             	mov    0x8(%ebp),%eax
8010504b:	83 c0 04             	add    $0x4,%eax
8010504e:	83 ec 0c             	sub    $0xc,%esp
80105051:	50                   	push   %eax
80105052:	e8 03 01 00 00       	call   8010515a <release>
80105057:	83 c4 10             	add    $0x10,%esp
}
8010505a:	90                   	nop
8010505b:	c9                   	leave  
8010505c:	c3                   	ret    

8010505d <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
8010505d:	55                   	push   %ebp
8010505e:	89 e5                	mov    %esp,%ebp
80105060:	83 ec 18             	sub    $0x18,%esp
  int r;
  
  acquire(&lk->lk);
80105063:	8b 45 08             	mov    0x8(%ebp),%eax
80105066:	83 c0 04             	add    $0x4,%eax
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	50                   	push   %eax
8010506d:	e8 7c 00 00 00       	call   801050ee <acquire>
80105072:	83 c4 10             	add    $0x10,%esp
  r = lk->locked;
80105075:	8b 45 08             	mov    0x8(%ebp),%eax
80105078:	8b 00                	mov    (%eax),%eax
8010507a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
8010507d:	8b 45 08             	mov    0x8(%ebp),%eax
80105080:	83 c0 04             	add    $0x4,%eax
80105083:	83 ec 0c             	sub    $0xc,%esp
80105086:	50                   	push   %eax
80105087:	e8 ce 00 00 00       	call   8010515a <release>
8010508c:	83 c4 10             	add    $0x10,%esp
  return r;
8010508f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105092:	c9                   	leave  
80105093:	c3                   	ret    

80105094 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80105094:	55                   	push   %ebp
80105095:	89 e5                	mov    %esp,%ebp
80105097:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010509a:	9c                   	pushf  
8010509b:	58                   	pop    %eax
8010509c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010509f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801050a2:	c9                   	leave  
801050a3:	c3                   	ret    

801050a4 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801050a4:	55                   	push   %ebp
801050a5:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801050a7:	fa                   	cli    
}
801050a8:	90                   	nop
801050a9:	5d                   	pop    %ebp
801050aa:	c3                   	ret    

801050ab <sti>:

static inline void
sti(void)
{
801050ab:	55                   	push   %ebp
801050ac:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801050ae:	fb                   	sti    
}
801050af:	90                   	nop
801050b0:	5d                   	pop    %ebp
801050b1:	c3                   	ret    

801050b2 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
801050b2:	55                   	push   %ebp
801050b3:	89 e5                	mov    %esp,%ebp
801050b5:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801050b8:	8b 55 08             	mov    0x8(%ebp),%edx
801050bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801050be:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050c1:	f0 87 02             	lock xchg %eax,(%edx)
801050c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801050c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801050ca:	c9                   	leave  
801050cb:	c3                   	ret    

801050cc <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801050cc:	55                   	push   %ebp
801050cd:	89 e5                	mov    %esp,%ebp
  lk->name = name;
801050cf:	8b 45 08             	mov    0x8(%ebp),%eax
801050d2:	8b 55 0c             	mov    0xc(%ebp),%edx
801050d5:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
801050d8:	8b 45 08             	mov    0x8(%ebp),%eax
801050db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
801050e1:	8b 45 08             	mov    0x8(%ebp),%eax
801050e4:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801050eb:	90                   	nop
801050ec:	5d                   	pop    %ebp
801050ed:	c3                   	ret    

801050ee <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801050ee:	55                   	push   %ebp
801050ef:	89 e5                	mov    %esp,%ebp
801050f1:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801050f4:	e8 57 01 00 00       	call   80105250 <pushcli>
  if(holding(lk))
801050f9:	8b 45 08             	mov    0x8(%ebp),%eax
801050fc:	83 ec 0c             	sub    $0xc,%esp
801050ff:	50                   	push   %eax
80105100:	e8 21 01 00 00       	call   80105226 <holding>
80105105:	83 c4 10             	add    $0x10,%esp
80105108:	85 c0                	test   %eax,%eax
8010510a:	74 0d                	je     80105119 <acquire+0x2b>
    panic("acquire");
8010510c:	83 ec 0c             	sub    $0xc,%esp
8010510f:	68 24 8d 10 80       	push   $0x80108d24
80105114:	e8 87 b4 ff ff       	call   801005a0 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80105119:	90                   	nop
8010511a:	8b 45 08             	mov    0x8(%ebp),%eax
8010511d:	83 ec 08             	sub    $0x8,%esp
80105120:	6a 01                	push   $0x1
80105122:	50                   	push   %eax
80105123:	e8 8a ff ff ff       	call   801050b2 <xchg>
80105128:	83 c4 10             	add    $0x10,%esp
8010512b:	85 c0                	test   %eax,%eax
8010512d:	75 eb                	jne    8010511a <acquire+0x2c>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010512f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80105134:	8b 45 08             	mov    0x8(%ebp),%eax
80105137:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010513e:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80105141:	8b 45 08             	mov    0x8(%ebp),%eax
80105144:	83 c0 0c             	add    $0xc,%eax
80105147:	83 ec 08             	sub    $0x8,%esp
8010514a:	50                   	push   %eax
8010514b:	8d 45 08             	lea    0x8(%ebp),%eax
8010514e:	50                   	push   %eax
8010514f:	e8 58 00 00 00       	call   801051ac <getcallerpcs>
80105154:	83 c4 10             	add    $0x10,%esp
}
80105157:	90                   	nop
80105158:	c9                   	leave  
80105159:	c3                   	ret    

8010515a <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
8010515a:	55                   	push   %ebp
8010515b:	89 e5                	mov    %esp,%ebp
8010515d:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80105160:	83 ec 0c             	sub    $0xc,%esp
80105163:	ff 75 08             	pushl  0x8(%ebp)
80105166:	e8 bb 00 00 00       	call   80105226 <holding>
8010516b:	83 c4 10             	add    $0x10,%esp
8010516e:	85 c0                	test   %eax,%eax
80105170:	75 0d                	jne    8010517f <release+0x25>
    panic("release");
80105172:	83 ec 0c             	sub    $0xc,%esp
80105175:	68 2c 8d 10 80       	push   $0x80108d2c
8010517a:	e8 21 b4 ff ff       	call   801005a0 <panic>

  lk->pcs[0] = 0;
8010517f:	8b 45 08             	mov    0x8(%ebp),%eax
80105182:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80105189:	8b 45 08             	mov    0x8(%ebp),%eax
8010518c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80105193:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105198:	8b 45 08             	mov    0x8(%ebp),%eax
8010519b:	8b 55 08             	mov    0x8(%ebp),%edx
8010519e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
801051a4:	e8 fe 00 00 00       	call   801052a7 <popcli>
}
801051a9:	90                   	nop
801051aa:	c9                   	leave  
801051ab:	c3                   	ret    

801051ac <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801051ac:	55                   	push   %ebp
801051ad:	89 e5                	mov    %esp,%ebp
801051af:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801051b2:	8b 45 08             	mov    0x8(%ebp),%eax
801051b5:	83 e8 08             	sub    $0x8,%eax
801051b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801051bb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
801051c2:	eb 38                	jmp    801051fc <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
801051c8:	74 53                	je     8010521d <getcallerpcs+0x71>
801051ca:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
801051d1:	76 4a                	jbe    8010521d <getcallerpcs+0x71>
801051d3:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
801051d7:	74 44                	je     8010521d <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
801051d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801051dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801051e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801051e6:	01 c2                	add    %eax,%edx
801051e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051eb:	8b 40 04             	mov    0x4(%eax),%eax
801051ee:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801051f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051f3:	8b 00                	mov    (%eax),%eax
801051f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801051f8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801051fc:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105200:	7e c2                	jle    801051c4 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105202:	eb 19                	jmp    8010521d <getcallerpcs+0x71>
    pcs[i] = 0;
80105204:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105207:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010520e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105211:	01 d0                	add    %edx,%eax
80105213:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105219:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010521d:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80105221:	7e e1                	jle    80105204 <getcallerpcs+0x58>
    pcs[i] = 0;
}
80105223:	90                   	nop
80105224:	c9                   	leave  
80105225:	c3                   	ret    

80105226 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105226:	55                   	push   %ebp
80105227:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105229:	8b 45 08             	mov    0x8(%ebp),%eax
8010522c:	8b 00                	mov    (%eax),%eax
8010522e:	85 c0                	test   %eax,%eax
80105230:	74 17                	je     80105249 <holding+0x23>
80105232:	8b 45 08             	mov    0x8(%ebp),%eax
80105235:	8b 50 08             	mov    0x8(%eax),%edx
80105238:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010523e:	39 c2                	cmp    %eax,%edx
80105240:	75 07                	jne    80105249 <holding+0x23>
80105242:	b8 01 00 00 00       	mov    $0x1,%eax
80105247:	eb 05                	jmp    8010524e <holding+0x28>
80105249:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010524e:	5d                   	pop    %ebp
8010524f:	c3                   	ret    

80105250 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	83 ec 10             	sub    $0x10,%esp
  int eflags;

  eflags = readeflags();
80105256:	e8 39 fe ff ff       	call   80105094 <readeflags>
8010525b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
8010525e:	e8 41 fe ff ff       	call   801050a4 <cli>
  if(cpu->ncli == 0)
80105263:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105269:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010526f:	85 c0                	test   %eax,%eax
80105271:	75 15                	jne    80105288 <pushcli+0x38>
    cpu->intena = eflags & FL_IF;
80105273:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105279:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010527c:	81 e2 00 02 00 00    	and    $0x200,%edx
80105282:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
  cpu->ncli += 1;
80105288:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010528e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105295:	8b 92 ac 00 00 00    	mov    0xac(%edx),%edx
8010529b:	83 c2 01             	add    $0x1,%edx
8010529e:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
801052a4:	90                   	nop
801052a5:	c9                   	leave  
801052a6:	c3                   	ret    

801052a7 <popcli>:

void
popcli(void)
{
801052a7:	55                   	push   %ebp
801052a8:	89 e5                	mov    %esp,%ebp
801052aa:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801052ad:	e8 e2 fd ff ff       	call   80105094 <readeflags>
801052b2:	25 00 02 00 00       	and    $0x200,%eax
801052b7:	85 c0                	test   %eax,%eax
801052b9:	74 0d                	je     801052c8 <popcli+0x21>
    panic("popcli - interruptible");
801052bb:	83 ec 0c             	sub    $0xc,%esp
801052be:	68 34 8d 10 80       	push   $0x80108d34
801052c3:	e8 d8 b2 ff ff       	call   801005a0 <panic>
  if(--cpu->ncli < 0)
801052c8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052ce:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801052d4:	83 ea 01             	sub    $0x1,%edx
801052d7:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801052dd:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801052e3:	85 c0                	test   %eax,%eax
801052e5:	79 0d                	jns    801052f4 <popcli+0x4d>
    panic("popcli");
801052e7:	83 ec 0c             	sub    $0xc,%esp
801052ea:	68 4b 8d 10 80       	push   $0x80108d4b
801052ef:	e8 ac b2 ff ff       	call   801005a0 <panic>
  if(cpu->ncli == 0 && cpu->intena)
801052f4:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801052fa:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105300:	85 c0                	test   %eax,%eax
80105302:	75 15                	jne    80105319 <popcli+0x72>
80105304:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010530a:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105310:	85 c0                	test   %eax,%eax
80105312:	74 05                	je     80105319 <popcli+0x72>
    sti();
80105314:	e8 92 fd ff ff       	call   801050ab <sti>
}
80105319:	90                   	nop
8010531a:	c9                   	leave  
8010531b:	c3                   	ret    

8010531c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
8010531c:	55                   	push   %ebp
8010531d:	89 e5                	mov    %esp,%ebp
8010531f:	57                   	push   %edi
80105320:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105321:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105324:	8b 55 10             	mov    0x10(%ebp),%edx
80105327:	8b 45 0c             	mov    0xc(%ebp),%eax
8010532a:	89 cb                	mov    %ecx,%ebx
8010532c:	89 df                	mov    %ebx,%edi
8010532e:	89 d1                	mov    %edx,%ecx
80105330:	fc                   	cld    
80105331:	f3 aa                	rep stos %al,%es:(%edi)
80105333:	89 ca                	mov    %ecx,%edx
80105335:	89 fb                	mov    %edi,%ebx
80105337:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010533a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010533d:	90                   	nop
8010533e:	5b                   	pop    %ebx
8010533f:	5f                   	pop    %edi
80105340:	5d                   	pop    %ebp
80105341:	c3                   	ret    

80105342 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105342:	55                   	push   %ebp
80105343:	89 e5                	mov    %esp,%ebp
80105345:	57                   	push   %edi
80105346:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80105347:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010534a:	8b 55 10             	mov    0x10(%ebp),%edx
8010534d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105350:	89 cb                	mov    %ecx,%ebx
80105352:	89 df                	mov    %ebx,%edi
80105354:	89 d1                	mov    %edx,%ecx
80105356:	fc                   	cld    
80105357:	f3 ab                	rep stos %eax,%es:(%edi)
80105359:	89 ca                	mov    %ecx,%edx
8010535b:	89 fb                	mov    %edi,%ebx
8010535d:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105360:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105363:	90                   	nop
80105364:	5b                   	pop    %ebx
80105365:	5f                   	pop    %edi
80105366:	5d                   	pop    %ebp
80105367:	c3                   	ret    

80105368 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105368:	55                   	push   %ebp
80105369:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
8010536b:	8b 45 08             	mov    0x8(%ebp),%eax
8010536e:	83 e0 03             	and    $0x3,%eax
80105371:	85 c0                	test   %eax,%eax
80105373:	75 43                	jne    801053b8 <memset+0x50>
80105375:	8b 45 10             	mov    0x10(%ebp),%eax
80105378:	83 e0 03             	and    $0x3,%eax
8010537b:	85 c0                	test   %eax,%eax
8010537d:	75 39                	jne    801053b8 <memset+0x50>
    c &= 0xFF;
8010537f:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105386:	8b 45 10             	mov    0x10(%ebp),%eax
80105389:	c1 e8 02             	shr    $0x2,%eax
8010538c:	89 c1                	mov    %eax,%ecx
8010538e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105391:	c1 e0 18             	shl    $0x18,%eax
80105394:	89 c2                	mov    %eax,%edx
80105396:	8b 45 0c             	mov    0xc(%ebp),%eax
80105399:	c1 e0 10             	shl    $0x10,%eax
8010539c:	09 c2                	or     %eax,%edx
8010539e:	8b 45 0c             	mov    0xc(%ebp),%eax
801053a1:	c1 e0 08             	shl    $0x8,%eax
801053a4:	09 d0                	or     %edx,%eax
801053a6:	0b 45 0c             	or     0xc(%ebp),%eax
801053a9:	51                   	push   %ecx
801053aa:	50                   	push   %eax
801053ab:	ff 75 08             	pushl  0x8(%ebp)
801053ae:	e8 8f ff ff ff       	call   80105342 <stosl>
801053b3:	83 c4 0c             	add    $0xc,%esp
801053b6:	eb 12                	jmp    801053ca <memset+0x62>
  } else
    stosb(dst, c, n);
801053b8:	8b 45 10             	mov    0x10(%ebp),%eax
801053bb:	50                   	push   %eax
801053bc:	ff 75 0c             	pushl  0xc(%ebp)
801053bf:	ff 75 08             	pushl  0x8(%ebp)
801053c2:	e8 55 ff ff ff       	call   8010531c <stosb>
801053c7:	83 c4 0c             	add    $0xc,%esp
  return dst;
801053ca:	8b 45 08             	mov    0x8(%ebp),%eax
}
801053cd:	c9                   	leave  
801053ce:	c3                   	ret    

801053cf <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801053cf:	55                   	push   %ebp
801053d0:	89 e5                	mov    %esp,%ebp
801053d2:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
801053d5:	8b 45 08             	mov    0x8(%ebp),%eax
801053d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801053db:	8b 45 0c             	mov    0xc(%ebp),%eax
801053de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801053e1:	eb 30                	jmp    80105413 <memcmp+0x44>
    if(*s1 != *s2)
801053e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053e6:	0f b6 10             	movzbl (%eax),%edx
801053e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053ec:	0f b6 00             	movzbl (%eax),%eax
801053ef:	38 c2                	cmp    %al,%dl
801053f1:	74 18                	je     8010540b <memcmp+0x3c>
      return *s1 - *s2;
801053f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053f6:	0f b6 00             	movzbl (%eax),%eax
801053f9:	0f b6 d0             	movzbl %al,%edx
801053fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
801053ff:	0f b6 00             	movzbl (%eax),%eax
80105402:	0f b6 c0             	movzbl %al,%eax
80105405:	29 c2                	sub    %eax,%edx
80105407:	89 d0                	mov    %edx,%eax
80105409:	eb 1a                	jmp    80105425 <memcmp+0x56>
    s1++, s2++;
8010540b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010540f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105413:	8b 45 10             	mov    0x10(%ebp),%eax
80105416:	8d 50 ff             	lea    -0x1(%eax),%edx
80105419:	89 55 10             	mov    %edx,0x10(%ebp)
8010541c:	85 c0                	test   %eax,%eax
8010541e:	75 c3                	jne    801053e3 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105420:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105425:	c9                   	leave  
80105426:	c3                   	ret    

80105427 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105427:	55                   	push   %ebp
80105428:	89 e5                	mov    %esp,%ebp
8010542a:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
8010542d:	8b 45 0c             	mov    0xc(%ebp),%eax
80105430:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80105433:	8b 45 08             	mov    0x8(%ebp),%eax
80105436:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80105439:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010543c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010543f:	73 54                	jae    80105495 <memmove+0x6e>
80105441:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105444:	8b 45 10             	mov    0x10(%ebp),%eax
80105447:	01 d0                	add    %edx,%eax
80105449:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010544c:	76 47                	jbe    80105495 <memmove+0x6e>
    s += n;
8010544e:	8b 45 10             	mov    0x10(%ebp),%eax
80105451:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80105454:	8b 45 10             	mov    0x10(%ebp),%eax
80105457:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
8010545a:	eb 13                	jmp    8010546f <memmove+0x48>
      *--d = *--s;
8010545c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80105460:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80105464:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105467:	0f b6 10             	movzbl (%eax),%edx
8010546a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010546d:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010546f:	8b 45 10             	mov    0x10(%ebp),%eax
80105472:	8d 50 ff             	lea    -0x1(%eax),%edx
80105475:	89 55 10             	mov    %edx,0x10(%ebp)
80105478:	85 c0                	test   %eax,%eax
8010547a:	75 e0                	jne    8010545c <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010547c:	eb 24                	jmp    801054a2 <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
8010547e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105481:	8d 50 01             	lea    0x1(%eax),%edx
80105484:	89 55 f8             	mov    %edx,-0x8(%ebp)
80105487:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010548a:	8d 4a 01             	lea    0x1(%edx),%ecx
8010548d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80105490:	0f b6 12             	movzbl (%edx),%edx
80105493:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105495:	8b 45 10             	mov    0x10(%ebp),%eax
80105498:	8d 50 ff             	lea    -0x1(%eax),%edx
8010549b:	89 55 10             	mov    %edx,0x10(%ebp)
8010549e:	85 c0                	test   %eax,%eax
801054a0:	75 dc                	jne    8010547e <memmove+0x57>
      *d++ = *s++;

  return dst;
801054a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
801054a5:	c9                   	leave  
801054a6:	c3                   	ret    

801054a7 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801054a7:	55                   	push   %ebp
801054a8:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801054aa:	ff 75 10             	pushl  0x10(%ebp)
801054ad:	ff 75 0c             	pushl  0xc(%ebp)
801054b0:	ff 75 08             	pushl  0x8(%ebp)
801054b3:	e8 6f ff ff ff       	call   80105427 <memmove>
801054b8:	83 c4 0c             	add    $0xc,%esp
}
801054bb:	c9                   	leave  
801054bc:	c3                   	ret    

801054bd <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801054bd:	55                   	push   %ebp
801054be:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
801054c0:	eb 0c                	jmp    801054ce <strncmp+0x11>
    n--, p++, q++;
801054c2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801054c6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801054ca:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801054ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054d2:	74 1a                	je     801054ee <strncmp+0x31>
801054d4:	8b 45 08             	mov    0x8(%ebp),%eax
801054d7:	0f b6 00             	movzbl (%eax),%eax
801054da:	84 c0                	test   %al,%al
801054dc:	74 10                	je     801054ee <strncmp+0x31>
801054de:	8b 45 08             	mov    0x8(%ebp),%eax
801054e1:	0f b6 10             	movzbl (%eax),%edx
801054e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801054e7:	0f b6 00             	movzbl (%eax),%eax
801054ea:	38 c2                	cmp    %al,%dl
801054ec:	74 d4                	je     801054c2 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
801054ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801054f2:	75 07                	jne    801054fb <strncmp+0x3e>
    return 0;
801054f4:	b8 00 00 00 00       	mov    $0x0,%eax
801054f9:	eb 16                	jmp    80105511 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
801054fb:	8b 45 08             	mov    0x8(%ebp),%eax
801054fe:	0f b6 00             	movzbl (%eax),%eax
80105501:	0f b6 d0             	movzbl %al,%edx
80105504:	8b 45 0c             	mov    0xc(%ebp),%eax
80105507:	0f b6 00             	movzbl (%eax),%eax
8010550a:	0f b6 c0             	movzbl %al,%eax
8010550d:	29 c2                	sub    %eax,%edx
8010550f:	89 d0                	mov    %edx,%eax
}
80105511:	5d                   	pop    %ebp
80105512:	c3                   	ret    

80105513 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105513:	55                   	push   %ebp
80105514:	89 e5                	mov    %esp,%ebp
80105516:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80105519:	8b 45 08             	mov    0x8(%ebp),%eax
8010551c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010551f:	90                   	nop
80105520:	8b 45 10             	mov    0x10(%ebp),%eax
80105523:	8d 50 ff             	lea    -0x1(%eax),%edx
80105526:	89 55 10             	mov    %edx,0x10(%ebp)
80105529:	85 c0                	test   %eax,%eax
8010552b:	7e 2c                	jle    80105559 <strncpy+0x46>
8010552d:	8b 45 08             	mov    0x8(%ebp),%eax
80105530:	8d 50 01             	lea    0x1(%eax),%edx
80105533:	89 55 08             	mov    %edx,0x8(%ebp)
80105536:	8b 55 0c             	mov    0xc(%ebp),%edx
80105539:	8d 4a 01             	lea    0x1(%edx),%ecx
8010553c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010553f:	0f b6 12             	movzbl (%edx),%edx
80105542:	88 10                	mov    %dl,(%eax)
80105544:	0f b6 00             	movzbl (%eax),%eax
80105547:	84 c0                	test   %al,%al
80105549:	75 d5                	jne    80105520 <strncpy+0xd>
    ;
  while(n-- > 0)
8010554b:	eb 0c                	jmp    80105559 <strncpy+0x46>
    *s++ = 0;
8010554d:	8b 45 08             	mov    0x8(%ebp),%eax
80105550:	8d 50 01             	lea    0x1(%eax),%edx
80105553:	89 55 08             	mov    %edx,0x8(%ebp)
80105556:	c6 00 00             	movb   $0x0,(%eax)
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105559:	8b 45 10             	mov    0x10(%ebp),%eax
8010555c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010555f:	89 55 10             	mov    %edx,0x10(%ebp)
80105562:	85 c0                	test   %eax,%eax
80105564:	7f e7                	jg     8010554d <strncpy+0x3a>
    *s++ = 0;
  return os;
80105566:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105569:	c9                   	leave  
8010556a:	c3                   	ret    

8010556b <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
8010556b:	55                   	push   %ebp
8010556c:	89 e5                	mov    %esp,%ebp
8010556e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80105571:	8b 45 08             	mov    0x8(%ebp),%eax
80105574:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80105577:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010557b:	7f 05                	jg     80105582 <safestrcpy+0x17>
    return os;
8010557d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105580:	eb 31                	jmp    801055b3 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80105582:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105586:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010558a:	7e 1e                	jle    801055aa <safestrcpy+0x3f>
8010558c:	8b 45 08             	mov    0x8(%ebp),%eax
8010558f:	8d 50 01             	lea    0x1(%eax),%edx
80105592:	89 55 08             	mov    %edx,0x8(%ebp)
80105595:	8b 55 0c             	mov    0xc(%ebp),%edx
80105598:	8d 4a 01             	lea    0x1(%edx),%ecx
8010559b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
8010559e:	0f b6 12             	movzbl (%edx),%edx
801055a1:	88 10                	mov    %dl,(%eax)
801055a3:	0f b6 00             	movzbl (%eax),%eax
801055a6:	84 c0                	test   %al,%al
801055a8:	75 d8                	jne    80105582 <safestrcpy+0x17>
    ;
  *s = 0;
801055aa:	8b 45 08             	mov    0x8(%ebp),%eax
801055ad:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801055b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801055b3:	c9                   	leave  
801055b4:	c3                   	ret    

801055b5 <strlen>:

int
strlen(const char *s)
{
801055b5:	55                   	push   %ebp
801055b6:	89 e5                	mov    %esp,%ebp
801055b8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801055bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801055c2:	eb 04                	jmp    801055c8 <strlen+0x13>
801055c4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801055c8:	8b 55 fc             	mov    -0x4(%ebp),%edx
801055cb:	8b 45 08             	mov    0x8(%ebp),%eax
801055ce:	01 d0                	add    %edx,%eax
801055d0:	0f b6 00             	movzbl (%eax),%eax
801055d3:	84 c0                	test   %al,%al
801055d5:	75 ed                	jne    801055c4 <strlen+0xf>
    ;
  return n;
801055d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801055da:	c9                   	leave  
801055db:	c3                   	ret    

801055dc <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801055dc:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801055e0:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801055e4:	55                   	push   %ebp
  pushl %ebx
801055e5:	53                   	push   %ebx
  pushl %esi
801055e6:	56                   	push   %esi
  pushl %edi
801055e7:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801055e8:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801055ea:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801055ec:	5f                   	pop    %edi
  popl %esi
801055ed:	5e                   	pop    %esi
  popl %ebx
801055ee:	5b                   	pop    %ebx
  popl %ebp
801055ef:	5d                   	pop    %ebp
  ret
801055f0:	c3                   	ret    

801055f1 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801055f1:	55                   	push   %ebp
801055f2:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801055f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055fa:	8b 00                	mov    (%eax),%eax
801055fc:	3b 45 08             	cmp    0x8(%ebp),%eax
801055ff:	76 12                	jbe    80105613 <fetchint+0x22>
80105601:	8b 45 08             	mov    0x8(%ebp),%eax
80105604:	8d 50 04             	lea    0x4(%eax),%edx
80105607:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010560d:	8b 00                	mov    (%eax),%eax
8010560f:	39 c2                	cmp    %eax,%edx
80105611:	76 07                	jbe    8010561a <fetchint+0x29>
    return -1;
80105613:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105618:	eb 0f                	jmp    80105629 <fetchint+0x38>
  *ip = *(int*)(addr);
8010561a:	8b 45 08             	mov    0x8(%ebp),%eax
8010561d:	8b 10                	mov    (%eax),%edx
8010561f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105622:	89 10                	mov    %edx,(%eax)
  return 0;
80105624:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105629:	5d                   	pop    %ebp
8010562a:	c3                   	ret    

8010562b <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010562b:	55                   	push   %ebp
8010562c:	89 e5                	mov    %esp,%ebp
8010562e:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105631:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105637:	8b 00                	mov    (%eax),%eax
80105639:	3b 45 08             	cmp    0x8(%ebp),%eax
8010563c:	77 07                	ja     80105645 <fetchstr+0x1a>
    return -1;
8010563e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105643:	eb 46                	jmp    8010568b <fetchstr+0x60>
  *pp = (char*)addr;
80105645:	8b 55 08             	mov    0x8(%ebp),%edx
80105648:	8b 45 0c             	mov    0xc(%ebp),%eax
8010564b:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
8010564d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105653:	8b 00                	mov    (%eax),%eax
80105655:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
80105658:	8b 45 0c             	mov    0xc(%ebp),%eax
8010565b:	8b 00                	mov    (%eax),%eax
8010565d:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105660:	eb 1c                	jmp    8010567e <fetchstr+0x53>
    if(*s == 0)
80105662:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105665:	0f b6 00             	movzbl (%eax),%eax
80105668:	84 c0                	test   %al,%al
8010566a:	75 0e                	jne    8010567a <fetchstr+0x4f>
      return s - *pp;
8010566c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010566f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105672:	8b 00                	mov    (%eax),%eax
80105674:	29 c2                	sub    %eax,%edx
80105676:	89 d0                	mov    %edx,%eax
80105678:	eb 11                	jmp    8010568b <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010567a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010567e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105681:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105684:	72 dc                	jb     80105662 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
80105686:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010568b:	c9                   	leave  
8010568c:	c3                   	ret    

8010568d <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
8010568d:	55                   	push   %ebp
8010568e:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105690:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105696:	8b 40 1c             	mov    0x1c(%eax),%eax
80105699:	8b 40 44             	mov    0x44(%eax),%eax
8010569c:	8b 55 08             	mov    0x8(%ebp),%edx
8010569f:	c1 e2 02             	shl    $0x2,%edx
801056a2:	01 d0                	add    %edx,%eax
801056a4:	83 c0 04             	add    $0x4,%eax
801056a7:	ff 75 0c             	pushl  0xc(%ebp)
801056aa:	50                   	push   %eax
801056ab:	e8 41 ff ff ff       	call   801055f1 <fetchint>
801056b0:	83 c4 08             	add    $0x8,%esp
}
801056b3:	c9                   	leave  
801056b4:	c3                   	ret    

801056b5 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801056b5:	55                   	push   %ebp
801056b6:	89 e5                	mov    %esp,%ebp
801056b8:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(argint(n, &i) < 0)
801056bb:	8d 45 fc             	lea    -0x4(%ebp),%eax
801056be:	50                   	push   %eax
801056bf:	ff 75 08             	pushl  0x8(%ebp)
801056c2:	e8 c6 ff ff ff       	call   8010568d <argint>
801056c7:	83 c4 08             	add    $0x8,%esp
801056ca:	85 c0                	test   %eax,%eax
801056cc:	79 07                	jns    801056d5 <argptr+0x20>
    return -1;
801056ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d3:	eb 3b                	jmp    80105710 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801056d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056db:	8b 00                	mov    (%eax),%eax
801056dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056e0:	39 d0                	cmp    %edx,%eax
801056e2:	76 16                	jbe    801056fa <argptr+0x45>
801056e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801056e7:	89 c2                	mov    %eax,%edx
801056e9:	8b 45 10             	mov    0x10(%ebp),%eax
801056ec:	01 c2                	add    %eax,%edx
801056ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056f4:	8b 00                	mov    (%eax),%eax
801056f6:	39 c2                	cmp    %eax,%edx
801056f8:	76 07                	jbe    80105701 <argptr+0x4c>
    return -1;
801056fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ff:	eb 0f                	jmp    80105710 <argptr+0x5b>
  *pp = (char*)i;
80105701:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105704:	89 c2                	mov    %eax,%edx
80105706:	8b 45 0c             	mov    0xc(%ebp),%eax
80105709:	89 10                	mov    %edx,(%eax)
  return 0;
8010570b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105710:	c9                   	leave  
80105711:	c3                   	ret    

80105712 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105712:	55                   	push   %ebp
80105713:	89 e5                	mov    %esp,%ebp
80105715:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105718:	8d 45 fc             	lea    -0x4(%ebp),%eax
8010571b:	50                   	push   %eax
8010571c:	ff 75 08             	pushl  0x8(%ebp)
8010571f:	e8 69 ff ff ff       	call   8010568d <argint>
80105724:	83 c4 08             	add    $0x8,%esp
80105727:	85 c0                	test   %eax,%eax
80105729:	79 07                	jns    80105732 <argstr+0x20>
    return -1;
8010572b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105730:	eb 0f                	jmp    80105741 <argstr+0x2f>
  return fetchstr(addr, pp);
80105732:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105735:	ff 75 0c             	pushl  0xc(%ebp)
80105738:	50                   	push   %eax
80105739:	e8 ed fe ff ff       	call   8010562b <fetchstr>
8010573e:	83 c4 08             	add    $0x8,%esp
}
80105741:	c9                   	leave  
80105742:	c3                   	ret    

80105743 <syscall>:
[SYS_dup2]    sys_dup2,
};

void
syscall(void)
{
80105743:	55                   	push   %ebp
80105744:	89 e5                	mov    %esp,%ebp
80105746:	53                   	push   %ebx
80105747:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
8010574a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105750:	8b 40 1c             	mov    0x1c(%eax),%eax
80105753:	8b 40 1c             	mov    0x1c(%eax),%eax
80105756:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105759:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010575d:	7e 30                	jle    8010578f <syscall+0x4c>
8010575f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105762:	83 f8 17             	cmp    $0x17,%eax
80105765:	77 28                	ja     8010578f <syscall+0x4c>
80105767:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010576a:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105771:	85 c0                	test   %eax,%eax
80105773:	74 1a                	je     8010578f <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105775:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010577b:	8b 58 1c             	mov    0x1c(%eax),%ebx
8010577e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105781:	8b 04 85 40 c0 10 80 	mov    -0x7fef3fc0(,%eax,4),%eax
80105788:	ff d0                	call   *%eax
8010578a:	89 43 1c             	mov    %eax,0x1c(%ebx)
8010578d:	eb 34                	jmp    801057c3 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010578f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105795:	8d 50 70             	lea    0x70(%eax),%edx
80105798:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010579e:	8b 40 14             	mov    0x14(%eax),%eax
801057a1:	ff 75 f4             	pushl  -0xc(%ebp)
801057a4:	52                   	push   %edx
801057a5:	50                   	push   %eax
801057a6:	68 52 8d 10 80       	push   $0x80108d52
801057ab:	e8 50 ac ff ff       	call   80100400 <cprintf>
801057b0:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801057b3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057b9:	8b 40 1c             	mov    0x1c(%eax),%eax
801057bc:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801057c3:	90                   	nop
801057c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057c7:	c9                   	leave  
801057c8:	c3                   	ret    

801057c9 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801057c9:	55                   	push   %ebp
801057ca:	89 e5                	mov    %esp,%ebp
801057cc:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801057cf:	83 ec 08             	sub    $0x8,%esp
801057d2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057d5:	50                   	push   %eax
801057d6:	ff 75 08             	pushl  0x8(%ebp)
801057d9:	e8 af fe ff ff       	call   8010568d <argint>
801057de:	83 c4 10             	add    $0x10,%esp
801057e1:	85 c0                	test   %eax,%eax
801057e3:	79 07                	jns    801057ec <argfd+0x23>
    return -1;
801057e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ea:	eb 50                	jmp    8010583c <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801057ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057ef:	85 c0                	test   %eax,%eax
801057f1:	78 21                	js     80105814 <argfd+0x4b>
801057f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057f6:	83 f8 0f             	cmp    $0xf,%eax
801057f9:	7f 19                	jg     80105814 <argfd+0x4b>
801057fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105801:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105804:	83 c2 08             	add    $0x8,%edx
80105807:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010580b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010580e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105812:	75 07                	jne    8010581b <argfd+0x52>
    return -1;
80105814:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105819:	eb 21                	jmp    8010583c <argfd+0x73>
  if(pfd)
8010581b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010581f:	74 08                	je     80105829 <argfd+0x60>
    *pfd = fd;
80105821:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105824:	8b 45 0c             	mov    0xc(%ebp),%eax
80105827:	89 10                	mov    %edx,(%eax)
  if(pf)
80105829:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010582d:	74 08                	je     80105837 <argfd+0x6e>
    *pf = f;
8010582f:	8b 45 10             	mov    0x10(%ebp),%eax
80105832:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105835:	89 10                	mov    %edx,(%eax)
  return 0;
80105837:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010583c:	c9                   	leave  
8010583d:	c3                   	ret    

8010583e <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010583e:	55                   	push   %ebp
8010583f:	89 e5                	mov    %esp,%ebp
80105841:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105844:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010584b:	eb 30                	jmp    8010587d <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
8010584d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105853:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105856:	83 c2 08             	add    $0x8,%edx
80105859:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
8010585d:	85 c0                	test   %eax,%eax
8010585f:	75 18                	jne    80105879 <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105861:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105867:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010586a:	8d 4a 08             	lea    0x8(%edx),%ecx
8010586d:	8b 55 08             	mov    0x8(%ebp),%edx
80105870:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
      return fd;
80105874:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105877:	eb 0f                	jmp    80105888 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105879:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010587d:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105881:	7e ca                	jle    8010584d <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105883:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105888:	c9                   	leave  
80105889:	c3                   	ret    

8010588a <sys_dup>:

int
sys_dup(void)
{
8010588a:	55                   	push   %ebp
8010588b:	89 e5                	mov    %esp,%ebp
8010588d:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105890:	83 ec 04             	sub    $0x4,%esp
80105893:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105896:	50                   	push   %eax
80105897:	6a 00                	push   $0x0
80105899:	6a 00                	push   $0x0
8010589b:	e8 29 ff ff ff       	call   801057c9 <argfd>
801058a0:	83 c4 10             	add    $0x10,%esp
801058a3:	85 c0                	test   %eax,%eax
801058a5:	79 07                	jns    801058ae <sys_dup+0x24>
    return -1;
801058a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ac:	eb 31                	jmp    801058df <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
801058ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058b1:	83 ec 0c             	sub    $0xc,%esp
801058b4:	50                   	push   %eax
801058b5:	e8 84 ff ff ff       	call   8010583e <fdalloc>
801058ba:	83 c4 10             	add    $0x10,%esp
801058bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801058c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801058c4:	79 07                	jns    801058cd <sys_dup+0x43>
    return -1;
801058c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058cb:	eb 12                	jmp    801058df <sys_dup+0x55>
  filedup(f);
801058cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058d0:	83 ec 0c             	sub    $0xc,%esp
801058d3:	50                   	push   %eax
801058d4:	e8 ac b7 ff ff       	call   80101085 <filedup>
801058d9:	83 c4 10             	add    $0x10,%esp
  return fd;
801058dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801058df:	c9                   	leave  
801058e0:	c3                   	ret    

801058e1 <sys_read>:

int
sys_read(void)
{
801058e1:	55                   	push   %ebp
801058e2:	89 e5                	mov    %esp,%ebp
801058e4:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058e7:	83 ec 04             	sub    $0x4,%esp
801058ea:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058ed:	50                   	push   %eax
801058ee:	6a 00                	push   $0x0
801058f0:	6a 00                	push   $0x0
801058f2:	e8 d2 fe ff ff       	call   801057c9 <argfd>
801058f7:	83 c4 10             	add    $0x10,%esp
801058fa:	85 c0                	test   %eax,%eax
801058fc:	78 2e                	js     8010592c <sys_read+0x4b>
801058fe:	83 ec 08             	sub    $0x8,%esp
80105901:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105904:	50                   	push   %eax
80105905:	6a 02                	push   $0x2
80105907:	e8 81 fd ff ff       	call   8010568d <argint>
8010590c:	83 c4 10             	add    $0x10,%esp
8010590f:	85 c0                	test   %eax,%eax
80105911:	78 19                	js     8010592c <sys_read+0x4b>
80105913:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105916:	83 ec 04             	sub    $0x4,%esp
80105919:	50                   	push   %eax
8010591a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010591d:	50                   	push   %eax
8010591e:	6a 01                	push   $0x1
80105920:	e8 90 fd ff ff       	call   801056b5 <argptr>
80105925:	83 c4 10             	add    $0x10,%esp
80105928:	85 c0                	test   %eax,%eax
8010592a:	79 07                	jns    80105933 <sys_read+0x52>
    return -1;
8010592c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105931:	eb 17                	jmp    8010594a <sys_read+0x69>
  return fileread(f, p, n);
80105933:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105936:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105939:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010593c:	83 ec 04             	sub    $0x4,%esp
8010593f:	51                   	push   %ecx
80105940:	52                   	push   %edx
80105941:	50                   	push   %eax
80105942:	e8 ce b8 ff ff       	call   80101215 <fileread>
80105947:	83 c4 10             	add    $0x10,%esp
}
8010594a:	c9                   	leave  
8010594b:	c3                   	ret    

8010594c <sys_write>:

int
sys_write(void)
{
8010594c:	55                   	push   %ebp
8010594d:	89 e5                	mov    %esp,%ebp
8010594f:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105952:	83 ec 04             	sub    $0x4,%esp
80105955:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105958:	50                   	push   %eax
80105959:	6a 00                	push   $0x0
8010595b:	6a 00                	push   $0x0
8010595d:	e8 67 fe ff ff       	call   801057c9 <argfd>
80105962:	83 c4 10             	add    $0x10,%esp
80105965:	85 c0                	test   %eax,%eax
80105967:	78 2e                	js     80105997 <sys_write+0x4b>
80105969:	83 ec 08             	sub    $0x8,%esp
8010596c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010596f:	50                   	push   %eax
80105970:	6a 02                	push   $0x2
80105972:	e8 16 fd ff ff       	call   8010568d <argint>
80105977:	83 c4 10             	add    $0x10,%esp
8010597a:	85 c0                	test   %eax,%eax
8010597c:	78 19                	js     80105997 <sys_write+0x4b>
8010597e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105981:	83 ec 04             	sub    $0x4,%esp
80105984:	50                   	push   %eax
80105985:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105988:	50                   	push   %eax
80105989:	6a 01                	push   $0x1
8010598b:	e8 25 fd ff ff       	call   801056b5 <argptr>
80105990:	83 c4 10             	add    $0x10,%esp
80105993:	85 c0                	test   %eax,%eax
80105995:	79 07                	jns    8010599e <sys_write+0x52>
    return -1;
80105997:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010599c:	eb 17                	jmp    801059b5 <sys_write+0x69>
  return filewrite(f, p, n);
8010599e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801059a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
801059a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059a7:	83 ec 04             	sub    $0x4,%esp
801059aa:	51                   	push   %ecx
801059ab:	52                   	push   %edx
801059ac:	50                   	push   %eax
801059ad:	e8 1b b9 ff ff       	call   801012cd <filewrite>
801059b2:	83 c4 10             	add    $0x10,%esp
}
801059b5:	c9                   	leave  
801059b6:	c3                   	ret    

801059b7 <sys_close>:

int
sys_close(void)
{
801059b7:	55                   	push   %ebp
801059b8:	89 e5                	mov    %esp,%ebp
801059ba:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801059bd:	83 ec 04             	sub    $0x4,%esp
801059c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c3:	50                   	push   %eax
801059c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059c7:	50                   	push   %eax
801059c8:	6a 00                	push   $0x0
801059ca:	e8 fa fd ff ff       	call   801057c9 <argfd>
801059cf:	83 c4 10             	add    $0x10,%esp
801059d2:	85 c0                	test   %eax,%eax
801059d4:	79 07                	jns    801059dd <sys_close+0x26>
    return -1;
801059d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059db:	eb 28                	jmp    80105a05 <sys_close+0x4e>
  proc->ofile[fd] = 0;
801059dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059e6:	83 c2 08             	add    $0x8,%edx
801059e9:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801059f0:	00 
  fileclose(f);
801059f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059f4:	83 ec 0c             	sub    $0xc,%esp
801059f7:	50                   	push   %eax
801059f8:	e8 d9 b6 ff ff       	call   801010d6 <fileclose>
801059fd:	83 c4 10             	add    $0x10,%esp
  return 0;
80105a00:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    

80105a07 <sys_fstat>:

int
sys_fstat(void)
{
80105a07:	55                   	push   %ebp
80105a08:	89 e5                	mov    %esp,%ebp
80105a0a:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a0d:	83 ec 04             	sub    $0x4,%esp
80105a10:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a13:	50                   	push   %eax
80105a14:	6a 00                	push   $0x0
80105a16:	6a 00                	push   $0x0
80105a18:	e8 ac fd ff ff       	call   801057c9 <argfd>
80105a1d:	83 c4 10             	add    $0x10,%esp
80105a20:	85 c0                	test   %eax,%eax
80105a22:	78 17                	js     80105a3b <sys_fstat+0x34>
80105a24:	83 ec 04             	sub    $0x4,%esp
80105a27:	6a 14                	push   $0x14
80105a29:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a2c:	50                   	push   %eax
80105a2d:	6a 01                	push   $0x1
80105a2f:	e8 81 fc ff ff       	call   801056b5 <argptr>
80105a34:	83 c4 10             	add    $0x10,%esp
80105a37:	85 c0                	test   %eax,%eax
80105a39:	79 07                	jns    80105a42 <sys_fstat+0x3b>
    return -1;
80105a3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a40:	eb 13                	jmp    80105a55 <sys_fstat+0x4e>
  return filestat(f, st);
80105a42:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a48:	83 ec 08             	sub    $0x8,%esp
80105a4b:	52                   	push   %edx
80105a4c:	50                   	push   %eax
80105a4d:	e8 6c b7 ff ff       	call   801011be <filestat>
80105a52:	83 c4 10             	add    $0x10,%esp
}
80105a55:	c9                   	leave  
80105a56:	c3                   	ret    

80105a57 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105a57:	55                   	push   %ebp
80105a58:	89 e5                	mov    %esp,%ebp
80105a5a:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a5d:	83 ec 08             	sub    $0x8,%esp
80105a60:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105a63:	50                   	push   %eax
80105a64:	6a 00                	push   $0x0
80105a66:	e8 a7 fc ff ff       	call   80105712 <argstr>
80105a6b:	83 c4 10             	add    $0x10,%esp
80105a6e:	85 c0                	test   %eax,%eax
80105a70:	78 15                	js     80105a87 <sys_link+0x30>
80105a72:	83 ec 08             	sub    $0x8,%esp
80105a75:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105a78:	50                   	push   %eax
80105a79:	6a 01                	push   $0x1
80105a7b:	e8 92 fc ff ff       	call   80105712 <argstr>
80105a80:	83 c4 10             	add    $0x10,%esp
80105a83:	85 c0                	test   %eax,%eax
80105a85:	79 0a                	jns    80105a91 <sys_link+0x3a>
    return -1;
80105a87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a8c:	e9 68 01 00 00       	jmp    80105bf9 <sys_link+0x1a2>

  begin_op();
80105a91:	e8 5d db ff ff       	call   801035f3 <begin_op>
  if((ip = namei(old)) == 0){
80105a96:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105a99:	83 ec 0c             	sub    $0xc,%esp
80105a9c:	50                   	push   %eax
80105a9d:	e8 b9 ca ff ff       	call   8010255b <namei>
80105aa2:	83 c4 10             	add    $0x10,%esp
80105aa5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105aa8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105aac:	75 0f                	jne    80105abd <sys_link+0x66>
    end_op();
80105aae:	e8 cc db ff ff       	call   8010367f <end_op>
    return -1;
80105ab3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ab8:	e9 3c 01 00 00       	jmp    80105bf9 <sys_link+0x1a2>
  }

  ilock(ip);
80105abd:	83 ec 0c             	sub    $0xc,%esp
80105ac0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ac3:	e8 6d bf ff ff       	call   80101a35 <ilock>
80105ac8:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80105acb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ace:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105ad2:	66 83 f8 01          	cmp    $0x1,%ax
80105ad6:	75 1d                	jne    80105af5 <sys_link+0x9e>
    iunlockput(ip);
80105ad8:	83 ec 0c             	sub    $0xc,%esp
80105adb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ade:	e8 68 c1 ff ff       	call   80101c4b <iunlockput>
80105ae3:	83 c4 10             	add    $0x10,%esp
    end_op();
80105ae6:	e8 94 db ff ff       	call   8010367f <end_op>
    return -1;
80105aeb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105af0:	e9 04 01 00 00       	jmp    80105bf9 <sys_link+0x1a2>
  }

  ip->nlink++;
80105af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105af8:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105afc:	83 c0 01             	add    $0x1,%eax
80105aff:	89 c2                	mov    %eax,%edx
80105b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b04:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b0e:	e8 45 bd ff ff       	call   80101858 <iupdate>
80105b13:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80105b16:	83 ec 0c             	sub    $0xc,%esp
80105b19:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1c:	e8 31 c0 ff ff       	call   80101b52 <iunlock>
80105b21:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105b24:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105b27:	83 ec 08             	sub    $0x8,%esp
80105b2a:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80105b2d:	52                   	push   %edx
80105b2e:	50                   	push   %eax
80105b2f:	e8 43 ca ff ff       	call   80102577 <nameiparent>
80105b34:	83 c4 10             	add    $0x10,%esp
80105b37:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105b3a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105b3e:	74 71                	je     80105bb1 <sys_link+0x15a>
    goto bad;
  ilock(dp);
80105b40:	83 ec 0c             	sub    $0xc,%esp
80105b43:	ff 75 f0             	pushl  -0x10(%ebp)
80105b46:	e8 ea be ff ff       	call   80101a35 <ilock>
80105b4b:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b51:	8b 10                	mov    (%eax),%edx
80105b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b56:	8b 00                	mov    (%eax),%eax
80105b58:	39 c2                	cmp    %eax,%edx
80105b5a:	75 1d                	jne    80105b79 <sys_link+0x122>
80105b5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b5f:	8b 40 04             	mov    0x4(%eax),%eax
80105b62:	83 ec 04             	sub    $0x4,%esp
80105b65:	50                   	push   %eax
80105b66:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105b69:	50                   	push   %eax
80105b6a:	ff 75 f0             	pushl  -0x10(%ebp)
80105b6d:	e8 4d c7 ff ff       	call   801022bf <dirlink>
80105b72:	83 c4 10             	add    $0x10,%esp
80105b75:	85 c0                	test   %eax,%eax
80105b77:	79 10                	jns    80105b89 <sys_link+0x132>
    iunlockput(dp);
80105b79:	83 ec 0c             	sub    $0xc,%esp
80105b7c:	ff 75 f0             	pushl  -0x10(%ebp)
80105b7f:	e8 c7 c0 ff ff       	call   80101c4b <iunlockput>
80105b84:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105b87:	eb 29                	jmp    80105bb2 <sys_link+0x15b>
  }
  iunlockput(dp);
80105b89:	83 ec 0c             	sub    $0xc,%esp
80105b8c:	ff 75 f0             	pushl  -0x10(%ebp)
80105b8f:	e8 b7 c0 ff ff       	call   80101c4b <iunlockput>
80105b94:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105b97:	83 ec 0c             	sub    $0xc,%esp
80105b9a:	ff 75 f4             	pushl  -0xc(%ebp)
80105b9d:	e8 fe bf ff ff       	call   80101ba0 <iput>
80105ba2:	83 c4 10             	add    $0x10,%esp

  end_op();
80105ba5:	e8 d5 da ff ff       	call   8010367f <end_op>

  return 0;
80105baa:	b8 00 00 00 00       	mov    $0x0,%eax
80105baf:	eb 48                	jmp    80105bf9 <sys_link+0x1a2>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105bb1:	90                   	nop
  end_op();

  return 0;

bad:
  ilock(ip);
80105bb2:	83 ec 0c             	sub    $0xc,%esp
80105bb5:	ff 75 f4             	pushl  -0xc(%ebp)
80105bb8:	e8 78 be ff ff       	call   80101a35 <ilock>
80105bbd:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80105bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc3:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105bc7:	83 e8 01             	sub    $0x1,%eax
80105bca:	89 c2                	mov    %eax,%edx
80105bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bcf:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80105bd3:	83 ec 0c             	sub    $0xc,%esp
80105bd6:	ff 75 f4             	pushl  -0xc(%ebp)
80105bd9:	e8 7a bc ff ff       	call   80101858 <iupdate>
80105bde:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105be1:	83 ec 0c             	sub    $0xc,%esp
80105be4:	ff 75 f4             	pushl  -0xc(%ebp)
80105be7:	e8 5f c0 ff ff       	call   80101c4b <iunlockput>
80105bec:	83 c4 10             	add    $0x10,%esp
  end_op();
80105bef:	e8 8b da ff ff       	call   8010367f <end_op>
  return -1;
80105bf4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bf9:	c9                   	leave  
80105bfa:	c3                   	ret    

80105bfb <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105bfb:	55                   	push   %ebp
80105bfc:	89 e5                	mov    %esp,%ebp
80105bfe:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c01:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105c08:	eb 40                	jmp    80105c4a <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c0d:	6a 10                	push   $0x10
80105c0f:	50                   	push   %eax
80105c10:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c13:	50                   	push   %eax
80105c14:	ff 75 08             	pushl  0x8(%ebp)
80105c17:	e8 ef c2 ff ff       	call   80101f0b <readi>
80105c1c:	83 c4 10             	add    $0x10,%esp
80105c1f:	83 f8 10             	cmp    $0x10,%eax
80105c22:	74 0d                	je     80105c31 <isdirempty+0x36>
      panic("isdirempty: readi");
80105c24:	83 ec 0c             	sub    $0xc,%esp
80105c27:	68 6e 8d 10 80       	push   $0x80108d6e
80105c2c:	e8 6f a9 ff ff       	call   801005a0 <panic>
    if(de.inum != 0)
80105c31:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105c35:	66 85 c0             	test   %ax,%ax
80105c38:	74 07                	je     80105c41 <isdirempty+0x46>
      return 0;
80105c3a:	b8 00 00 00 00       	mov    $0x0,%eax
80105c3f:	eb 1b                	jmp    80105c5c <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c44:	83 c0 10             	add    $0x10,%eax
80105c47:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c4a:	8b 45 08             	mov    0x8(%ebp),%eax
80105c4d:	8b 50 58             	mov    0x58(%eax),%edx
80105c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c53:	39 c2                	cmp    %eax,%edx
80105c55:	77 b3                	ja     80105c0a <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105c57:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105c5c:	c9                   	leave  
80105c5d:	c3                   	ret    

80105c5e <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105c5e:	55                   	push   %ebp
80105c5f:	89 e5                	mov    %esp,%ebp
80105c61:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105c64:	83 ec 08             	sub    $0x8,%esp
80105c67:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105c6a:	50                   	push   %eax
80105c6b:	6a 00                	push   $0x0
80105c6d:	e8 a0 fa ff ff       	call   80105712 <argstr>
80105c72:	83 c4 10             	add    $0x10,%esp
80105c75:	85 c0                	test   %eax,%eax
80105c77:	79 0a                	jns    80105c83 <sys_unlink+0x25>
    return -1;
80105c79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c7e:	e9 bc 01 00 00       	jmp    80105e3f <sys_unlink+0x1e1>

  begin_op();
80105c83:	e8 6b d9 ff ff       	call   801035f3 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105c88:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105c8b:	83 ec 08             	sub    $0x8,%esp
80105c8e:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105c91:	52                   	push   %edx
80105c92:	50                   	push   %eax
80105c93:	e8 df c8 ff ff       	call   80102577 <nameiparent>
80105c98:	83 c4 10             	add    $0x10,%esp
80105c9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105c9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105ca2:	75 0f                	jne    80105cb3 <sys_unlink+0x55>
    end_op();
80105ca4:	e8 d6 d9 ff ff       	call   8010367f <end_op>
    return -1;
80105ca9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cae:	e9 8c 01 00 00       	jmp    80105e3f <sys_unlink+0x1e1>
  }

  ilock(dp);
80105cb3:	83 ec 0c             	sub    $0xc,%esp
80105cb6:	ff 75 f4             	pushl  -0xc(%ebp)
80105cb9:	e8 77 bd ff ff       	call   80101a35 <ilock>
80105cbe:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105cc1:	83 ec 08             	sub    $0x8,%esp
80105cc4:	68 80 8d 10 80       	push   $0x80108d80
80105cc9:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105ccc:	50                   	push   %eax
80105ccd:	e8 18 c5 ff ff       	call   801021ea <namecmp>
80105cd2:	83 c4 10             	add    $0x10,%esp
80105cd5:	85 c0                	test   %eax,%eax
80105cd7:	0f 84 4a 01 00 00    	je     80105e27 <sys_unlink+0x1c9>
80105cdd:	83 ec 08             	sub    $0x8,%esp
80105ce0:	68 82 8d 10 80       	push   $0x80108d82
80105ce5:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105ce8:	50                   	push   %eax
80105ce9:	e8 fc c4 ff ff       	call   801021ea <namecmp>
80105cee:	83 c4 10             	add    $0x10,%esp
80105cf1:	85 c0                	test   %eax,%eax
80105cf3:	0f 84 2e 01 00 00    	je     80105e27 <sys_unlink+0x1c9>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105cf9:	83 ec 04             	sub    $0x4,%esp
80105cfc:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105cff:	50                   	push   %eax
80105d00:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105d03:	50                   	push   %eax
80105d04:	ff 75 f4             	pushl  -0xc(%ebp)
80105d07:	e8 f9 c4 ff ff       	call   80102205 <dirlookup>
80105d0c:	83 c4 10             	add    $0x10,%esp
80105d0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d12:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d16:	0f 84 0a 01 00 00    	je     80105e26 <sys_unlink+0x1c8>
    goto bad;
  ilock(ip);
80105d1c:	83 ec 0c             	sub    $0xc,%esp
80105d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80105d22:	e8 0e bd ff ff       	call   80101a35 <ilock>
80105d27:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105d2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d2d:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105d31:	66 85 c0             	test   %ax,%ax
80105d34:	7f 0d                	jg     80105d43 <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
80105d36:	83 ec 0c             	sub    $0xc,%esp
80105d39:	68 85 8d 10 80       	push   $0x80108d85
80105d3e:	e8 5d a8 ff ff       	call   801005a0 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105d43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d46:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105d4a:	66 83 f8 01          	cmp    $0x1,%ax
80105d4e:	75 25                	jne    80105d75 <sys_unlink+0x117>
80105d50:	83 ec 0c             	sub    $0xc,%esp
80105d53:	ff 75 f0             	pushl  -0x10(%ebp)
80105d56:	e8 a0 fe ff ff       	call   80105bfb <isdirempty>
80105d5b:	83 c4 10             	add    $0x10,%esp
80105d5e:	85 c0                	test   %eax,%eax
80105d60:	75 13                	jne    80105d75 <sys_unlink+0x117>
    iunlockput(ip);
80105d62:	83 ec 0c             	sub    $0xc,%esp
80105d65:	ff 75 f0             	pushl  -0x10(%ebp)
80105d68:	e8 de be ff ff       	call   80101c4b <iunlockput>
80105d6d:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105d70:	e9 b2 00 00 00       	jmp    80105e27 <sys_unlink+0x1c9>
  }

  memset(&de, 0, sizeof(de));
80105d75:	83 ec 04             	sub    $0x4,%esp
80105d78:	6a 10                	push   $0x10
80105d7a:	6a 00                	push   $0x0
80105d7c:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d7f:	50                   	push   %eax
80105d80:	e8 e3 f5 ff ff       	call   80105368 <memset>
80105d85:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d88:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105d8b:	6a 10                	push   $0x10
80105d8d:	50                   	push   %eax
80105d8e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d91:	50                   	push   %eax
80105d92:	ff 75 f4             	pushl  -0xc(%ebp)
80105d95:	e8 c8 c2 ff ff       	call   80102062 <writei>
80105d9a:	83 c4 10             	add    $0x10,%esp
80105d9d:	83 f8 10             	cmp    $0x10,%eax
80105da0:	74 0d                	je     80105daf <sys_unlink+0x151>
    panic("unlink: writei");
80105da2:	83 ec 0c             	sub    $0xc,%esp
80105da5:	68 97 8d 10 80       	push   $0x80108d97
80105daa:	e8 f1 a7 ff ff       	call   801005a0 <panic>
  if(ip->type == T_DIR){
80105daf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105db2:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105db6:	66 83 f8 01          	cmp    $0x1,%ax
80105dba:	75 21                	jne    80105ddd <sys_unlink+0x17f>
    dp->nlink--;
80105dbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dbf:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105dc3:	83 e8 01             	sub    $0x1,%eax
80105dc6:	89 c2                	mov    %eax,%edx
80105dc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dcb:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
80105dcf:	83 ec 0c             	sub    $0xc,%esp
80105dd2:	ff 75 f4             	pushl  -0xc(%ebp)
80105dd5:	e8 7e ba ff ff       	call   80101858 <iupdate>
80105dda:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80105ddd:	83 ec 0c             	sub    $0xc,%esp
80105de0:	ff 75 f4             	pushl  -0xc(%ebp)
80105de3:	e8 63 be ff ff       	call   80101c4b <iunlockput>
80105de8:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80105deb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dee:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105df2:	83 e8 01             	sub    $0x1,%eax
80105df5:	89 c2                	mov    %eax,%edx
80105df7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dfa:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80105dfe:	83 ec 0c             	sub    $0xc,%esp
80105e01:	ff 75 f0             	pushl  -0x10(%ebp)
80105e04:	e8 4f ba ff ff       	call   80101858 <iupdate>
80105e09:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80105e0c:	83 ec 0c             	sub    $0xc,%esp
80105e0f:	ff 75 f0             	pushl  -0x10(%ebp)
80105e12:	e8 34 be ff ff       	call   80101c4b <iunlockput>
80105e17:	83 c4 10             	add    $0x10,%esp

  end_op();
80105e1a:	e8 60 d8 ff ff       	call   8010367f <end_op>

  return 0;
80105e1f:	b8 00 00 00 00       	mov    $0x0,%eax
80105e24:	eb 19                	jmp    80105e3f <sys_unlink+0x1e1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105e26:	90                   	nop
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105e27:	83 ec 0c             	sub    $0xc,%esp
80105e2a:	ff 75 f4             	pushl  -0xc(%ebp)
80105e2d:	e8 19 be ff ff       	call   80101c4b <iunlockput>
80105e32:	83 c4 10             	add    $0x10,%esp
  end_op();
80105e35:	e8 45 d8 ff ff       	call   8010367f <end_op>
  return -1;
80105e3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e3f:	c9                   	leave  
80105e40:	c3                   	ret    

80105e41 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105e41:	55                   	push   %ebp
80105e42:	89 e5                	mov    %esp,%ebp
80105e44:	83 ec 38             	sub    $0x38,%esp
80105e47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105e4a:	8b 55 10             	mov    0x10(%ebp),%edx
80105e4d:	8b 45 14             	mov    0x14(%ebp),%eax
80105e50:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105e54:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105e58:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105e5c:	83 ec 08             	sub    $0x8,%esp
80105e5f:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e62:	50                   	push   %eax
80105e63:	ff 75 08             	pushl  0x8(%ebp)
80105e66:	e8 0c c7 ff ff       	call   80102577 <nameiparent>
80105e6b:	83 c4 10             	add    $0x10,%esp
80105e6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e71:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e75:	75 0a                	jne    80105e81 <create+0x40>
    return 0;
80105e77:	b8 00 00 00 00       	mov    $0x0,%eax
80105e7c:	e9 90 01 00 00       	jmp    80106011 <create+0x1d0>
  ilock(dp);
80105e81:	83 ec 0c             	sub    $0xc,%esp
80105e84:	ff 75 f4             	pushl  -0xc(%ebp)
80105e87:	e8 a9 bb ff ff       	call   80101a35 <ilock>
80105e8c:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105e8f:	83 ec 04             	sub    $0x4,%esp
80105e92:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e95:	50                   	push   %eax
80105e96:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e99:	50                   	push   %eax
80105e9a:	ff 75 f4             	pushl  -0xc(%ebp)
80105e9d:	e8 63 c3 ff ff       	call   80102205 <dirlookup>
80105ea2:	83 c4 10             	add    $0x10,%esp
80105ea5:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ea8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105eac:	74 50                	je     80105efe <create+0xbd>
    iunlockput(dp);
80105eae:	83 ec 0c             	sub    $0xc,%esp
80105eb1:	ff 75 f4             	pushl  -0xc(%ebp)
80105eb4:	e8 92 bd ff ff       	call   80101c4b <iunlockput>
80105eb9:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105ebc:	83 ec 0c             	sub    $0xc,%esp
80105ebf:	ff 75 f0             	pushl  -0x10(%ebp)
80105ec2:	e8 6e bb ff ff       	call   80101a35 <ilock>
80105ec7:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80105eca:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105ecf:	75 15                	jne    80105ee6 <create+0xa5>
80105ed1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ed4:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80105ed8:	66 83 f8 02          	cmp    $0x2,%ax
80105edc:	75 08                	jne    80105ee6 <create+0xa5>
      return ip;
80105ede:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ee1:	e9 2b 01 00 00       	jmp    80106011 <create+0x1d0>
    iunlockput(ip);
80105ee6:	83 ec 0c             	sub    $0xc,%esp
80105ee9:	ff 75 f0             	pushl  -0x10(%ebp)
80105eec:	e8 5a bd ff ff       	call   80101c4b <iunlockput>
80105ef1:	83 c4 10             	add    $0x10,%esp
    return 0;
80105ef4:	b8 00 00 00 00       	mov    $0x0,%eax
80105ef9:	e9 13 01 00 00       	jmp    80106011 <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105efe:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105f02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f05:	8b 00                	mov    (%eax),%eax
80105f07:	83 ec 08             	sub    $0x8,%esp
80105f0a:	52                   	push   %edx
80105f0b:	50                   	push   %eax
80105f0c:	e8 70 b8 ff ff       	call   80101781 <ialloc>
80105f11:	83 c4 10             	add    $0x10,%esp
80105f14:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f17:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f1b:	75 0d                	jne    80105f2a <create+0xe9>
    panic("create: ialloc");
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	68 a6 8d 10 80       	push   $0x80108da6
80105f25:	e8 76 a6 ff ff       	call   801005a0 <panic>

  ilock(ip);
80105f2a:	83 ec 0c             	sub    $0xc,%esp
80105f2d:	ff 75 f0             	pushl  -0x10(%ebp)
80105f30:	e8 00 bb ff ff       	call   80101a35 <ilock>
80105f35:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105f38:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f3b:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105f3f:	66 89 50 52          	mov    %dx,0x52(%eax)
  ip->minor = minor;
80105f43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f46:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105f4a:	66 89 50 54          	mov    %dx,0x54(%eax)
  ip->nlink = 1;
80105f4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f51:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
  iupdate(ip);
80105f57:	83 ec 0c             	sub    $0xc,%esp
80105f5a:	ff 75 f0             	pushl  -0x10(%ebp)
80105f5d:	e8 f6 b8 ff ff       	call   80101858 <iupdate>
80105f62:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105f65:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105f6a:	75 6a                	jne    80105fd6 <create+0x195>
    dp->nlink++;  // for ".."
80105f6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f6f:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80105f73:	83 c0 01             	add    $0x1,%eax
80105f76:	89 c2                	mov    %eax,%edx
80105f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f7b:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
80105f7f:	83 ec 0c             	sub    $0xc,%esp
80105f82:	ff 75 f4             	pushl  -0xc(%ebp)
80105f85:	e8 ce b8 ff ff       	call   80101858 <iupdate>
80105f8a:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105f8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f90:	8b 40 04             	mov    0x4(%eax),%eax
80105f93:	83 ec 04             	sub    $0x4,%esp
80105f96:	50                   	push   %eax
80105f97:	68 80 8d 10 80       	push   $0x80108d80
80105f9c:	ff 75 f0             	pushl  -0x10(%ebp)
80105f9f:	e8 1b c3 ff ff       	call   801022bf <dirlink>
80105fa4:	83 c4 10             	add    $0x10,%esp
80105fa7:	85 c0                	test   %eax,%eax
80105fa9:	78 1e                	js     80105fc9 <create+0x188>
80105fab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fae:	8b 40 04             	mov    0x4(%eax),%eax
80105fb1:	83 ec 04             	sub    $0x4,%esp
80105fb4:	50                   	push   %eax
80105fb5:	68 82 8d 10 80       	push   $0x80108d82
80105fba:	ff 75 f0             	pushl  -0x10(%ebp)
80105fbd:	e8 fd c2 ff ff       	call   801022bf <dirlink>
80105fc2:	83 c4 10             	add    $0x10,%esp
80105fc5:	85 c0                	test   %eax,%eax
80105fc7:	79 0d                	jns    80105fd6 <create+0x195>
      panic("create dots");
80105fc9:	83 ec 0c             	sub    $0xc,%esp
80105fcc:	68 b5 8d 10 80       	push   $0x80108db5
80105fd1:	e8 ca a5 ff ff       	call   801005a0 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fd9:	8b 40 04             	mov    0x4(%eax),%eax
80105fdc:	83 ec 04             	sub    $0x4,%esp
80105fdf:	50                   	push   %eax
80105fe0:	8d 45 de             	lea    -0x22(%ebp),%eax
80105fe3:	50                   	push   %eax
80105fe4:	ff 75 f4             	pushl  -0xc(%ebp)
80105fe7:	e8 d3 c2 ff ff       	call   801022bf <dirlink>
80105fec:	83 c4 10             	add    $0x10,%esp
80105fef:	85 c0                	test   %eax,%eax
80105ff1:	79 0d                	jns    80106000 <create+0x1bf>
    panic("create: dirlink");
80105ff3:	83 ec 0c             	sub    $0xc,%esp
80105ff6:	68 c1 8d 10 80       	push   $0x80108dc1
80105ffb:	e8 a0 a5 ff ff       	call   801005a0 <panic>

  iunlockput(dp);
80106000:	83 ec 0c             	sub    $0xc,%esp
80106003:	ff 75 f4             	pushl  -0xc(%ebp)
80106006:	e8 40 bc ff ff       	call   80101c4b <iunlockput>
8010600b:	83 c4 10             	add    $0x10,%esp

  return ip;
8010600e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106011:	c9                   	leave  
80106012:	c3                   	ret    

80106013 <sys_open>:

int
sys_open(void)
{
80106013:	55                   	push   %ebp
80106014:	89 e5                	mov    %esp,%ebp
80106016:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106019:	83 ec 08             	sub    $0x8,%esp
8010601c:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010601f:	50                   	push   %eax
80106020:	6a 00                	push   $0x0
80106022:	e8 eb f6 ff ff       	call   80105712 <argstr>
80106027:	83 c4 10             	add    $0x10,%esp
8010602a:	85 c0                	test   %eax,%eax
8010602c:	78 15                	js     80106043 <sys_open+0x30>
8010602e:	83 ec 08             	sub    $0x8,%esp
80106031:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106034:	50                   	push   %eax
80106035:	6a 01                	push   $0x1
80106037:	e8 51 f6 ff ff       	call   8010568d <argint>
8010603c:	83 c4 10             	add    $0x10,%esp
8010603f:	85 c0                	test   %eax,%eax
80106041:	79 0a                	jns    8010604d <sys_open+0x3a>
    return -1;
80106043:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106048:	e9 61 01 00 00       	jmp    801061ae <sys_open+0x19b>

  begin_op();
8010604d:	e8 a1 d5 ff ff       	call   801035f3 <begin_op>

  if(omode & O_CREATE){
80106052:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106055:	25 00 02 00 00       	and    $0x200,%eax
8010605a:	85 c0                	test   %eax,%eax
8010605c:	74 2a                	je     80106088 <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
8010605e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106061:	6a 00                	push   $0x0
80106063:	6a 00                	push   $0x0
80106065:	6a 02                	push   $0x2
80106067:	50                   	push   %eax
80106068:	e8 d4 fd ff ff       	call   80105e41 <create>
8010606d:	83 c4 10             	add    $0x10,%esp
80106070:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80106073:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106077:	75 75                	jne    801060ee <sys_open+0xdb>
      end_op();
80106079:	e8 01 d6 ff ff       	call   8010367f <end_op>
      return -1;
8010607e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106083:	e9 26 01 00 00       	jmp    801061ae <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
80106088:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010608b:	83 ec 0c             	sub    $0xc,%esp
8010608e:	50                   	push   %eax
8010608f:	e8 c7 c4 ff ff       	call   8010255b <namei>
80106094:	83 c4 10             	add    $0x10,%esp
80106097:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010609a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010609e:	75 0f                	jne    801060af <sys_open+0x9c>
      end_op();
801060a0:	e8 da d5 ff ff       	call   8010367f <end_op>
      return -1;
801060a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060aa:	e9 ff 00 00 00       	jmp    801061ae <sys_open+0x19b>
    }
    ilock(ip);
801060af:	83 ec 0c             	sub    $0xc,%esp
801060b2:	ff 75 f4             	pushl  -0xc(%ebp)
801060b5:	e8 7b b9 ff ff       	call   80101a35 <ilock>
801060ba:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
801060bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801060c0:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801060c4:	66 83 f8 01          	cmp    $0x1,%ax
801060c8:	75 24                	jne    801060ee <sys_open+0xdb>
801060ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060cd:	85 c0                	test   %eax,%eax
801060cf:	74 1d                	je     801060ee <sys_open+0xdb>
      iunlockput(ip);
801060d1:	83 ec 0c             	sub    $0xc,%esp
801060d4:	ff 75 f4             	pushl  -0xc(%ebp)
801060d7:	e8 6f bb ff ff       	call   80101c4b <iunlockput>
801060dc:	83 c4 10             	add    $0x10,%esp
      end_op();
801060df:	e8 9b d5 ff ff       	call   8010367f <end_op>
      return -1;
801060e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060e9:	e9 c0 00 00 00       	jmp    801061ae <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801060ee:	e8 25 af ff ff       	call   80101018 <filealloc>
801060f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
801060f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801060fa:	74 17                	je     80106113 <sys_open+0x100>
801060fc:	83 ec 0c             	sub    $0xc,%esp
801060ff:	ff 75 f0             	pushl  -0x10(%ebp)
80106102:	e8 37 f7 ff ff       	call   8010583e <fdalloc>
80106107:	83 c4 10             	add    $0x10,%esp
8010610a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010610d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106111:	79 2e                	jns    80106141 <sys_open+0x12e>
    if(f)
80106113:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106117:	74 0e                	je     80106127 <sys_open+0x114>
      fileclose(f);
80106119:	83 ec 0c             	sub    $0xc,%esp
8010611c:	ff 75 f0             	pushl  -0x10(%ebp)
8010611f:	e8 b2 af ff ff       	call   801010d6 <fileclose>
80106124:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80106127:	83 ec 0c             	sub    $0xc,%esp
8010612a:	ff 75 f4             	pushl  -0xc(%ebp)
8010612d:	e8 19 bb ff ff       	call   80101c4b <iunlockput>
80106132:	83 c4 10             	add    $0x10,%esp
    end_op();
80106135:	e8 45 d5 ff ff       	call   8010367f <end_op>
    return -1;
8010613a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010613f:	eb 6d                	jmp    801061ae <sys_open+0x19b>
  }
  iunlock(ip);
80106141:	83 ec 0c             	sub    $0xc,%esp
80106144:	ff 75 f4             	pushl  -0xc(%ebp)
80106147:	e8 06 ba ff ff       	call   80101b52 <iunlock>
8010614c:	83 c4 10             	add    $0x10,%esp
  end_op();
8010614f:	e8 2b d5 ff ff       	call   8010367f <end_op>

  f->type = FD_INODE;
80106154:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106157:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
8010615d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106160:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106163:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80106166:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106169:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80106170:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106173:	83 e0 01             	and    $0x1,%eax
80106176:	85 c0                	test   %eax,%eax
80106178:	0f 94 c0             	sete   %al
8010617b:	89 c2                	mov    %eax,%edx
8010617d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106180:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106183:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106186:	83 e0 01             	and    $0x1,%eax
80106189:	85 c0                	test   %eax,%eax
8010618b:	75 0a                	jne    80106197 <sys_open+0x184>
8010618d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106190:	83 e0 02             	and    $0x2,%eax
80106193:	85 c0                	test   %eax,%eax
80106195:	74 07                	je     8010619e <sys_open+0x18b>
80106197:	b8 01 00 00 00       	mov    $0x1,%eax
8010619c:	eb 05                	jmp    801061a3 <sys_open+0x190>
8010619e:	b8 00 00 00 00       	mov    $0x0,%eax
801061a3:	89 c2                	mov    %eax,%edx
801061a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061a8:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
801061ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
801061ae:	c9                   	leave  
801061af:	c3                   	ret    

801061b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801061b6:	e8 38 d4 ff ff       	call   801035f3 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801061bb:	83 ec 08             	sub    $0x8,%esp
801061be:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061c1:	50                   	push   %eax
801061c2:	6a 00                	push   $0x0
801061c4:	e8 49 f5 ff ff       	call   80105712 <argstr>
801061c9:	83 c4 10             	add    $0x10,%esp
801061cc:	85 c0                	test   %eax,%eax
801061ce:	78 1b                	js     801061eb <sys_mkdir+0x3b>
801061d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061d3:	6a 00                	push   $0x0
801061d5:	6a 00                	push   $0x0
801061d7:	6a 01                	push   $0x1
801061d9:	50                   	push   %eax
801061da:	e8 62 fc ff ff       	call   80105e41 <create>
801061df:	83 c4 10             	add    $0x10,%esp
801061e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801061e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801061e9:	75 0c                	jne    801061f7 <sys_mkdir+0x47>
    end_op();
801061eb:	e8 8f d4 ff ff       	call   8010367f <end_op>
    return -1;
801061f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061f5:	eb 18                	jmp    8010620f <sys_mkdir+0x5f>
  }
  iunlockput(ip);
801061f7:	83 ec 0c             	sub    $0xc,%esp
801061fa:	ff 75 f4             	pushl  -0xc(%ebp)
801061fd:	e8 49 ba ff ff       	call   80101c4b <iunlockput>
80106202:	83 c4 10             	add    $0x10,%esp
  end_op();
80106205:	e8 75 d4 ff ff       	call   8010367f <end_op>
  return 0;
8010620a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010620f:	c9                   	leave  
80106210:	c3                   	ret    

80106211 <sys_mknod>:

int
sys_mknod(void)
{
80106211:	55                   	push   %ebp
80106212:	89 e5                	mov    %esp,%ebp
80106214:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106217:	e8 d7 d3 ff ff       	call   801035f3 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010621c:	83 ec 08             	sub    $0x8,%esp
8010621f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106222:	50                   	push   %eax
80106223:	6a 00                	push   $0x0
80106225:	e8 e8 f4 ff ff       	call   80105712 <argstr>
8010622a:	83 c4 10             	add    $0x10,%esp
8010622d:	85 c0                	test   %eax,%eax
8010622f:	78 4f                	js     80106280 <sys_mknod+0x6f>
     argint(1, &major) < 0 ||
80106231:	83 ec 08             	sub    $0x8,%esp
80106234:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106237:	50                   	push   %eax
80106238:	6a 01                	push   $0x1
8010623a:	e8 4e f4 ff ff       	call   8010568d <argint>
8010623f:	83 c4 10             	add    $0x10,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80106242:	85 c0                	test   %eax,%eax
80106244:	78 3a                	js     80106280 <sys_mknod+0x6f>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106246:	83 ec 08             	sub    $0x8,%esp
80106249:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010624c:	50                   	push   %eax
8010624d:	6a 02                	push   $0x2
8010624f:	e8 39 f4 ff ff       	call   8010568d <argint>
80106254:	83 c4 10             	add    $0x10,%esp
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106257:	85 c0                	test   %eax,%eax
80106259:	78 25                	js     80106280 <sys_mknod+0x6f>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
8010625b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010625e:	0f bf c8             	movswl %ax,%ecx
80106261:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106264:	0f bf d0             	movswl %ax,%edx
80106267:	8b 45 f0             	mov    -0x10(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
8010626a:	51                   	push   %ecx
8010626b:	52                   	push   %edx
8010626c:	6a 03                	push   $0x3
8010626e:	50                   	push   %eax
8010626f:	e8 cd fb ff ff       	call   80105e41 <create>
80106274:	83 c4 10             	add    $0x10,%esp
80106277:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010627a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010627e:	75 0c                	jne    8010628c <sys_mknod+0x7b>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80106280:	e8 fa d3 ff ff       	call   8010367f <end_op>
    return -1;
80106285:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010628a:	eb 18                	jmp    801062a4 <sys_mknod+0x93>
  }
  iunlockput(ip);
8010628c:	83 ec 0c             	sub    $0xc,%esp
8010628f:	ff 75 f4             	pushl  -0xc(%ebp)
80106292:	e8 b4 b9 ff ff       	call   80101c4b <iunlockput>
80106297:	83 c4 10             	add    $0x10,%esp
  end_op();
8010629a:	e8 e0 d3 ff ff       	call   8010367f <end_op>
  return 0;
8010629f:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062a4:	c9                   	leave  
801062a5:	c3                   	ret    

801062a6 <sys_chdir>:

int
sys_chdir(void)
{
801062a6:	55                   	push   %ebp
801062a7:	89 e5                	mov    %esp,%ebp
801062a9:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801062ac:	e8 42 d3 ff ff       	call   801035f3 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801062b1:	83 ec 08             	sub    $0x8,%esp
801062b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801062b7:	50                   	push   %eax
801062b8:	6a 00                	push   $0x0
801062ba:	e8 53 f4 ff ff       	call   80105712 <argstr>
801062bf:	83 c4 10             	add    $0x10,%esp
801062c2:	85 c0                	test   %eax,%eax
801062c4:	78 18                	js     801062de <sys_chdir+0x38>
801062c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062c9:	83 ec 0c             	sub    $0xc,%esp
801062cc:	50                   	push   %eax
801062cd:	e8 89 c2 ff ff       	call   8010255b <namei>
801062d2:	83 c4 10             	add    $0x10,%esp
801062d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801062d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801062dc:	75 0c                	jne    801062ea <sys_chdir+0x44>
    end_op();
801062de:	e8 9c d3 ff ff       	call   8010367f <end_op>
    return -1;
801062e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062e8:	eb 6e                	jmp    80106358 <sys_chdir+0xb2>
  }
  ilock(ip);
801062ea:	83 ec 0c             	sub    $0xc,%esp
801062ed:	ff 75 f4             	pushl  -0xc(%ebp)
801062f0:	e8 40 b7 ff ff       	call   80101a35 <ilock>
801062f5:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
801062f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062fb:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801062ff:	66 83 f8 01          	cmp    $0x1,%ax
80106303:	74 1a                	je     8010631f <sys_chdir+0x79>
    iunlockput(ip);
80106305:	83 ec 0c             	sub    $0xc,%esp
80106308:	ff 75 f4             	pushl  -0xc(%ebp)
8010630b:	e8 3b b9 ff ff       	call   80101c4b <iunlockput>
80106310:	83 c4 10             	add    $0x10,%esp
    end_op();
80106313:	e8 67 d3 ff ff       	call   8010367f <end_op>
    return -1;
80106318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631d:	eb 39                	jmp    80106358 <sys_chdir+0xb2>
  }
  iunlock(ip);
8010631f:	83 ec 0c             	sub    $0xc,%esp
80106322:	ff 75 f4             	pushl  -0xc(%ebp)
80106325:	e8 28 b8 ff ff       	call   80101b52 <iunlock>
8010632a:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
8010632d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106333:	8b 40 6c             	mov    0x6c(%eax),%eax
80106336:	83 ec 0c             	sub    $0xc,%esp
80106339:	50                   	push   %eax
8010633a:	e8 61 b8 ff ff       	call   80101ba0 <iput>
8010633f:	83 c4 10             	add    $0x10,%esp
  end_op();
80106342:	e8 38 d3 ff ff       	call   8010367f <end_op>
  proc->cwd = ip;
80106347:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010634d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106350:	89 50 6c             	mov    %edx,0x6c(%eax)
  return 0;
80106353:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106358:	c9                   	leave  
80106359:	c3                   	ret    

8010635a <sys_exec>:

int
sys_exec(void)
{
8010635a:	55                   	push   %ebp
8010635b:	89 e5                	mov    %esp,%ebp
8010635d:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106363:	83 ec 08             	sub    $0x8,%esp
80106366:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106369:	50                   	push   %eax
8010636a:	6a 00                	push   $0x0
8010636c:	e8 a1 f3 ff ff       	call   80105712 <argstr>
80106371:	83 c4 10             	add    $0x10,%esp
80106374:	85 c0                	test   %eax,%eax
80106376:	78 18                	js     80106390 <sys_exec+0x36>
80106378:	83 ec 08             	sub    $0x8,%esp
8010637b:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106381:	50                   	push   %eax
80106382:	6a 01                	push   $0x1
80106384:	e8 04 f3 ff ff       	call   8010568d <argint>
80106389:	83 c4 10             	add    $0x10,%esp
8010638c:	85 c0                	test   %eax,%eax
8010638e:	79 0a                	jns    8010639a <sys_exec+0x40>
    return -1;
80106390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106395:	e9 c6 00 00 00       	jmp    80106460 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
8010639a:	83 ec 04             	sub    $0x4,%esp
8010639d:	68 80 00 00 00       	push   $0x80
801063a2:	6a 00                	push   $0x0
801063a4:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801063aa:	50                   	push   %eax
801063ab:	e8 b8 ef ff ff       	call   80105368 <memset>
801063b0:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
801063b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
801063ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063bd:	83 f8 1f             	cmp    $0x1f,%eax
801063c0:	76 0a                	jbe    801063cc <sys_exec+0x72>
      return -1;
801063c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063c7:	e9 94 00 00 00       	jmp    80106460 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801063cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063cf:	c1 e0 02             	shl    $0x2,%eax
801063d2:	89 c2                	mov    %eax,%edx
801063d4:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801063da:	01 c2                	add    %eax,%edx
801063dc:	83 ec 08             	sub    $0x8,%esp
801063df:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801063e5:	50                   	push   %eax
801063e6:	52                   	push   %edx
801063e7:	e8 05 f2 ff ff       	call   801055f1 <fetchint>
801063ec:	83 c4 10             	add    $0x10,%esp
801063ef:	85 c0                	test   %eax,%eax
801063f1:	79 07                	jns    801063fa <sys_exec+0xa0>
      return -1;
801063f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063f8:	eb 66                	jmp    80106460 <sys_exec+0x106>
    if(uarg == 0){
801063fa:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106400:	85 c0                	test   %eax,%eax
80106402:	75 27                	jne    8010642b <sys_exec+0xd1>
      argv[i] = 0;
80106404:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106407:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010640e:	00 00 00 00 
      break;
80106412:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106413:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106416:	83 ec 08             	sub    $0x8,%esp
80106419:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010641f:	52                   	push   %edx
80106420:	50                   	push   %eax
80106421:	e8 85 a7 ff ff       	call   80100bab <exec>
80106426:	83 c4 10             	add    $0x10,%esp
80106429:	eb 35                	jmp    80106460 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010642b:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106431:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106434:	c1 e2 02             	shl    $0x2,%edx
80106437:	01 c2                	add    %eax,%edx
80106439:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
8010643f:	83 ec 08             	sub    $0x8,%esp
80106442:	52                   	push   %edx
80106443:	50                   	push   %eax
80106444:	e8 e2 f1 ff ff       	call   8010562b <fetchstr>
80106449:	83 c4 10             	add    $0x10,%esp
8010644c:	85 c0                	test   %eax,%eax
8010644e:	79 07                	jns    80106457 <sys_exec+0xfd>
      return -1;
80106450:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106455:	eb 09                	jmp    80106460 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106457:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
8010645b:	e9 5a ff ff ff       	jmp    801063ba <sys_exec+0x60>
  return exec(path, argv);
}
80106460:	c9                   	leave  
80106461:	c3                   	ret    

80106462 <sys_pipe>:

int
sys_pipe(void)
{
80106462:	55                   	push   %ebp
80106463:	89 e5                	mov    %esp,%ebp
80106465:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106468:	83 ec 04             	sub    $0x4,%esp
8010646b:	6a 08                	push   $0x8
8010646d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106470:	50                   	push   %eax
80106471:	6a 00                	push   $0x0
80106473:	e8 3d f2 ff ff       	call   801056b5 <argptr>
80106478:	83 c4 10             	add    $0x10,%esp
8010647b:	85 c0                	test   %eax,%eax
8010647d:	79 0a                	jns    80106489 <sys_pipe+0x27>
    return -1;
8010647f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106484:	e9 af 00 00 00       	jmp    80106538 <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80106489:	83 ec 08             	sub    $0x8,%esp
8010648c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010648f:	50                   	push   %eax
80106490:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106493:	50                   	push   %eax
80106494:	e8 54 db ff ff       	call   80103fed <pipealloc>
80106499:	83 c4 10             	add    $0x10,%esp
8010649c:	85 c0                	test   %eax,%eax
8010649e:	79 0a                	jns    801064aa <sys_pipe+0x48>
    return -1;
801064a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064a5:	e9 8e 00 00 00       	jmp    80106538 <sys_pipe+0xd6>
  fd0 = -1;
801064aa:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801064b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064b4:	83 ec 0c             	sub    $0xc,%esp
801064b7:	50                   	push   %eax
801064b8:	e8 81 f3 ff ff       	call   8010583e <fdalloc>
801064bd:	83 c4 10             	add    $0x10,%esp
801064c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064c7:	78 18                	js     801064e1 <sys_pipe+0x7f>
801064c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064cc:	83 ec 0c             	sub    $0xc,%esp
801064cf:	50                   	push   %eax
801064d0:	e8 69 f3 ff ff       	call   8010583e <fdalloc>
801064d5:	83 c4 10             	add    $0x10,%esp
801064d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
801064db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801064df:	79 3f                	jns    80106520 <sys_pipe+0xbe>
    if(fd0 >= 0)
801064e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064e5:	78 14                	js     801064fb <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
801064e7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
801064f0:	83 c2 08             	add    $0x8,%edx
801064f3:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
801064fa:	00 
    fileclose(rf);
801064fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801064fe:	83 ec 0c             	sub    $0xc,%esp
80106501:	50                   	push   %eax
80106502:	e8 cf ab ff ff       	call   801010d6 <fileclose>
80106507:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
8010650a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010650d:	83 ec 0c             	sub    $0xc,%esp
80106510:	50                   	push   %eax
80106511:	e8 c0 ab ff ff       	call   801010d6 <fileclose>
80106516:	83 c4 10             	add    $0x10,%esp
    return -1;
80106519:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010651e:	eb 18                	jmp    80106538 <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80106520:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106523:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106526:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80106528:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010652b:	8d 50 04             	lea    0x4(%eax),%edx
8010652e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106531:	89 02                	mov    %eax,(%edx)
  return 0;
80106533:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106538:	c9                   	leave  
80106539:	c3                   	ret    

8010653a <sys_dup2>:

int
sys_dup2(void)
{
8010653a:	55                   	push   %ebp
8010653b:	89 e5                	mov    %esp,%ebp
8010653d:	53                   	push   %ebx
8010653e:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd1, fd2;
  if(argfd(0, &fd1, &f) < 0)
80106541:	83 ec 04             	sub    $0x4,%esp
80106544:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106547:	50                   	push   %eax
80106548:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010654b:	50                   	push   %eax
8010654c:	6a 00                	push   $0x0
8010654e:	e8 76 f2 ff ff       	call   801057c9 <argfd>
80106553:	83 c4 10             	add    $0x10,%esp
80106556:	85 c0                	test   %eax,%eax
80106558:	79 0a                	jns    80106564 <sys_dup2+0x2a>
    return -1;
8010655a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010655f:	e9 a7 00 00 00       	jmp    8010660b <sys_dup2+0xd1>
  if(argint(1,&fd2) < 0)
80106564:	83 ec 08             	sub    $0x8,%esp
80106567:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010656a:	50                   	push   %eax
8010656b:	6a 01                	push   $0x1
8010656d:	e8 1b f1 ff ff       	call   8010568d <argint>
80106572:	83 c4 10             	add    $0x10,%esp
80106575:	85 c0                	test   %eax,%eax
80106577:	79 0a                	jns    80106583 <sys_dup2+0x49>
    return -1;
80106579:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010657e:	e9 88 00 00 00       	jmp    8010660b <sys_dup2+0xd1>
  if (fd2 < 0 || fd2 >= NOFILE)
80106583:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106586:	85 c0                	test   %eax,%eax
80106588:	78 08                	js     80106592 <sys_dup2+0x58>
8010658a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010658d:	83 f8 0f             	cmp    $0xf,%eax
80106590:	7e 07                	jle    80106599 <sys_dup2+0x5f>
    return -1; 
80106592:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106597:	eb 72                	jmp    8010660b <sys_dup2+0xd1>
  if(fd1==fd2)
80106599:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010659c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010659f:	39 c2                	cmp    %eax,%edx
801065a1:	75 05                	jne    801065a8 <sys_dup2+0x6e>
    return fd2;
801065a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801065a6:	eb 63                	jmp    8010660b <sys_dup2+0xd1>
  if(proc->ofile[fd2] != 0)
801065a8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065ae:	8b 55 ec             	mov    -0x14(%ebp),%edx
801065b1:	83 c2 08             	add    $0x8,%edx
801065b4:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801065b8:	85 c0                	test   %eax,%eax
801065ba:	74 1c                	je     801065d8 <sys_dup2+0x9e>
	fileclose(proc->ofile[fd2]);
801065bc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801065c5:	83 c2 08             	add    $0x8,%edx
801065c8:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
801065cc:	83 ec 0c             	sub    $0xc,%esp
801065cf:	50                   	push   %eax
801065d0:	e8 01 ab ff ff       	call   801010d6 <fileclose>
801065d5:	83 c4 10             	add    $0x10,%esp
  proc->ofile[fd2]=proc->ofile[fd1];
801065d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065de:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801065e1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801065e8:	8b 5d f0             	mov    -0x10(%ebp),%ebx
801065eb:	83 c3 08             	add    $0x8,%ebx
801065ee:	8b 54 9a 0c          	mov    0xc(%edx,%ebx,4),%edx
801065f2:	83 c1 08             	add    $0x8,%ecx
801065f5:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
  filedup(f);
801065f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065fc:	83 ec 0c             	sub    $0xc,%esp
801065ff:	50                   	push   %eax
80106600:	e8 80 aa ff ff       	call   80101085 <filedup>
80106605:	83 c4 10             	add    $0x10,%esp
  return fd2;
80106608:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
8010660b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010660e:	c9                   	leave  
8010660f:	c3                   	ret    

80106610 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106610:	55                   	push   %ebp
80106611:	89 e5                	mov    %esp,%ebp
80106613:	83 ec 08             	sub    $0x8,%esp
  return fork();
80106616:	e8 e8 e0 ff ff       	call   80104703 <fork>
}
8010661b:	c9                   	leave  
8010661c:	c3                   	ret    

8010661d <sys_exit>:

int
sys_exit(void)
{
8010661d:	55                   	push   %ebp
8010661e:	89 e5                	mov    %esp,%ebp
80106620:	83 ec 08             	sub    $0x8,%esp
  exit();
80106623:	e8 6c e2 ff ff       	call   80104894 <exit>
  return 0;  // not reached
80106628:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010662d:	c9                   	leave  
8010662e:	c3                   	ret    

8010662f <sys_wait>:

int
sys_wait(void)
{
8010662f:	55                   	push   %ebp
80106630:	89 e5                	mov    %esp,%ebp
80106632:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106635:	e8 92 e3 ff ff       	call   801049cc <wait>
}
8010663a:	c9                   	leave  
8010663b:	c3                   	ret    

8010663c <sys_kill>:

int
sys_kill(void)
{
8010663c:	55                   	push   %ebp
8010663d:	89 e5                	mov    %esp,%ebp
8010663f:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106642:	83 ec 08             	sub    $0x8,%esp
80106645:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106648:	50                   	push   %eax
80106649:	6a 00                	push   $0x0
8010664b:	e8 3d f0 ff ff       	call   8010568d <argint>
80106650:	83 c4 10             	add    $0x10,%esp
80106653:	85 c0                	test   %eax,%eax
80106655:	79 07                	jns    8010665e <sys_kill+0x22>
    return -1;
80106657:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010665c:	eb 0f                	jmp    8010666d <sys_kill+0x31>
  return kill(pid);
8010665e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106661:	83 ec 0c             	sub    $0xc,%esp
80106664:	50                   	push   %eax
80106665:	e8 87 e7 ff ff       	call   80104df1 <kill>
8010666a:	83 c4 10             	add    $0x10,%esp
}
8010666d:	c9                   	leave  
8010666e:	c3                   	ret    

8010666f <sys_getpid>:

int
sys_getpid(void)
{
8010666f:	55                   	push   %ebp
80106670:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106672:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106678:	8b 40 14             	mov    0x14(%eax),%eax
}
8010667b:	5d                   	pop    %ebp
8010667c:	c3                   	ret    

8010667d <sys_sbrk>:

int
sys_sbrk(void)
{
8010667d:	55                   	push   %ebp
8010667e:	89 e5                	mov    %esp,%ebp
80106680:	83 ec 18             	sub    $0x18,%esp
//Falta liberar memoria si el argumento es negativo
//Redondear hacia arriba size al liberar (se hace ya en dealloc y si no lo ponemos)
  int addr;
  int n;
  if(argint(0, &n) < 0)
80106683:	83 ec 08             	sub    $0x8,%esp
80106686:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106689:	50                   	push   %eax
8010668a:	6a 00                	push   $0x0
8010668c:	e8 fc ef ff ff       	call   8010568d <argint>
80106691:	83 c4 10             	add    $0x10,%esp
80106694:	85 c0                	test   %eax,%eax
80106696:	79 07                	jns    8010669f <sys_sbrk+0x22>
    return -1; 
80106698:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010669d:	eb 77                	jmp    80106716 <sys_sbrk+0x99>
  addr = proc->sz;
8010669f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066a5:	8b 00                	mov    (%eax),%eax
801066a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((proc->sz+n)>=KERNBASE || (proc->sz+n)<0)
801066aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066b0:	8b 00                	mov    (%eax),%eax
801066b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
801066b5:	01 d0                	add    %edx,%eax
801066b7:	85 c0                	test   %eax,%eax
801066b9:	79 17                	jns    801066d2 <sys_sbrk+0x55>
    {
      cprintf("virtual page error\n");
801066bb:	83 ec 0c             	sub    $0xc,%esp
801066be:	68 d1 8d 10 80       	push   $0x80108dd1
801066c3:	e8 38 9d ff ff       	call   80100400 <cprintf>
801066c8:	83 c4 10             	add    $0x10,%esp
      return -1;
801066cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066d0:	eb 44                	jmp    80106716 <sys_sbrk+0x99>
    }
  if(n<0)
801066d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066d5:	85 c0                	test   %eax,%eax
801066d7:	79 24                	jns    801066fd <sys_sbrk+0x80>
	deallocuvm(proc->pgdir,addr,addr+n);
801066d9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801066dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066df:	01 d0                	add    %edx,%eax
801066e1:	89 c1                	mov    %eax,%ecx
801066e3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801066e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066ec:	8b 40 04             	mov    0x4(%eax),%eax
801066ef:	83 ec 04             	sub    $0x4,%esp
801066f2:	51                   	push   %ecx
801066f3:	52                   	push   %edx
801066f4:	50                   	push   %eax
801066f5:	e8 b3 1e 00 00       	call   801085ad <deallocuvm>
801066fa:	83 c4 10             	add    $0x10,%esp
  proc->sz+=n;
801066fd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106703:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010670a:	8b 12                	mov    (%edx),%edx
8010670c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010670f:	01 ca                	add    %ecx,%edx
80106711:	89 10                	mov    %edx,(%eax)
  return addr;
80106713:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106716:	c9                   	leave  
80106717:	c3                   	ret    

80106718 <sys_sleep>:

int
sys_sleep(void)
{
80106718:	55                   	push   %ebp
80106719:	89 e5                	mov    %esp,%ebp
8010671b:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010671e:	83 ec 08             	sub    $0x8,%esp
80106721:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106724:	50                   	push   %eax
80106725:	6a 00                	push   $0x0
80106727:	e8 61 ef ff ff       	call   8010568d <argint>
8010672c:	83 c4 10             	add    $0x10,%esp
8010672f:	85 c0                	test   %eax,%eax
80106731:	79 07                	jns    8010673a <sys_sleep+0x22>
    return -1;
80106733:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106738:	eb 77                	jmp    801067b1 <sys_sleep+0x99>
  acquire(&tickslock);
8010673a:	83 ec 0c             	sub    $0xc,%esp
8010673d:	68 60 6e 11 80       	push   $0x80116e60
80106742:	e8 a7 e9 ff ff       	call   801050ee <acquire>
80106747:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
8010674a:	a1 a0 76 11 80       	mov    0x801176a0,%eax
8010674f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106752:	eb 39                	jmp    8010678d <sys_sleep+0x75>
    if(proc->killed){
80106754:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010675a:	8b 40 28             	mov    0x28(%eax),%eax
8010675d:	85 c0                	test   %eax,%eax
8010675f:	74 17                	je     80106778 <sys_sleep+0x60>
      release(&tickslock);
80106761:	83 ec 0c             	sub    $0xc,%esp
80106764:	68 60 6e 11 80       	push   $0x80116e60
80106769:	e8 ec e9 ff ff       	call   8010515a <release>
8010676e:	83 c4 10             	add    $0x10,%esp
      return -1;
80106771:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106776:	eb 39                	jmp    801067b1 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
80106778:	83 ec 08             	sub    $0x8,%esp
8010677b:	68 60 6e 11 80       	push   $0x80116e60
80106780:	68 a0 76 11 80       	push   $0x801176a0
80106785:	e8 45 e5 ff ff       	call   80104ccf <sleep>
8010678a:	83 c4 10             	add    $0x10,%esp

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010678d:	a1 a0 76 11 80       	mov    0x801176a0,%eax
80106792:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106795:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106798:	39 d0                	cmp    %edx,%eax
8010679a:	72 b8                	jb     80106754 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010679c:	83 ec 0c             	sub    $0xc,%esp
8010679f:	68 60 6e 11 80       	push   $0x80116e60
801067a4:	e8 b1 e9 ff ff       	call   8010515a <release>
801067a9:	83 c4 10             	add    $0x10,%esp
  return 0;
801067ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
801067b1:	c9                   	leave  
801067b2:	c3                   	ret    

801067b3 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801067b3:	55                   	push   %ebp
801067b4:	89 e5                	mov    %esp,%ebp
801067b6:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
801067b9:	83 ec 0c             	sub    $0xc,%esp
801067bc:	68 60 6e 11 80       	push   $0x80116e60
801067c1:	e8 28 e9 ff ff       	call   801050ee <acquire>
801067c6:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
801067c9:	a1 a0 76 11 80       	mov    0x801176a0,%eax
801067ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801067d1:	83 ec 0c             	sub    $0xc,%esp
801067d4:	68 60 6e 11 80       	push   $0x80116e60
801067d9:	e8 7c e9 ff ff       	call   8010515a <release>
801067de:	83 c4 10             	add    $0x10,%esp
  return xticks;
801067e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801067e4:	c9                   	leave  
801067e5:	c3                   	ret    

801067e6 <sys_date>:

// Return current UTC time
int
sys_date(void)
{
801067e6:	55                   	push   %ebp
801067e7:	89 e5                	mov    %esp,%ebp
801067e9:	83 ec 18             	sub    $0x18,%esp
  struct rtcdate *date;
  if(argptr(0,(void *)&date,sizeof(struct rtcdat *))<0)
801067ec:	83 ec 04             	sub    $0x4,%esp
801067ef:	6a 04                	push   $0x4
801067f1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067f4:	50                   	push   %eax
801067f5:	6a 00                	push   $0x0
801067f7:	e8 b9 ee ff ff       	call   801056b5 <argptr>
801067fc:	83 c4 10             	add    $0x10,%esp
801067ff:	85 c0                	test   %eax,%eax
80106801:	79 07                	jns    8010680a <sys_date+0x24>
  {
	return -1;
80106803:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106808:	eb 14                	jmp    8010681e <sys_date+0x38>
  }
  cmostime(date);
8010680a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010680d:	83 ec 0c             	sub    $0xc,%esp
80106810:	50                   	push   %eax
80106811:	e8 58 ca ff ff       	call   8010326e <cmostime>
80106816:	83 c4 10             	add    $0x10,%esp
  return 0;
80106819:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010681e:	c9                   	leave  
8010681f:	c3                   	ret    

80106820 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106820:	55                   	push   %ebp
80106821:	89 e5                	mov    %esp,%ebp
80106823:	83 ec 08             	sub    $0x8,%esp
80106826:	8b 55 08             	mov    0x8(%ebp),%edx
80106829:	8b 45 0c             	mov    0xc(%ebp),%eax
8010682c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106830:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106833:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106837:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010683b:	ee                   	out    %al,(%dx)
}
8010683c:	90                   	nop
8010683d:	c9                   	leave  
8010683e:	c3                   	ret    

8010683f <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
8010683f:	55                   	push   %ebp
80106840:	89 e5                	mov    %esp,%ebp
80106842:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106845:	6a 34                	push   $0x34
80106847:	6a 43                	push   $0x43
80106849:	e8 d2 ff ff ff       	call   80106820 <outb>
8010684e:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106851:	68 9c 00 00 00       	push   $0x9c
80106856:	6a 40                	push   $0x40
80106858:	e8 c3 ff ff ff       	call   80106820 <outb>
8010685d:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106860:	6a 2e                	push   $0x2e
80106862:	6a 40                	push   $0x40
80106864:	e8 b7 ff ff ff       	call   80106820 <outb>
80106869:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
8010686c:	83 ec 0c             	sub    $0xc,%esp
8010686f:	6a 00                	push   $0x0
80106871:	e8 61 d6 ff ff       	call   80103ed7 <picenable>
80106876:	83 c4 10             	add    $0x10,%esp
}
80106879:	90                   	nop
8010687a:	c9                   	leave  
8010687b:	c3                   	ret    

8010687c <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010687c:	1e                   	push   %ds
  pushl %es
8010687d:	06                   	push   %es
  pushl %fs
8010687e:	0f a0                	push   %fs
  pushl %gs
80106880:	0f a8                	push   %gs
  pushal
80106882:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106883:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106887:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106889:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010688b:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010688f:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106891:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106893:	54                   	push   %esp
  call trap
80106894:	e8 d7 01 00 00       	call   80106a70 <trap>
  addl $4, %esp
80106899:	83 c4 04             	add    $0x4,%esp

8010689c <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010689c:	61                   	popa   
  popl %gs
8010689d:	0f a9                	pop    %gs
  popl %fs
8010689f:	0f a1                	pop    %fs
  popl %es
801068a1:	07                   	pop    %es
  popl %ds
801068a2:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801068a3:	83 c4 08             	add    $0x8,%esp
  iret
801068a6:	cf                   	iret   

801068a7 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801068a7:	55                   	push   %ebp
801068a8:	89 e5                	mov    %esp,%ebp
801068aa:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801068ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801068b0:	83 e8 01             	sub    $0x1,%eax
801068b3:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801068b7:	8b 45 08             	mov    0x8(%ebp),%eax
801068ba:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801068be:	8b 45 08             	mov    0x8(%ebp),%eax
801068c1:	c1 e8 10             	shr    $0x10,%eax
801068c4:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801068c8:	8d 45 fa             	lea    -0x6(%ebp),%eax
801068cb:	0f 01 18             	lidtl  (%eax)
}
801068ce:	90                   	nop
801068cf:	c9                   	leave  
801068d0:	c3                   	ret    

801068d1 <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801068d1:	55                   	push   %ebp
801068d2:	89 e5                	mov    %esp,%ebp
801068d4:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801068d7:	0f 20 d0             	mov    %cr2,%eax
801068da:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801068dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801068e0:	c9                   	leave  
801068e1:	c3                   	ret    

801068e2 <tvinit>:
uint ticks;
extern int mappages(pde_t *, void *, uint, uint, int);

void
tvinit(void)
{
801068e2:	55                   	push   %ebp
801068e3:	89 e5                	mov    %esp,%ebp
801068e5:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801068e8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801068ef:	e9 c3 00 00 00       	jmp    801069b7 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801068f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068f7:	8b 04 85 a0 c0 10 80 	mov    -0x7fef3f60(,%eax,4),%eax
801068fe:	89 c2                	mov    %eax,%edx
80106900:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106903:	66 89 14 c5 a0 6e 11 	mov    %dx,-0x7fee9160(,%eax,8)
8010690a:	80 
8010690b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010690e:	66 c7 04 c5 a2 6e 11 	movw   $0x8,-0x7fee915e(,%eax,8)
80106915:	80 08 00 
80106918:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010691b:	0f b6 14 c5 a4 6e 11 	movzbl -0x7fee915c(,%eax,8),%edx
80106922:	80 
80106923:	83 e2 e0             	and    $0xffffffe0,%edx
80106926:	88 14 c5 a4 6e 11 80 	mov    %dl,-0x7fee915c(,%eax,8)
8010692d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106930:	0f b6 14 c5 a4 6e 11 	movzbl -0x7fee915c(,%eax,8),%edx
80106937:	80 
80106938:	83 e2 1f             	and    $0x1f,%edx
8010693b:	88 14 c5 a4 6e 11 80 	mov    %dl,-0x7fee915c(,%eax,8)
80106942:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106945:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
8010694c:	80 
8010694d:	83 e2 f0             	and    $0xfffffff0,%edx
80106950:	83 ca 0e             	or     $0xe,%edx
80106953:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
8010695a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010695d:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
80106964:	80 
80106965:	83 e2 ef             	and    $0xffffffef,%edx
80106968:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
8010696f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106972:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
80106979:	80 
8010697a:	83 e2 9f             	and    $0xffffff9f,%edx
8010697d:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
80106984:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106987:	0f b6 14 c5 a5 6e 11 	movzbl -0x7fee915b(,%eax,8),%edx
8010698e:	80 
8010698f:	83 ca 80             	or     $0xffffff80,%edx
80106992:	88 14 c5 a5 6e 11 80 	mov    %dl,-0x7fee915b(,%eax,8)
80106999:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010699c:	8b 04 85 a0 c0 10 80 	mov    -0x7fef3f60(,%eax,4),%eax
801069a3:	c1 e8 10             	shr    $0x10,%eax
801069a6:	89 c2                	mov    %eax,%edx
801069a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069ab:	66 89 14 c5 a6 6e 11 	mov    %dx,-0x7fee915a(,%eax,8)
801069b2:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801069b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801069b7:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801069be:	0f 8e 30 ff ff ff    	jle    801068f4 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801069c4:	a1 a0 c1 10 80       	mov    0x8010c1a0,%eax
801069c9:	66 a3 a0 70 11 80    	mov    %ax,0x801170a0
801069cf:	66 c7 05 a2 70 11 80 	movw   $0x8,0x801170a2
801069d6:	08 00 
801069d8:	0f b6 05 a4 70 11 80 	movzbl 0x801170a4,%eax
801069df:	83 e0 e0             	and    $0xffffffe0,%eax
801069e2:	a2 a4 70 11 80       	mov    %al,0x801170a4
801069e7:	0f b6 05 a4 70 11 80 	movzbl 0x801170a4,%eax
801069ee:	83 e0 1f             	and    $0x1f,%eax
801069f1:	a2 a4 70 11 80       	mov    %al,0x801170a4
801069f6:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
801069fd:	83 c8 0f             	or     $0xf,%eax
80106a00:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a05:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
80106a0c:	83 e0 ef             	and    $0xffffffef,%eax
80106a0f:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a14:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
80106a1b:	83 c8 60             	or     $0x60,%eax
80106a1e:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a23:	0f b6 05 a5 70 11 80 	movzbl 0x801170a5,%eax
80106a2a:	83 c8 80             	or     $0xffffff80,%eax
80106a2d:	a2 a5 70 11 80       	mov    %al,0x801170a5
80106a32:	a1 a0 c1 10 80       	mov    0x8010c1a0,%eax
80106a37:	c1 e8 10             	shr    $0x10,%eax
80106a3a:	66 a3 a6 70 11 80    	mov    %ax,0x801170a6

  initlock(&tickslock, "time");
80106a40:	83 ec 08             	sub    $0x8,%esp
80106a43:	68 e8 8d 10 80       	push   $0x80108de8
80106a48:	68 60 6e 11 80       	push   $0x80116e60
80106a4d:	e8 7a e6 ff ff       	call   801050cc <initlock>
80106a52:	83 c4 10             	add    $0x10,%esp
}
80106a55:	90                   	nop
80106a56:	c9                   	leave  
80106a57:	c3                   	ret    

80106a58 <idtinit>:

void
idtinit(void)
{
80106a58:	55                   	push   %ebp
80106a59:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106a5b:	68 00 08 00 00       	push   $0x800
80106a60:	68 a0 6e 11 80       	push   $0x80116ea0
80106a65:	e8 3d fe ff ff       	call   801068a7 <lidt>
80106a6a:	83 c4 08             	add    $0x8,%esp
}
80106a6d:	90                   	nop
80106a6e:	c9                   	leave  
80106a6f:	c3                   	ret    

80106a70 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	57                   	push   %edi
80106a74:	56                   	push   %esi
80106a75:	53                   	push   %ebx
80106a76:	83 ec 2c             	sub    $0x2c,%esp
  if(tf->trapno == T_SYSCALL){
80106a79:	8b 45 08             	mov    0x8(%ebp),%eax
80106a7c:	8b 40 30             	mov    0x30(%eax),%eax
80106a7f:	83 f8 40             	cmp    $0x40,%eax
80106a82:	75 3e                	jne    80106ac2 <trap+0x52>
    if(proc->killed)
80106a84:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a8a:	8b 40 28             	mov    0x28(%eax),%eax
80106a8d:	85 c0                	test   %eax,%eax
80106a8f:	74 05                	je     80106a96 <trap+0x26>
      exit();
80106a91:	e8 fe dd ff ff       	call   80104894 <exit>
    proc->tf = tf;
80106a96:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a9c:	8b 55 08             	mov    0x8(%ebp),%edx
80106a9f:	89 50 1c             	mov    %edx,0x1c(%eax)
    syscall();
80106aa2:	e8 9c ec ff ff       	call   80105743 <syscall>
    if(proc->killed)
80106aa7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aad:	8b 40 28             	mov    0x28(%eax),%eax
80106ab0:	85 c0                	test   %eax,%eax
80106ab2:	0f 84 15 04 00 00    	je     80106ecd <trap+0x45d>
      exit();
80106ab8:	e8 d7 dd ff ff       	call   80104894 <exit>
    return;
80106abd:	e9 0b 04 00 00       	jmp    80106ecd <trap+0x45d>
  }

  switch(tf->trapno){
80106ac2:	8b 45 08             	mov    0x8(%ebp),%eax
80106ac5:	8b 40 30             	mov    0x30(%eax),%eax
80106ac8:	83 e8 0e             	sub    $0xe,%eax
80106acb:	83 f8 31             	cmp    $0x31,%eax
80106ace:	0f 87 c4 02 00 00    	ja     80106d98 <trap+0x328>
80106ad4:	8b 04 85 a8 8f 10 80 	mov    -0x7fef7058(,%eax,4),%eax
80106adb:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80106add:	e8 4b c5 ff ff       	call   8010302d <cpunum>
80106ae2:	85 c0                	test   %eax,%eax
80106ae4:	75 3d                	jne    80106b23 <trap+0xb3>
      acquire(&tickslock);
80106ae6:	83 ec 0c             	sub    $0xc,%esp
80106ae9:	68 60 6e 11 80       	push   $0x80116e60
80106aee:	e8 fb e5 ff ff       	call   801050ee <acquire>
80106af3:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106af6:	a1 a0 76 11 80       	mov    0x801176a0,%eax
80106afb:	83 c0 01             	add    $0x1,%eax
80106afe:	a3 a0 76 11 80       	mov    %eax,0x801176a0
      wakeup(&ticks);
80106b03:	83 ec 0c             	sub    $0xc,%esp
80106b06:	68 a0 76 11 80       	push   $0x801176a0
80106b0b:	e8 aa e2 ff ff       	call   80104dba <wakeup>
80106b10:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106b13:	83 ec 0c             	sub    $0xc,%esp
80106b16:	68 60 6e 11 80       	push   $0x80116e60
80106b1b:	e8 3a e6 ff ff       	call   8010515a <release>
80106b20:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106b23:	e8 a3 c5 ff ff       	call   801030cb <lapiceoi>
    break;
80106b28:	e9 1a 03 00 00       	jmp    80106e47 <trap+0x3d7>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106b2d:	e8 6d bd ff ff       	call   8010289f <ideintr>
    lapiceoi();
80106b32:	e8 94 c5 ff ff       	call   801030cb <lapiceoi>
    break;
80106b37:	e9 0b 03 00 00       	jmp    80106e47 <trap+0x3d7>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106b3c:	e8 47 c3 ff ff       	call   80102e88 <kbdintr>
    lapiceoi();
80106b41:	e8 85 c5 ff ff       	call   801030cb <lapiceoi>
    break;
80106b46:	e9 fc 02 00 00       	jmp    80106e47 <trap+0x3d7>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106b4b:	e8 5e 05 00 00       	call   801070ae <uartintr>
    lapiceoi();
80106b50:	e8 76 c5 ff ff       	call   801030cb <lapiceoi>
    break;
80106b55:	e9 ed 02 00 00       	jmp    80106e47 <trap+0x3d7>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b5a:	8b 45 08             	mov    0x8(%ebp),%eax
80106b5d:	8b 70 38             	mov    0x38(%eax),%esi
            cpunum(), tf->cs, tf->eip);
80106b60:	8b 45 08             	mov    0x8(%ebp),%eax
80106b63:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106b67:	0f b7 d8             	movzwl %ax,%ebx
80106b6a:	e8 be c4 ff ff       	call   8010302d <cpunum>
80106b6f:	56                   	push   %esi
80106b70:	53                   	push   %ebx
80106b71:	50                   	push   %eax
80106b72:	68 f0 8d 10 80       	push   $0x80108df0
80106b77:	e8 84 98 ff ff       	call   80100400 <cprintf>
80106b7c:	83 c4 10             	add    $0x10,%esp
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80106b7f:	e8 47 c5 ff ff       	call   801030cb <lapiceoi>
    break;
80106b84:	e9 be 02 00 00       	jmp    80106e47 <trap+0x3d7>

  case T_PGFLT:
    if(proc == 0 || ((tf->cs&3) == 0 && rcr2()>KERNBASE)){
80106b89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106b8f:	85 c0                	test   %eax,%eax
80106b91:	74 1d                	je     80106bb0 <trap+0x140>
80106b93:	8b 45 08             	mov    0x8(%ebp),%eax
80106b96:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106b9a:	0f b7 c0             	movzwl %ax,%eax
80106b9d:	83 e0 03             	and    $0x3,%eax
80106ba0:	85 c0                	test   %eax,%eax
80106ba2:	75 47                	jne    80106beb <trap+0x17b>
80106ba4:	e8 28 fd ff ff       	call   801068d1 <rcr2>
80106ba9:	3d 00 00 00 80       	cmp    $0x80000000,%eax
80106bae:	76 3b                	jbe    80106beb <trap+0x17b>
      // In kernel, it must be our mistake.
      cprintf("unexpected page fault from cpu %d eip %x (cr2=0x%x)\n",
80106bb0:	e8 1c fd ff ff       	call   801068d1 <rcr2>
80106bb5:	89 c6                	mov    %eax,%esi
80106bb7:	8b 45 08             	mov    0x8(%ebp),%eax
80106bba:	8b 58 38             	mov    0x38(%eax),%ebx
80106bbd:	e8 6b c4 ff ff       	call   8010302d <cpunum>
80106bc2:	89 c2                	mov    %eax,%edx
80106bc4:	8b 45 08             	mov    0x8(%ebp),%eax
80106bc7:	8b 40 30             	mov    0x30(%eax),%eax
80106bca:	83 ec 0c             	sub    $0xc,%esp
80106bcd:	56                   	push   %esi
80106bce:	53                   	push   %ebx
80106bcf:	52                   	push   %edx
80106bd0:	50                   	push   %eax
80106bd1:	68 14 8e 10 80       	push   $0x80108e14
80106bd6:	e8 25 98 ff ff       	call   80100400 <cprintf>
80106bdb:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("page fault inside kernel");
80106bde:	83 ec 0c             	sub    $0xc,%esp
80106be1:	68 49 8e 10 80       	push   $0x80108e49
80106be6:	e8 b5 99 ff ff       	call   801005a0 <panic>
    }

    char * mem = kalloc();
80106beb:	e8 d7 c0 ff ff       	call   80102cc7 <kalloc>
80106bf0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(mem == 0){
80106bf3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80106bf7:	75 22                	jne    80106c1b <trap+0x1ab>
      cprintf("allocuvm out of memory\n");
80106bf9:	83 ec 0c             	sub    $0xc,%esp
80106bfc:	68 62 8e 10 80       	push   $0x80108e62
80106c01:	e8 fa 97 ff ff       	call   80100400 <cprintf>
80106c06:	83 c4 10             	add    $0x10,%esp
      proc->killed=1;
80106c09:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c0f:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      break;
80106c16:	e9 2c 02 00 00       	jmp    80106e47 <trap+0x3d7>
    }
    if(rcr2()>proc->sz)
80106c1b:	e8 b1 fc ff ff       	call   801068d1 <rcr2>
80106c20:	89 c2                	mov    %eax,%edx
80106c22:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c28:	8b 00                	mov    (%eax),%eax
80106c2a:	39 c2                	cmp    %eax,%edx
80106c2c:	76 43                	jbe    80106c71 <trap+0x201>
    {
      cprintf("sz %d rcr2 %x",proc->sz,rcr2());
80106c2e:	e8 9e fc ff ff       	call   801068d1 <rcr2>
80106c33:	89 c2                	mov    %eax,%edx
80106c35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c3b:	8b 00                	mov    (%eax),%eax
80106c3d:	83 ec 04             	sub    $0x4,%esp
80106c40:	52                   	push   %edx
80106c41:	50                   	push   %eax
80106c42:	68 7a 8e 10 80       	push   $0x80108e7a
80106c47:	e8 b4 97 ff ff       	call   80100400 <cprintf>
80106c4c:	83 c4 10             	add    $0x10,%esp
      cprintf("address out of proc memory\n");
80106c4f:	83 ec 0c             	sub    $0xc,%esp
80106c52:	68 88 8e 10 80       	push   $0x80108e88
80106c57:	e8 a4 97 ff ff       	call   80100400 <cprintf>
80106c5c:	83 c4 10             	add    $0x10,%esp
      proc->killed=1;
80106c5f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c65:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      break;
80106c6c:	e9 d6 01 00 00       	jmp    80106e47 <trap+0x3d7>
    }
    if(rcr2()>proc->ustack && rcr2()<(proc->ustack+PGSIZE))
80106c71:	e8 5b fc ff ff       	call   801068d1 <rcr2>
80106c76:	89 c2                	mov    %eax,%edx
80106c78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c7e:	8b 40 0c             	mov    0xc(%eax),%eax
80106c81:	39 c2                	cmp    %eax,%edx
80106c83:	76 3b                	jbe    80106cc0 <trap+0x250>
80106c85:	e8 47 fc ff ff       	call   801068d1 <rcr2>
80106c8a:	89 c2                	mov    %eax,%edx
80106c8c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106c92:	8b 40 0c             	mov    0xc(%eax),%eax
80106c95:	05 00 10 00 00       	add    $0x1000,%eax
80106c9a:	39 c2                	cmp    %eax,%edx
80106c9c:	73 22                	jae    80106cc0 <trap+0x250>
    {
      cprintf("stack overflow\n");
80106c9e:	83 ec 0c             	sub    $0xc,%esp
80106ca1:	68 a4 8e 10 80       	push   $0x80108ea4
80106ca6:	e8 55 97 ff ff       	call   80100400 <cprintf>
80106cab:	83 c4 10             	add    $0x10,%esp
      proc->killed=1;
80106cae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cb4:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      break;
80106cbb:	e9 87 01 00 00       	jmp    80106e47 <trap+0x3d7>
    }
    memset(mem, 0, PGSIZE);
80106cc0:	83 ec 04             	sub    $0x4,%esp
80106cc3:	68 00 10 00 00       	push   $0x1000
80106cc8:	6a 00                	push   $0x0
80106cca:	ff 75 e4             	pushl  -0x1c(%ebp)
80106ccd:	e8 96 e6 ff ff       	call   80105368 <memset>
80106cd2:	83 c4 10             	add    $0x10,%esp
//Comprobar si rcr2 está en la página de guarda. Habrá que añadir un campo al proc que contega qué pagina es (en el exec lo metemos)
    uint virAddr = (uint) PGROUNDDOWN(rcr2());
80106cd5:	e8 f7 fb ff ff       	call   801068d1 <rcr2>
80106cda:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cdf:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(mappages(proc->pgdir, (char*)virAddr, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106ce2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ce5:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80106ceb:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106cee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106cf4:	8b 40 04             	mov    0x4(%eax),%eax
80106cf7:	83 ec 0c             	sub    $0xc,%esp
80106cfa:	6a 06                	push   $0x6
80106cfc:	51                   	push   %ecx
80106cfd:	68 00 10 00 00       	push   $0x1000
80106d02:	52                   	push   %edx
80106d03:	50                   	push   %eax
80106d04:	e8 9e 13 00 00       	call   801080a7 <mappages>
80106d09:	83 c4 20             	add    $0x20,%esp
80106d0c:	85 c0                	test   %eax,%eax
80106d0e:	79 4f                	jns    80106d5f <trap+0x2ef>
      cprintf("pid %d %s: page fault on cpu %d "
80106d10:	e8 bc fb ff ff       	call   801068d1 <rcr2>
80106d15:	89 c3                	mov    %eax,%ebx
80106d17:	e8 11 c3 ff ff       	call   8010302d <cpunum>
80106d1c:	89 c1                	mov    %eax,%ecx
            "at addr 0x%x--kill proc\n",
            proc->pid, proc->name, cpunum(), rcr2());  
80106d1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d24:	8d 50 70             	lea    0x70(%eax),%edx
80106d27:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    }
    memset(mem, 0, PGSIZE);
//Comprobar si rcr2 está en la página de guarda. Habrá que añadir un campo al proc que contega qué pagina es (en el exec lo metemos)
    uint virAddr = (uint) PGROUNDDOWN(rcr2());
    if(mappages(proc->pgdir, (char*)virAddr, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("pid %d %s: page fault on cpu %d "
80106d2d:	8b 40 14             	mov    0x14(%eax),%eax
80106d30:	83 ec 0c             	sub    $0xc,%esp
80106d33:	53                   	push   %ebx
80106d34:	51                   	push   %ecx
80106d35:	52                   	push   %edx
80106d36:	50                   	push   %eax
80106d37:	68 b4 8e 10 80       	push   $0x80108eb4
80106d3c:	e8 bf 96 ff ff       	call   80100400 <cprintf>
80106d41:	83 c4 20             	add    $0x20,%esp
            "at addr 0x%x--kill proc\n",
            proc->pid, proc->name, cpunum(), rcr2());  
      kfree(mem);
80106d44:	83 ec 0c             	sub    $0xc,%esp
80106d47:	ff 75 e4             	pushl  -0x1c(%ebp)
80106d4a:	e8 de be ff ff       	call   80102c2d <kfree>
80106d4f:	83 c4 10             	add    $0x10,%esp
      proc->killed = 1;
80106d52:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d58:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
    }    
    cprintf("pid %d %s: page fault on cpu %d "
80106d5f:	e8 6d fb ff ff       	call   801068d1 <rcr2>
80106d64:	89 c3                	mov    %eax,%ebx
80106d66:	e8 c2 c2 ff ff       	call   8010302d <cpunum>
80106d6b:	89 c1                	mov    %eax,%ecx
          "at addr 0x%x--allocated\n",
          proc->pid, proc->name, cpunum(), rcr2());  
80106d6d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d73:	8d 50 70             	lea    0x70(%eax),%edx
80106d76:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
            "at addr 0x%x--kill proc\n",
            proc->pid, proc->name, cpunum(), rcr2());  
      kfree(mem);
      proc->killed = 1;
    }    
    cprintf("pid %d %s: page fault on cpu %d "
80106d7c:	8b 40 14             	mov    0x14(%eax),%eax
80106d7f:	83 ec 0c             	sub    $0xc,%esp
80106d82:	53                   	push   %ebx
80106d83:	51                   	push   %ecx
80106d84:	52                   	push   %edx
80106d85:	50                   	push   %eax
80106d86:	68 f0 8e 10 80       	push   $0x80108ef0
80106d8b:	e8 70 96 ff ff       	call   80100400 <cprintf>
80106d90:	83 c4 20             	add    $0x20,%esp
          "at addr 0x%x--allocated\n",
          proc->pid, proc->name, cpunum(), rcr2());  

    break;
80106d93:	e9 af 00 00 00       	jmp    80106e47 <trap+0x3d7>



  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80106d98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106d9e:	85 c0                	test   %eax,%eax
80106da0:	74 11                	je     80106db3 <trap+0x343>
80106da2:	8b 45 08             	mov    0x8(%ebp),%eax
80106da5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106da9:	0f b7 c0             	movzwl %ax,%eax
80106dac:	83 e0 03             	and    $0x3,%eax
80106daf:	85 c0                	test   %eax,%eax
80106db1:	75 3b                	jne    80106dee <trap+0x37e>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106db3:	e8 19 fb ff ff       	call   801068d1 <rcr2>
80106db8:	89 c6                	mov    %eax,%esi
80106dba:	8b 45 08             	mov    0x8(%ebp),%eax
80106dbd:	8b 58 38             	mov    0x38(%eax),%ebx
80106dc0:	e8 68 c2 ff ff       	call   8010302d <cpunum>
80106dc5:	89 c2                	mov    %eax,%edx
80106dc7:	8b 45 08             	mov    0x8(%ebp),%eax
80106dca:	8b 40 30             	mov    0x30(%eax),%eax
80106dcd:	83 ec 0c             	sub    $0xc,%esp
80106dd0:	56                   	push   %esi
80106dd1:	53                   	push   %ebx
80106dd2:	52                   	push   %edx
80106dd3:	50                   	push   %eax
80106dd4:	68 2c 8f 10 80       	push   $0x80108f2c
80106dd9:	e8 22 96 ff ff       	call   80100400 <cprintf>
80106dde:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80106de1:	83 ec 0c             	sub    $0xc,%esp
80106de4:	68 5e 8f 10 80       	push   $0x80108f5e
80106de9:	e8 b2 97 ff ff       	call   801005a0 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106dee:	e8 de fa ff ff       	call   801068d1 <rcr2>
80106df3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80106df6:	8b 45 08             	mov    0x8(%ebp),%eax
80106df9:	8b 58 38             	mov    0x38(%eax),%ebx
80106dfc:	e8 2c c2 ff ff       	call   8010302d <cpunum>
80106e01:	89 c7                	mov    %eax,%edi
80106e03:	8b 45 08             	mov    0x8(%ebp),%eax
80106e06:	8b 48 34             	mov    0x34(%eax),%ecx
80106e09:	8b 45 08             	mov    0x8(%ebp),%eax
80106e0c:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80106e0f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e15:	8d 70 70             	lea    0x70(%eax),%esi
80106e18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e1e:	8b 40 14             	mov    0x14(%eax),%eax
80106e21:	ff 75 d4             	pushl  -0x2c(%ebp)
80106e24:	53                   	push   %ebx
80106e25:	57                   	push   %edi
80106e26:	51                   	push   %ecx
80106e27:	52                   	push   %edx
80106e28:	56                   	push   %esi
80106e29:	50                   	push   %eax
80106e2a:	68 64 8f 10 80       	push   $0x80108f64
80106e2f:	e8 cc 95 ff ff       	call   80100400 <cprintf>
80106e34:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80106e37:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e3d:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80106e44:	eb 01                	jmp    80106e47 <trap+0x3d7>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106e46:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106e47:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e4d:	85 c0                	test   %eax,%eax
80106e4f:	74 24                	je     80106e75 <trap+0x405>
80106e51:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e57:	8b 40 28             	mov    0x28(%eax),%eax
80106e5a:	85 c0                	test   %eax,%eax
80106e5c:	74 17                	je     80106e75 <trap+0x405>
80106e5e:	8b 45 08             	mov    0x8(%ebp),%eax
80106e61:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106e65:	0f b7 c0             	movzwl %ax,%eax
80106e68:	83 e0 03             	and    $0x3,%eax
80106e6b:	83 f8 03             	cmp    $0x3,%eax
80106e6e:	75 05                	jne    80106e75 <trap+0x405>
    exit();
80106e70:	e8 1f da ff ff       	call   80104894 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106e75:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e7b:	85 c0                	test   %eax,%eax
80106e7d:	74 1e                	je     80106e9d <trap+0x42d>
80106e7f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106e85:	8b 40 10             	mov    0x10(%eax),%eax
80106e88:	83 f8 04             	cmp    $0x4,%eax
80106e8b:	75 10                	jne    80106e9d <trap+0x42d>
80106e8d:	8b 45 08             	mov    0x8(%ebp),%eax
80106e90:	8b 40 30             	mov    0x30(%eax),%eax
80106e93:	83 f8 20             	cmp    $0x20,%eax
80106e96:	75 05                	jne    80106e9d <trap+0x42d>
    yield();
80106e98:	e8 b1 dd ff ff       	call   80104c4e <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106e9d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ea3:	85 c0                	test   %eax,%eax
80106ea5:	74 27                	je     80106ece <trap+0x45e>
80106ea7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ead:	8b 40 28             	mov    0x28(%eax),%eax
80106eb0:	85 c0                	test   %eax,%eax
80106eb2:	74 1a                	je     80106ece <trap+0x45e>
80106eb4:	8b 45 08             	mov    0x8(%ebp),%eax
80106eb7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ebb:	0f b7 c0             	movzwl %ax,%eax
80106ebe:	83 e0 03             	and    $0x3,%eax
80106ec1:	83 f8 03             	cmp    $0x3,%eax
80106ec4:	75 08                	jne    80106ece <trap+0x45e>
    exit();
80106ec6:	e8 c9 d9 ff ff       	call   80104894 <exit>
80106ecb:	eb 01                	jmp    80106ece <trap+0x45e>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106ecd:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106ece:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ed1:	5b                   	pop    %ebx
80106ed2:	5e                   	pop    %esi
80106ed3:	5f                   	pop    %edi
80106ed4:	5d                   	pop    %ebp
80106ed5:	c3                   	ret    

80106ed6 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106ed6:	55                   	push   %ebp
80106ed7:	89 e5                	mov    %esp,%ebp
80106ed9:	83 ec 14             	sub    $0x14,%esp
80106edc:	8b 45 08             	mov    0x8(%ebp),%eax
80106edf:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106ee3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106ee7:	89 c2                	mov    %eax,%edx
80106ee9:	ec                   	in     (%dx),%al
80106eea:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106eed:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106ef1:	c9                   	leave  
80106ef2:	c3                   	ret    

80106ef3 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106ef3:	55                   	push   %ebp
80106ef4:	89 e5                	mov    %esp,%ebp
80106ef6:	83 ec 08             	sub    $0x8,%esp
80106ef9:	8b 55 08             	mov    0x8(%ebp),%edx
80106efc:	8b 45 0c             	mov    0xc(%ebp),%eax
80106eff:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106f03:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106f06:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106f0a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106f0e:	ee                   	out    %al,(%dx)
}
80106f0f:	90                   	nop
80106f10:	c9                   	leave  
80106f11:	c3                   	ret    

80106f12 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106f12:	55                   	push   %ebp
80106f13:	89 e5                	mov    %esp,%ebp
80106f15:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106f18:	6a 00                	push   $0x0
80106f1a:	68 fa 03 00 00       	push   $0x3fa
80106f1f:	e8 cf ff ff ff       	call   80106ef3 <outb>
80106f24:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106f27:	68 80 00 00 00       	push   $0x80
80106f2c:	68 fb 03 00 00       	push   $0x3fb
80106f31:	e8 bd ff ff ff       	call   80106ef3 <outb>
80106f36:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80106f39:	6a 0c                	push   $0xc
80106f3b:	68 f8 03 00 00       	push   $0x3f8
80106f40:	e8 ae ff ff ff       	call   80106ef3 <outb>
80106f45:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80106f48:	6a 00                	push   $0x0
80106f4a:	68 f9 03 00 00       	push   $0x3f9
80106f4f:	e8 9f ff ff ff       	call   80106ef3 <outb>
80106f54:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106f57:	6a 03                	push   $0x3
80106f59:	68 fb 03 00 00       	push   $0x3fb
80106f5e:	e8 90 ff ff ff       	call   80106ef3 <outb>
80106f63:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106f66:	6a 00                	push   $0x0
80106f68:	68 fc 03 00 00       	push   $0x3fc
80106f6d:	e8 81 ff ff ff       	call   80106ef3 <outb>
80106f72:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106f75:	6a 01                	push   $0x1
80106f77:	68 f9 03 00 00       	push   $0x3f9
80106f7c:	e8 72 ff ff ff       	call   80106ef3 <outb>
80106f81:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106f84:	68 fd 03 00 00       	push   $0x3fd
80106f89:	e8 48 ff ff ff       	call   80106ed6 <inb>
80106f8e:	83 c4 04             	add    $0x4,%esp
80106f91:	3c ff                	cmp    $0xff,%al
80106f93:	74 6e                	je     80107003 <uartinit+0xf1>
    return;
  uart = 1;
80106f95:	c7 05 48 c6 10 80 01 	movl   $0x1,0x8010c648
80106f9c:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106f9f:	68 fa 03 00 00       	push   $0x3fa
80106fa4:	e8 2d ff ff ff       	call   80106ed6 <inb>
80106fa9:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80106fac:	68 f8 03 00 00       	push   $0x3f8
80106fb1:	e8 20 ff ff ff       	call   80106ed6 <inb>
80106fb6:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80106fb9:	83 ec 0c             	sub    $0xc,%esp
80106fbc:	6a 04                	push   $0x4
80106fbe:	e8 14 cf ff ff       	call   80103ed7 <picenable>
80106fc3:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80106fc6:	83 ec 08             	sub    $0x8,%esp
80106fc9:	6a 00                	push   $0x0
80106fcb:	6a 04                	push   $0x4
80106fcd:	e8 79 bb ff ff       	call   80102b4b <ioapicenable>
80106fd2:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106fd5:	c7 45 f4 70 90 10 80 	movl   $0x80109070,-0xc(%ebp)
80106fdc:	eb 19                	jmp    80106ff7 <uartinit+0xe5>
    uartputc(*p);
80106fde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fe1:	0f b6 00             	movzbl (%eax),%eax
80106fe4:	0f be c0             	movsbl %al,%eax
80106fe7:	83 ec 0c             	sub    $0xc,%esp
80106fea:	50                   	push   %eax
80106feb:	e8 16 00 00 00       	call   80107006 <uartputc>
80106ff0:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106ff3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106ff7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ffa:	0f b6 00             	movzbl (%eax),%eax
80106ffd:	84 c0                	test   %al,%al
80106fff:	75 dd                	jne    80106fde <uartinit+0xcc>
80107001:	eb 01                	jmp    80107004 <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80107003:	90                   	nop
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80107004:	c9                   	leave  
80107005:	c3                   	ret    

80107006 <uartputc>:

void
uartputc(int c)
{
80107006:	55                   	push   %ebp
80107007:	89 e5                	mov    %esp,%ebp
80107009:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
8010700c:	a1 48 c6 10 80       	mov    0x8010c648,%eax
80107011:	85 c0                	test   %eax,%eax
80107013:	74 53                	je     80107068 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107015:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010701c:	eb 11                	jmp    8010702f <uartputc+0x29>
    microdelay(10);
8010701e:	83 ec 0c             	sub    $0xc,%esp
80107021:	6a 0a                	push   $0xa
80107023:	e8 be c0 ff ff       	call   801030e6 <microdelay>
80107028:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010702b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010702f:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107033:	7f 1a                	jg     8010704f <uartputc+0x49>
80107035:	83 ec 0c             	sub    $0xc,%esp
80107038:	68 fd 03 00 00       	push   $0x3fd
8010703d:	e8 94 fe ff ff       	call   80106ed6 <inb>
80107042:	83 c4 10             	add    $0x10,%esp
80107045:	0f b6 c0             	movzbl %al,%eax
80107048:	83 e0 20             	and    $0x20,%eax
8010704b:	85 c0                	test   %eax,%eax
8010704d:	74 cf                	je     8010701e <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
8010704f:	8b 45 08             	mov    0x8(%ebp),%eax
80107052:	0f b6 c0             	movzbl %al,%eax
80107055:	83 ec 08             	sub    $0x8,%esp
80107058:	50                   	push   %eax
80107059:	68 f8 03 00 00       	push   $0x3f8
8010705e:	e8 90 fe ff ff       	call   80106ef3 <outb>
80107063:	83 c4 10             	add    $0x10,%esp
80107066:	eb 01                	jmp    80107069 <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80107068:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80107069:	c9                   	leave  
8010706a:	c3                   	ret    

8010706b <uartgetc>:

static int
uartgetc(void)
{
8010706b:	55                   	push   %ebp
8010706c:	89 e5                	mov    %esp,%ebp
  if(!uart)
8010706e:	a1 48 c6 10 80       	mov    0x8010c648,%eax
80107073:	85 c0                	test   %eax,%eax
80107075:	75 07                	jne    8010707e <uartgetc+0x13>
    return -1;
80107077:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010707c:	eb 2e                	jmp    801070ac <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
8010707e:	68 fd 03 00 00       	push   $0x3fd
80107083:	e8 4e fe ff ff       	call   80106ed6 <inb>
80107088:	83 c4 04             	add    $0x4,%esp
8010708b:	0f b6 c0             	movzbl %al,%eax
8010708e:	83 e0 01             	and    $0x1,%eax
80107091:	85 c0                	test   %eax,%eax
80107093:	75 07                	jne    8010709c <uartgetc+0x31>
    return -1;
80107095:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010709a:	eb 10                	jmp    801070ac <uartgetc+0x41>
  return inb(COM1+0);
8010709c:	68 f8 03 00 00       	push   $0x3f8
801070a1:	e8 30 fe ff ff       	call   80106ed6 <inb>
801070a6:	83 c4 04             	add    $0x4,%esp
801070a9:	0f b6 c0             	movzbl %al,%eax
}
801070ac:	c9                   	leave  
801070ad:	c3                   	ret    

801070ae <uartintr>:

void
uartintr(void)
{
801070ae:	55                   	push   %ebp
801070af:	89 e5                	mov    %esp,%ebp
801070b1:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
801070b4:	83 ec 0c             	sub    $0xc,%esp
801070b7:	68 6b 70 10 80       	push   $0x8010706b
801070bc:	e8 72 97 ff ff       	call   80100833 <consoleintr>
801070c1:	83 c4 10             	add    $0x10,%esp
}
801070c4:	90                   	nop
801070c5:	c9                   	leave  
801070c6:	c3                   	ret    

801070c7 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $0
801070c9:	6a 00                	push   $0x0
  jmp alltraps
801070cb:	e9 ac f7 ff ff       	jmp    8010687c <alltraps>

801070d0 <vector1>:
.globl vector1
vector1:
  pushl $0
801070d0:	6a 00                	push   $0x0
  pushl $1
801070d2:	6a 01                	push   $0x1
  jmp alltraps
801070d4:	e9 a3 f7 ff ff       	jmp    8010687c <alltraps>

801070d9 <vector2>:
.globl vector2
vector2:
  pushl $0
801070d9:	6a 00                	push   $0x0
  pushl $2
801070db:	6a 02                	push   $0x2
  jmp alltraps
801070dd:	e9 9a f7 ff ff       	jmp    8010687c <alltraps>

801070e2 <vector3>:
.globl vector3
vector3:
  pushl $0
801070e2:	6a 00                	push   $0x0
  pushl $3
801070e4:	6a 03                	push   $0x3
  jmp alltraps
801070e6:	e9 91 f7 ff ff       	jmp    8010687c <alltraps>

801070eb <vector4>:
.globl vector4
vector4:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $4
801070ed:	6a 04                	push   $0x4
  jmp alltraps
801070ef:	e9 88 f7 ff ff       	jmp    8010687c <alltraps>

801070f4 <vector5>:
.globl vector5
vector5:
  pushl $0
801070f4:	6a 00                	push   $0x0
  pushl $5
801070f6:	6a 05                	push   $0x5
  jmp alltraps
801070f8:	e9 7f f7 ff ff       	jmp    8010687c <alltraps>

801070fd <vector6>:
.globl vector6
vector6:
  pushl $0
801070fd:	6a 00                	push   $0x0
  pushl $6
801070ff:	6a 06                	push   $0x6
  jmp alltraps
80107101:	e9 76 f7 ff ff       	jmp    8010687c <alltraps>

80107106 <vector7>:
.globl vector7
vector7:
  pushl $0
80107106:	6a 00                	push   $0x0
  pushl $7
80107108:	6a 07                	push   $0x7
  jmp alltraps
8010710a:	e9 6d f7 ff ff       	jmp    8010687c <alltraps>

8010710f <vector8>:
.globl vector8
vector8:
  pushl $8
8010710f:	6a 08                	push   $0x8
  jmp alltraps
80107111:	e9 66 f7 ff ff       	jmp    8010687c <alltraps>

80107116 <vector9>:
.globl vector9
vector9:
  pushl $0
80107116:	6a 00                	push   $0x0
  pushl $9
80107118:	6a 09                	push   $0x9
  jmp alltraps
8010711a:	e9 5d f7 ff ff       	jmp    8010687c <alltraps>

8010711f <vector10>:
.globl vector10
vector10:
  pushl $10
8010711f:	6a 0a                	push   $0xa
  jmp alltraps
80107121:	e9 56 f7 ff ff       	jmp    8010687c <alltraps>

80107126 <vector11>:
.globl vector11
vector11:
  pushl $11
80107126:	6a 0b                	push   $0xb
  jmp alltraps
80107128:	e9 4f f7 ff ff       	jmp    8010687c <alltraps>

8010712d <vector12>:
.globl vector12
vector12:
  pushl $12
8010712d:	6a 0c                	push   $0xc
  jmp alltraps
8010712f:	e9 48 f7 ff ff       	jmp    8010687c <alltraps>

80107134 <vector13>:
.globl vector13
vector13:
  pushl $13
80107134:	6a 0d                	push   $0xd
  jmp alltraps
80107136:	e9 41 f7 ff ff       	jmp    8010687c <alltraps>

8010713b <vector14>:
.globl vector14
vector14:
  pushl $14
8010713b:	6a 0e                	push   $0xe
  jmp alltraps
8010713d:	e9 3a f7 ff ff       	jmp    8010687c <alltraps>

80107142 <vector15>:
.globl vector15
vector15:
  pushl $0
80107142:	6a 00                	push   $0x0
  pushl $15
80107144:	6a 0f                	push   $0xf
  jmp alltraps
80107146:	e9 31 f7 ff ff       	jmp    8010687c <alltraps>

8010714b <vector16>:
.globl vector16
vector16:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $16
8010714d:	6a 10                	push   $0x10
  jmp alltraps
8010714f:	e9 28 f7 ff ff       	jmp    8010687c <alltraps>

80107154 <vector17>:
.globl vector17
vector17:
  pushl $17
80107154:	6a 11                	push   $0x11
  jmp alltraps
80107156:	e9 21 f7 ff ff       	jmp    8010687c <alltraps>

8010715b <vector18>:
.globl vector18
vector18:
  pushl $0
8010715b:	6a 00                	push   $0x0
  pushl $18
8010715d:	6a 12                	push   $0x12
  jmp alltraps
8010715f:	e9 18 f7 ff ff       	jmp    8010687c <alltraps>

80107164 <vector19>:
.globl vector19
vector19:
  pushl $0
80107164:	6a 00                	push   $0x0
  pushl $19
80107166:	6a 13                	push   $0x13
  jmp alltraps
80107168:	e9 0f f7 ff ff       	jmp    8010687c <alltraps>

8010716d <vector20>:
.globl vector20
vector20:
  pushl $0
8010716d:	6a 00                	push   $0x0
  pushl $20
8010716f:	6a 14                	push   $0x14
  jmp alltraps
80107171:	e9 06 f7 ff ff       	jmp    8010687c <alltraps>

80107176 <vector21>:
.globl vector21
vector21:
  pushl $0
80107176:	6a 00                	push   $0x0
  pushl $21
80107178:	6a 15                	push   $0x15
  jmp alltraps
8010717a:	e9 fd f6 ff ff       	jmp    8010687c <alltraps>

8010717f <vector22>:
.globl vector22
vector22:
  pushl $0
8010717f:	6a 00                	push   $0x0
  pushl $22
80107181:	6a 16                	push   $0x16
  jmp alltraps
80107183:	e9 f4 f6 ff ff       	jmp    8010687c <alltraps>

80107188 <vector23>:
.globl vector23
vector23:
  pushl $0
80107188:	6a 00                	push   $0x0
  pushl $23
8010718a:	6a 17                	push   $0x17
  jmp alltraps
8010718c:	e9 eb f6 ff ff       	jmp    8010687c <alltraps>

80107191 <vector24>:
.globl vector24
vector24:
  pushl $0
80107191:	6a 00                	push   $0x0
  pushl $24
80107193:	6a 18                	push   $0x18
  jmp alltraps
80107195:	e9 e2 f6 ff ff       	jmp    8010687c <alltraps>

8010719a <vector25>:
.globl vector25
vector25:
  pushl $0
8010719a:	6a 00                	push   $0x0
  pushl $25
8010719c:	6a 19                	push   $0x19
  jmp alltraps
8010719e:	e9 d9 f6 ff ff       	jmp    8010687c <alltraps>

801071a3 <vector26>:
.globl vector26
vector26:
  pushl $0
801071a3:	6a 00                	push   $0x0
  pushl $26
801071a5:	6a 1a                	push   $0x1a
  jmp alltraps
801071a7:	e9 d0 f6 ff ff       	jmp    8010687c <alltraps>

801071ac <vector27>:
.globl vector27
vector27:
  pushl $0
801071ac:	6a 00                	push   $0x0
  pushl $27
801071ae:	6a 1b                	push   $0x1b
  jmp alltraps
801071b0:	e9 c7 f6 ff ff       	jmp    8010687c <alltraps>

801071b5 <vector28>:
.globl vector28
vector28:
  pushl $0
801071b5:	6a 00                	push   $0x0
  pushl $28
801071b7:	6a 1c                	push   $0x1c
  jmp alltraps
801071b9:	e9 be f6 ff ff       	jmp    8010687c <alltraps>

801071be <vector29>:
.globl vector29
vector29:
  pushl $0
801071be:	6a 00                	push   $0x0
  pushl $29
801071c0:	6a 1d                	push   $0x1d
  jmp alltraps
801071c2:	e9 b5 f6 ff ff       	jmp    8010687c <alltraps>

801071c7 <vector30>:
.globl vector30
vector30:
  pushl $0
801071c7:	6a 00                	push   $0x0
  pushl $30
801071c9:	6a 1e                	push   $0x1e
  jmp alltraps
801071cb:	e9 ac f6 ff ff       	jmp    8010687c <alltraps>

801071d0 <vector31>:
.globl vector31
vector31:
  pushl $0
801071d0:	6a 00                	push   $0x0
  pushl $31
801071d2:	6a 1f                	push   $0x1f
  jmp alltraps
801071d4:	e9 a3 f6 ff ff       	jmp    8010687c <alltraps>

801071d9 <vector32>:
.globl vector32
vector32:
  pushl $0
801071d9:	6a 00                	push   $0x0
  pushl $32
801071db:	6a 20                	push   $0x20
  jmp alltraps
801071dd:	e9 9a f6 ff ff       	jmp    8010687c <alltraps>

801071e2 <vector33>:
.globl vector33
vector33:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $33
801071e4:	6a 21                	push   $0x21
  jmp alltraps
801071e6:	e9 91 f6 ff ff       	jmp    8010687c <alltraps>

801071eb <vector34>:
.globl vector34
vector34:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $34
801071ed:	6a 22                	push   $0x22
  jmp alltraps
801071ef:	e9 88 f6 ff ff       	jmp    8010687c <alltraps>

801071f4 <vector35>:
.globl vector35
vector35:
  pushl $0
801071f4:	6a 00                	push   $0x0
  pushl $35
801071f6:	6a 23                	push   $0x23
  jmp alltraps
801071f8:	e9 7f f6 ff ff       	jmp    8010687c <alltraps>

801071fd <vector36>:
.globl vector36
vector36:
  pushl $0
801071fd:	6a 00                	push   $0x0
  pushl $36
801071ff:	6a 24                	push   $0x24
  jmp alltraps
80107201:	e9 76 f6 ff ff       	jmp    8010687c <alltraps>

80107206 <vector37>:
.globl vector37
vector37:
  pushl $0
80107206:	6a 00                	push   $0x0
  pushl $37
80107208:	6a 25                	push   $0x25
  jmp alltraps
8010720a:	e9 6d f6 ff ff       	jmp    8010687c <alltraps>

8010720f <vector38>:
.globl vector38
vector38:
  pushl $0
8010720f:	6a 00                	push   $0x0
  pushl $38
80107211:	6a 26                	push   $0x26
  jmp alltraps
80107213:	e9 64 f6 ff ff       	jmp    8010687c <alltraps>

80107218 <vector39>:
.globl vector39
vector39:
  pushl $0
80107218:	6a 00                	push   $0x0
  pushl $39
8010721a:	6a 27                	push   $0x27
  jmp alltraps
8010721c:	e9 5b f6 ff ff       	jmp    8010687c <alltraps>

80107221 <vector40>:
.globl vector40
vector40:
  pushl $0
80107221:	6a 00                	push   $0x0
  pushl $40
80107223:	6a 28                	push   $0x28
  jmp alltraps
80107225:	e9 52 f6 ff ff       	jmp    8010687c <alltraps>

8010722a <vector41>:
.globl vector41
vector41:
  pushl $0
8010722a:	6a 00                	push   $0x0
  pushl $41
8010722c:	6a 29                	push   $0x29
  jmp alltraps
8010722e:	e9 49 f6 ff ff       	jmp    8010687c <alltraps>

80107233 <vector42>:
.globl vector42
vector42:
  pushl $0
80107233:	6a 00                	push   $0x0
  pushl $42
80107235:	6a 2a                	push   $0x2a
  jmp alltraps
80107237:	e9 40 f6 ff ff       	jmp    8010687c <alltraps>

8010723c <vector43>:
.globl vector43
vector43:
  pushl $0
8010723c:	6a 00                	push   $0x0
  pushl $43
8010723e:	6a 2b                	push   $0x2b
  jmp alltraps
80107240:	e9 37 f6 ff ff       	jmp    8010687c <alltraps>

80107245 <vector44>:
.globl vector44
vector44:
  pushl $0
80107245:	6a 00                	push   $0x0
  pushl $44
80107247:	6a 2c                	push   $0x2c
  jmp alltraps
80107249:	e9 2e f6 ff ff       	jmp    8010687c <alltraps>

8010724e <vector45>:
.globl vector45
vector45:
  pushl $0
8010724e:	6a 00                	push   $0x0
  pushl $45
80107250:	6a 2d                	push   $0x2d
  jmp alltraps
80107252:	e9 25 f6 ff ff       	jmp    8010687c <alltraps>

80107257 <vector46>:
.globl vector46
vector46:
  pushl $0
80107257:	6a 00                	push   $0x0
  pushl $46
80107259:	6a 2e                	push   $0x2e
  jmp alltraps
8010725b:	e9 1c f6 ff ff       	jmp    8010687c <alltraps>

80107260 <vector47>:
.globl vector47
vector47:
  pushl $0
80107260:	6a 00                	push   $0x0
  pushl $47
80107262:	6a 2f                	push   $0x2f
  jmp alltraps
80107264:	e9 13 f6 ff ff       	jmp    8010687c <alltraps>

80107269 <vector48>:
.globl vector48
vector48:
  pushl $0
80107269:	6a 00                	push   $0x0
  pushl $48
8010726b:	6a 30                	push   $0x30
  jmp alltraps
8010726d:	e9 0a f6 ff ff       	jmp    8010687c <alltraps>

80107272 <vector49>:
.globl vector49
vector49:
  pushl $0
80107272:	6a 00                	push   $0x0
  pushl $49
80107274:	6a 31                	push   $0x31
  jmp alltraps
80107276:	e9 01 f6 ff ff       	jmp    8010687c <alltraps>

8010727b <vector50>:
.globl vector50
vector50:
  pushl $0
8010727b:	6a 00                	push   $0x0
  pushl $50
8010727d:	6a 32                	push   $0x32
  jmp alltraps
8010727f:	e9 f8 f5 ff ff       	jmp    8010687c <alltraps>

80107284 <vector51>:
.globl vector51
vector51:
  pushl $0
80107284:	6a 00                	push   $0x0
  pushl $51
80107286:	6a 33                	push   $0x33
  jmp alltraps
80107288:	e9 ef f5 ff ff       	jmp    8010687c <alltraps>

8010728d <vector52>:
.globl vector52
vector52:
  pushl $0
8010728d:	6a 00                	push   $0x0
  pushl $52
8010728f:	6a 34                	push   $0x34
  jmp alltraps
80107291:	e9 e6 f5 ff ff       	jmp    8010687c <alltraps>

80107296 <vector53>:
.globl vector53
vector53:
  pushl $0
80107296:	6a 00                	push   $0x0
  pushl $53
80107298:	6a 35                	push   $0x35
  jmp alltraps
8010729a:	e9 dd f5 ff ff       	jmp    8010687c <alltraps>

8010729f <vector54>:
.globl vector54
vector54:
  pushl $0
8010729f:	6a 00                	push   $0x0
  pushl $54
801072a1:	6a 36                	push   $0x36
  jmp alltraps
801072a3:	e9 d4 f5 ff ff       	jmp    8010687c <alltraps>

801072a8 <vector55>:
.globl vector55
vector55:
  pushl $0
801072a8:	6a 00                	push   $0x0
  pushl $55
801072aa:	6a 37                	push   $0x37
  jmp alltraps
801072ac:	e9 cb f5 ff ff       	jmp    8010687c <alltraps>

801072b1 <vector56>:
.globl vector56
vector56:
  pushl $0
801072b1:	6a 00                	push   $0x0
  pushl $56
801072b3:	6a 38                	push   $0x38
  jmp alltraps
801072b5:	e9 c2 f5 ff ff       	jmp    8010687c <alltraps>

801072ba <vector57>:
.globl vector57
vector57:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $57
801072bc:	6a 39                	push   $0x39
  jmp alltraps
801072be:	e9 b9 f5 ff ff       	jmp    8010687c <alltraps>

801072c3 <vector58>:
.globl vector58
vector58:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $58
801072c5:	6a 3a                	push   $0x3a
  jmp alltraps
801072c7:	e9 b0 f5 ff ff       	jmp    8010687c <alltraps>

801072cc <vector59>:
.globl vector59
vector59:
  pushl $0
801072cc:	6a 00                	push   $0x0
  pushl $59
801072ce:	6a 3b                	push   $0x3b
  jmp alltraps
801072d0:	e9 a7 f5 ff ff       	jmp    8010687c <alltraps>

801072d5 <vector60>:
.globl vector60
vector60:
  pushl $0
801072d5:	6a 00                	push   $0x0
  pushl $60
801072d7:	6a 3c                	push   $0x3c
  jmp alltraps
801072d9:	e9 9e f5 ff ff       	jmp    8010687c <alltraps>

801072de <vector61>:
.globl vector61
vector61:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $61
801072e0:	6a 3d                	push   $0x3d
  jmp alltraps
801072e2:	e9 95 f5 ff ff       	jmp    8010687c <alltraps>

801072e7 <vector62>:
.globl vector62
vector62:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $62
801072e9:	6a 3e                	push   $0x3e
  jmp alltraps
801072eb:	e9 8c f5 ff ff       	jmp    8010687c <alltraps>

801072f0 <vector63>:
.globl vector63
vector63:
  pushl $0
801072f0:	6a 00                	push   $0x0
  pushl $63
801072f2:	6a 3f                	push   $0x3f
  jmp alltraps
801072f4:	e9 83 f5 ff ff       	jmp    8010687c <alltraps>

801072f9 <vector64>:
.globl vector64
vector64:
  pushl $0
801072f9:	6a 00                	push   $0x0
  pushl $64
801072fb:	6a 40                	push   $0x40
  jmp alltraps
801072fd:	e9 7a f5 ff ff       	jmp    8010687c <alltraps>

80107302 <vector65>:
.globl vector65
vector65:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $65
80107304:	6a 41                	push   $0x41
  jmp alltraps
80107306:	e9 71 f5 ff ff       	jmp    8010687c <alltraps>

8010730b <vector66>:
.globl vector66
vector66:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $66
8010730d:	6a 42                	push   $0x42
  jmp alltraps
8010730f:	e9 68 f5 ff ff       	jmp    8010687c <alltraps>

80107314 <vector67>:
.globl vector67
vector67:
  pushl $0
80107314:	6a 00                	push   $0x0
  pushl $67
80107316:	6a 43                	push   $0x43
  jmp alltraps
80107318:	e9 5f f5 ff ff       	jmp    8010687c <alltraps>

8010731d <vector68>:
.globl vector68
vector68:
  pushl $0
8010731d:	6a 00                	push   $0x0
  pushl $68
8010731f:	6a 44                	push   $0x44
  jmp alltraps
80107321:	e9 56 f5 ff ff       	jmp    8010687c <alltraps>

80107326 <vector69>:
.globl vector69
vector69:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $69
80107328:	6a 45                	push   $0x45
  jmp alltraps
8010732a:	e9 4d f5 ff ff       	jmp    8010687c <alltraps>

8010732f <vector70>:
.globl vector70
vector70:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $70
80107331:	6a 46                	push   $0x46
  jmp alltraps
80107333:	e9 44 f5 ff ff       	jmp    8010687c <alltraps>

80107338 <vector71>:
.globl vector71
vector71:
  pushl $0
80107338:	6a 00                	push   $0x0
  pushl $71
8010733a:	6a 47                	push   $0x47
  jmp alltraps
8010733c:	e9 3b f5 ff ff       	jmp    8010687c <alltraps>

80107341 <vector72>:
.globl vector72
vector72:
  pushl $0
80107341:	6a 00                	push   $0x0
  pushl $72
80107343:	6a 48                	push   $0x48
  jmp alltraps
80107345:	e9 32 f5 ff ff       	jmp    8010687c <alltraps>

8010734a <vector73>:
.globl vector73
vector73:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $73
8010734c:	6a 49                	push   $0x49
  jmp alltraps
8010734e:	e9 29 f5 ff ff       	jmp    8010687c <alltraps>

80107353 <vector74>:
.globl vector74
vector74:
  pushl $0
80107353:	6a 00                	push   $0x0
  pushl $74
80107355:	6a 4a                	push   $0x4a
  jmp alltraps
80107357:	e9 20 f5 ff ff       	jmp    8010687c <alltraps>

8010735c <vector75>:
.globl vector75
vector75:
  pushl $0
8010735c:	6a 00                	push   $0x0
  pushl $75
8010735e:	6a 4b                	push   $0x4b
  jmp alltraps
80107360:	e9 17 f5 ff ff       	jmp    8010687c <alltraps>

80107365 <vector76>:
.globl vector76
vector76:
  pushl $0
80107365:	6a 00                	push   $0x0
  pushl $76
80107367:	6a 4c                	push   $0x4c
  jmp alltraps
80107369:	e9 0e f5 ff ff       	jmp    8010687c <alltraps>

8010736e <vector77>:
.globl vector77
vector77:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $77
80107370:	6a 4d                	push   $0x4d
  jmp alltraps
80107372:	e9 05 f5 ff ff       	jmp    8010687c <alltraps>

80107377 <vector78>:
.globl vector78
vector78:
  pushl $0
80107377:	6a 00                	push   $0x0
  pushl $78
80107379:	6a 4e                	push   $0x4e
  jmp alltraps
8010737b:	e9 fc f4 ff ff       	jmp    8010687c <alltraps>

80107380 <vector79>:
.globl vector79
vector79:
  pushl $0
80107380:	6a 00                	push   $0x0
  pushl $79
80107382:	6a 4f                	push   $0x4f
  jmp alltraps
80107384:	e9 f3 f4 ff ff       	jmp    8010687c <alltraps>

80107389 <vector80>:
.globl vector80
vector80:
  pushl $0
80107389:	6a 00                	push   $0x0
  pushl $80
8010738b:	6a 50                	push   $0x50
  jmp alltraps
8010738d:	e9 ea f4 ff ff       	jmp    8010687c <alltraps>

80107392 <vector81>:
.globl vector81
vector81:
  pushl $0
80107392:	6a 00                	push   $0x0
  pushl $81
80107394:	6a 51                	push   $0x51
  jmp alltraps
80107396:	e9 e1 f4 ff ff       	jmp    8010687c <alltraps>

8010739b <vector82>:
.globl vector82
vector82:
  pushl $0
8010739b:	6a 00                	push   $0x0
  pushl $82
8010739d:	6a 52                	push   $0x52
  jmp alltraps
8010739f:	e9 d8 f4 ff ff       	jmp    8010687c <alltraps>

801073a4 <vector83>:
.globl vector83
vector83:
  pushl $0
801073a4:	6a 00                	push   $0x0
  pushl $83
801073a6:	6a 53                	push   $0x53
  jmp alltraps
801073a8:	e9 cf f4 ff ff       	jmp    8010687c <alltraps>

801073ad <vector84>:
.globl vector84
vector84:
  pushl $0
801073ad:	6a 00                	push   $0x0
  pushl $84
801073af:	6a 54                	push   $0x54
  jmp alltraps
801073b1:	e9 c6 f4 ff ff       	jmp    8010687c <alltraps>

801073b6 <vector85>:
.globl vector85
vector85:
  pushl $0
801073b6:	6a 00                	push   $0x0
  pushl $85
801073b8:	6a 55                	push   $0x55
  jmp alltraps
801073ba:	e9 bd f4 ff ff       	jmp    8010687c <alltraps>

801073bf <vector86>:
.globl vector86
vector86:
  pushl $0
801073bf:	6a 00                	push   $0x0
  pushl $86
801073c1:	6a 56                	push   $0x56
  jmp alltraps
801073c3:	e9 b4 f4 ff ff       	jmp    8010687c <alltraps>

801073c8 <vector87>:
.globl vector87
vector87:
  pushl $0
801073c8:	6a 00                	push   $0x0
  pushl $87
801073ca:	6a 57                	push   $0x57
  jmp alltraps
801073cc:	e9 ab f4 ff ff       	jmp    8010687c <alltraps>

801073d1 <vector88>:
.globl vector88
vector88:
  pushl $0
801073d1:	6a 00                	push   $0x0
  pushl $88
801073d3:	6a 58                	push   $0x58
  jmp alltraps
801073d5:	e9 a2 f4 ff ff       	jmp    8010687c <alltraps>

801073da <vector89>:
.globl vector89
vector89:
  pushl $0
801073da:	6a 00                	push   $0x0
  pushl $89
801073dc:	6a 59                	push   $0x59
  jmp alltraps
801073de:	e9 99 f4 ff ff       	jmp    8010687c <alltraps>

801073e3 <vector90>:
.globl vector90
vector90:
  pushl $0
801073e3:	6a 00                	push   $0x0
  pushl $90
801073e5:	6a 5a                	push   $0x5a
  jmp alltraps
801073e7:	e9 90 f4 ff ff       	jmp    8010687c <alltraps>

801073ec <vector91>:
.globl vector91
vector91:
  pushl $0
801073ec:	6a 00                	push   $0x0
  pushl $91
801073ee:	6a 5b                	push   $0x5b
  jmp alltraps
801073f0:	e9 87 f4 ff ff       	jmp    8010687c <alltraps>

801073f5 <vector92>:
.globl vector92
vector92:
  pushl $0
801073f5:	6a 00                	push   $0x0
  pushl $92
801073f7:	6a 5c                	push   $0x5c
  jmp alltraps
801073f9:	e9 7e f4 ff ff       	jmp    8010687c <alltraps>

801073fe <vector93>:
.globl vector93
vector93:
  pushl $0
801073fe:	6a 00                	push   $0x0
  pushl $93
80107400:	6a 5d                	push   $0x5d
  jmp alltraps
80107402:	e9 75 f4 ff ff       	jmp    8010687c <alltraps>

80107407 <vector94>:
.globl vector94
vector94:
  pushl $0
80107407:	6a 00                	push   $0x0
  pushl $94
80107409:	6a 5e                	push   $0x5e
  jmp alltraps
8010740b:	e9 6c f4 ff ff       	jmp    8010687c <alltraps>

80107410 <vector95>:
.globl vector95
vector95:
  pushl $0
80107410:	6a 00                	push   $0x0
  pushl $95
80107412:	6a 5f                	push   $0x5f
  jmp alltraps
80107414:	e9 63 f4 ff ff       	jmp    8010687c <alltraps>

80107419 <vector96>:
.globl vector96
vector96:
  pushl $0
80107419:	6a 00                	push   $0x0
  pushl $96
8010741b:	6a 60                	push   $0x60
  jmp alltraps
8010741d:	e9 5a f4 ff ff       	jmp    8010687c <alltraps>

80107422 <vector97>:
.globl vector97
vector97:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $97
80107424:	6a 61                	push   $0x61
  jmp alltraps
80107426:	e9 51 f4 ff ff       	jmp    8010687c <alltraps>

8010742b <vector98>:
.globl vector98
vector98:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $98
8010742d:	6a 62                	push   $0x62
  jmp alltraps
8010742f:	e9 48 f4 ff ff       	jmp    8010687c <alltraps>

80107434 <vector99>:
.globl vector99
vector99:
  pushl $0
80107434:	6a 00                	push   $0x0
  pushl $99
80107436:	6a 63                	push   $0x63
  jmp alltraps
80107438:	e9 3f f4 ff ff       	jmp    8010687c <alltraps>

8010743d <vector100>:
.globl vector100
vector100:
  pushl $0
8010743d:	6a 00                	push   $0x0
  pushl $100
8010743f:	6a 64                	push   $0x64
  jmp alltraps
80107441:	e9 36 f4 ff ff       	jmp    8010687c <alltraps>

80107446 <vector101>:
.globl vector101
vector101:
  pushl $0
80107446:	6a 00                	push   $0x0
  pushl $101
80107448:	6a 65                	push   $0x65
  jmp alltraps
8010744a:	e9 2d f4 ff ff       	jmp    8010687c <alltraps>

8010744f <vector102>:
.globl vector102
vector102:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $102
80107451:	6a 66                	push   $0x66
  jmp alltraps
80107453:	e9 24 f4 ff ff       	jmp    8010687c <alltraps>

80107458 <vector103>:
.globl vector103
vector103:
  pushl $0
80107458:	6a 00                	push   $0x0
  pushl $103
8010745a:	6a 67                	push   $0x67
  jmp alltraps
8010745c:	e9 1b f4 ff ff       	jmp    8010687c <alltraps>

80107461 <vector104>:
.globl vector104
vector104:
  pushl $0
80107461:	6a 00                	push   $0x0
  pushl $104
80107463:	6a 68                	push   $0x68
  jmp alltraps
80107465:	e9 12 f4 ff ff       	jmp    8010687c <alltraps>

8010746a <vector105>:
.globl vector105
vector105:
  pushl $0
8010746a:	6a 00                	push   $0x0
  pushl $105
8010746c:	6a 69                	push   $0x69
  jmp alltraps
8010746e:	e9 09 f4 ff ff       	jmp    8010687c <alltraps>

80107473 <vector106>:
.globl vector106
vector106:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $106
80107475:	6a 6a                	push   $0x6a
  jmp alltraps
80107477:	e9 00 f4 ff ff       	jmp    8010687c <alltraps>

8010747c <vector107>:
.globl vector107
vector107:
  pushl $0
8010747c:	6a 00                	push   $0x0
  pushl $107
8010747e:	6a 6b                	push   $0x6b
  jmp alltraps
80107480:	e9 f7 f3 ff ff       	jmp    8010687c <alltraps>

80107485 <vector108>:
.globl vector108
vector108:
  pushl $0
80107485:	6a 00                	push   $0x0
  pushl $108
80107487:	6a 6c                	push   $0x6c
  jmp alltraps
80107489:	e9 ee f3 ff ff       	jmp    8010687c <alltraps>

8010748e <vector109>:
.globl vector109
vector109:
  pushl $0
8010748e:	6a 00                	push   $0x0
  pushl $109
80107490:	6a 6d                	push   $0x6d
  jmp alltraps
80107492:	e9 e5 f3 ff ff       	jmp    8010687c <alltraps>

80107497 <vector110>:
.globl vector110
vector110:
  pushl $0
80107497:	6a 00                	push   $0x0
  pushl $110
80107499:	6a 6e                	push   $0x6e
  jmp alltraps
8010749b:	e9 dc f3 ff ff       	jmp    8010687c <alltraps>

801074a0 <vector111>:
.globl vector111
vector111:
  pushl $0
801074a0:	6a 00                	push   $0x0
  pushl $111
801074a2:	6a 6f                	push   $0x6f
  jmp alltraps
801074a4:	e9 d3 f3 ff ff       	jmp    8010687c <alltraps>

801074a9 <vector112>:
.globl vector112
vector112:
  pushl $0
801074a9:	6a 00                	push   $0x0
  pushl $112
801074ab:	6a 70                	push   $0x70
  jmp alltraps
801074ad:	e9 ca f3 ff ff       	jmp    8010687c <alltraps>

801074b2 <vector113>:
.globl vector113
vector113:
  pushl $0
801074b2:	6a 00                	push   $0x0
  pushl $113
801074b4:	6a 71                	push   $0x71
  jmp alltraps
801074b6:	e9 c1 f3 ff ff       	jmp    8010687c <alltraps>

801074bb <vector114>:
.globl vector114
vector114:
  pushl $0
801074bb:	6a 00                	push   $0x0
  pushl $114
801074bd:	6a 72                	push   $0x72
  jmp alltraps
801074bf:	e9 b8 f3 ff ff       	jmp    8010687c <alltraps>

801074c4 <vector115>:
.globl vector115
vector115:
  pushl $0
801074c4:	6a 00                	push   $0x0
  pushl $115
801074c6:	6a 73                	push   $0x73
  jmp alltraps
801074c8:	e9 af f3 ff ff       	jmp    8010687c <alltraps>

801074cd <vector116>:
.globl vector116
vector116:
  pushl $0
801074cd:	6a 00                	push   $0x0
  pushl $116
801074cf:	6a 74                	push   $0x74
  jmp alltraps
801074d1:	e9 a6 f3 ff ff       	jmp    8010687c <alltraps>

801074d6 <vector117>:
.globl vector117
vector117:
  pushl $0
801074d6:	6a 00                	push   $0x0
  pushl $117
801074d8:	6a 75                	push   $0x75
  jmp alltraps
801074da:	e9 9d f3 ff ff       	jmp    8010687c <alltraps>

801074df <vector118>:
.globl vector118
vector118:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $118
801074e1:	6a 76                	push   $0x76
  jmp alltraps
801074e3:	e9 94 f3 ff ff       	jmp    8010687c <alltraps>

801074e8 <vector119>:
.globl vector119
vector119:
  pushl $0
801074e8:	6a 00                	push   $0x0
  pushl $119
801074ea:	6a 77                	push   $0x77
  jmp alltraps
801074ec:	e9 8b f3 ff ff       	jmp    8010687c <alltraps>

801074f1 <vector120>:
.globl vector120
vector120:
  pushl $0
801074f1:	6a 00                	push   $0x0
  pushl $120
801074f3:	6a 78                	push   $0x78
  jmp alltraps
801074f5:	e9 82 f3 ff ff       	jmp    8010687c <alltraps>

801074fa <vector121>:
.globl vector121
vector121:
  pushl $0
801074fa:	6a 00                	push   $0x0
  pushl $121
801074fc:	6a 79                	push   $0x79
  jmp alltraps
801074fe:	e9 79 f3 ff ff       	jmp    8010687c <alltraps>

80107503 <vector122>:
.globl vector122
vector122:
  pushl $0
80107503:	6a 00                	push   $0x0
  pushl $122
80107505:	6a 7a                	push   $0x7a
  jmp alltraps
80107507:	e9 70 f3 ff ff       	jmp    8010687c <alltraps>

8010750c <vector123>:
.globl vector123
vector123:
  pushl $0
8010750c:	6a 00                	push   $0x0
  pushl $123
8010750e:	6a 7b                	push   $0x7b
  jmp alltraps
80107510:	e9 67 f3 ff ff       	jmp    8010687c <alltraps>

80107515 <vector124>:
.globl vector124
vector124:
  pushl $0
80107515:	6a 00                	push   $0x0
  pushl $124
80107517:	6a 7c                	push   $0x7c
  jmp alltraps
80107519:	e9 5e f3 ff ff       	jmp    8010687c <alltraps>

8010751e <vector125>:
.globl vector125
vector125:
  pushl $0
8010751e:	6a 00                	push   $0x0
  pushl $125
80107520:	6a 7d                	push   $0x7d
  jmp alltraps
80107522:	e9 55 f3 ff ff       	jmp    8010687c <alltraps>

80107527 <vector126>:
.globl vector126
vector126:
  pushl $0
80107527:	6a 00                	push   $0x0
  pushl $126
80107529:	6a 7e                	push   $0x7e
  jmp alltraps
8010752b:	e9 4c f3 ff ff       	jmp    8010687c <alltraps>

80107530 <vector127>:
.globl vector127
vector127:
  pushl $0
80107530:	6a 00                	push   $0x0
  pushl $127
80107532:	6a 7f                	push   $0x7f
  jmp alltraps
80107534:	e9 43 f3 ff ff       	jmp    8010687c <alltraps>

80107539 <vector128>:
.globl vector128
vector128:
  pushl $0
80107539:	6a 00                	push   $0x0
  pushl $128
8010753b:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107540:	e9 37 f3 ff ff       	jmp    8010687c <alltraps>

80107545 <vector129>:
.globl vector129
vector129:
  pushl $0
80107545:	6a 00                	push   $0x0
  pushl $129
80107547:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010754c:	e9 2b f3 ff ff       	jmp    8010687c <alltraps>

80107551 <vector130>:
.globl vector130
vector130:
  pushl $0
80107551:	6a 00                	push   $0x0
  pushl $130
80107553:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107558:	e9 1f f3 ff ff       	jmp    8010687c <alltraps>

8010755d <vector131>:
.globl vector131
vector131:
  pushl $0
8010755d:	6a 00                	push   $0x0
  pushl $131
8010755f:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107564:	e9 13 f3 ff ff       	jmp    8010687c <alltraps>

80107569 <vector132>:
.globl vector132
vector132:
  pushl $0
80107569:	6a 00                	push   $0x0
  pushl $132
8010756b:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107570:	e9 07 f3 ff ff       	jmp    8010687c <alltraps>

80107575 <vector133>:
.globl vector133
vector133:
  pushl $0
80107575:	6a 00                	push   $0x0
  pushl $133
80107577:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010757c:	e9 fb f2 ff ff       	jmp    8010687c <alltraps>

80107581 <vector134>:
.globl vector134
vector134:
  pushl $0
80107581:	6a 00                	push   $0x0
  pushl $134
80107583:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107588:	e9 ef f2 ff ff       	jmp    8010687c <alltraps>

8010758d <vector135>:
.globl vector135
vector135:
  pushl $0
8010758d:	6a 00                	push   $0x0
  pushl $135
8010758f:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107594:	e9 e3 f2 ff ff       	jmp    8010687c <alltraps>

80107599 <vector136>:
.globl vector136
vector136:
  pushl $0
80107599:	6a 00                	push   $0x0
  pushl $136
8010759b:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801075a0:	e9 d7 f2 ff ff       	jmp    8010687c <alltraps>

801075a5 <vector137>:
.globl vector137
vector137:
  pushl $0
801075a5:	6a 00                	push   $0x0
  pushl $137
801075a7:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801075ac:	e9 cb f2 ff ff       	jmp    8010687c <alltraps>

801075b1 <vector138>:
.globl vector138
vector138:
  pushl $0
801075b1:	6a 00                	push   $0x0
  pushl $138
801075b3:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801075b8:	e9 bf f2 ff ff       	jmp    8010687c <alltraps>

801075bd <vector139>:
.globl vector139
vector139:
  pushl $0
801075bd:	6a 00                	push   $0x0
  pushl $139
801075bf:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801075c4:	e9 b3 f2 ff ff       	jmp    8010687c <alltraps>

801075c9 <vector140>:
.globl vector140
vector140:
  pushl $0
801075c9:	6a 00                	push   $0x0
  pushl $140
801075cb:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801075d0:	e9 a7 f2 ff ff       	jmp    8010687c <alltraps>

801075d5 <vector141>:
.globl vector141
vector141:
  pushl $0
801075d5:	6a 00                	push   $0x0
  pushl $141
801075d7:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801075dc:	e9 9b f2 ff ff       	jmp    8010687c <alltraps>

801075e1 <vector142>:
.globl vector142
vector142:
  pushl $0
801075e1:	6a 00                	push   $0x0
  pushl $142
801075e3:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801075e8:	e9 8f f2 ff ff       	jmp    8010687c <alltraps>

801075ed <vector143>:
.globl vector143
vector143:
  pushl $0
801075ed:	6a 00                	push   $0x0
  pushl $143
801075ef:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801075f4:	e9 83 f2 ff ff       	jmp    8010687c <alltraps>

801075f9 <vector144>:
.globl vector144
vector144:
  pushl $0
801075f9:	6a 00                	push   $0x0
  pushl $144
801075fb:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107600:	e9 77 f2 ff ff       	jmp    8010687c <alltraps>

80107605 <vector145>:
.globl vector145
vector145:
  pushl $0
80107605:	6a 00                	push   $0x0
  pushl $145
80107607:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010760c:	e9 6b f2 ff ff       	jmp    8010687c <alltraps>

80107611 <vector146>:
.globl vector146
vector146:
  pushl $0
80107611:	6a 00                	push   $0x0
  pushl $146
80107613:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107618:	e9 5f f2 ff ff       	jmp    8010687c <alltraps>

8010761d <vector147>:
.globl vector147
vector147:
  pushl $0
8010761d:	6a 00                	push   $0x0
  pushl $147
8010761f:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107624:	e9 53 f2 ff ff       	jmp    8010687c <alltraps>

80107629 <vector148>:
.globl vector148
vector148:
  pushl $0
80107629:	6a 00                	push   $0x0
  pushl $148
8010762b:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107630:	e9 47 f2 ff ff       	jmp    8010687c <alltraps>

80107635 <vector149>:
.globl vector149
vector149:
  pushl $0
80107635:	6a 00                	push   $0x0
  pushl $149
80107637:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010763c:	e9 3b f2 ff ff       	jmp    8010687c <alltraps>

80107641 <vector150>:
.globl vector150
vector150:
  pushl $0
80107641:	6a 00                	push   $0x0
  pushl $150
80107643:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107648:	e9 2f f2 ff ff       	jmp    8010687c <alltraps>

8010764d <vector151>:
.globl vector151
vector151:
  pushl $0
8010764d:	6a 00                	push   $0x0
  pushl $151
8010764f:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107654:	e9 23 f2 ff ff       	jmp    8010687c <alltraps>

80107659 <vector152>:
.globl vector152
vector152:
  pushl $0
80107659:	6a 00                	push   $0x0
  pushl $152
8010765b:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107660:	e9 17 f2 ff ff       	jmp    8010687c <alltraps>

80107665 <vector153>:
.globl vector153
vector153:
  pushl $0
80107665:	6a 00                	push   $0x0
  pushl $153
80107667:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010766c:	e9 0b f2 ff ff       	jmp    8010687c <alltraps>

80107671 <vector154>:
.globl vector154
vector154:
  pushl $0
80107671:	6a 00                	push   $0x0
  pushl $154
80107673:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107678:	e9 ff f1 ff ff       	jmp    8010687c <alltraps>

8010767d <vector155>:
.globl vector155
vector155:
  pushl $0
8010767d:	6a 00                	push   $0x0
  pushl $155
8010767f:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107684:	e9 f3 f1 ff ff       	jmp    8010687c <alltraps>

80107689 <vector156>:
.globl vector156
vector156:
  pushl $0
80107689:	6a 00                	push   $0x0
  pushl $156
8010768b:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107690:	e9 e7 f1 ff ff       	jmp    8010687c <alltraps>

80107695 <vector157>:
.globl vector157
vector157:
  pushl $0
80107695:	6a 00                	push   $0x0
  pushl $157
80107697:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010769c:	e9 db f1 ff ff       	jmp    8010687c <alltraps>

801076a1 <vector158>:
.globl vector158
vector158:
  pushl $0
801076a1:	6a 00                	push   $0x0
  pushl $158
801076a3:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801076a8:	e9 cf f1 ff ff       	jmp    8010687c <alltraps>

801076ad <vector159>:
.globl vector159
vector159:
  pushl $0
801076ad:	6a 00                	push   $0x0
  pushl $159
801076af:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801076b4:	e9 c3 f1 ff ff       	jmp    8010687c <alltraps>

801076b9 <vector160>:
.globl vector160
vector160:
  pushl $0
801076b9:	6a 00                	push   $0x0
  pushl $160
801076bb:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801076c0:	e9 b7 f1 ff ff       	jmp    8010687c <alltraps>

801076c5 <vector161>:
.globl vector161
vector161:
  pushl $0
801076c5:	6a 00                	push   $0x0
  pushl $161
801076c7:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801076cc:	e9 ab f1 ff ff       	jmp    8010687c <alltraps>

801076d1 <vector162>:
.globl vector162
vector162:
  pushl $0
801076d1:	6a 00                	push   $0x0
  pushl $162
801076d3:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801076d8:	e9 9f f1 ff ff       	jmp    8010687c <alltraps>

801076dd <vector163>:
.globl vector163
vector163:
  pushl $0
801076dd:	6a 00                	push   $0x0
  pushl $163
801076df:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801076e4:	e9 93 f1 ff ff       	jmp    8010687c <alltraps>

801076e9 <vector164>:
.globl vector164
vector164:
  pushl $0
801076e9:	6a 00                	push   $0x0
  pushl $164
801076eb:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801076f0:	e9 87 f1 ff ff       	jmp    8010687c <alltraps>

801076f5 <vector165>:
.globl vector165
vector165:
  pushl $0
801076f5:	6a 00                	push   $0x0
  pushl $165
801076f7:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801076fc:	e9 7b f1 ff ff       	jmp    8010687c <alltraps>

80107701 <vector166>:
.globl vector166
vector166:
  pushl $0
80107701:	6a 00                	push   $0x0
  pushl $166
80107703:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107708:	e9 6f f1 ff ff       	jmp    8010687c <alltraps>

8010770d <vector167>:
.globl vector167
vector167:
  pushl $0
8010770d:	6a 00                	push   $0x0
  pushl $167
8010770f:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107714:	e9 63 f1 ff ff       	jmp    8010687c <alltraps>

80107719 <vector168>:
.globl vector168
vector168:
  pushl $0
80107719:	6a 00                	push   $0x0
  pushl $168
8010771b:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107720:	e9 57 f1 ff ff       	jmp    8010687c <alltraps>

80107725 <vector169>:
.globl vector169
vector169:
  pushl $0
80107725:	6a 00                	push   $0x0
  pushl $169
80107727:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010772c:	e9 4b f1 ff ff       	jmp    8010687c <alltraps>

80107731 <vector170>:
.globl vector170
vector170:
  pushl $0
80107731:	6a 00                	push   $0x0
  pushl $170
80107733:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107738:	e9 3f f1 ff ff       	jmp    8010687c <alltraps>

8010773d <vector171>:
.globl vector171
vector171:
  pushl $0
8010773d:	6a 00                	push   $0x0
  pushl $171
8010773f:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107744:	e9 33 f1 ff ff       	jmp    8010687c <alltraps>

80107749 <vector172>:
.globl vector172
vector172:
  pushl $0
80107749:	6a 00                	push   $0x0
  pushl $172
8010774b:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107750:	e9 27 f1 ff ff       	jmp    8010687c <alltraps>

80107755 <vector173>:
.globl vector173
vector173:
  pushl $0
80107755:	6a 00                	push   $0x0
  pushl $173
80107757:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010775c:	e9 1b f1 ff ff       	jmp    8010687c <alltraps>

80107761 <vector174>:
.globl vector174
vector174:
  pushl $0
80107761:	6a 00                	push   $0x0
  pushl $174
80107763:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107768:	e9 0f f1 ff ff       	jmp    8010687c <alltraps>

8010776d <vector175>:
.globl vector175
vector175:
  pushl $0
8010776d:	6a 00                	push   $0x0
  pushl $175
8010776f:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107774:	e9 03 f1 ff ff       	jmp    8010687c <alltraps>

80107779 <vector176>:
.globl vector176
vector176:
  pushl $0
80107779:	6a 00                	push   $0x0
  pushl $176
8010777b:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107780:	e9 f7 f0 ff ff       	jmp    8010687c <alltraps>

80107785 <vector177>:
.globl vector177
vector177:
  pushl $0
80107785:	6a 00                	push   $0x0
  pushl $177
80107787:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010778c:	e9 eb f0 ff ff       	jmp    8010687c <alltraps>

80107791 <vector178>:
.globl vector178
vector178:
  pushl $0
80107791:	6a 00                	push   $0x0
  pushl $178
80107793:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107798:	e9 df f0 ff ff       	jmp    8010687c <alltraps>

8010779d <vector179>:
.globl vector179
vector179:
  pushl $0
8010779d:	6a 00                	push   $0x0
  pushl $179
8010779f:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801077a4:	e9 d3 f0 ff ff       	jmp    8010687c <alltraps>

801077a9 <vector180>:
.globl vector180
vector180:
  pushl $0
801077a9:	6a 00                	push   $0x0
  pushl $180
801077ab:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801077b0:	e9 c7 f0 ff ff       	jmp    8010687c <alltraps>

801077b5 <vector181>:
.globl vector181
vector181:
  pushl $0
801077b5:	6a 00                	push   $0x0
  pushl $181
801077b7:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801077bc:	e9 bb f0 ff ff       	jmp    8010687c <alltraps>

801077c1 <vector182>:
.globl vector182
vector182:
  pushl $0
801077c1:	6a 00                	push   $0x0
  pushl $182
801077c3:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801077c8:	e9 af f0 ff ff       	jmp    8010687c <alltraps>

801077cd <vector183>:
.globl vector183
vector183:
  pushl $0
801077cd:	6a 00                	push   $0x0
  pushl $183
801077cf:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801077d4:	e9 a3 f0 ff ff       	jmp    8010687c <alltraps>

801077d9 <vector184>:
.globl vector184
vector184:
  pushl $0
801077d9:	6a 00                	push   $0x0
  pushl $184
801077db:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801077e0:	e9 97 f0 ff ff       	jmp    8010687c <alltraps>

801077e5 <vector185>:
.globl vector185
vector185:
  pushl $0
801077e5:	6a 00                	push   $0x0
  pushl $185
801077e7:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801077ec:	e9 8b f0 ff ff       	jmp    8010687c <alltraps>

801077f1 <vector186>:
.globl vector186
vector186:
  pushl $0
801077f1:	6a 00                	push   $0x0
  pushl $186
801077f3:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801077f8:	e9 7f f0 ff ff       	jmp    8010687c <alltraps>

801077fd <vector187>:
.globl vector187
vector187:
  pushl $0
801077fd:	6a 00                	push   $0x0
  pushl $187
801077ff:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107804:	e9 73 f0 ff ff       	jmp    8010687c <alltraps>

80107809 <vector188>:
.globl vector188
vector188:
  pushl $0
80107809:	6a 00                	push   $0x0
  pushl $188
8010780b:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107810:	e9 67 f0 ff ff       	jmp    8010687c <alltraps>

80107815 <vector189>:
.globl vector189
vector189:
  pushl $0
80107815:	6a 00                	push   $0x0
  pushl $189
80107817:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010781c:	e9 5b f0 ff ff       	jmp    8010687c <alltraps>

80107821 <vector190>:
.globl vector190
vector190:
  pushl $0
80107821:	6a 00                	push   $0x0
  pushl $190
80107823:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107828:	e9 4f f0 ff ff       	jmp    8010687c <alltraps>

8010782d <vector191>:
.globl vector191
vector191:
  pushl $0
8010782d:	6a 00                	push   $0x0
  pushl $191
8010782f:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107834:	e9 43 f0 ff ff       	jmp    8010687c <alltraps>

80107839 <vector192>:
.globl vector192
vector192:
  pushl $0
80107839:	6a 00                	push   $0x0
  pushl $192
8010783b:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107840:	e9 37 f0 ff ff       	jmp    8010687c <alltraps>

80107845 <vector193>:
.globl vector193
vector193:
  pushl $0
80107845:	6a 00                	push   $0x0
  pushl $193
80107847:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010784c:	e9 2b f0 ff ff       	jmp    8010687c <alltraps>

80107851 <vector194>:
.globl vector194
vector194:
  pushl $0
80107851:	6a 00                	push   $0x0
  pushl $194
80107853:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107858:	e9 1f f0 ff ff       	jmp    8010687c <alltraps>

8010785d <vector195>:
.globl vector195
vector195:
  pushl $0
8010785d:	6a 00                	push   $0x0
  pushl $195
8010785f:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107864:	e9 13 f0 ff ff       	jmp    8010687c <alltraps>

80107869 <vector196>:
.globl vector196
vector196:
  pushl $0
80107869:	6a 00                	push   $0x0
  pushl $196
8010786b:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107870:	e9 07 f0 ff ff       	jmp    8010687c <alltraps>

80107875 <vector197>:
.globl vector197
vector197:
  pushl $0
80107875:	6a 00                	push   $0x0
  pushl $197
80107877:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010787c:	e9 fb ef ff ff       	jmp    8010687c <alltraps>

80107881 <vector198>:
.globl vector198
vector198:
  pushl $0
80107881:	6a 00                	push   $0x0
  pushl $198
80107883:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107888:	e9 ef ef ff ff       	jmp    8010687c <alltraps>

8010788d <vector199>:
.globl vector199
vector199:
  pushl $0
8010788d:	6a 00                	push   $0x0
  pushl $199
8010788f:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107894:	e9 e3 ef ff ff       	jmp    8010687c <alltraps>

80107899 <vector200>:
.globl vector200
vector200:
  pushl $0
80107899:	6a 00                	push   $0x0
  pushl $200
8010789b:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801078a0:	e9 d7 ef ff ff       	jmp    8010687c <alltraps>

801078a5 <vector201>:
.globl vector201
vector201:
  pushl $0
801078a5:	6a 00                	push   $0x0
  pushl $201
801078a7:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801078ac:	e9 cb ef ff ff       	jmp    8010687c <alltraps>

801078b1 <vector202>:
.globl vector202
vector202:
  pushl $0
801078b1:	6a 00                	push   $0x0
  pushl $202
801078b3:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801078b8:	e9 bf ef ff ff       	jmp    8010687c <alltraps>

801078bd <vector203>:
.globl vector203
vector203:
  pushl $0
801078bd:	6a 00                	push   $0x0
  pushl $203
801078bf:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801078c4:	e9 b3 ef ff ff       	jmp    8010687c <alltraps>

801078c9 <vector204>:
.globl vector204
vector204:
  pushl $0
801078c9:	6a 00                	push   $0x0
  pushl $204
801078cb:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801078d0:	e9 a7 ef ff ff       	jmp    8010687c <alltraps>

801078d5 <vector205>:
.globl vector205
vector205:
  pushl $0
801078d5:	6a 00                	push   $0x0
  pushl $205
801078d7:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801078dc:	e9 9b ef ff ff       	jmp    8010687c <alltraps>

801078e1 <vector206>:
.globl vector206
vector206:
  pushl $0
801078e1:	6a 00                	push   $0x0
  pushl $206
801078e3:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801078e8:	e9 8f ef ff ff       	jmp    8010687c <alltraps>

801078ed <vector207>:
.globl vector207
vector207:
  pushl $0
801078ed:	6a 00                	push   $0x0
  pushl $207
801078ef:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801078f4:	e9 83 ef ff ff       	jmp    8010687c <alltraps>

801078f9 <vector208>:
.globl vector208
vector208:
  pushl $0
801078f9:	6a 00                	push   $0x0
  pushl $208
801078fb:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107900:	e9 77 ef ff ff       	jmp    8010687c <alltraps>

80107905 <vector209>:
.globl vector209
vector209:
  pushl $0
80107905:	6a 00                	push   $0x0
  pushl $209
80107907:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010790c:	e9 6b ef ff ff       	jmp    8010687c <alltraps>

80107911 <vector210>:
.globl vector210
vector210:
  pushl $0
80107911:	6a 00                	push   $0x0
  pushl $210
80107913:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107918:	e9 5f ef ff ff       	jmp    8010687c <alltraps>

8010791d <vector211>:
.globl vector211
vector211:
  pushl $0
8010791d:	6a 00                	push   $0x0
  pushl $211
8010791f:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107924:	e9 53 ef ff ff       	jmp    8010687c <alltraps>

80107929 <vector212>:
.globl vector212
vector212:
  pushl $0
80107929:	6a 00                	push   $0x0
  pushl $212
8010792b:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107930:	e9 47 ef ff ff       	jmp    8010687c <alltraps>

80107935 <vector213>:
.globl vector213
vector213:
  pushl $0
80107935:	6a 00                	push   $0x0
  pushl $213
80107937:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010793c:	e9 3b ef ff ff       	jmp    8010687c <alltraps>

80107941 <vector214>:
.globl vector214
vector214:
  pushl $0
80107941:	6a 00                	push   $0x0
  pushl $214
80107943:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107948:	e9 2f ef ff ff       	jmp    8010687c <alltraps>

8010794d <vector215>:
.globl vector215
vector215:
  pushl $0
8010794d:	6a 00                	push   $0x0
  pushl $215
8010794f:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107954:	e9 23 ef ff ff       	jmp    8010687c <alltraps>

80107959 <vector216>:
.globl vector216
vector216:
  pushl $0
80107959:	6a 00                	push   $0x0
  pushl $216
8010795b:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107960:	e9 17 ef ff ff       	jmp    8010687c <alltraps>

80107965 <vector217>:
.globl vector217
vector217:
  pushl $0
80107965:	6a 00                	push   $0x0
  pushl $217
80107967:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010796c:	e9 0b ef ff ff       	jmp    8010687c <alltraps>

80107971 <vector218>:
.globl vector218
vector218:
  pushl $0
80107971:	6a 00                	push   $0x0
  pushl $218
80107973:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107978:	e9 ff ee ff ff       	jmp    8010687c <alltraps>

8010797d <vector219>:
.globl vector219
vector219:
  pushl $0
8010797d:	6a 00                	push   $0x0
  pushl $219
8010797f:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107984:	e9 f3 ee ff ff       	jmp    8010687c <alltraps>

80107989 <vector220>:
.globl vector220
vector220:
  pushl $0
80107989:	6a 00                	push   $0x0
  pushl $220
8010798b:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107990:	e9 e7 ee ff ff       	jmp    8010687c <alltraps>

80107995 <vector221>:
.globl vector221
vector221:
  pushl $0
80107995:	6a 00                	push   $0x0
  pushl $221
80107997:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010799c:	e9 db ee ff ff       	jmp    8010687c <alltraps>

801079a1 <vector222>:
.globl vector222
vector222:
  pushl $0
801079a1:	6a 00                	push   $0x0
  pushl $222
801079a3:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801079a8:	e9 cf ee ff ff       	jmp    8010687c <alltraps>

801079ad <vector223>:
.globl vector223
vector223:
  pushl $0
801079ad:	6a 00                	push   $0x0
  pushl $223
801079af:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801079b4:	e9 c3 ee ff ff       	jmp    8010687c <alltraps>

801079b9 <vector224>:
.globl vector224
vector224:
  pushl $0
801079b9:	6a 00                	push   $0x0
  pushl $224
801079bb:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801079c0:	e9 b7 ee ff ff       	jmp    8010687c <alltraps>

801079c5 <vector225>:
.globl vector225
vector225:
  pushl $0
801079c5:	6a 00                	push   $0x0
  pushl $225
801079c7:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801079cc:	e9 ab ee ff ff       	jmp    8010687c <alltraps>

801079d1 <vector226>:
.globl vector226
vector226:
  pushl $0
801079d1:	6a 00                	push   $0x0
  pushl $226
801079d3:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801079d8:	e9 9f ee ff ff       	jmp    8010687c <alltraps>

801079dd <vector227>:
.globl vector227
vector227:
  pushl $0
801079dd:	6a 00                	push   $0x0
  pushl $227
801079df:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801079e4:	e9 93 ee ff ff       	jmp    8010687c <alltraps>

801079e9 <vector228>:
.globl vector228
vector228:
  pushl $0
801079e9:	6a 00                	push   $0x0
  pushl $228
801079eb:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801079f0:	e9 87 ee ff ff       	jmp    8010687c <alltraps>

801079f5 <vector229>:
.globl vector229
vector229:
  pushl $0
801079f5:	6a 00                	push   $0x0
  pushl $229
801079f7:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801079fc:	e9 7b ee ff ff       	jmp    8010687c <alltraps>

80107a01 <vector230>:
.globl vector230
vector230:
  pushl $0
80107a01:	6a 00                	push   $0x0
  pushl $230
80107a03:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107a08:	e9 6f ee ff ff       	jmp    8010687c <alltraps>

80107a0d <vector231>:
.globl vector231
vector231:
  pushl $0
80107a0d:	6a 00                	push   $0x0
  pushl $231
80107a0f:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107a14:	e9 63 ee ff ff       	jmp    8010687c <alltraps>

80107a19 <vector232>:
.globl vector232
vector232:
  pushl $0
80107a19:	6a 00                	push   $0x0
  pushl $232
80107a1b:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107a20:	e9 57 ee ff ff       	jmp    8010687c <alltraps>

80107a25 <vector233>:
.globl vector233
vector233:
  pushl $0
80107a25:	6a 00                	push   $0x0
  pushl $233
80107a27:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107a2c:	e9 4b ee ff ff       	jmp    8010687c <alltraps>

80107a31 <vector234>:
.globl vector234
vector234:
  pushl $0
80107a31:	6a 00                	push   $0x0
  pushl $234
80107a33:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107a38:	e9 3f ee ff ff       	jmp    8010687c <alltraps>

80107a3d <vector235>:
.globl vector235
vector235:
  pushl $0
80107a3d:	6a 00                	push   $0x0
  pushl $235
80107a3f:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107a44:	e9 33 ee ff ff       	jmp    8010687c <alltraps>

80107a49 <vector236>:
.globl vector236
vector236:
  pushl $0
80107a49:	6a 00                	push   $0x0
  pushl $236
80107a4b:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107a50:	e9 27 ee ff ff       	jmp    8010687c <alltraps>

80107a55 <vector237>:
.globl vector237
vector237:
  pushl $0
80107a55:	6a 00                	push   $0x0
  pushl $237
80107a57:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107a5c:	e9 1b ee ff ff       	jmp    8010687c <alltraps>

80107a61 <vector238>:
.globl vector238
vector238:
  pushl $0
80107a61:	6a 00                	push   $0x0
  pushl $238
80107a63:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107a68:	e9 0f ee ff ff       	jmp    8010687c <alltraps>

80107a6d <vector239>:
.globl vector239
vector239:
  pushl $0
80107a6d:	6a 00                	push   $0x0
  pushl $239
80107a6f:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107a74:	e9 03 ee ff ff       	jmp    8010687c <alltraps>

80107a79 <vector240>:
.globl vector240
vector240:
  pushl $0
80107a79:	6a 00                	push   $0x0
  pushl $240
80107a7b:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107a80:	e9 f7 ed ff ff       	jmp    8010687c <alltraps>

80107a85 <vector241>:
.globl vector241
vector241:
  pushl $0
80107a85:	6a 00                	push   $0x0
  pushl $241
80107a87:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107a8c:	e9 eb ed ff ff       	jmp    8010687c <alltraps>

80107a91 <vector242>:
.globl vector242
vector242:
  pushl $0
80107a91:	6a 00                	push   $0x0
  pushl $242
80107a93:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107a98:	e9 df ed ff ff       	jmp    8010687c <alltraps>

80107a9d <vector243>:
.globl vector243
vector243:
  pushl $0
80107a9d:	6a 00                	push   $0x0
  pushl $243
80107a9f:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107aa4:	e9 d3 ed ff ff       	jmp    8010687c <alltraps>

80107aa9 <vector244>:
.globl vector244
vector244:
  pushl $0
80107aa9:	6a 00                	push   $0x0
  pushl $244
80107aab:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107ab0:	e9 c7 ed ff ff       	jmp    8010687c <alltraps>

80107ab5 <vector245>:
.globl vector245
vector245:
  pushl $0
80107ab5:	6a 00                	push   $0x0
  pushl $245
80107ab7:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107abc:	e9 bb ed ff ff       	jmp    8010687c <alltraps>

80107ac1 <vector246>:
.globl vector246
vector246:
  pushl $0
80107ac1:	6a 00                	push   $0x0
  pushl $246
80107ac3:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107ac8:	e9 af ed ff ff       	jmp    8010687c <alltraps>

80107acd <vector247>:
.globl vector247
vector247:
  pushl $0
80107acd:	6a 00                	push   $0x0
  pushl $247
80107acf:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107ad4:	e9 a3 ed ff ff       	jmp    8010687c <alltraps>

80107ad9 <vector248>:
.globl vector248
vector248:
  pushl $0
80107ad9:	6a 00                	push   $0x0
  pushl $248
80107adb:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107ae0:	e9 97 ed ff ff       	jmp    8010687c <alltraps>

80107ae5 <vector249>:
.globl vector249
vector249:
  pushl $0
80107ae5:	6a 00                	push   $0x0
  pushl $249
80107ae7:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107aec:	e9 8b ed ff ff       	jmp    8010687c <alltraps>

80107af1 <vector250>:
.globl vector250
vector250:
  pushl $0
80107af1:	6a 00                	push   $0x0
  pushl $250
80107af3:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107af8:	e9 7f ed ff ff       	jmp    8010687c <alltraps>

80107afd <vector251>:
.globl vector251
vector251:
  pushl $0
80107afd:	6a 00                	push   $0x0
  pushl $251
80107aff:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107b04:	e9 73 ed ff ff       	jmp    8010687c <alltraps>

80107b09 <vector252>:
.globl vector252
vector252:
  pushl $0
80107b09:	6a 00                	push   $0x0
  pushl $252
80107b0b:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107b10:	e9 67 ed ff ff       	jmp    8010687c <alltraps>

80107b15 <vector253>:
.globl vector253
vector253:
  pushl $0
80107b15:	6a 00                	push   $0x0
  pushl $253
80107b17:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107b1c:	e9 5b ed ff ff       	jmp    8010687c <alltraps>

80107b21 <vector254>:
.globl vector254
vector254:
  pushl $0
80107b21:	6a 00                	push   $0x0
  pushl $254
80107b23:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107b28:	e9 4f ed ff ff       	jmp    8010687c <alltraps>

80107b2d <vector255>:
.globl vector255
vector255:
  pushl $0
80107b2d:	6a 00                	push   $0x0
  pushl $255
80107b2f:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107b34:	e9 43 ed ff ff       	jmp    8010687c <alltraps>

80107b39 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107b39:	55                   	push   %ebp
80107b3a:	89 e5                	mov    %esp,%ebp
80107b3c:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b42:	83 e8 01             	sub    $0x1,%eax
80107b45:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107b49:	8b 45 08             	mov    0x8(%ebp),%eax
80107b4c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107b50:	8b 45 08             	mov    0x8(%ebp),%eax
80107b53:	c1 e8 10             	shr    $0x10,%eax
80107b56:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107b5a:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107b5d:	0f 01 10             	lgdtl  (%eax)
}
80107b60:	90                   	nop
80107b61:	c9                   	leave  
80107b62:	c3                   	ret    

80107b63 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107b63:	55                   	push   %ebp
80107b64:	89 e5                	mov    %esp,%ebp
80107b66:	83 ec 04             	sub    $0x4,%esp
80107b69:	8b 45 08             	mov    0x8(%ebp),%eax
80107b6c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107b70:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107b74:	0f 00 d8             	ltr    %ax
}
80107b77:	90                   	nop
80107b78:	c9                   	leave  
80107b79:	c3                   	ret    

80107b7a <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
80107b7a:	55                   	push   %ebp
80107b7b:	89 e5                	mov    %esp,%ebp
80107b7d:	83 ec 04             	sub    $0x4,%esp
80107b80:	8b 45 08             	mov    0x8(%ebp),%eax
80107b83:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
80107b87:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107b8b:	8e e8                	mov    %eax,%gs
}
80107b8d:	90                   	nop
80107b8e:	c9                   	leave  
80107b8f:	c3                   	ret    

80107b90 <lcr3>:
  return val;
}

static inline void
lcr3(uint val)
{
80107b90:	55                   	push   %ebp
80107b91:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107b93:	8b 45 08             	mov    0x8(%ebp),%eax
80107b96:	0f 22 d8             	mov    %eax,%cr3
}
80107b99:	90                   	nop
80107b9a:	5d                   	pop    %ebp
80107b9b:	c3                   	ret    

80107b9c <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107b9c:	55                   	push   %ebp
80107b9d:	89 e5                	mov    %esp,%ebp
80107b9f:	53                   	push   %ebx
80107ba0:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107ba3:	e8 85 b4 ff ff       	call   8010302d <cpunum>
80107ba8:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107bae:	05 20 48 11 80       	add    $0x80114820,%eax
80107bb3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb9:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107bbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc2:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bcb:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd2:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107bd6:	83 e2 f0             	and    $0xfffffff0,%edx
80107bd9:	83 ca 0a             	or     $0xa,%edx
80107bdc:	88 50 7d             	mov    %dl,0x7d(%eax)
80107bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be2:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107be6:	83 ca 10             	or     $0x10,%edx
80107be9:	88 50 7d             	mov    %dl,0x7d(%eax)
80107bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bef:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107bf3:	83 e2 9f             	and    $0xffffff9f,%edx
80107bf6:	88 50 7d             	mov    %dl,0x7d(%eax)
80107bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bfc:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107c00:	83 ca 80             	or     $0xffffff80,%edx
80107c03:	88 50 7d             	mov    %dl,0x7d(%eax)
80107c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c09:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c0d:	83 ca 0f             	or     $0xf,%edx
80107c10:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c16:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c1a:	83 e2 ef             	and    $0xffffffef,%edx
80107c1d:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c23:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c27:	83 e2 df             	and    $0xffffffdf,%edx
80107c2a:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c30:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c34:	83 ca 40             	or     $0x40,%edx
80107c37:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c3d:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107c41:	83 ca 80             	or     $0xffffff80,%edx
80107c44:	88 50 7e             	mov    %dl,0x7e(%eax)
80107c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4a:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107c4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c51:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107c58:	ff ff 
80107c5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c5d:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107c64:	00 00 
80107c66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c69:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c73:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107c7a:	83 e2 f0             	and    $0xfffffff0,%edx
80107c7d:	83 ca 02             	or     $0x2,%edx
80107c80:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107c86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c89:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107c90:	83 ca 10             	or     $0x10,%edx
80107c93:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107c99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c9c:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107ca3:	83 e2 9f             	and    $0xffffff9f,%edx
80107ca6:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107cac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107caf:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80107cb6:	83 ca 80             	or     $0xffffff80,%edx
80107cb9:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cc2:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107cc9:	83 ca 0f             	or     $0xf,%edx
80107ccc:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107cd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cd5:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107cdc:	83 e2 ef             	and    $0xffffffef,%edx
80107cdf:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ce8:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107cef:	83 e2 df             	and    $0xffffffdf,%edx
80107cf2:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107cf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cfb:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d02:	83 ca 40             	or     $0x40,%edx
80107d05:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d0e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107d15:	83 ca 80             	or     $0xffffff80,%edx
80107d18:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d21:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107d28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d2b:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107d32:	ff ff 
80107d34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d37:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107d3e:	00 00 
80107d40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d43:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d4d:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d54:	83 e2 f0             	and    $0xfffffff0,%edx
80107d57:	83 ca 0a             	or     $0xa,%edx
80107d5a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d63:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d6a:	83 ca 10             	or     $0x10,%edx
80107d6d:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d76:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d7d:	83 ca 60             	or     $0x60,%edx
80107d80:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d89:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107d90:	83 ca 80             	or     $0xffffff80,%edx
80107d93:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80107d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9c:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107da3:	83 ca 0f             	or     $0xf,%edx
80107da6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107dac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107daf:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107db6:	83 e2 ef             	and    $0xffffffef,%edx
80107db9:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107dbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dc2:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107dc9:	83 e2 df             	and    $0xffffffdf,%edx
80107dcc:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107dd2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd5:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107ddc:	83 ca 40             	or     $0x40,%edx
80107ddf:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107de5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107de8:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107def:	83 ca 80             	or     $0xffffff80,%edx
80107df2:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dfb:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107e02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e05:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107e0c:	ff ff 
80107e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e11:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107e18:	00 00 
80107e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e1d:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e27:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e2e:	83 e2 f0             	and    $0xfffffff0,%edx
80107e31:	83 ca 02             	or     $0x2,%edx
80107e34:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e3d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e44:	83 ca 10             	or     $0x10,%edx
80107e47:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e50:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e57:	83 ca 60             	or     $0x60,%edx
80107e5a:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e63:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107e6a:	83 ca 80             	or     $0xffffff80,%edx
80107e6d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107e73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e76:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107e7d:	83 ca 0f             	or     $0xf,%edx
80107e80:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107e86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e89:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107e90:	83 e2 ef             	and    $0xffffffef,%edx
80107e93:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e9c:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ea3:	83 e2 df             	and    $0xffffffdf,%edx
80107ea6:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107eac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eaf:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107eb6:	83 ca 40             	or     $0x40,%edx
80107eb9:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ebf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ec2:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ec9:	83 ca 80             	or     $0xffffff80,%edx
80107ecc:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107ed2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed5:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107edc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107edf:	05 b4 00 00 00       	add    $0xb4,%eax
80107ee4:	89 c3                	mov    %eax,%ebx
80107ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ee9:	05 b4 00 00 00       	add    $0xb4,%eax
80107eee:	c1 e8 10             	shr    $0x10,%eax
80107ef1:	89 c2                	mov    %eax,%edx
80107ef3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ef6:	05 b4 00 00 00       	add    $0xb4,%eax
80107efb:	c1 e8 18             	shr    $0x18,%eax
80107efe:	89 c1                	mov    %eax,%ecx
80107f00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f03:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107f0a:	00 00 
80107f0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f0f:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107f16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f19:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f22:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f29:	83 e2 f0             	and    $0xfffffff0,%edx
80107f2c:	83 ca 02             	or     $0x2,%edx
80107f2f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f38:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f3f:	83 ca 10             	or     $0x10,%edx
80107f42:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f4b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f52:	83 e2 9f             	and    $0xffffff9f,%edx
80107f55:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f5e:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107f65:	83 ca 80             	or     $0xffffff80,%edx
80107f68:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f71:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107f78:	83 e2 f0             	and    $0xfffffff0,%edx
80107f7b:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107f81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f84:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107f8b:	83 e2 ef             	and    $0xffffffef,%edx
80107f8e:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107f94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f97:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107f9e:	83 e2 df             	and    $0xffffffdf,%edx
80107fa1:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107faa:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107fb1:	83 ca 40             	or     $0x40,%edx
80107fb4:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fbd:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107fc4:	83 ca 80             	or     $0xffffff80,%edx
80107fc7:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd0:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107fd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fd9:	83 c0 70             	add    $0x70,%eax
80107fdc:	83 ec 08             	sub    $0x8,%esp
80107fdf:	6a 38                	push   $0x38
80107fe1:	50                   	push   %eax
80107fe2:	e8 52 fb ff ff       	call   80107b39 <lgdt>
80107fe7:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107fea:	83 ec 0c             	sub    $0xc,%esp
80107fed:	6a 18                	push   $0x18
80107fef:	e8 86 fb ff ff       	call   80107b7a <loadgs>
80107ff4:	83 c4 10             	add    $0x10,%esp

  // Initialize cpu-local storage.
  cpu = c;
80107ff7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ffa:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80108000:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80108007:	00 00 00 00 
}
8010800b:	90                   	nop
8010800c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010800f:	c9                   	leave  
80108010:	c3                   	ret    

80108011 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108011:	55                   	push   %ebp
80108012:	89 e5                	mov    %esp,%ebp
80108014:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108017:	8b 45 0c             	mov    0xc(%ebp),%eax
8010801a:	c1 e8 16             	shr    $0x16,%eax
8010801d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108024:	8b 45 08             	mov    0x8(%ebp),%eax
80108027:	01 d0                	add    %edx,%eax
80108029:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
8010802c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010802f:	8b 00                	mov    (%eax),%eax
80108031:	83 e0 01             	and    $0x1,%eax
80108034:	85 c0                	test   %eax,%eax
80108036:	74 14                	je     8010804c <walkpgdir+0x3b>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108038:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010803b:	8b 00                	mov    (%eax),%eax
8010803d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108042:	05 00 00 00 80       	add    $0x80000000,%eax
80108047:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010804a:	eb 42                	jmp    8010808e <walkpgdir+0x7d>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010804c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80108050:	74 0e                	je     80108060 <walkpgdir+0x4f>
80108052:	e8 70 ac ff ff       	call   80102cc7 <kalloc>
80108057:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010805a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010805e:	75 07                	jne    80108067 <walkpgdir+0x56>
      return 0;
80108060:	b8 00 00 00 00       	mov    $0x0,%eax
80108065:	eb 3e                	jmp    801080a5 <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80108067:	83 ec 04             	sub    $0x4,%esp
8010806a:	68 00 10 00 00       	push   $0x1000
8010806f:	6a 00                	push   $0x0
80108071:	ff 75 f4             	pushl  -0xc(%ebp)
80108074:	e8 ef d2 ff ff       	call   80105368 <memset>
80108079:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010807c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010807f:	05 00 00 00 80       	add    $0x80000000,%eax
80108084:	83 c8 07             	or     $0x7,%eax
80108087:	89 c2                	mov    %eax,%edx
80108089:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010808c:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
8010808e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108091:	c1 e8 0c             	shr    $0xc,%eax
80108094:	25 ff 03 00 00       	and    $0x3ff,%eax
80108099:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801080a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a3:	01 d0                	add    %edx,%eax
}
801080a5:	c9                   	leave  
801080a6:	c3                   	ret    

801080a7 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801080a7:	55                   	push   %ebp
801080a8:	89 e5                	mov    %esp,%ebp
801080aa:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801080ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801080b0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801080b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801080bb:	8b 45 10             	mov    0x10(%ebp),%eax
801080be:	01 d0                	add    %edx,%eax
801080c0:	83 e8 01             	sub    $0x1,%eax
801080c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801080cb:	83 ec 04             	sub    $0x4,%esp
801080ce:	6a 01                	push   $0x1
801080d0:	ff 75 f4             	pushl  -0xc(%ebp)
801080d3:	ff 75 08             	pushl  0x8(%ebp)
801080d6:	e8 36 ff ff ff       	call   80108011 <walkpgdir>
801080db:	83 c4 10             	add    $0x10,%esp
801080de:	89 45 ec             	mov    %eax,-0x14(%ebp)
801080e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801080e5:	75 07                	jne    801080ee <mappages+0x47>
      return -1;
801080e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801080ec:	eb 47                	jmp    80108135 <mappages+0x8e>
    if(*pte & PTE_P)
801080ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080f1:	8b 00                	mov    (%eax),%eax
801080f3:	83 e0 01             	and    $0x1,%eax
801080f6:	85 c0                	test   %eax,%eax
801080f8:	74 0d                	je     80108107 <mappages+0x60>
      panic("remap");
801080fa:	83 ec 0c             	sub    $0xc,%esp
801080fd:	68 78 90 10 80       	push   $0x80109078
80108102:	e8 99 84 ff ff       	call   801005a0 <panic>
    *pte = pa | perm | PTE_P;
80108107:	8b 45 18             	mov    0x18(%ebp),%eax
8010810a:	0b 45 14             	or     0x14(%ebp),%eax
8010810d:	83 c8 01             	or     $0x1,%eax
80108110:	89 c2                	mov    %eax,%edx
80108112:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108115:	89 10                	mov    %edx,(%eax)
    if(a == last)
80108117:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010811a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010811d:	74 10                	je     8010812f <mappages+0x88>
      break;
    a += PGSIZE;
8010811f:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80108126:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
8010812d:	eb 9c                	jmp    801080cb <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
8010812f:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80108130:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108135:	c9                   	leave  
80108136:	c3                   	ret    

80108137 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108137:	55                   	push   %ebp
80108138:	89 e5                	mov    %esp,%ebp
8010813a:	53                   	push   %ebx
8010813b:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
8010813e:	e8 84 ab ff ff       	call   80102cc7 <kalloc>
80108143:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108146:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010814a:	75 07                	jne    80108153 <setupkvm+0x1c>
    return 0;
8010814c:	b8 00 00 00 00       	mov    $0x0,%eax
80108151:	eb 6a                	jmp    801081bd <setupkvm+0x86>
  memset(pgdir, 0, PGSIZE);
80108153:	83 ec 04             	sub    $0x4,%esp
80108156:	68 00 10 00 00       	push   $0x1000
8010815b:	6a 00                	push   $0x0
8010815d:	ff 75 f0             	pushl  -0x10(%ebp)
80108160:	e8 03 d2 ff ff       	call   80105368 <memset>
80108165:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108168:	c7 45 f4 a0 c4 10 80 	movl   $0x8010c4a0,-0xc(%ebp)
8010816f:	eb 40                	jmp    801081b1 <setupkvm+0x7a>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108171:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108174:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80108177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010817a:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010817d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108180:	8b 58 08             	mov    0x8(%eax),%ebx
80108183:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108186:	8b 40 04             	mov    0x4(%eax),%eax
80108189:	29 c3                	sub    %eax,%ebx
8010818b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010818e:	8b 00                	mov    (%eax),%eax
80108190:	83 ec 0c             	sub    $0xc,%esp
80108193:	51                   	push   %ecx
80108194:	52                   	push   %edx
80108195:	53                   	push   %ebx
80108196:	50                   	push   %eax
80108197:	ff 75 f0             	pushl  -0x10(%ebp)
8010819a:	e8 08 ff ff ff       	call   801080a7 <mappages>
8010819f:	83 c4 20             	add    $0x20,%esp
801081a2:	85 c0                	test   %eax,%eax
801081a4:	79 07                	jns    801081ad <setupkvm+0x76>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
801081a6:	b8 00 00 00 00       	mov    $0x0,%eax
801081ab:	eb 10                	jmp    801081bd <setupkvm+0x86>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801081ad:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801081b1:	81 7d f4 e0 c4 10 80 	cmpl   $0x8010c4e0,-0xc(%ebp)
801081b8:	72 b7                	jb     80108171 <setupkvm+0x3a>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
801081ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801081bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801081c0:	c9                   	leave  
801081c1:	c3                   	ret    

801081c2 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
801081c2:	55                   	push   %ebp
801081c3:	89 e5                	mov    %esp,%ebp
801081c5:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801081c8:	e8 6a ff ff ff       	call   80108137 <setupkvm>
801081cd:	a3 a4 76 11 80       	mov    %eax,0x801176a4
  switchkvm();
801081d2:	e8 03 00 00 00       	call   801081da <switchkvm>
}
801081d7:	90                   	nop
801081d8:	c9                   	leave  
801081d9:	c3                   	ret    

801081da <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801081da:	55                   	push   %ebp
801081db:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801081dd:	a1 a4 76 11 80       	mov    0x801176a4,%eax
801081e2:	05 00 00 00 80       	add    $0x80000000,%eax
801081e7:	50                   	push   %eax
801081e8:	e8 a3 f9 ff ff       	call   80107b90 <lcr3>
801081ed:	83 c4 04             	add    $0x4,%esp
}
801081f0:	90                   	nop
801081f1:	c9                   	leave  
801081f2:	c3                   	ret    

801081f3 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801081f3:	55                   	push   %ebp
801081f4:	89 e5                	mov    %esp,%ebp
801081f6:	56                   	push   %esi
801081f7:	53                   	push   %ebx
  pushcli();
801081f8:	e8 53 d0 ff ff       	call   80105250 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801081fd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108203:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010820a:	83 c2 08             	add    $0x8,%edx
8010820d:	89 d6                	mov    %edx,%esi
8010820f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108216:	83 c2 08             	add    $0x8,%edx
80108219:	c1 ea 10             	shr    $0x10,%edx
8010821c:	89 d3                	mov    %edx,%ebx
8010821e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80108225:	83 c2 08             	add    $0x8,%edx
80108228:	c1 ea 18             	shr    $0x18,%edx
8010822b:	89 d1                	mov    %edx,%ecx
8010822d:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80108234:	67 00 
80108236:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
8010823d:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80108243:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010824a:	83 e2 f0             	and    $0xfffffff0,%edx
8010824d:	83 ca 09             	or     $0x9,%edx
80108250:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108256:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010825d:	83 ca 10             	or     $0x10,%edx
80108260:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108266:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010826d:	83 e2 9f             	and    $0xffffff9f,%edx
80108270:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108276:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
8010827d:	83 ca 80             	or     $0xffffff80,%edx
80108280:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80108286:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010828d:	83 e2 f0             	and    $0xfffffff0,%edx
80108290:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80108296:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
8010829d:	83 e2 ef             	and    $0xffffffef,%edx
801082a0:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082a6:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801082ad:	83 e2 df             	and    $0xffffffdf,%edx
801082b0:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082b6:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801082bd:	83 ca 40             	or     $0x40,%edx
801082c0:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082c6:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
801082cd:	83 e2 7f             	and    $0x7f,%edx
801082d0:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
801082d6:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801082dc:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801082e2:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
801082e9:	83 e2 ef             	and    $0xffffffef,%edx
801082ec:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
801082f2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801082f8:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801082fe:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108304:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010830b:	8b 52 08             	mov    0x8(%edx),%edx
8010830e:	81 c2 00 10 00 00    	add    $0x1000,%edx
80108314:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80108317:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010831d:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
80108323:	83 ec 0c             	sub    $0xc,%esp
80108326:	6a 30                	push   $0x30
80108328:	e8 36 f8 ff ff       	call   80107b63 <ltr>
8010832d:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80108330:	8b 45 08             	mov    0x8(%ebp),%eax
80108333:	8b 40 04             	mov    0x4(%eax),%eax
80108336:	85 c0                	test   %eax,%eax
80108338:	75 0d                	jne    80108347 <switchuvm+0x154>
    panic("switchuvm: no pgdir");
8010833a:	83 ec 0c             	sub    $0xc,%esp
8010833d:	68 7e 90 10 80       	push   $0x8010907e
80108342:	e8 59 82 ff ff       	call   801005a0 <panic>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108347:	8b 45 08             	mov    0x8(%ebp),%eax
8010834a:	8b 40 04             	mov    0x4(%eax),%eax
8010834d:	05 00 00 00 80       	add    $0x80000000,%eax
80108352:	83 ec 0c             	sub    $0xc,%esp
80108355:	50                   	push   %eax
80108356:	e8 35 f8 ff ff       	call   80107b90 <lcr3>
8010835b:	83 c4 10             	add    $0x10,%esp
  popcli();
8010835e:	e8 44 cf ff ff       	call   801052a7 <popcli>
}
80108363:	90                   	nop
80108364:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108367:	5b                   	pop    %ebx
80108368:	5e                   	pop    %esi
80108369:	5d                   	pop    %ebp
8010836a:	c3                   	ret    

8010836b <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010836b:	55                   	push   %ebp
8010836c:	89 e5                	mov    %esp,%ebp
8010836e:	83 ec 18             	sub    $0x18,%esp
  char *mem;

  if(sz >= PGSIZE)
80108371:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108378:	76 0d                	jbe    80108387 <inituvm+0x1c>
    panic("inituvm: more than a page");
8010837a:	83 ec 0c             	sub    $0xc,%esp
8010837d:	68 92 90 10 80       	push   $0x80109092
80108382:	e8 19 82 ff ff       	call   801005a0 <panic>
  mem = kalloc();
80108387:	e8 3b a9 ff ff       	call   80102cc7 <kalloc>
8010838c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010838f:	83 ec 04             	sub    $0x4,%esp
80108392:	68 00 10 00 00       	push   $0x1000
80108397:	6a 00                	push   $0x0
80108399:	ff 75 f4             	pushl  -0xc(%ebp)
8010839c:	e8 c7 cf ff ff       	call   80105368 <memset>
801083a1:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801083a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083a7:	05 00 00 00 80       	add    $0x80000000,%eax
801083ac:	83 ec 0c             	sub    $0xc,%esp
801083af:	6a 06                	push   $0x6
801083b1:	50                   	push   %eax
801083b2:	68 00 10 00 00       	push   $0x1000
801083b7:	6a 00                	push   $0x0
801083b9:	ff 75 08             	pushl  0x8(%ebp)
801083bc:	e8 e6 fc ff ff       	call   801080a7 <mappages>
801083c1:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
801083c4:	83 ec 04             	sub    $0x4,%esp
801083c7:	ff 75 10             	pushl  0x10(%ebp)
801083ca:	ff 75 0c             	pushl  0xc(%ebp)
801083cd:	ff 75 f4             	pushl  -0xc(%ebp)
801083d0:	e8 52 d0 ff ff       	call   80105427 <memmove>
801083d5:	83 c4 10             	add    $0x10,%esp
}
801083d8:	90                   	nop
801083d9:	c9                   	leave  
801083da:	c3                   	ret    

801083db <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801083db:	55                   	push   %ebp
801083dc:	89 e5                	mov    %esp,%ebp
801083de:	83 ec 18             	sub    $0x18,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801083e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801083e4:	25 ff 0f 00 00       	and    $0xfff,%eax
801083e9:	85 c0                	test   %eax,%eax
801083eb:	74 0d                	je     801083fa <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
801083ed:	83 ec 0c             	sub    $0xc,%esp
801083f0:	68 ac 90 10 80       	push   $0x801090ac
801083f5:	e8 a6 81 ff ff       	call   801005a0 <panic>
  for(i = 0; i < sz; i += PGSIZE){
801083fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108401:	e9 8f 00 00 00       	jmp    80108495 <loaduvm+0xba>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108406:	8b 55 0c             	mov    0xc(%ebp),%edx
80108409:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010840c:	01 d0                	add    %edx,%eax
8010840e:	83 ec 04             	sub    $0x4,%esp
80108411:	6a 00                	push   $0x0
80108413:	50                   	push   %eax
80108414:	ff 75 08             	pushl  0x8(%ebp)
80108417:	e8 f5 fb ff ff       	call   80108011 <walkpgdir>
8010841c:	83 c4 10             	add    $0x10,%esp
8010841f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108422:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108426:	75 0d                	jne    80108435 <loaduvm+0x5a>
      panic("loaduvm: address should exist");
80108428:	83 ec 0c             	sub    $0xc,%esp
8010842b:	68 cf 90 10 80       	push   $0x801090cf
80108430:	e8 6b 81 ff ff       	call   801005a0 <panic>
    pa = PTE_ADDR(*pte);
80108435:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108438:	8b 00                	mov    (%eax),%eax
8010843a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010843f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80108442:	8b 45 18             	mov    0x18(%ebp),%eax
80108445:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108448:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010844d:	77 0b                	ja     8010845a <loaduvm+0x7f>
      n = sz - i;
8010844f:	8b 45 18             	mov    0x18(%ebp),%eax
80108452:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108455:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108458:	eb 07                	jmp    80108461 <loaduvm+0x86>
    else
      n = PGSIZE;
8010845a:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108461:	8b 55 14             	mov    0x14(%ebp),%edx
80108464:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108467:	01 d0                	add    %edx,%eax
80108469:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010846c:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80108472:	ff 75 f0             	pushl  -0x10(%ebp)
80108475:	50                   	push   %eax
80108476:	52                   	push   %edx
80108477:	ff 75 10             	pushl  0x10(%ebp)
8010847a:	e8 8c 9a ff ff       	call   80101f0b <readi>
8010847f:	83 c4 10             	add    $0x10,%esp
80108482:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108485:	74 07                	je     8010848e <loaduvm+0xb3>
      return -1;
80108487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010848c:	eb 18                	jmp    801084a6 <loaduvm+0xcb>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
8010848e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108495:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108498:	3b 45 18             	cmp    0x18(%ebp),%eax
8010849b:	0f 82 65 ff ff ff    	jb     80108406 <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801084a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
801084a6:	c9                   	leave  
801084a7:	c3                   	ret    

801084a8 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801084a8:	55                   	push   %ebp
801084a9:	89 e5                	mov    %esp,%ebp
801084ab:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801084ae:	8b 45 10             	mov    0x10(%ebp),%eax
801084b1:	85 c0                	test   %eax,%eax
801084b3:	79 0a                	jns    801084bf <allocuvm+0x17>
    return 0;
801084b5:	b8 00 00 00 00       	mov    $0x0,%eax
801084ba:	e9 ec 00 00 00       	jmp    801085ab <allocuvm+0x103>
  if(newsz < oldsz)
801084bf:	8b 45 10             	mov    0x10(%ebp),%eax
801084c2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084c5:	73 08                	jae    801084cf <allocuvm+0x27>
    return oldsz;
801084c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801084ca:	e9 dc 00 00 00       	jmp    801085ab <allocuvm+0x103>

  a = PGROUNDUP(oldsz);
801084cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801084d2:	05 ff 0f 00 00       	add    $0xfff,%eax
801084d7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
801084df:	e9 b8 00 00 00       	jmp    8010859c <allocuvm+0xf4>
    mem = kalloc();
801084e4:	e8 de a7 ff ff       	call   80102cc7 <kalloc>
801084e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801084ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801084f0:	75 2e                	jne    80108520 <allocuvm+0x78>
      cprintf("allocuvm out of memory\n");
801084f2:	83 ec 0c             	sub    $0xc,%esp
801084f5:	68 ed 90 10 80       	push   $0x801090ed
801084fa:	e8 01 7f ff ff       	call   80100400 <cprintf>
801084ff:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80108502:	83 ec 04             	sub    $0x4,%esp
80108505:	ff 75 0c             	pushl  0xc(%ebp)
80108508:	ff 75 10             	pushl  0x10(%ebp)
8010850b:	ff 75 08             	pushl  0x8(%ebp)
8010850e:	e8 9a 00 00 00       	call   801085ad <deallocuvm>
80108513:	83 c4 10             	add    $0x10,%esp
      return 0;
80108516:	b8 00 00 00 00       	mov    $0x0,%eax
8010851b:	e9 8b 00 00 00       	jmp    801085ab <allocuvm+0x103>
    }
    memset(mem, 0, PGSIZE);
80108520:	83 ec 04             	sub    $0x4,%esp
80108523:	68 00 10 00 00       	push   $0x1000
80108528:	6a 00                	push   $0x0
8010852a:	ff 75 f0             	pushl  -0x10(%ebp)
8010852d:	e8 36 ce ff ff       	call   80105368 <memset>
80108532:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108535:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108538:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
8010853e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108541:	83 ec 0c             	sub    $0xc,%esp
80108544:	6a 06                	push   $0x6
80108546:	52                   	push   %edx
80108547:	68 00 10 00 00       	push   $0x1000
8010854c:	50                   	push   %eax
8010854d:	ff 75 08             	pushl  0x8(%ebp)
80108550:	e8 52 fb ff ff       	call   801080a7 <mappages>
80108555:	83 c4 20             	add    $0x20,%esp
80108558:	85 c0                	test   %eax,%eax
8010855a:	79 39                	jns    80108595 <allocuvm+0xed>
      cprintf("allocuvm out of memory (2)\n");
8010855c:	83 ec 0c             	sub    $0xc,%esp
8010855f:	68 05 91 10 80       	push   $0x80109105
80108564:	e8 97 7e ff ff       	call   80100400 <cprintf>
80108569:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010856c:	83 ec 04             	sub    $0x4,%esp
8010856f:	ff 75 0c             	pushl  0xc(%ebp)
80108572:	ff 75 10             	pushl  0x10(%ebp)
80108575:	ff 75 08             	pushl  0x8(%ebp)
80108578:	e8 30 00 00 00       	call   801085ad <deallocuvm>
8010857d:	83 c4 10             	add    $0x10,%esp
      kfree(mem);
80108580:	83 ec 0c             	sub    $0xc,%esp
80108583:	ff 75 f0             	pushl  -0x10(%ebp)
80108586:	e8 a2 a6 ff ff       	call   80102c2d <kfree>
8010858b:	83 c4 10             	add    $0x10,%esp
      return 0;
8010858e:	b8 00 00 00 00       	mov    $0x0,%eax
80108593:	eb 16                	jmp    801085ab <allocuvm+0x103>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108595:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010859c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010859f:	3b 45 10             	cmp    0x10(%ebp),%eax
801085a2:	0f 82 3c ff ff ff    	jb     801084e4 <allocuvm+0x3c>
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
    }
  }
  return newsz;
801085a8:	8b 45 10             	mov    0x10(%ebp),%eax
}
801085ab:	c9                   	leave  
801085ac:	c3                   	ret    

801085ad <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801085ad:	55                   	push   %ebp
801085ae:	89 e5                	mov    %esp,%ebp
801085b0:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801085b3:	8b 45 10             	mov    0x10(%ebp),%eax
801085b6:	3b 45 0c             	cmp    0xc(%ebp),%eax
801085b9:	72 08                	jb     801085c3 <deallocuvm+0x16>
    return oldsz;
801085bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801085be:	e9 82 00 00 00       	jmp    80108645 <deallocuvm+0x98>

  a = PGROUNDUP(newsz);
801085c3:	8b 45 10             	mov    0x10(%ebp),%eax
801085c6:	05 ff 0f 00 00       	add    $0xfff,%eax
801085cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801085d3:	eb 65                	jmp    8010863a <deallocuvm+0x8d>
    pte = walkpgdir(pgdir, (char*)a, 0);
801085d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085d8:	83 ec 04             	sub    $0x4,%esp
801085db:	6a 00                	push   $0x0
801085dd:	50                   	push   %eax
801085de:	ff 75 08             	pushl  0x8(%ebp)
801085e1:	e8 2b fa ff ff       	call   80108011 <walkpgdir>
801085e6:	83 c4 10             	add    $0x10,%esp
801085e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte) ;
801085ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801085f0:	74 41                	je     80108633 <deallocuvm+0x86>
    else if((*pte & PTE_P) != 0){
801085f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085f5:	8b 00                	mov    (%eax),%eax
801085f7:	83 e0 01             	and    $0x1,%eax
801085fa:	85 c0                	test   %eax,%eax
801085fc:	74 35                	je     80108633 <deallocuvm+0x86>
      pa = PTE_ADDR(*pte);
801085fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108601:	8b 00                	mov    (%eax),%eax
80108603:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108608:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa != 0)
8010860b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010860f:	74 22                	je     80108633 <deallocuvm+0x86>
      {
      	char *v = P2V(pa);
80108611:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108614:	05 00 00 00 80       	add    $0x80000000,%eax
80108619:	89 45 e8             	mov    %eax,-0x18(%ebp)
      	kfree(v);
8010861c:	83 ec 0c             	sub    $0xc,%esp
8010861f:	ff 75 e8             	pushl  -0x18(%ebp)
80108622:	e8 06 a6 ff ff       	call   80102c2d <kfree>
80108627:	83 c4 10             	add    $0x10,%esp
      	*pte = 0;
8010862a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010862d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80108633:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010863a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010863d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108640:	72 93                	jb     801085d5 <deallocuvm+0x28>
      	kfree(v);
      	*pte = 0;
      }
    }
  }
  return newsz;
80108642:	8b 45 10             	mov    0x10(%ebp),%eax
}
80108645:	c9                   	leave  
80108646:	c3                   	ret    

80108647 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108647:	55                   	push   %ebp
80108648:	89 e5                	mov    %esp,%ebp
8010864a:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
8010864d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108651:	75 0d                	jne    80108660 <freevm+0x19>
    panic("freevm: no pgdir");
80108653:	83 ec 0c             	sub    $0xc,%esp
80108656:	68 21 91 10 80       	push   $0x80109121
8010865b:	e8 40 7f ff ff       	call   801005a0 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108660:	83 ec 04             	sub    $0x4,%esp
80108663:	6a 00                	push   $0x0
80108665:	68 00 00 00 80       	push   $0x80000000
8010866a:	ff 75 08             	pushl  0x8(%ebp)
8010866d:	e8 3b ff ff ff       	call   801085ad <deallocuvm>
80108672:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108675:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010867c:	eb 48                	jmp    801086c6 <freevm+0x7f>
    if(pgdir[i] & PTE_P){
8010867e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108681:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108688:	8b 45 08             	mov    0x8(%ebp),%eax
8010868b:	01 d0                	add    %edx,%eax
8010868d:	8b 00                	mov    (%eax),%eax
8010868f:	83 e0 01             	and    $0x1,%eax
80108692:	85 c0                	test   %eax,%eax
80108694:	74 2c                	je     801086c2 <freevm+0x7b>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108696:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108699:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801086a0:	8b 45 08             	mov    0x8(%ebp),%eax
801086a3:	01 d0                	add    %edx,%eax
801086a5:	8b 00                	mov    (%eax),%eax
801086a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086ac:	05 00 00 00 80       	add    $0x80000000,%eax
801086b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
801086b4:	83 ec 0c             	sub    $0xc,%esp
801086b7:	ff 75 f0             	pushl  -0x10(%ebp)
801086ba:	e8 6e a5 ff ff       	call   80102c2d <kfree>
801086bf:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801086c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801086c6:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801086cd:	76 af                	jbe    8010867e <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801086cf:	83 ec 0c             	sub    $0xc,%esp
801086d2:	ff 75 08             	pushl  0x8(%ebp)
801086d5:	e8 53 a5 ff ff       	call   80102c2d <kfree>
801086da:	83 c4 10             	add    $0x10,%esp
}
801086dd:	90                   	nop
801086de:	c9                   	leave  
801086df:	c3                   	ret    

801086e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801086e0:	55                   	push   %ebp
801086e1:	89 e5                	mov    %esp,%ebp
801086e3:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801086e6:	83 ec 04             	sub    $0x4,%esp
801086e9:	6a 00                	push   $0x0
801086eb:	ff 75 0c             	pushl  0xc(%ebp)
801086ee:	ff 75 08             	pushl  0x8(%ebp)
801086f1:	e8 1b f9 ff ff       	call   80108011 <walkpgdir>
801086f6:	83 c4 10             	add    $0x10,%esp
801086f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801086fc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108700:	75 0d                	jne    8010870f <clearpteu+0x2f>
    panic("clearpteu");
80108702:	83 ec 0c             	sub    $0xc,%esp
80108705:	68 32 91 10 80       	push   $0x80109132
8010870a:	e8 91 7e ff ff       	call   801005a0 <panic>
  *pte &= ~PTE_U;
8010870f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108712:	8b 00                	mov    (%eax),%eax
80108714:	83 e0 fb             	and    $0xfffffffb,%eax
80108717:	89 c2                	mov    %eax,%edx
80108719:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010871c:	89 10                	mov    %edx,(%eax)
}
8010871e:	90                   	nop
8010871f:	c9                   	leave  
80108720:	c3                   	ret    

80108721 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108721:	55                   	push   %ebp
80108722:	89 e5                	mov    %esp,%ebp
80108724:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108727:	e8 0b fa ff ff       	call   80108137 <setupkvm>
8010872c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010872f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108733:	75 0a                	jne    8010873f <copyuvm+0x1e>
    return 0;
80108735:	b8 00 00 00 00       	mov    $0x0,%eax
8010873a:	e9 de 00 00 00       	jmp    8010881d <copyuvm+0xfc>
  for(i = 0; i < sz; i += PGSIZE){
8010873f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108746:	e9 aa 00 00 00       	jmp    801087f5 <copyuvm+0xd4>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010874b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010874e:	83 ec 04             	sub    $0x4,%esp
80108751:	6a 00                	push   $0x0
80108753:	50                   	push   %eax
80108754:	ff 75 08             	pushl  0x8(%ebp)
80108757:	e8 b5 f8 ff ff       	call   80108011 <walkpgdir>
8010875c:	83 c4 10             	add    $0x10,%esp
8010875f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108762:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108766:	75 0d                	jne    80108775 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
80108768:	83 ec 0c             	sub    $0xc,%esp
8010876b:	68 3c 91 10 80       	push   $0x8010913c
80108770:	e8 2b 7e ff ff       	call   801005a0 <panic>
    if(*pte & PTE_P)
80108775:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108778:	8b 00                	mov    (%eax),%eax
8010877a:	83 e0 01             	and    $0x1,%eax
8010877d:	85 c0                	test   %eax,%eax
8010877f:	74 6d                	je     801087ee <copyuvm+0xcd>
    {
      pa = PTE_ADDR(*pte);
80108781:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108784:	8b 00                	mov    (%eax),%eax
80108786:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010878b:	89 45 e8             	mov    %eax,-0x18(%ebp)
      flags = PTE_FLAGS(*pte);
8010878e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108791:	8b 00                	mov    (%eax),%eax
80108793:	25 ff 0f 00 00       	and    $0xfff,%eax
80108798:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if((mem = kalloc()) == 0)
8010879b:	e8 27 a5 ff ff       	call   80102cc7 <kalloc>
801087a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801087a3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801087a7:	74 5d                	je     80108806 <copyuvm+0xe5>
        goto bad;
      memmove(mem, (char*)P2V(pa), PGSIZE);
801087a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801087ac:	05 00 00 00 80       	add    $0x80000000,%eax
801087b1:	83 ec 04             	sub    $0x4,%esp
801087b4:	68 00 10 00 00       	push   $0x1000
801087b9:	50                   	push   %eax
801087ba:	ff 75 e0             	pushl  -0x20(%ebp)
801087bd:	e8 65 cc ff ff       	call   80105427 <memmove>
801087c2:	83 c4 10             	add    $0x10,%esp
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801087c5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801087c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801087cb:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801087d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087d4:	83 ec 0c             	sub    $0xc,%esp
801087d7:	52                   	push   %edx
801087d8:	51                   	push   %ecx
801087d9:	68 00 10 00 00       	push   $0x1000
801087de:	50                   	push   %eax
801087df:	ff 75 f0             	pushl  -0x10(%ebp)
801087e2:	e8 c0 f8 ff ff       	call   801080a7 <mappages>
801087e7:	83 c4 20             	add    $0x20,%esp
801087ea:	85 c0                	test   %eax,%eax
801087ec:	78 1b                	js     80108809 <copyuvm+0xe8>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801087ee:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801087f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
801087fb:	0f 82 4a ff ff ff    	jb     8010874b <copyuvm+0x2a>
      memmove(mem, (char*)P2V(pa), PGSIZE);
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
        goto bad;
    }
  }
  return d;
80108801:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108804:	eb 17                	jmp    8010881d <copyuvm+0xfc>
    if(*pte & PTE_P)
    {
      pa = PTE_ADDR(*pte);
      flags = PTE_FLAGS(*pte);
      if((mem = kalloc()) == 0)
        goto bad;
80108806:	90                   	nop
80108807:	eb 01                	jmp    8010880a <copyuvm+0xe9>
      memmove(mem, (char*)P2V(pa), PGSIZE);
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
        goto bad;
80108809:	90                   	nop
    }
  }
  return d;

bad:
  freevm(d);
8010880a:	83 ec 0c             	sub    $0xc,%esp
8010880d:	ff 75 f0             	pushl  -0x10(%ebp)
80108810:	e8 32 fe ff ff       	call   80108647 <freevm>
80108815:	83 c4 10             	add    $0x10,%esp
  return 0;
80108818:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010881d:	c9                   	leave  
8010881e:	c3                   	ret    

8010881f <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010881f:	55                   	push   %ebp
80108820:	89 e5                	mov    %esp,%ebp
80108822:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108825:	83 ec 04             	sub    $0x4,%esp
80108828:	6a 00                	push   $0x0
8010882a:	ff 75 0c             	pushl  0xc(%ebp)
8010882d:	ff 75 08             	pushl  0x8(%ebp)
80108830:	e8 dc f7 ff ff       	call   80108011 <walkpgdir>
80108835:	83 c4 10             	add    $0x10,%esp
80108838:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010883b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010883e:	8b 00                	mov    (%eax),%eax
80108840:	83 e0 01             	and    $0x1,%eax
80108843:	85 c0                	test   %eax,%eax
80108845:	75 07                	jne    8010884e <uva2ka+0x2f>
    return 0;
80108847:	b8 00 00 00 00       	mov    $0x0,%eax
8010884c:	eb 22                	jmp    80108870 <uva2ka+0x51>
  if((*pte & PTE_U) == 0)
8010884e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108851:	8b 00                	mov    (%eax),%eax
80108853:	83 e0 04             	and    $0x4,%eax
80108856:	85 c0                	test   %eax,%eax
80108858:	75 07                	jne    80108861 <uva2ka+0x42>
    return 0;
8010885a:	b8 00 00 00 00       	mov    $0x0,%eax
8010885f:	eb 0f                	jmp    80108870 <uva2ka+0x51>
  return (char*)P2V(PTE_ADDR(*pte));
80108861:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108864:	8b 00                	mov    (%eax),%eax
80108866:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010886b:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108870:	c9                   	leave  
80108871:	c3                   	ret    

80108872 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108872:	55                   	push   %ebp
80108873:	89 e5                	mov    %esp,%ebp
80108875:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108878:	8b 45 10             	mov    0x10(%ebp),%eax
8010887b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010887e:	eb 7f                	jmp    801088ff <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80108880:	8b 45 0c             	mov    0xc(%ebp),%eax
80108883:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108888:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010888b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010888e:	83 ec 08             	sub    $0x8,%esp
80108891:	50                   	push   %eax
80108892:	ff 75 08             	pushl  0x8(%ebp)
80108895:	e8 85 ff ff ff       	call   8010881f <uva2ka>
8010889a:	83 c4 10             	add    $0x10,%esp
8010889d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
801088a0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801088a4:	75 07                	jne    801088ad <copyout+0x3b>
      return -1;
801088a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801088ab:	eb 61                	jmp    8010890e <copyout+0x9c>
    n = PGSIZE - (va - va0);
801088ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
801088b0:	2b 45 0c             	sub    0xc(%ebp),%eax
801088b3:	05 00 10 00 00       	add    $0x1000,%eax
801088b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801088bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088be:	3b 45 14             	cmp    0x14(%ebp),%eax
801088c1:	76 06                	jbe    801088c9 <copyout+0x57>
      n = len;
801088c3:	8b 45 14             	mov    0x14(%ebp),%eax
801088c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801088c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801088cc:	2b 45 ec             	sub    -0x14(%ebp),%eax
801088cf:	89 c2                	mov    %eax,%edx
801088d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801088d4:	01 d0                	add    %edx,%eax
801088d6:	83 ec 04             	sub    $0x4,%esp
801088d9:	ff 75 f0             	pushl  -0x10(%ebp)
801088dc:	ff 75 f4             	pushl  -0xc(%ebp)
801088df:	50                   	push   %eax
801088e0:	e8 42 cb ff ff       	call   80105427 <memmove>
801088e5:	83 c4 10             	add    $0x10,%esp
    len -= n;
801088e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088eb:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801088ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801088f1:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801088f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801088f7:	05 00 10 00 00       	add    $0x1000,%eax
801088fc:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801088ff:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108903:	0f 85 77 ff ff ff    	jne    80108880 <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108909:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010890e:	c9                   	leave  
8010890f:	c3                   	ret    
