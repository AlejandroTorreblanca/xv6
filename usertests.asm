
_usertests:     formato del fichero elf32-i386


Desensamblado de la sección .text:

00000000 <iputtest>:
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
       6:	a1 0c 64 00 00       	mov    0x640c,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 06 45 00 00       	push   $0x4506
      13:	50                   	push   %eax
      14:	e8 fd 40 00 00       	call   4116 <printf>
      19:	83 c4 10             	add    $0x10,%esp
      1c:	83 ec 0c             	sub    $0xc,%esp
      1f:	68 11 45 00 00       	push   $0x4511
      24:	e8 c5 3f 00 00       	call   3fee <mkdir>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	79 1b                	jns    4b <iputtest+0x4b>
      30:	a1 0c 64 00 00       	mov    0x640c,%eax
      35:	83 ec 08             	sub    $0x8,%esp
      38:	68 19 45 00 00       	push   $0x4519
      3d:	50                   	push   %eax
      3e:	e8 d3 40 00 00       	call   4116 <printf>
      43:	83 c4 10             	add    $0x10,%esp
      46:	e8 3b 3f 00 00       	call   3f86 <exit>
      4b:	83 ec 0c             	sub    $0xc,%esp
      4e:	68 11 45 00 00       	push   $0x4511
      53:	e8 9e 3f 00 00       	call   3ff6 <chdir>
      58:	83 c4 10             	add    $0x10,%esp
      5b:	85 c0                	test   %eax,%eax
      5d:	79 1b                	jns    7a <iputtest+0x7a>
      5f:	a1 0c 64 00 00       	mov    0x640c,%eax
      64:	83 ec 08             	sub    $0x8,%esp
      67:	68 27 45 00 00       	push   $0x4527
      6c:	50                   	push   %eax
      6d:	e8 a4 40 00 00       	call   4116 <printf>
      72:	83 c4 10             	add    $0x10,%esp
      75:	e8 0c 3f 00 00       	call   3f86 <exit>
      7a:	83 ec 0c             	sub    $0xc,%esp
      7d:	68 3d 45 00 00       	push   $0x453d
      82:	e8 4f 3f 00 00       	call   3fd6 <unlink>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	85 c0                	test   %eax,%eax
      8c:	79 1b                	jns    a9 <iputtest+0xa9>
      8e:	a1 0c 64 00 00       	mov    0x640c,%eax
      93:	83 ec 08             	sub    $0x8,%esp
      96:	68 48 45 00 00       	push   $0x4548
      9b:	50                   	push   %eax
      9c:	e8 75 40 00 00       	call   4116 <printf>
      a1:	83 c4 10             	add    $0x10,%esp
      a4:	e8 dd 3e 00 00       	call   3f86 <exit>
      a9:	83 ec 0c             	sub    $0xc,%esp
      ac:	68 62 45 00 00       	push   $0x4562
      b1:	e8 40 3f 00 00       	call   3ff6 <chdir>
      b6:	83 c4 10             	add    $0x10,%esp
      b9:	85 c0                	test   %eax,%eax
      bb:	79 1b                	jns    d8 <iputtest+0xd8>
      bd:	a1 0c 64 00 00       	mov    0x640c,%eax
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	68 64 45 00 00       	push   $0x4564
      ca:	50                   	push   %eax
      cb:	e8 46 40 00 00       	call   4116 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
      d3:	e8 ae 3e 00 00       	call   3f86 <exit>
      d8:	a1 0c 64 00 00       	mov    0x640c,%eax
      dd:	83 ec 08             	sub    $0x8,%esp
      e0:	68 74 45 00 00       	push   $0x4574
      e5:	50                   	push   %eax
      e6:	e8 2b 40 00 00       	call   4116 <printf>
      eb:	83 c4 10             	add    $0x10,%esp
      ee:	90                   	nop
      ef:	c9                   	leave  
      f0:	c3                   	ret    

000000f1 <exitiputtest>:
      f1:	55                   	push   %ebp
      f2:	89 e5                	mov    %esp,%ebp
      f4:	83 ec 18             	sub    $0x18,%esp
      f7:	a1 0c 64 00 00       	mov    0x640c,%eax
      fc:	83 ec 08             	sub    $0x8,%esp
      ff:	68 82 45 00 00       	push   $0x4582
     104:	50                   	push   %eax
     105:	e8 0c 40 00 00       	call   4116 <printf>
     10a:	83 c4 10             	add    $0x10,%esp
     10d:	e8 6c 3e 00 00       	call   3f7e <fork>
     112:	89 45 f4             	mov    %eax,-0xc(%ebp)
     115:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     119:	79 1b                	jns    136 <exitiputtest+0x45>
     11b:	a1 0c 64 00 00       	mov    0x640c,%eax
     120:	83 ec 08             	sub    $0x8,%esp
     123:	68 91 45 00 00       	push   $0x4591
     128:	50                   	push   %eax
     129:	e8 e8 3f 00 00       	call   4116 <printf>
     12e:	83 c4 10             	add    $0x10,%esp
     131:	e8 50 3e 00 00       	call   3f86 <exit>
     136:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     13a:	0f 85 92 00 00 00    	jne    1d2 <exitiputtest+0xe1>
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 11 45 00 00       	push   $0x4511
     148:	e8 a1 3e 00 00       	call   3fee <mkdir>
     14d:	83 c4 10             	add    $0x10,%esp
     150:	85 c0                	test   %eax,%eax
     152:	79 1b                	jns    16f <exitiputtest+0x7e>
     154:	a1 0c 64 00 00       	mov    0x640c,%eax
     159:	83 ec 08             	sub    $0x8,%esp
     15c:	68 19 45 00 00       	push   $0x4519
     161:	50                   	push   %eax
     162:	e8 af 3f 00 00       	call   4116 <printf>
     167:	83 c4 10             	add    $0x10,%esp
     16a:	e8 17 3e 00 00       	call   3f86 <exit>
     16f:	83 ec 0c             	sub    $0xc,%esp
     172:	68 11 45 00 00       	push   $0x4511
     177:	e8 7a 3e 00 00       	call   3ff6 <chdir>
     17c:	83 c4 10             	add    $0x10,%esp
     17f:	85 c0                	test   %eax,%eax
     181:	79 1b                	jns    19e <exitiputtest+0xad>
     183:	a1 0c 64 00 00       	mov    0x640c,%eax
     188:	83 ec 08             	sub    $0x8,%esp
     18b:	68 9e 45 00 00       	push   $0x459e
     190:	50                   	push   %eax
     191:	e8 80 3f 00 00       	call   4116 <printf>
     196:	83 c4 10             	add    $0x10,%esp
     199:	e8 e8 3d 00 00       	call   3f86 <exit>
     19e:	83 ec 0c             	sub    $0xc,%esp
     1a1:	68 3d 45 00 00       	push   $0x453d
     1a6:	e8 2b 3e 00 00       	call   3fd6 <unlink>
     1ab:	83 c4 10             	add    $0x10,%esp
     1ae:	85 c0                	test   %eax,%eax
     1b0:	79 1b                	jns    1cd <exitiputtest+0xdc>
     1b2:	a1 0c 64 00 00       	mov    0x640c,%eax
     1b7:	83 ec 08             	sub    $0x8,%esp
     1ba:	68 48 45 00 00       	push   $0x4548
     1bf:	50                   	push   %eax
     1c0:	e8 51 3f 00 00       	call   4116 <printf>
     1c5:	83 c4 10             	add    $0x10,%esp
     1c8:	e8 b9 3d 00 00       	call   3f86 <exit>
     1cd:	e8 b4 3d 00 00       	call   3f86 <exit>
     1d2:	e8 b7 3d 00 00       	call   3f8e <wait>
     1d7:	a1 0c 64 00 00       	mov    0x640c,%eax
     1dc:	83 ec 08             	sub    $0x8,%esp
     1df:	68 b2 45 00 00       	push   $0x45b2
     1e4:	50                   	push   %eax
     1e5:	e8 2c 3f 00 00       	call   4116 <printf>
     1ea:	83 c4 10             	add    $0x10,%esp
     1ed:	90                   	nop
     1ee:	c9                   	leave  
     1ef:	c3                   	ret    

000001f0 <openiputtest>:
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 18             	sub    $0x18,%esp
     1f6:	a1 0c 64 00 00       	mov    0x640c,%eax
     1fb:	83 ec 08             	sub    $0x8,%esp
     1fe:	68 c4 45 00 00       	push   $0x45c4
     203:	50                   	push   %eax
     204:	e8 0d 3f 00 00       	call   4116 <printf>
     209:	83 c4 10             	add    $0x10,%esp
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	68 d3 45 00 00       	push   $0x45d3
     214:	e8 d5 3d 00 00       	call   3fee <mkdir>
     219:	83 c4 10             	add    $0x10,%esp
     21c:	85 c0                	test   %eax,%eax
     21e:	79 1b                	jns    23b <openiputtest+0x4b>
     220:	a1 0c 64 00 00       	mov    0x640c,%eax
     225:	83 ec 08             	sub    $0x8,%esp
     228:	68 d9 45 00 00       	push   $0x45d9
     22d:	50                   	push   %eax
     22e:	e8 e3 3e 00 00       	call   4116 <printf>
     233:	83 c4 10             	add    $0x10,%esp
     236:	e8 4b 3d 00 00       	call   3f86 <exit>
     23b:	e8 3e 3d 00 00       	call   3f7e <fork>
     240:	89 45 f4             	mov    %eax,-0xc(%ebp)
     243:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     247:	79 1b                	jns    264 <openiputtest+0x74>
     249:	a1 0c 64 00 00       	mov    0x640c,%eax
     24e:	83 ec 08             	sub    $0x8,%esp
     251:	68 91 45 00 00       	push   $0x4591
     256:	50                   	push   %eax
     257:	e8 ba 3e 00 00       	call   4116 <printf>
     25c:	83 c4 10             	add    $0x10,%esp
     25f:	e8 22 3d 00 00       	call   3f86 <exit>
     264:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     268:	75 3b                	jne    2a5 <openiputtest+0xb5>
     26a:	83 ec 08             	sub    $0x8,%esp
     26d:	6a 02                	push   $0x2
     26f:	68 d3 45 00 00       	push   $0x45d3
     274:	e8 4d 3d 00 00       	call   3fc6 <open>
     279:	83 c4 10             	add    $0x10,%esp
     27c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     27f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     283:	78 1b                	js     2a0 <openiputtest+0xb0>
     285:	a1 0c 64 00 00       	mov    0x640c,%eax
     28a:	83 ec 08             	sub    $0x8,%esp
     28d:	68 f0 45 00 00       	push   $0x45f0
     292:	50                   	push   %eax
     293:	e8 7e 3e 00 00       	call   4116 <printf>
     298:	83 c4 10             	add    $0x10,%esp
     29b:	e8 e6 3c 00 00       	call   3f86 <exit>
     2a0:	e8 e1 3c 00 00       	call   3f86 <exit>
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	6a 01                	push   $0x1
     2aa:	e8 67 3d 00 00       	call   4016 <sleep>
     2af:	83 c4 10             	add    $0x10,%esp
     2b2:	83 ec 0c             	sub    $0xc,%esp
     2b5:	68 d3 45 00 00       	push   $0x45d3
     2ba:	e8 17 3d 00 00       	call   3fd6 <unlink>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	85 c0                	test   %eax,%eax
     2c4:	74 1b                	je     2e1 <openiputtest+0xf1>
     2c6:	a1 0c 64 00 00       	mov    0x640c,%eax
     2cb:	83 ec 08             	sub    $0x8,%esp
     2ce:	68 14 46 00 00       	push   $0x4614
     2d3:	50                   	push   %eax
     2d4:	e8 3d 3e 00 00       	call   4116 <printf>
     2d9:	83 c4 10             	add    $0x10,%esp
     2dc:	e8 a5 3c 00 00       	call   3f86 <exit>
     2e1:	e8 a8 3c 00 00       	call   3f8e <wait>
     2e6:	a1 0c 64 00 00       	mov    0x640c,%eax
     2eb:	83 ec 08             	sub    $0x8,%esp
     2ee:	68 23 46 00 00       	push   $0x4623
     2f3:	50                   	push   %eax
     2f4:	e8 1d 3e 00 00       	call   4116 <printf>
     2f9:	83 c4 10             	add    $0x10,%esp
     2fc:	90                   	nop
     2fd:	c9                   	leave  
     2fe:	c3                   	ret    

000002ff <opentest>:
     2ff:	55                   	push   %ebp
     300:	89 e5                	mov    %esp,%ebp
     302:	83 ec 18             	sub    $0x18,%esp
     305:	a1 0c 64 00 00       	mov    0x640c,%eax
     30a:	83 ec 08             	sub    $0x8,%esp
     30d:	68 35 46 00 00       	push   $0x4635
     312:	50                   	push   %eax
     313:	e8 fe 3d 00 00       	call   4116 <printf>
     318:	83 c4 10             	add    $0x10,%esp
     31b:	83 ec 08             	sub    $0x8,%esp
     31e:	6a 00                	push   $0x0
     320:	68 f0 44 00 00       	push   $0x44f0
     325:	e8 9c 3c 00 00       	call   3fc6 <open>
     32a:	83 c4 10             	add    $0x10,%esp
     32d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     330:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     334:	79 1b                	jns    351 <opentest+0x52>
     336:	a1 0c 64 00 00       	mov    0x640c,%eax
     33b:	83 ec 08             	sub    $0x8,%esp
     33e:	68 40 46 00 00       	push   $0x4640
     343:	50                   	push   %eax
     344:	e8 cd 3d 00 00       	call   4116 <printf>
     349:	83 c4 10             	add    $0x10,%esp
     34c:	e8 35 3c 00 00       	call   3f86 <exit>
     351:	83 ec 0c             	sub    $0xc,%esp
     354:	ff 75 f4             	pushl  -0xc(%ebp)
     357:	e8 52 3c 00 00       	call   3fae <close>
     35c:	83 c4 10             	add    $0x10,%esp
     35f:	83 ec 08             	sub    $0x8,%esp
     362:	6a 00                	push   $0x0
     364:	68 53 46 00 00       	push   $0x4653
     369:	e8 58 3c 00 00       	call   3fc6 <open>
     36e:	83 c4 10             	add    $0x10,%esp
     371:	89 45 f4             	mov    %eax,-0xc(%ebp)
     374:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     378:	78 1b                	js     395 <opentest+0x96>
     37a:	a1 0c 64 00 00       	mov    0x640c,%eax
     37f:	83 ec 08             	sub    $0x8,%esp
     382:	68 60 46 00 00       	push   $0x4660
     387:	50                   	push   %eax
     388:	e8 89 3d 00 00       	call   4116 <printf>
     38d:	83 c4 10             	add    $0x10,%esp
     390:	e8 f1 3b 00 00       	call   3f86 <exit>
     395:	a1 0c 64 00 00       	mov    0x640c,%eax
     39a:	83 ec 08             	sub    $0x8,%esp
     39d:	68 7e 46 00 00       	push   $0x467e
     3a2:	50                   	push   %eax
     3a3:	e8 6e 3d 00 00       	call   4116 <printf>
     3a8:	83 c4 10             	add    $0x10,%esp
     3ab:	90                   	nop
     3ac:	c9                   	leave  
     3ad:	c3                   	ret    

000003ae <writetest>:
     3ae:	55                   	push   %ebp
     3af:	89 e5                	mov    %esp,%ebp
     3b1:	83 ec 18             	sub    $0x18,%esp
     3b4:	a1 0c 64 00 00       	mov    0x640c,%eax
     3b9:	83 ec 08             	sub    $0x8,%esp
     3bc:	68 8c 46 00 00       	push   $0x468c
     3c1:	50                   	push   %eax
     3c2:	e8 4f 3d 00 00       	call   4116 <printf>
     3c7:	83 c4 10             	add    $0x10,%esp
     3ca:	83 ec 08             	sub    $0x8,%esp
     3cd:	68 02 02 00 00       	push   $0x202
     3d2:	68 9d 46 00 00       	push   $0x469d
     3d7:	e8 ea 3b 00 00       	call   3fc6 <open>
     3dc:	83 c4 10             	add    $0x10,%esp
     3df:	89 45 f0             	mov    %eax,-0x10(%ebp)
     3e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3e6:	78 22                	js     40a <writetest+0x5c>
     3e8:	a1 0c 64 00 00       	mov    0x640c,%eax
     3ed:	83 ec 08             	sub    $0x8,%esp
     3f0:	68 a3 46 00 00       	push   $0x46a3
     3f5:	50                   	push   %eax
     3f6:	e8 1b 3d 00 00       	call   4116 <printf>
     3fb:	83 c4 10             	add    $0x10,%esp
     3fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     405:	e9 8f 00 00 00       	jmp    499 <writetest+0xeb>
     40a:	a1 0c 64 00 00       	mov    0x640c,%eax
     40f:	83 ec 08             	sub    $0x8,%esp
     412:	68 be 46 00 00       	push   $0x46be
     417:	50                   	push   %eax
     418:	e8 f9 3c 00 00       	call   4116 <printf>
     41d:	83 c4 10             	add    $0x10,%esp
     420:	e8 61 3b 00 00       	call   3f86 <exit>
     425:	83 ec 04             	sub    $0x4,%esp
     428:	6a 0a                	push   $0xa
     42a:	68 da 46 00 00       	push   $0x46da
     42f:	ff 75 f0             	pushl  -0x10(%ebp)
     432:	e8 6f 3b 00 00       	call   3fa6 <write>
     437:	83 c4 10             	add    $0x10,%esp
     43a:	83 f8 0a             	cmp    $0xa,%eax
     43d:	74 1e                	je     45d <writetest+0xaf>
     43f:	a1 0c 64 00 00       	mov    0x640c,%eax
     444:	83 ec 04             	sub    $0x4,%esp
     447:	ff 75 f4             	pushl  -0xc(%ebp)
     44a:	68 e8 46 00 00       	push   $0x46e8
     44f:	50                   	push   %eax
     450:	e8 c1 3c 00 00       	call   4116 <printf>
     455:	83 c4 10             	add    $0x10,%esp
     458:	e8 29 3b 00 00       	call   3f86 <exit>
     45d:	83 ec 04             	sub    $0x4,%esp
     460:	6a 0a                	push   $0xa
     462:	68 0c 47 00 00       	push   $0x470c
     467:	ff 75 f0             	pushl  -0x10(%ebp)
     46a:	e8 37 3b 00 00       	call   3fa6 <write>
     46f:	83 c4 10             	add    $0x10,%esp
     472:	83 f8 0a             	cmp    $0xa,%eax
     475:	74 1e                	je     495 <writetest+0xe7>
     477:	a1 0c 64 00 00       	mov    0x640c,%eax
     47c:	83 ec 04             	sub    $0x4,%esp
     47f:	ff 75 f4             	pushl  -0xc(%ebp)
     482:	68 18 47 00 00       	push   $0x4718
     487:	50                   	push   %eax
     488:	e8 89 3c 00 00       	call   4116 <printf>
     48d:	83 c4 10             	add    $0x10,%esp
     490:	e8 f1 3a 00 00       	call   3f86 <exit>
     495:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     499:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     49d:	7e 86                	jle    425 <writetest+0x77>
     49f:	a1 0c 64 00 00       	mov    0x640c,%eax
     4a4:	83 ec 08             	sub    $0x8,%esp
     4a7:	68 3c 47 00 00       	push   $0x473c
     4ac:	50                   	push   %eax
     4ad:	e8 64 3c 00 00       	call   4116 <printf>
     4b2:	83 c4 10             	add    $0x10,%esp
     4b5:	83 ec 0c             	sub    $0xc,%esp
     4b8:	ff 75 f0             	pushl  -0x10(%ebp)
     4bb:	e8 ee 3a 00 00       	call   3fae <close>
     4c0:	83 c4 10             	add    $0x10,%esp
     4c3:	83 ec 08             	sub    $0x8,%esp
     4c6:	6a 00                	push   $0x0
     4c8:	68 9d 46 00 00       	push   $0x469d
     4cd:	e8 f4 3a 00 00       	call   3fc6 <open>
     4d2:	83 c4 10             	add    $0x10,%esp
     4d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     4d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4dc:	78 3c                	js     51a <writetest+0x16c>
     4de:	a1 0c 64 00 00       	mov    0x640c,%eax
     4e3:	83 ec 08             	sub    $0x8,%esp
     4e6:	68 47 47 00 00       	push   $0x4747
     4eb:	50                   	push   %eax
     4ec:	e8 25 3c 00 00       	call   4116 <printf>
     4f1:	83 c4 10             	add    $0x10,%esp
     4f4:	83 ec 04             	sub    $0x4,%esp
     4f7:	68 d0 07 00 00       	push   $0x7d0
     4fc:	68 00 8c 00 00       	push   $0x8c00
     501:	ff 75 f0             	pushl  -0x10(%ebp)
     504:	e8 95 3a 00 00       	call   3f9e <read>
     509:	83 c4 10             	add    $0x10,%esp
     50c:	89 45 f4             	mov    %eax,-0xc(%ebp)
     50f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     516:	75 57                	jne    56f <writetest+0x1c1>
     518:	eb 1b                	jmp    535 <writetest+0x187>
     51a:	a1 0c 64 00 00       	mov    0x640c,%eax
     51f:	83 ec 08             	sub    $0x8,%esp
     522:	68 60 47 00 00       	push   $0x4760
     527:	50                   	push   %eax
     528:	e8 e9 3b 00 00       	call   4116 <printf>
     52d:	83 c4 10             	add    $0x10,%esp
     530:	e8 51 3a 00 00       	call   3f86 <exit>
     535:	a1 0c 64 00 00       	mov    0x640c,%eax
     53a:	83 ec 08             	sub    $0x8,%esp
     53d:	68 7b 47 00 00       	push   $0x477b
     542:	50                   	push   %eax
     543:	e8 ce 3b 00 00       	call   4116 <printf>
     548:	83 c4 10             	add    $0x10,%esp
     54b:	83 ec 0c             	sub    $0xc,%esp
     54e:	ff 75 f0             	pushl  -0x10(%ebp)
     551:	e8 58 3a 00 00       	call   3fae <close>
     556:	83 c4 10             	add    $0x10,%esp
     559:	83 ec 0c             	sub    $0xc,%esp
     55c:	68 9d 46 00 00       	push   $0x469d
     561:	e8 70 3a 00 00       	call   3fd6 <unlink>
     566:	83 c4 10             	add    $0x10,%esp
     569:	85 c0                	test   %eax,%eax
     56b:	79 38                	jns    5a5 <writetest+0x1f7>
     56d:	eb 1b                	jmp    58a <writetest+0x1dc>
     56f:	a1 0c 64 00 00       	mov    0x640c,%eax
     574:	83 ec 08             	sub    $0x8,%esp
     577:	68 8e 47 00 00       	push   $0x478e
     57c:	50                   	push   %eax
     57d:	e8 94 3b 00 00       	call   4116 <printf>
     582:	83 c4 10             	add    $0x10,%esp
     585:	e8 fc 39 00 00       	call   3f86 <exit>
     58a:	a1 0c 64 00 00       	mov    0x640c,%eax
     58f:	83 ec 08             	sub    $0x8,%esp
     592:	68 9b 47 00 00       	push   $0x479b
     597:	50                   	push   %eax
     598:	e8 79 3b 00 00       	call   4116 <printf>
     59d:	83 c4 10             	add    $0x10,%esp
     5a0:	e8 e1 39 00 00       	call   3f86 <exit>
     5a5:	a1 0c 64 00 00       	mov    0x640c,%eax
     5aa:	83 ec 08             	sub    $0x8,%esp
     5ad:	68 b0 47 00 00       	push   $0x47b0
     5b2:	50                   	push   %eax
     5b3:	e8 5e 3b 00 00       	call   4116 <printf>
     5b8:	83 c4 10             	add    $0x10,%esp
     5bb:	90                   	nop
     5bc:	c9                   	leave  
     5bd:	c3                   	ret    

000005be <writetest1>:
     5be:	55                   	push   %ebp
     5bf:	89 e5                	mov    %esp,%ebp
     5c1:	83 ec 18             	sub    $0x18,%esp
     5c4:	a1 0c 64 00 00       	mov    0x640c,%eax
     5c9:	83 ec 08             	sub    $0x8,%esp
     5cc:	68 c4 47 00 00       	push   $0x47c4
     5d1:	50                   	push   %eax
     5d2:	e8 3f 3b 00 00       	call   4116 <printf>
     5d7:	83 c4 10             	add    $0x10,%esp
     5da:	83 ec 08             	sub    $0x8,%esp
     5dd:	68 02 02 00 00       	push   $0x202
     5e2:	68 d4 47 00 00       	push   $0x47d4
     5e7:	e8 da 39 00 00       	call   3fc6 <open>
     5ec:	83 c4 10             	add    $0x10,%esp
     5ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
     5f2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5f6:	79 1b                	jns    613 <writetest1+0x55>
     5f8:	a1 0c 64 00 00       	mov    0x640c,%eax
     5fd:	83 ec 08             	sub    $0x8,%esp
     600:	68 d8 47 00 00       	push   $0x47d8
     605:	50                   	push   %eax
     606:	e8 0b 3b 00 00       	call   4116 <printf>
     60b:	83 c4 10             	add    $0x10,%esp
     60e:	e8 73 39 00 00       	call   3f86 <exit>
     613:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     61a:	eb 4b                	jmp    667 <writetest1+0xa9>
     61c:	ba 00 8c 00 00       	mov    $0x8c00,%edx
     621:	8b 45 f4             	mov    -0xc(%ebp),%eax
     624:	89 02                	mov    %eax,(%edx)
     626:	83 ec 04             	sub    $0x4,%esp
     629:	68 00 02 00 00       	push   $0x200
     62e:	68 00 8c 00 00       	push   $0x8c00
     633:	ff 75 ec             	pushl  -0x14(%ebp)
     636:	e8 6b 39 00 00       	call   3fa6 <write>
     63b:	83 c4 10             	add    $0x10,%esp
     63e:	3d 00 02 00 00       	cmp    $0x200,%eax
     643:	74 1e                	je     663 <writetest1+0xa5>
     645:	a1 0c 64 00 00       	mov    0x640c,%eax
     64a:	83 ec 04             	sub    $0x4,%esp
     64d:	ff 75 f4             	pushl  -0xc(%ebp)
     650:	68 f2 47 00 00       	push   $0x47f2
     655:	50                   	push   %eax
     656:	e8 bb 3a 00 00       	call   4116 <printf>
     65b:	83 c4 10             	add    $0x10,%esp
     65e:	e8 23 39 00 00       	call   3f86 <exit>
     663:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     667:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66a:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     66f:	76 ab                	jbe    61c <writetest1+0x5e>
     671:	83 ec 0c             	sub    $0xc,%esp
     674:	ff 75 ec             	pushl  -0x14(%ebp)
     677:	e8 32 39 00 00       	call   3fae <close>
     67c:	83 c4 10             	add    $0x10,%esp
     67f:	83 ec 08             	sub    $0x8,%esp
     682:	6a 00                	push   $0x0
     684:	68 d4 47 00 00       	push   $0x47d4
     689:	e8 38 39 00 00       	call   3fc6 <open>
     68e:	83 c4 10             	add    $0x10,%esp
     691:	89 45 ec             	mov    %eax,-0x14(%ebp)
     694:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     698:	79 1b                	jns    6b5 <writetest1+0xf7>
     69a:	a1 0c 64 00 00       	mov    0x640c,%eax
     69f:	83 ec 08             	sub    $0x8,%esp
     6a2:	68 10 48 00 00       	push   $0x4810
     6a7:	50                   	push   %eax
     6a8:	e8 69 3a 00 00       	call   4116 <printf>
     6ad:	83 c4 10             	add    $0x10,%esp
     6b0:	e8 d1 38 00 00       	call   3f86 <exit>
     6b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     6bc:	83 ec 04             	sub    $0x4,%esp
     6bf:	68 00 02 00 00       	push   $0x200
     6c4:	68 00 8c 00 00       	push   $0x8c00
     6c9:	ff 75 ec             	pushl  -0x14(%ebp)
     6cc:	e8 cd 38 00 00       	call   3f9e <read>
     6d1:	83 c4 10             	add    $0x10,%esp
     6d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
     6d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6db:	75 27                	jne    704 <writetest1+0x146>
     6dd:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     6e4:	75 7d                	jne    763 <writetest1+0x1a5>
     6e6:	a1 0c 64 00 00       	mov    0x640c,%eax
     6eb:	83 ec 04             	sub    $0x4,%esp
     6ee:	ff 75 f0             	pushl  -0x10(%ebp)
     6f1:	68 29 48 00 00       	push   $0x4829
     6f6:	50                   	push   %eax
     6f7:	e8 1a 3a 00 00       	call   4116 <printf>
     6fc:	83 c4 10             	add    $0x10,%esp
     6ff:	e8 82 38 00 00       	call   3f86 <exit>
     704:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     70b:	74 1e                	je     72b <writetest1+0x16d>
     70d:	a1 0c 64 00 00       	mov    0x640c,%eax
     712:	83 ec 04             	sub    $0x4,%esp
     715:	ff 75 f4             	pushl  -0xc(%ebp)
     718:	68 46 48 00 00       	push   $0x4846
     71d:	50                   	push   %eax
     71e:	e8 f3 39 00 00       	call   4116 <printf>
     723:	83 c4 10             	add    $0x10,%esp
     726:	e8 5b 38 00 00       	call   3f86 <exit>
     72b:	b8 00 8c 00 00       	mov    $0x8c00,%eax
     730:	8b 00                	mov    (%eax),%eax
     732:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     735:	74 23                	je     75a <writetest1+0x19c>
     737:	b8 00 8c 00 00       	mov    $0x8c00,%eax
     73c:	8b 10                	mov    (%eax),%edx
     73e:	a1 0c 64 00 00       	mov    0x640c,%eax
     743:	52                   	push   %edx
     744:	ff 75 f0             	pushl  -0x10(%ebp)
     747:	68 58 48 00 00       	push   $0x4858
     74c:	50                   	push   %eax
     74d:	e8 c4 39 00 00       	call   4116 <printf>
     752:	83 c4 10             	add    $0x10,%esp
     755:	e8 2c 38 00 00       	call   3f86 <exit>
     75a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     75e:	e9 59 ff ff ff       	jmp    6bc <writetest1+0xfe>
     763:	90                   	nop
     764:	83 ec 0c             	sub    $0xc,%esp
     767:	ff 75 ec             	pushl  -0x14(%ebp)
     76a:	e8 3f 38 00 00       	call   3fae <close>
     76f:	83 c4 10             	add    $0x10,%esp
     772:	83 ec 0c             	sub    $0xc,%esp
     775:	68 d4 47 00 00       	push   $0x47d4
     77a:	e8 57 38 00 00       	call   3fd6 <unlink>
     77f:	83 c4 10             	add    $0x10,%esp
     782:	85 c0                	test   %eax,%eax
     784:	79 1b                	jns    7a1 <writetest1+0x1e3>
     786:	a1 0c 64 00 00       	mov    0x640c,%eax
     78b:	83 ec 08             	sub    $0x8,%esp
     78e:	68 78 48 00 00       	push   $0x4878
     793:	50                   	push   %eax
     794:	e8 7d 39 00 00       	call   4116 <printf>
     799:	83 c4 10             	add    $0x10,%esp
     79c:	e8 e5 37 00 00       	call   3f86 <exit>
     7a1:	a1 0c 64 00 00       	mov    0x640c,%eax
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	68 8b 48 00 00       	push   $0x488b
     7ae:	50                   	push   %eax
     7af:	e8 62 39 00 00       	call   4116 <printf>
     7b4:	83 c4 10             	add    $0x10,%esp
     7b7:	90                   	nop
     7b8:	c9                   	leave  
     7b9:	c3                   	ret    

000007ba <createtest>:
     7ba:	55                   	push   %ebp
     7bb:	89 e5                	mov    %esp,%ebp
     7bd:	83 ec 18             	sub    $0x18,%esp
     7c0:	a1 0c 64 00 00       	mov    0x640c,%eax
     7c5:	83 ec 08             	sub    $0x8,%esp
     7c8:	68 9c 48 00 00       	push   $0x489c
     7cd:	50                   	push   %eax
     7ce:	e8 43 39 00 00       	call   4116 <printf>
     7d3:	83 c4 10             	add    $0x10,%esp
     7d6:	c6 05 00 ac 00 00 61 	movb   $0x61,0xac00
     7dd:	c6 05 02 ac 00 00 00 	movb   $0x0,0xac02
     7e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7eb:	eb 35                	jmp    822 <createtest+0x68>
     7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f0:	83 c0 30             	add    $0x30,%eax
     7f3:	a2 01 ac 00 00       	mov    %al,0xac01
     7f8:	83 ec 08             	sub    $0x8,%esp
     7fb:	68 02 02 00 00       	push   $0x202
     800:	68 00 ac 00 00       	push   $0xac00
     805:	e8 bc 37 00 00       	call   3fc6 <open>
     80a:	83 c4 10             	add    $0x10,%esp
     80d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     810:	83 ec 0c             	sub    $0xc,%esp
     813:	ff 75 f0             	pushl  -0x10(%ebp)
     816:	e8 93 37 00 00       	call   3fae <close>
     81b:	83 c4 10             	add    $0x10,%esp
     81e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     822:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     826:	7e c5                	jle    7ed <createtest+0x33>
     828:	c6 05 00 ac 00 00 61 	movb   $0x61,0xac00
     82f:	c6 05 02 ac 00 00 00 	movb   $0x0,0xac02
     836:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     83d:	eb 1f                	jmp    85e <createtest+0xa4>
     83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     842:	83 c0 30             	add    $0x30,%eax
     845:	a2 01 ac 00 00       	mov    %al,0xac01
     84a:	83 ec 0c             	sub    $0xc,%esp
     84d:	68 00 ac 00 00       	push   $0xac00
     852:	e8 7f 37 00 00       	call   3fd6 <unlink>
     857:	83 c4 10             	add    $0x10,%esp
     85a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     85e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     862:	7e db                	jle    83f <createtest+0x85>
     864:	a1 0c 64 00 00       	mov    0x640c,%eax
     869:	83 ec 08             	sub    $0x8,%esp
     86c:	68 c4 48 00 00       	push   $0x48c4
     871:	50                   	push   %eax
     872:	e8 9f 38 00 00       	call   4116 <printf>
     877:	83 c4 10             	add    $0x10,%esp
     87a:	90                   	nop
     87b:	c9                   	leave  
     87c:	c3                   	ret    

0000087d <dirtest>:
     87d:	55                   	push   %ebp
     87e:	89 e5                	mov    %esp,%ebp
     880:	83 ec 08             	sub    $0x8,%esp
     883:	a1 0c 64 00 00       	mov    0x640c,%eax
     888:	83 ec 08             	sub    $0x8,%esp
     88b:	68 ea 48 00 00       	push   $0x48ea
     890:	50                   	push   %eax
     891:	e8 80 38 00 00       	call   4116 <printf>
     896:	83 c4 10             	add    $0x10,%esp
     899:	83 ec 0c             	sub    $0xc,%esp
     89c:	68 f6 48 00 00       	push   $0x48f6
     8a1:	e8 48 37 00 00       	call   3fee <mkdir>
     8a6:	83 c4 10             	add    $0x10,%esp
     8a9:	85 c0                	test   %eax,%eax
     8ab:	79 1b                	jns    8c8 <dirtest+0x4b>
     8ad:	a1 0c 64 00 00       	mov    0x640c,%eax
     8b2:	83 ec 08             	sub    $0x8,%esp
     8b5:	68 19 45 00 00       	push   $0x4519
     8ba:	50                   	push   %eax
     8bb:	e8 56 38 00 00       	call   4116 <printf>
     8c0:	83 c4 10             	add    $0x10,%esp
     8c3:	e8 be 36 00 00       	call   3f86 <exit>
     8c8:	83 ec 0c             	sub    $0xc,%esp
     8cb:	68 f6 48 00 00       	push   $0x48f6
     8d0:	e8 21 37 00 00       	call   3ff6 <chdir>
     8d5:	83 c4 10             	add    $0x10,%esp
     8d8:	85 c0                	test   %eax,%eax
     8da:	79 1b                	jns    8f7 <dirtest+0x7a>
     8dc:	a1 0c 64 00 00       	mov    0x640c,%eax
     8e1:	83 ec 08             	sub    $0x8,%esp
     8e4:	68 fb 48 00 00       	push   $0x48fb
     8e9:	50                   	push   %eax
     8ea:	e8 27 38 00 00       	call   4116 <printf>
     8ef:	83 c4 10             	add    $0x10,%esp
     8f2:	e8 8f 36 00 00       	call   3f86 <exit>
     8f7:	83 ec 0c             	sub    $0xc,%esp
     8fa:	68 0e 49 00 00       	push   $0x490e
     8ff:	e8 f2 36 00 00       	call   3ff6 <chdir>
     904:	83 c4 10             	add    $0x10,%esp
     907:	85 c0                	test   %eax,%eax
     909:	79 1b                	jns    926 <dirtest+0xa9>
     90b:	a1 0c 64 00 00       	mov    0x640c,%eax
     910:	83 ec 08             	sub    $0x8,%esp
     913:	68 11 49 00 00       	push   $0x4911
     918:	50                   	push   %eax
     919:	e8 f8 37 00 00       	call   4116 <printf>
     91e:	83 c4 10             	add    $0x10,%esp
     921:	e8 60 36 00 00       	call   3f86 <exit>
     926:	83 ec 0c             	sub    $0xc,%esp
     929:	68 f6 48 00 00       	push   $0x48f6
     92e:	e8 a3 36 00 00       	call   3fd6 <unlink>
     933:	83 c4 10             	add    $0x10,%esp
     936:	85 c0                	test   %eax,%eax
     938:	79 1b                	jns    955 <dirtest+0xd8>
     93a:	a1 0c 64 00 00       	mov    0x640c,%eax
     93f:	83 ec 08             	sub    $0x8,%esp
     942:	68 22 49 00 00       	push   $0x4922
     947:	50                   	push   %eax
     948:	e8 c9 37 00 00       	call   4116 <printf>
     94d:	83 c4 10             	add    $0x10,%esp
     950:	e8 31 36 00 00       	call   3f86 <exit>
     955:	a1 0c 64 00 00       	mov    0x640c,%eax
     95a:	83 ec 08             	sub    $0x8,%esp
     95d:	68 36 49 00 00       	push   $0x4936
     962:	50                   	push   %eax
     963:	e8 ae 37 00 00       	call   4116 <printf>
     968:	83 c4 10             	add    $0x10,%esp
     96b:	90                   	nop
     96c:	c9                   	leave  
     96d:	c3                   	ret    

0000096e <exectest>:
     96e:	55                   	push   %ebp
     96f:	89 e5                	mov    %esp,%ebp
     971:	83 ec 08             	sub    $0x8,%esp
     974:	a1 0c 64 00 00       	mov    0x640c,%eax
     979:	83 ec 08             	sub    $0x8,%esp
     97c:	68 45 49 00 00       	push   $0x4945
     981:	50                   	push   %eax
     982:	e8 8f 37 00 00       	call   4116 <printf>
     987:	83 c4 10             	add    $0x10,%esp
     98a:	83 ec 08             	sub    $0x8,%esp
     98d:	68 f8 63 00 00       	push   $0x63f8
     992:	68 f0 44 00 00       	push   $0x44f0
     997:	e8 22 36 00 00       	call   3fbe <exec>
     99c:	83 c4 10             	add    $0x10,%esp
     99f:	85 c0                	test   %eax,%eax
     9a1:	79 1b                	jns    9be <exectest+0x50>
     9a3:	a1 0c 64 00 00       	mov    0x640c,%eax
     9a8:	83 ec 08             	sub    $0x8,%esp
     9ab:	68 50 49 00 00       	push   $0x4950
     9b0:	50                   	push   %eax
     9b1:	e8 60 37 00 00       	call   4116 <printf>
     9b6:	83 c4 10             	add    $0x10,%esp
     9b9:	e8 c8 35 00 00       	call   3f86 <exit>
     9be:	90                   	nop
     9bf:	c9                   	leave  
     9c0:	c3                   	ret    

000009c1 <pipe1>:
     9c1:	55                   	push   %ebp
     9c2:	89 e5                	mov    %esp,%ebp
     9c4:	83 ec 28             	sub    $0x28,%esp
     9c7:	83 ec 0c             	sub    $0xc,%esp
     9ca:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9cd:	50                   	push   %eax
     9ce:	e8 c3 35 00 00       	call   3f96 <pipe>
     9d3:	83 c4 10             	add    $0x10,%esp
     9d6:	85 c0                	test   %eax,%eax
     9d8:	74 17                	je     9f1 <pipe1+0x30>
     9da:	83 ec 08             	sub    $0x8,%esp
     9dd:	68 62 49 00 00       	push   $0x4962
     9e2:	6a 01                	push   $0x1
     9e4:	e8 2d 37 00 00       	call   4116 <printf>
     9e9:	83 c4 10             	add    $0x10,%esp
     9ec:	e8 95 35 00 00       	call   3f86 <exit>
     9f1:	e8 88 35 00 00       	call   3f7e <fork>
     9f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
     9f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a00:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a04:	0f 85 89 00 00 00    	jne    a93 <pipe1+0xd2>
     a0a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a0d:	83 ec 0c             	sub    $0xc,%esp
     a10:	50                   	push   %eax
     a11:	e8 98 35 00 00       	call   3fae <close>
     a16:	83 c4 10             	add    $0x10,%esp
     a19:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     a20:	eb 66                	jmp    a88 <pipe1+0xc7>
     a22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a29:	eb 19                	jmp    a44 <pipe1+0x83>
     a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2e:	8d 50 01             	lea    0x1(%eax),%edx
     a31:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a34:	89 c2                	mov    %eax,%edx
     a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a39:	05 00 8c 00 00       	add    $0x8c00,%eax
     a3e:	88 10                	mov    %dl,(%eax)
     a40:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a44:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     a4b:	7e de                	jle    a2b <pipe1+0x6a>
     a4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a50:	83 ec 04             	sub    $0x4,%esp
     a53:	68 09 04 00 00       	push   $0x409
     a58:	68 00 8c 00 00       	push   $0x8c00
     a5d:	50                   	push   %eax
     a5e:	e8 43 35 00 00       	call   3fa6 <write>
     a63:	83 c4 10             	add    $0x10,%esp
     a66:	3d 09 04 00 00       	cmp    $0x409,%eax
     a6b:	74 17                	je     a84 <pipe1+0xc3>
     a6d:	83 ec 08             	sub    $0x8,%esp
     a70:	68 71 49 00 00       	push   $0x4971
     a75:	6a 01                	push   $0x1
     a77:	e8 9a 36 00 00       	call   4116 <printf>
     a7c:	83 c4 10             	add    $0x10,%esp
     a7f:	e8 02 35 00 00       	call   3f86 <exit>
     a84:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     a88:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     a8c:	7e 94                	jle    a22 <pipe1+0x61>
     a8e:	e8 f3 34 00 00       	call   3f86 <exit>
     a93:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a97:	0f 8e f4 00 00 00    	jle    b91 <pipe1+0x1d0>
     a9d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aa0:	83 ec 0c             	sub    $0xc,%esp
     aa3:	50                   	push   %eax
     aa4:	e8 05 35 00 00       	call   3fae <close>
     aa9:	83 c4 10             	add    $0x10,%esp
     aac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     ab3:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
     aba:	eb 66                	jmp    b22 <pipe1+0x161>
     abc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ac3:	eb 3b                	jmp    b00 <pipe1+0x13f>
     ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac8:	05 00 8c 00 00       	add    $0x8c00,%eax
     acd:	0f b6 00             	movzbl (%eax),%eax
     ad0:	0f be c8             	movsbl %al,%ecx
     ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad6:	8d 50 01             	lea    0x1(%eax),%edx
     ad9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     adc:	31 c8                	xor    %ecx,%eax
     ade:	0f b6 c0             	movzbl %al,%eax
     ae1:	85 c0                	test   %eax,%eax
     ae3:	74 17                	je     afc <pipe1+0x13b>
     ae5:	83 ec 08             	sub    $0x8,%esp
     ae8:	68 7f 49 00 00       	push   $0x497f
     aed:	6a 01                	push   $0x1
     aef:	e8 22 36 00 00       	call   4116 <printf>
     af4:	83 c4 10             	add    $0x10,%esp
     af7:	e9 ac 00 00 00       	jmp    ba8 <pipe1+0x1e7>
     afc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b03:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     b06:	7c bd                	jl     ac5 <pipe1+0x104>
     b08:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b0b:	01 45 e4             	add    %eax,-0x1c(%ebp)
     b0e:	d1 65 e8             	shll   -0x18(%ebp)
     b11:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b14:	3d 00 20 00 00       	cmp    $0x2000,%eax
     b19:	76 07                	jbe    b22 <pipe1+0x161>
     b1b:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
     b22:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b25:	83 ec 04             	sub    $0x4,%esp
     b28:	ff 75 e8             	pushl  -0x18(%ebp)
     b2b:	68 00 8c 00 00       	push   $0x8c00
     b30:	50                   	push   %eax
     b31:	e8 68 34 00 00       	call   3f9e <read>
     b36:	83 c4 10             	add    $0x10,%esp
     b39:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b3c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b40:	0f 8f 76 ff ff ff    	jg     abc <pipe1+0xfb>
     b46:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     b4d:	74 1a                	je     b69 <pipe1+0x1a8>
     b4f:	83 ec 04             	sub    $0x4,%esp
     b52:	ff 75 e4             	pushl  -0x1c(%ebp)
     b55:	68 8d 49 00 00       	push   $0x498d
     b5a:	6a 01                	push   $0x1
     b5c:	e8 b5 35 00 00       	call   4116 <printf>
     b61:	83 c4 10             	add    $0x10,%esp
     b64:	e8 1d 34 00 00       	call   3f86 <exit>
     b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b6c:	83 ec 0c             	sub    $0xc,%esp
     b6f:	50                   	push   %eax
     b70:	e8 39 34 00 00       	call   3fae <close>
     b75:	83 c4 10             	add    $0x10,%esp
     b78:	e8 11 34 00 00       	call   3f8e <wait>
     b7d:	83 ec 08             	sub    $0x8,%esp
     b80:	68 b3 49 00 00       	push   $0x49b3
     b85:	6a 01                	push   $0x1
     b87:	e8 8a 35 00 00       	call   4116 <printf>
     b8c:	83 c4 10             	add    $0x10,%esp
     b8f:	eb 17                	jmp    ba8 <pipe1+0x1e7>
     b91:	83 ec 08             	sub    $0x8,%esp
     b94:	68 a4 49 00 00       	push   $0x49a4
     b99:	6a 01                	push   $0x1
     b9b:	e8 76 35 00 00       	call   4116 <printf>
     ba0:	83 c4 10             	add    $0x10,%esp
     ba3:	e8 de 33 00 00       	call   3f86 <exit>
     ba8:	c9                   	leave  
     ba9:	c3                   	ret    

00000baa <preempt>:
     baa:	55                   	push   %ebp
     bab:	89 e5                	mov    %esp,%ebp
     bad:	83 ec 28             	sub    $0x28,%esp
     bb0:	83 ec 08             	sub    $0x8,%esp
     bb3:	68 bd 49 00 00       	push   $0x49bd
     bb8:	6a 01                	push   $0x1
     bba:	e8 57 35 00 00       	call   4116 <printf>
     bbf:	83 c4 10             	add    $0x10,%esp
     bc2:	e8 b7 33 00 00       	call   3f7e <fork>
     bc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     bca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bce:	75 02                	jne    bd2 <preempt+0x28>
     bd0:	eb fe                	jmp    bd0 <preempt+0x26>
     bd2:	e8 a7 33 00 00       	call   3f7e <fork>
     bd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bda:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bde:	75 02                	jne    be2 <preempt+0x38>
     be0:	eb fe                	jmp    be0 <preempt+0x36>
     be2:	83 ec 0c             	sub    $0xc,%esp
     be5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     be8:	50                   	push   %eax
     be9:	e8 a8 33 00 00       	call   3f96 <pipe>
     bee:	83 c4 10             	add    $0x10,%esp
     bf1:	e8 88 33 00 00       	call   3f7e <fork>
     bf6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     bf9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bfd:	75 4d                	jne    c4c <preempt+0xa2>
     bff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c02:	83 ec 0c             	sub    $0xc,%esp
     c05:	50                   	push   %eax
     c06:	e8 a3 33 00 00       	call   3fae <close>
     c0b:	83 c4 10             	add    $0x10,%esp
     c0e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c11:	83 ec 04             	sub    $0x4,%esp
     c14:	6a 01                	push   $0x1
     c16:	68 c7 49 00 00       	push   $0x49c7
     c1b:	50                   	push   %eax
     c1c:	e8 85 33 00 00       	call   3fa6 <write>
     c21:	83 c4 10             	add    $0x10,%esp
     c24:	83 f8 01             	cmp    $0x1,%eax
     c27:	74 12                	je     c3b <preempt+0x91>
     c29:	83 ec 08             	sub    $0x8,%esp
     c2c:	68 c9 49 00 00       	push   $0x49c9
     c31:	6a 01                	push   $0x1
     c33:	e8 de 34 00 00       	call   4116 <printf>
     c38:	83 c4 10             	add    $0x10,%esp
     c3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c3e:	83 ec 0c             	sub    $0xc,%esp
     c41:	50                   	push   %eax
     c42:	e8 67 33 00 00       	call   3fae <close>
     c47:	83 c4 10             	add    $0x10,%esp
     c4a:	eb fe                	jmp    c4a <preempt+0xa0>
     c4c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c4f:	83 ec 0c             	sub    $0xc,%esp
     c52:	50                   	push   %eax
     c53:	e8 56 33 00 00       	call   3fae <close>
     c58:	83 c4 10             	add    $0x10,%esp
     c5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c5e:	83 ec 04             	sub    $0x4,%esp
     c61:	68 00 20 00 00       	push   $0x2000
     c66:	68 00 8c 00 00       	push   $0x8c00
     c6b:	50                   	push   %eax
     c6c:	e8 2d 33 00 00       	call   3f9e <read>
     c71:	83 c4 10             	add    $0x10,%esp
     c74:	83 f8 01             	cmp    $0x1,%eax
     c77:	74 14                	je     c8d <preempt+0xe3>
     c79:	83 ec 08             	sub    $0x8,%esp
     c7c:	68 dd 49 00 00       	push   $0x49dd
     c81:	6a 01                	push   $0x1
     c83:	e8 8e 34 00 00       	call   4116 <printf>
     c88:	83 c4 10             	add    $0x10,%esp
     c8b:	eb 7e                	jmp    d0b <preempt+0x161>
     c8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c90:	83 ec 0c             	sub    $0xc,%esp
     c93:	50                   	push   %eax
     c94:	e8 15 33 00 00       	call   3fae <close>
     c99:	83 c4 10             	add    $0x10,%esp
     c9c:	83 ec 08             	sub    $0x8,%esp
     c9f:	68 f0 49 00 00       	push   $0x49f0
     ca4:	6a 01                	push   $0x1
     ca6:	e8 6b 34 00 00       	call   4116 <printf>
     cab:	83 c4 10             	add    $0x10,%esp
     cae:	83 ec 0c             	sub    $0xc,%esp
     cb1:	ff 75 f4             	pushl  -0xc(%ebp)
     cb4:	e8 fd 32 00 00       	call   3fb6 <kill>
     cb9:	83 c4 10             	add    $0x10,%esp
     cbc:	83 ec 0c             	sub    $0xc,%esp
     cbf:	ff 75 f0             	pushl  -0x10(%ebp)
     cc2:	e8 ef 32 00 00       	call   3fb6 <kill>
     cc7:	83 c4 10             	add    $0x10,%esp
     cca:	83 ec 0c             	sub    $0xc,%esp
     ccd:	ff 75 ec             	pushl  -0x14(%ebp)
     cd0:	e8 e1 32 00 00       	call   3fb6 <kill>
     cd5:	83 c4 10             	add    $0x10,%esp
     cd8:	83 ec 08             	sub    $0x8,%esp
     cdb:	68 f9 49 00 00       	push   $0x49f9
     ce0:	6a 01                	push   $0x1
     ce2:	e8 2f 34 00 00       	call   4116 <printf>
     ce7:	83 c4 10             	add    $0x10,%esp
     cea:	e8 9f 32 00 00       	call   3f8e <wait>
     cef:	e8 9a 32 00 00       	call   3f8e <wait>
     cf4:	e8 95 32 00 00       	call   3f8e <wait>
     cf9:	83 ec 08             	sub    $0x8,%esp
     cfc:	68 02 4a 00 00       	push   $0x4a02
     d01:	6a 01                	push   $0x1
     d03:	e8 0e 34 00 00       	call   4116 <printf>
     d08:	83 c4 10             	add    $0x10,%esp
     d0b:	c9                   	leave  
     d0c:	c3                   	ret    

00000d0d <exitwait>:
     d0d:	55                   	push   %ebp
     d0e:	89 e5                	mov    %esp,%ebp
     d10:	83 ec 18             	sub    $0x18,%esp
     d13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d1a:	eb 4f                	jmp    d6b <exitwait+0x5e>
     d1c:	e8 5d 32 00 00       	call   3f7e <fork>
     d21:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d28:	79 14                	jns    d3e <exitwait+0x31>
     d2a:	83 ec 08             	sub    $0x8,%esp
     d2d:	68 91 45 00 00       	push   $0x4591
     d32:	6a 01                	push   $0x1
     d34:	e8 dd 33 00 00       	call   4116 <printf>
     d39:	83 c4 10             	add    $0x10,%esp
     d3c:	eb 45                	jmp    d83 <exitwait+0x76>
     d3e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d42:	74 1e                	je     d62 <exitwait+0x55>
     d44:	e8 45 32 00 00       	call   3f8e <wait>
     d49:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     d4c:	74 19                	je     d67 <exitwait+0x5a>
     d4e:	83 ec 08             	sub    $0x8,%esp
     d51:	68 0e 4a 00 00       	push   $0x4a0e
     d56:	6a 01                	push   $0x1
     d58:	e8 b9 33 00 00       	call   4116 <printf>
     d5d:	83 c4 10             	add    $0x10,%esp
     d60:	eb 21                	jmp    d83 <exitwait+0x76>
     d62:	e8 1f 32 00 00       	call   3f86 <exit>
     d67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d6b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     d6f:	7e ab                	jle    d1c <exitwait+0xf>
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 1e 4a 00 00       	push   $0x4a1e
     d79:	6a 01                	push   $0x1
     d7b:	e8 96 33 00 00       	call   4116 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
     d83:	c9                   	leave  
     d84:	c3                   	ret    

00000d85 <mem>:
     d85:	55                   	push   %ebp
     d86:	89 e5                	mov    %esp,%ebp
     d88:	83 ec 18             	sub    $0x18,%esp
     d8b:	83 ec 08             	sub    $0x8,%esp
     d8e:	68 2b 4a 00 00       	push   $0x4a2b
     d93:	6a 01                	push   $0x1
     d95:	e8 7c 33 00 00       	call   4116 <printf>
     d9a:	83 c4 10             	add    $0x10,%esp
     d9d:	e8 64 32 00 00       	call   4006 <getpid>
     da2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     da5:	e8 d4 31 00 00       	call   3f7e <fork>
     daa:	89 45 ec             	mov    %eax,-0x14(%ebp)
     dad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     db1:	0f 85 b7 00 00 00    	jne    e6e <mem+0xe9>
     db7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     dbe:	eb 0e                	jmp    dce <mem+0x49>
     dc0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     dc6:	89 10                	mov    %edx,(%eax)
     dc8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
     dce:	83 ec 0c             	sub    $0xc,%esp
     dd1:	68 11 27 00 00       	push   $0x2711
     dd6:	e8 30 36 00 00       	call   440b <malloc>
     ddb:	83 c4 10             	add    $0x10,%esp
     dde:	89 45 e8             	mov    %eax,-0x18(%ebp)
     de1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     de5:	75 d9                	jne    dc0 <mem+0x3b>
     de7:	eb 1c                	jmp    e05 <mem+0x80>
     de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dec:	8b 00                	mov    (%eax),%eax
     dee:	89 45 e8             	mov    %eax,-0x18(%ebp)
     df1:	83 ec 0c             	sub    $0xc,%esp
     df4:	ff 75 f4             	pushl  -0xc(%ebp)
     df7:	e8 cd 34 00 00       	call   42c9 <free>
     dfc:	83 c4 10             	add    $0x10,%esp
     dff:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e02:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e05:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e09:	75 de                	jne    de9 <mem+0x64>
     e0b:	83 ec 0c             	sub    $0xc,%esp
     e0e:	68 00 50 00 00       	push   $0x5000
     e13:	e8 f3 35 00 00       	call   440b <malloc>
     e18:	83 c4 10             	add    $0x10,%esp
     e1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     e1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e22:	75 25                	jne    e49 <mem+0xc4>
     e24:	83 ec 08             	sub    $0x8,%esp
     e27:	68 35 4a 00 00       	push   $0x4a35
     e2c:	6a 01                	push   $0x1
     e2e:	e8 e3 32 00 00       	call   4116 <printf>
     e33:	83 c4 10             	add    $0x10,%esp
     e36:	83 ec 0c             	sub    $0xc,%esp
     e39:	ff 75 f0             	pushl  -0x10(%ebp)
     e3c:	e8 75 31 00 00       	call   3fb6 <kill>
     e41:	83 c4 10             	add    $0x10,%esp
     e44:	e8 3d 31 00 00       	call   3f86 <exit>
     e49:	83 ec 0c             	sub    $0xc,%esp
     e4c:	ff 75 f4             	pushl  -0xc(%ebp)
     e4f:	e8 75 34 00 00       	call   42c9 <free>
     e54:	83 c4 10             	add    $0x10,%esp
     e57:	83 ec 08             	sub    $0x8,%esp
     e5a:	68 4f 4a 00 00       	push   $0x4a4f
     e5f:	6a 01                	push   $0x1
     e61:	e8 b0 32 00 00       	call   4116 <printf>
     e66:	83 c4 10             	add    $0x10,%esp
     e69:	e8 18 31 00 00       	call   3f86 <exit>
     e6e:	e8 1b 31 00 00       	call   3f8e <wait>
     e73:	90                   	nop
     e74:	c9                   	leave  
     e75:	c3                   	ret    

00000e76 <sharedfd>:
     e76:	55                   	push   %ebp
     e77:	89 e5                	mov    %esp,%ebp
     e79:	83 ec 38             	sub    $0x38,%esp
     e7c:	83 ec 08             	sub    $0x8,%esp
     e7f:	68 57 4a 00 00       	push   $0x4a57
     e84:	6a 01                	push   $0x1
     e86:	e8 8b 32 00 00       	call   4116 <printf>
     e8b:	83 c4 10             	add    $0x10,%esp
     e8e:	83 ec 0c             	sub    $0xc,%esp
     e91:	68 66 4a 00 00       	push   $0x4a66
     e96:	e8 3b 31 00 00       	call   3fd6 <unlink>
     e9b:	83 c4 10             	add    $0x10,%esp
     e9e:	83 ec 08             	sub    $0x8,%esp
     ea1:	68 02 02 00 00       	push   $0x202
     ea6:	68 66 4a 00 00       	push   $0x4a66
     eab:	e8 16 31 00 00       	call   3fc6 <open>
     eb0:	83 c4 10             	add    $0x10,%esp
     eb3:	89 45 e8             	mov    %eax,-0x18(%ebp)
     eb6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     eba:	79 17                	jns    ed3 <sharedfd+0x5d>
     ebc:	83 ec 08             	sub    $0x8,%esp
     ebf:	68 70 4a 00 00       	push   $0x4a70
     ec4:	6a 01                	push   $0x1
     ec6:	e8 4b 32 00 00       	call   4116 <printf>
     ecb:	83 c4 10             	add    $0x10,%esp
     ece:	e9 84 01 00 00       	jmp    1057 <sharedfd+0x1e1>
     ed3:	e8 a6 30 00 00       	call   3f7e <fork>
     ed8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     edb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     edf:	75 07                	jne    ee8 <sharedfd+0x72>
     ee1:	b8 63 00 00 00       	mov    $0x63,%eax
     ee6:	eb 05                	jmp    eed <sharedfd+0x77>
     ee8:	b8 70 00 00 00       	mov    $0x70,%eax
     eed:	83 ec 04             	sub    $0x4,%esp
     ef0:	6a 0a                	push   $0xa
     ef2:	50                   	push   %eax
     ef3:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ef6:	50                   	push   %eax
     ef7:	e8 dd 2e 00 00       	call   3dd9 <memset>
     efc:	83 c4 10             	add    $0x10,%esp
     eff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f06:	eb 31                	jmp    f39 <sharedfd+0xc3>
     f08:	83 ec 04             	sub    $0x4,%esp
     f0b:	6a 0a                	push   $0xa
     f0d:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f10:	50                   	push   %eax
     f11:	ff 75 e8             	pushl  -0x18(%ebp)
     f14:	e8 8d 30 00 00       	call   3fa6 <write>
     f19:	83 c4 10             	add    $0x10,%esp
     f1c:	83 f8 0a             	cmp    $0xa,%eax
     f1f:	74 14                	je     f35 <sharedfd+0xbf>
     f21:	83 ec 08             	sub    $0x8,%esp
     f24:	68 9c 4a 00 00       	push   $0x4a9c
     f29:	6a 01                	push   $0x1
     f2b:	e8 e6 31 00 00       	call   4116 <printf>
     f30:	83 c4 10             	add    $0x10,%esp
     f33:	eb 0d                	jmp    f42 <sharedfd+0xcc>
     f35:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f39:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     f40:	7e c6                	jle    f08 <sharedfd+0x92>
     f42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     f46:	75 05                	jne    f4d <sharedfd+0xd7>
     f48:	e8 39 30 00 00       	call   3f86 <exit>
     f4d:	e8 3c 30 00 00       	call   3f8e <wait>
     f52:	83 ec 0c             	sub    $0xc,%esp
     f55:	ff 75 e8             	pushl  -0x18(%ebp)
     f58:	e8 51 30 00 00       	call   3fae <close>
     f5d:	83 c4 10             	add    $0x10,%esp
     f60:	83 ec 08             	sub    $0x8,%esp
     f63:	6a 00                	push   $0x0
     f65:	68 66 4a 00 00       	push   $0x4a66
     f6a:	e8 57 30 00 00       	call   3fc6 <open>
     f6f:	83 c4 10             	add    $0x10,%esp
     f72:	89 45 e8             	mov    %eax,-0x18(%ebp)
     f75:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     f79:	79 17                	jns    f92 <sharedfd+0x11c>
     f7b:	83 ec 08             	sub    $0x8,%esp
     f7e:	68 bc 4a 00 00       	push   $0x4abc
     f83:	6a 01                	push   $0x1
     f85:	e8 8c 31 00 00       	call   4116 <printf>
     f8a:	83 c4 10             	add    $0x10,%esp
     f8d:	e9 c5 00 00 00       	jmp    1057 <sharedfd+0x1e1>
     f92:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f99:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f9f:	eb 3b                	jmp    fdc <sharedfd+0x166>
     fa1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fa8:	eb 2a                	jmp    fd4 <sharedfd+0x15e>
     faa:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     fad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb0:	01 d0                	add    %edx,%eax
     fb2:	0f b6 00             	movzbl (%eax),%eax
     fb5:	3c 63                	cmp    $0x63,%al
     fb7:	75 04                	jne    fbd <sharedfd+0x147>
     fb9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     fbd:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc3:	01 d0                	add    %edx,%eax
     fc5:	0f b6 00             	movzbl (%eax),%eax
     fc8:	3c 70                	cmp    $0x70,%al
     fca:	75 04                	jne    fd0 <sharedfd+0x15a>
     fcc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     fd0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd7:	83 f8 09             	cmp    $0x9,%eax
     fda:	76 ce                	jbe    faa <sharedfd+0x134>
     fdc:	83 ec 04             	sub    $0x4,%esp
     fdf:	6a 0a                	push   $0xa
     fe1:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     fe4:	50                   	push   %eax
     fe5:	ff 75 e8             	pushl  -0x18(%ebp)
     fe8:	e8 b1 2f 00 00       	call   3f9e <read>
     fed:	83 c4 10             	add    $0x10,%esp
     ff0:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ff3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     ff7:	7f a8                	jg     fa1 <sharedfd+0x12b>
     ff9:	83 ec 0c             	sub    $0xc,%esp
     ffc:	ff 75 e8             	pushl  -0x18(%ebp)
     fff:	e8 aa 2f 00 00       	call   3fae <close>
    1004:	83 c4 10             	add    $0x10,%esp
    1007:	83 ec 0c             	sub    $0xc,%esp
    100a:	68 66 4a 00 00       	push   $0x4a66
    100f:	e8 c2 2f 00 00       	call   3fd6 <unlink>
    1014:	83 c4 10             	add    $0x10,%esp
    1017:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    101e:	75 1d                	jne    103d <sharedfd+0x1c7>
    1020:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    1027:	75 14                	jne    103d <sharedfd+0x1c7>
    1029:	83 ec 08             	sub    $0x8,%esp
    102c:	68 e7 4a 00 00       	push   $0x4ae7
    1031:	6a 01                	push   $0x1
    1033:	e8 de 30 00 00       	call   4116 <printf>
    1038:	83 c4 10             	add    $0x10,%esp
    103b:	eb 1a                	jmp    1057 <sharedfd+0x1e1>
    103d:	ff 75 ec             	pushl  -0x14(%ebp)
    1040:	ff 75 f0             	pushl  -0x10(%ebp)
    1043:	68 f4 4a 00 00       	push   $0x4af4
    1048:	6a 01                	push   $0x1
    104a:	e8 c7 30 00 00       	call   4116 <printf>
    104f:	83 c4 10             	add    $0x10,%esp
    1052:	e8 2f 2f 00 00       	call   3f86 <exit>
    1057:	c9                   	leave  
    1058:	c3                   	ret    

00001059 <fourfiles>:
    1059:	55                   	push   %ebp
    105a:	89 e5                	mov    %esp,%ebp
    105c:	83 ec 38             	sub    $0x38,%esp
    105f:	c7 45 c8 09 4b 00 00 	movl   $0x4b09,-0x38(%ebp)
    1066:	c7 45 cc 0c 4b 00 00 	movl   $0x4b0c,-0x34(%ebp)
    106d:	c7 45 d0 0f 4b 00 00 	movl   $0x4b0f,-0x30(%ebp)
    1074:	c7 45 d4 12 4b 00 00 	movl   $0x4b12,-0x2c(%ebp)
    107b:	83 ec 08             	sub    $0x8,%esp
    107e:	68 15 4b 00 00       	push   $0x4b15
    1083:	6a 01                	push   $0x1
    1085:	e8 8c 30 00 00       	call   4116 <printf>
    108a:	83 c4 10             	add    $0x10,%esp
    108d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1094:	e9 f0 00 00 00       	jmp    1189 <fourfiles+0x130>
    1099:	8b 45 e8             	mov    -0x18(%ebp),%eax
    109c:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    10a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    10a3:	83 ec 0c             	sub    $0xc,%esp
    10a6:	ff 75 e4             	pushl  -0x1c(%ebp)
    10a9:	e8 28 2f 00 00       	call   3fd6 <unlink>
    10ae:	83 c4 10             	add    $0x10,%esp
    10b1:	e8 c8 2e 00 00       	call   3f7e <fork>
    10b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    10b9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10bd:	79 17                	jns    10d6 <fourfiles+0x7d>
    10bf:	83 ec 08             	sub    $0x8,%esp
    10c2:	68 91 45 00 00       	push   $0x4591
    10c7:	6a 01                	push   $0x1
    10c9:	e8 48 30 00 00       	call   4116 <printf>
    10ce:	83 c4 10             	add    $0x10,%esp
    10d1:	e8 b0 2e 00 00       	call   3f86 <exit>
    10d6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10da:	0f 85 a5 00 00 00    	jne    1185 <fourfiles+0x12c>
    10e0:	83 ec 08             	sub    $0x8,%esp
    10e3:	68 02 02 00 00       	push   $0x202
    10e8:	ff 75 e4             	pushl  -0x1c(%ebp)
    10eb:	e8 d6 2e 00 00       	call   3fc6 <open>
    10f0:	83 c4 10             	add    $0x10,%esp
    10f3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    10f6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    10fa:	79 17                	jns    1113 <fourfiles+0xba>
    10fc:	83 ec 08             	sub    $0x8,%esp
    10ff:	68 25 4b 00 00       	push   $0x4b25
    1104:	6a 01                	push   $0x1
    1106:	e8 0b 30 00 00       	call   4116 <printf>
    110b:	83 c4 10             	add    $0x10,%esp
    110e:	e8 73 2e 00 00       	call   3f86 <exit>
    1113:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1116:	83 c0 30             	add    $0x30,%eax
    1119:	83 ec 04             	sub    $0x4,%esp
    111c:	68 00 02 00 00       	push   $0x200
    1121:	50                   	push   %eax
    1122:	68 00 8c 00 00       	push   $0x8c00
    1127:	e8 ad 2c 00 00       	call   3dd9 <memset>
    112c:	83 c4 10             	add    $0x10,%esp
    112f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1136:	eb 42                	jmp    117a <fourfiles+0x121>
    1138:	83 ec 04             	sub    $0x4,%esp
    113b:	68 f4 01 00 00       	push   $0x1f4
    1140:	68 00 8c 00 00       	push   $0x8c00
    1145:	ff 75 dc             	pushl  -0x24(%ebp)
    1148:	e8 59 2e 00 00       	call   3fa6 <write>
    114d:	83 c4 10             	add    $0x10,%esp
    1150:	89 45 d8             	mov    %eax,-0x28(%ebp)
    1153:	81 7d d8 f4 01 00 00 	cmpl   $0x1f4,-0x28(%ebp)
    115a:	74 1a                	je     1176 <fourfiles+0x11d>
    115c:	83 ec 04             	sub    $0x4,%esp
    115f:	ff 75 d8             	pushl  -0x28(%ebp)
    1162:	68 34 4b 00 00       	push   $0x4b34
    1167:	6a 01                	push   $0x1
    1169:	e8 a8 2f 00 00       	call   4116 <printf>
    116e:	83 c4 10             	add    $0x10,%esp
    1171:	e8 10 2e 00 00       	call   3f86 <exit>
    1176:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    117a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    117e:	7e b8                	jle    1138 <fourfiles+0xdf>
    1180:	e8 01 2e 00 00       	call   3f86 <exit>
    1185:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1189:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    118d:	0f 8e 06 ff ff ff    	jle    1099 <fourfiles+0x40>
    1193:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    119a:	eb 09                	jmp    11a5 <fourfiles+0x14c>
    119c:	e8 ed 2d 00 00       	call   3f8e <wait>
    11a1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11a5:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    11a9:	7e f1                	jle    119c <fourfiles+0x143>
    11ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11b2:	e9 d4 00 00 00       	jmp    128b <fourfiles+0x232>
    11b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ba:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    11be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    11c1:	83 ec 08             	sub    $0x8,%esp
    11c4:	6a 00                	push   $0x0
    11c6:	ff 75 e4             	pushl  -0x1c(%ebp)
    11c9:	e8 f8 2d 00 00       	call   3fc6 <open>
    11ce:	83 c4 10             	add    $0x10,%esp
    11d1:	89 45 dc             	mov    %eax,-0x24(%ebp)
    11d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    11db:	eb 4a                	jmp    1227 <fourfiles+0x1ce>
    11dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11e4:	eb 33                	jmp    1219 <fourfiles+0x1c0>
    11e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e9:	05 00 8c 00 00       	add    $0x8c00,%eax
    11ee:	0f b6 00             	movzbl (%eax),%eax
    11f1:	0f be c0             	movsbl %al,%eax
    11f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11f7:	83 c2 30             	add    $0x30,%edx
    11fa:	39 d0                	cmp    %edx,%eax
    11fc:	74 17                	je     1215 <fourfiles+0x1bc>
    11fe:	83 ec 08             	sub    $0x8,%esp
    1201:	68 45 4b 00 00       	push   $0x4b45
    1206:	6a 01                	push   $0x1
    1208:	e8 09 2f 00 00       	call   4116 <printf>
    120d:	83 c4 10             	add    $0x10,%esp
    1210:	e8 71 2d 00 00       	call   3f86 <exit>
    1215:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1219:	8b 45 f0             	mov    -0x10(%ebp),%eax
    121c:	3b 45 d8             	cmp    -0x28(%ebp),%eax
    121f:	7c c5                	jl     11e6 <fourfiles+0x18d>
    1221:	8b 45 d8             	mov    -0x28(%ebp),%eax
    1224:	01 45 ec             	add    %eax,-0x14(%ebp)
    1227:	83 ec 04             	sub    $0x4,%esp
    122a:	68 00 20 00 00       	push   $0x2000
    122f:	68 00 8c 00 00       	push   $0x8c00
    1234:	ff 75 dc             	pushl  -0x24(%ebp)
    1237:	e8 62 2d 00 00       	call   3f9e <read>
    123c:	83 c4 10             	add    $0x10,%esp
    123f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    1242:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    1246:	7f 95                	jg     11dd <fourfiles+0x184>
    1248:	83 ec 0c             	sub    $0xc,%esp
    124b:	ff 75 dc             	pushl  -0x24(%ebp)
    124e:	e8 5b 2d 00 00       	call   3fae <close>
    1253:	83 c4 10             	add    $0x10,%esp
    1256:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    125d:	74 1a                	je     1279 <fourfiles+0x220>
    125f:	83 ec 04             	sub    $0x4,%esp
    1262:	ff 75 ec             	pushl  -0x14(%ebp)
    1265:	68 51 4b 00 00       	push   $0x4b51
    126a:	6a 01                	push   $0x1
    126c:	e8 a5 2e 00 00       	call   4116 <printf>
    1271:	83 c4 10             	add    $0x10,%esp
    1274:	e8 0d 2d 00 00       	call   3f86 <exit>
    1279:	83 ec 0c             	sub    $0xc,%esp
    127c:	ff 75 e4             	pushl  -0x1c(%ebp)
    127f:	e8 52 2d 00 00       	call   3fd6 <unlink>
    1284:	83 c4 10             	add    $0x10,%esp
    1287:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    128b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    128f:	0f 8e 22 ff ff ff    	jle    11b7 <fourfiles+0x15e>
    1295:	83 ec 08             	sub    $0x8,%esp
    1298:	68 62 4b 00 00       	push   $0x4b62
    129d:	6a 01                	push   $0x1
    129f:	e8 72 2e 00 00       	call   4116 <printf>
    12a4:	83 c4 10             	add    $0x10,%esp
    12a7:	90                   	nop
    12a8:	c9                   	leave  
    12a9:	c3                   	ret    

000012aa <createdelete>:
    12aa:	55                   	push   %ebp
    12ab:	89 e5                	mov    %esp,%ebp
    12ad:	83 ec 38             	sub    $0x38,%esp
    12b0:	83 ec 08             	sub    $0x8,%esp
    12b3:	68 70 4b 00 00       	push   $0x4b70
    12b8:	6a 01                	push   $0x1
    12ba:	e8 57 2e 00 00       	call   4116 <printf>
    12bf:	83 c4 10             	add    $0x10,%esp
    12c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12c9:	e9 f6 00 00 00       	jmp    13c4 <createdelete+0x11a>
    12ce:	e8 ab 2c 00 00       	call   3f7e <fork>
    12d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    12d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12da:	79 17                	jns    12f3 <createdelete+0x49>
    12dc:	83 ec 08             	sub    $0x8,%esp
    12df:	68 91 45 00 00       	push   $0x4591
    12e4:	6a 01                	push   $0x1
    12e6:	e8 2b 2e 00 00       	call   4116 <printf>
    12eb:	83 c4 10             	add    $0x10,%esp
    12ee:	e8 93 2c 00 00       	call   3f86 <exit>
    12f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    12f7:	0f 85 c3 00 00 00    	jne    13c0 <createdelete+0x116>
    12fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1300:	83 c0 70             	add    $0x70,%eax
    1303:	88 45 c8             	mov    %al,-0x38(%ebp)
    1306:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    130a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1311:	e9 9b 00 00 00       	jmp    13b1 <createdelete+0x107>
    1316:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1319:	83 c0 30             	add    $0x30,%eax
    131c:	88 45 c9             	mov    %al,-0x37(%ebp)
    131f:	83 ec 08             	sub    $0x8,%esp
    1322:	68 02 02 00 00       	push   $0x202
    1327:	8d 45 c8             	lea    -0x38(%ebp),%eax
    132a:	50                   	push   %eax
    132b:	e8 96 2c 00 00       	call   3fc6 <open>
    1330:	83 c4 10             	add    $0x10,%esp
    1333:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1336:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    133a:	79 17                	jns    1353 <createdelete+0xa9>
    133c:	83 ec 08             	sub    $0x8,%esp
    133f:	68 25 4b 00 00       	push   $0x4b25
    1344:	6a 01                	push   $0x1
    1346:	e8 cb 2d 00 00       	call   4116 <printf>
    134b:	83 c4 10             	add    $0x10,%esp
    134e:	e8 33 2c 00 00       	call   3f86 <exit>
    1353:	83 ec 0c             	sub    $0xc,%esp
    1356:	ff 75 e8             	pushl  -0x18(%ebp)
    1359:	e8 50 2c 00 00       	call   3fae <close>
    135e:	83 c4 10             	add    $0x10,%esp
    1361:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1365:	7e 46                	jle    13ad <createdelete+0x103>
    1367:	8b 45 f4             	mov    -0xc(%ebp),%eax
    136a:	83 e0 01             	and    $0x1,%eax
    136d:	85 c0                	test   %eax,%eax
    136f:	75 3c                	jne    13ad <createdelete+0x103>
    1371:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1374:	89 c2                	mov    %eax,%edx
    1376:	c1 ea 1f             	shr    $0x1f,%edx
    1379:	01 d0                	add    %edx,%eax
    137b:	d1 f8                	sar    %eax
    137d:	83 c0 30             	add    $0x30,%eax
    1380:	88 45 c9             	mov    %al,-0x37(%ebp)
    1383:	83 ec 0c             	sub    $0xc,%esp
    1386:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1389:	50                   	push   %eax
    138a:	e8 47 2c 00 00       	call   3fd6 <unlink>
    138f:	83 c4 10             	add    $0x10,%esp
    1392:	85 c0                	test   %eax,%eax
    1394:	79 17                	jns    13ad <createdelete+0x103>
    1396:	83 ec 08             	sub    $0x8,%esp
    1399:	68 14 46 00 00       	push   $0x4614
    139e:	6a 01                	push   $0x1
    13a0:	e8 71 2d 00 00       	call   4116 <printf>
    13a5:	83 c4 10             	add    $0x10,%esp
    13a8:	e8 d9 2b 00 00       	call   3f86 <exit>
    13ad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13b1:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    13b5:	0f 8e 5b ff ff ff    	jle    1316 <createdelete+0x6c>
    13bb:	e8 c6 2b 00 00       	call   3f86 <exit>
    13c0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13c4:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13c8:	0f 8e 00 ff ff ff    	jle    12ce <createdelete+0x24>
    13ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13d5:	eb 09                	jmp    13e0 <createdelete+0x136>
    13d7:	e8 b2 2b 00 00       	call   3f8e <wait>
    13dc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13e0:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13e4:	7e f1                	jle    13d7 <createdelete+0x12d>
    13e6:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13ea:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    13ee:	88 45 c9             	mov    %al,-0x37(%ebp)
    13f1:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    13f5:	88 45 c8             	mov    %al,-0x38(%ebp)
    13f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13ff:	e9 b2 00 00 00       	jmp    14b6 <createdelete+0x20c>
    1404:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    140b:	e9 98 00 00 00       	jmp    14a8 <createdelete+0x1fe>
    1410:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1413:	83 c0 70             	add    $0x70,%eax
    1416:	88 45 c8             	mov    %al,-0x38(%ebp)
    1419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141c:	83 c0 30             	add    $0x30,%eax
    141f:	88 45 c9             	mov    %al,-0x37(%ebp)
    1422:	83 ec 08             	sub    $0x8,%esp
    1425:	6a 00                	push   $0x0
    1427:	8d 45 c8             	lea    -0x38(%ebp),%eax
    142a:	50                   	push   %eax
    142b:	e8 96 2b 00 00       	call   3fc6 <open>
    1430:	83 c4 10             	add    $0x10,%esp
    1433:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1436:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    143a:	74 06                	je     1442 <createdelete+0x198>
    143c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1440:	7e 21                	jle    1463 <createdelete+0x1b9>
    1442:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1446:	79 1b                	jns    1463 <createdelete+0x1b9>
    1448:	83 ec 04             	sub    $0x4,%esp
    144b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    144e:	50                   	push   %eax
    144f:	68 84 4b 00 00       	push   $0x4b84
    1454:	6a 01                	push   $0x1
    1456:	e8 bb 2c 00 00       	call   4116 <printf>
    145b:	83 c4 10             	add    $0x10,%esp
    145e:	e8 23 2b 00 00       	call   3f86 <exit>
    1463:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1467:	7e 27                	jle    1490 <createdelete+0x1e6>
    1469:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    146d:	7f 21                	jg     1490 <createdelete+0x1e6>
    146f:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1473:	78 1b                	js     1490 <createdelete+0x1e6>
    1475:	83 ec 04             	sub    $0x4,%esp
    1478:	8d 45 c8             	lea    -0x38(%ebp),%eax
    147b:	50                   	push   %eax
    147c:	68 a8 4b 00 00       	push   $0x4ba8
    1481:	6a 01                	push   $0x1
    1483:	e8 8e 2c 00 00       	call   4116 <printf>
    1488:	83 c4 10             	add    $0x10,%esp
    148b:	e8 f6 2a 00 00       	call   3f86 <exit>
    1490:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1494:	78 0e                	js     14a4 <createdelete+0x1fa>
    1496:	83 ec 0c             	sub    $0xc,%esp
    1499:	ff 75 e8             	pushl  -0x18(%ebp)
    149c:	e8 0d 2b 00 00       	call   3fae <close>
    14a1:	83 c4 10             	add    $0x10,%esp
    14a4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14a8:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14ac:	0f 8e 5e ff ff ff    	jle    1410 <createdelete+0x166>
    14b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14b6:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    14ba:	0f 8e 44 ff ff ff    	jle    1404 <createdelete+0x15a>
    14c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14c7:	eb 38                	jmp    1501 <createdelete+0x257>
    14c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14d0:	eb 25                	jmp    14f7 <createdelete+0x24d>
    14d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d5:	83 c0 70             	add    $0x70,%eax
    14d8:	88 45 c8             	mov    %al,-0x38(%ebp)
    14db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14de:	83 c0 30             	add    $0x30,%eax
    14e1:	88 45 c9             	mov    %al,-0x37(%ebp)
    14e4:	83 ec 0c             	sub    $0xc,%esp
    14e7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14ea:	50                   	push   %eax
    14eb:	e8 e6 2a 00 00       	call   3fd6 <unlink>
    14f0:	83 c4 10             	add    $0x10,%esp
    14f3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14f7:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14fb:	7e d5                	jle    14d2 <createdelete+0x228>
    14fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1501:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1505:	7e c2                	jle    14c9 <createdelete+0x21f>
    1507:	83 ec 08             	sub    $0x8,%esp
    150a:	68 c8 4b 00 00       	push   $0x4bc8
    150f:	6a 01                	push   $0x1
    1511:	e8 00 2c 00 00       	call   4116 <printf>
    1516:	83 c4 10             	add    $0x10,%esp
    1519:	90                   	nop
    151a:	c9                   	leave  
    151b:	c3                   	ret    

0000151c <unlinkread>:
    151c:	55                   	push   %ebp
    151d:	89 e5                	mov    %esp,%ebp
    151f:	83 ec 18             	sub    $0x18,%esp
    1522:	83 ec 08             	sub    $0x8,%esp
    1525:	68 d9 4b 00 00       	push   $0x4bd9
    152a:	6a 01                	push   $0x1
    152c:	e8 e5 2b 00 00       	call   4116 <printf>
    1531:	83 c4 10             	add    $0x10,%esp
    1534:	83 ec 08             	sub    $0x8,%esp
    1537:	68 02 02 00 00       	push   $0x202
    153c:	68 ea 4b 00 00       	push   $0x4bea
    1541:	e8 80 2a 00 00       	call   3fc6 <open>
    1546:	83 c4 10             	add    $0x10,%esp
    1549:	89 45 f4             	mov    %eax,-0xc(%ebp)
    154c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1550:	79 17                	jns    1569 <unlinkread+0x4d>
    1552:	83 ec 08             	sub    $0x8,%esp
    1555:	68 f5 4b 00 00       	push   $0x4bf5
    155a:	6a 01                	push   $0x1
    155c:	e8 b5 2b 00 00       	call   4116 <printf>
    1561:	83 c4 10             	add    $0x10,%esp
    1564:	e8 1d 2a 00 00       	call   3f86 <exit>
    1569:	83 ec 04             	sub    $0x4,%esp
    156c:	6a 05                	push   $0x5
    156e:	68 0f 4c 00 00       	push   $0x4c0f
    1573:	ff 75 f4             	pushl  -0xc(%ebp)
    1576:	e8 2b 2a 00 00       	call   3fa6 <write>
    157b:	83 c4 10             	add    $0x10,%esp
    157e:	83 ec 0c             	sub    $0xc,%esp
    1581:	ff 75 f4             	pushl  -0xc(%ebp)
    1584:	e8 25 2a 00 00       	call   3fae <close>
    1589:	83 c4 10             	add    $0x10,%esp
    158c:	83 ec 08             	sub    $0x8,%esp
    158f:	6a 02                	push   $0x2
    1591:	68 ea 4b 00 00       	push   $0x4bea
    1596:	e8 2b 2a 00 00       	call   3fc6 <open>
    159b:	83 c4 10             	add    $0x10,%esp
    159e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15a5:	79 17                	jns    15be <unlinkread+0xa2>
    15a7:	83 ec 08             	sub    $0x8,%esp
    15aa:	68 15 4c 00 00       	push   $0x4c15
    15af:	6a 01                	push   $0x1
    15b1:	e8 60 2b 00 00       	call   4116 <printf>
    15b6:	83 c4 10             	add    $0x10,%esp
    15b9:	e8 c8 29 00 00       	call   3f86 <exit>
    15be:	83 ec 0c             	sub    $0xc,%esp
    15c1:	68 ea 4b 00 00       	push   $0x4bea
    15c6:	e8 0b 2a 00 00       	call   3fd6 <unlink>
    15cb:	83 c4 10             	add    $0x10,%esp
    15ce:	85 c0                	test   %eax,%eax
    15d0:	74 17                	je     15e9 <unlinkread+0xcd>
    15d2:	83 ec 08             	sub    $0x8,%esp
    15d5:	68 2d 4c 00 00       	push   $0x4c2d
    15da:	6a 01                	push   $0x1
    15dc:	e8 35 2b 00 00       	call   4116 <printf>
    15e1:	83 c4 10             	add    $0x10,%esp
    15e4:	e8 9d 29 00 00       	call   3f86 <exit>
    15e9:	83 ec 08             	sub    $0x8,%esp
    15ec:	68 02 02 00 00       	push   $0x202
    15f1:	68 ea 4b 00 00       	push   $0x4bea
    15f6:	e8 cb 29 00 00       	call   3fc6 <open>
    15fb:	83 c4 10             	add    $0x10,%esp
    15fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	6a 03                	push   $0x3
    1606:	68 47 4c 00 00       	push   $0x4c47
    160b:	ff 75 f0             	pushl  -0x10(%ebp)
    160e:	e8 93 29 00 00       	call   3fa6 <write>
    1613:	83 c4 10             	add    $0x10,%esp
    1616:	83 ec 0c             	sub    $0xc,%esp
    1619:	ff 75 f0             	pushl  -0x10(%ebp)
    161c:	e8 8d 29 00 00       	call   3fae <close>
    1621:	83 c4 10             	add    $0x10,%esp
    1624:	83 ec 04             	sub    $0x4,%esp
    1627:	68 00 20 00 00       	push   $0x2000
    162c:	68 00 8c 00 00       	push   $0x8c00
    1631:	ff 75 f4             	pushl  -0xc(%ebp)
    1634:	e8 65 29 00 00       	call   3f9e <read>
    1639:	83 c4 10             	add    $0x10,%esp
    163c:	83 f8 05             	cmp    $0x5,%eax
    163f:	74 17                	je     1658 <unlinkread+0x13c>
    1641:	83 ec 08             	sub    $0x8,%esp
    1644:	68 4b 4c 00 00       	push   $0x4c4b
    1649:	6a 01                	push   $0x1
    164b:	e8 c6 2a 00 00       	call   4116 <printf>
    1650:	83 c4 10             	add    $0x10,%esp
    1653:	e8 2e 29 00 00       	call   3f86 <exit>
    1658:	0f b6 05 00 8c 00 00 	movzbl 0x8c00,%eax
    165f:	3c 68                	cmp    $0x68,%al
    1661:	74 17                	je     167a <unlinkread+0x15e>
    1663:	83 ec 08             	sub    $0x8,%esp
    1666:	68 62 4c 00 00       	push   $0x4c62
    166b:	6a 01                	push   $0x1
    166d:	e8 a4 2a 00 00       	call   4116 <printf>
    1672:	83 c4 10             	add    $0x10,%esp
    1675:	e8 0c 29 00 00       	call   3f86 <exit>
    167a:	83 ec 04             	sub    $0x4,%esp
    167d:	6a 0a                	push   $0xa
    167f:	68 00 8c 00 00       	push   $0x8c00
    1684:	ff 75 f4             	pushl  -0xc(%ebp)
    1687:	e8 1a 29 00 00       	call   3fa6 <write>
    168c:	83 c4 10             	add    $0x10,%esp
    168f:	83 f8 0a             	cmp    $0xa,%eax
    1692:	74 17                	je     16ab <unlinkread+0x18f>
    1694:	83 ec 08             	sub    $0x8,%esp
    1697:	68 79 4c 00 00       	push   $0x4c79
    169c:	6a 01                	push   $0x1
    169e:	e8 73 2a 00 00       	call   4116 <printf>
    16a3:	83 c4 10             	add    $0x10,%esp
    16a6:	e8 db 28 00 00       	call   3f86 <exit>
    16ab:	83 ec 0c             	sub    $0xc,%esp
    16ae:	ff 75 f4             	pushl  -0xc(%ebp)
    16b1:	e8 f8 28 00 00       	call   3fae <close>
    16b6:	83 c4 10             	add    $0x10,%esp
    16b9:	83 ec 0c             	sub    $0xc,%esp
    16bc:	68 ea 4b 00 00       	push   $0x4bea
    16c1:	e8 10 29 00 00       	call   3fd6 <unlink>
    16c6:	83 c4 10             	add    $0x10,%esp
    16c9:	83 ec 08             	sub    $0x8,%esp
    16cc:	68 92 4c 00 00       	push   $0x4c92
    16d1:	6a 01                	push   $0x1
    16d3:	e8 3e 2a 00 00       	call   4116 <printf>
    16d8:	83 c4 10             	add    $0x10,%esp
    16db:	90                   	nop
    16dc:	c9                   	leave  
    16dd:	c3                   	ret    

000016de <linktest>:
    16de:	55                   	push   %ebp
    16df:	89 e5                	mov    %esp,%ebp
    16e1:	83 ec 18             	sub    $0x18,%esp
    16e4:	83 ec 08             	sub    $0x8,%esp
    16e7:	68 a1 4c 00 00       	push   $0x4ca1
    16ec:	6a 01                	push   $0x1
    16ee:	e8 23 2a 00 00       	call   4116 <printf>
    16f3:	83 c4 10             	add    $0x10,%esp
    16f6:	83 ec 0c             	sub    $0xc,%esp
    16f9:	68 ab 4c 00 00       	push   $0x4cab
    16fe:	e8 d3 28 00 00       	call   3fd6 <unlink>
    1703:	83 c4 10             	add    $0x10,%esp
    1706:	83 ec 0c             	sub    $0xc,%esp
    1709:	68 af 4c 00 00       	push   $0x4caf
    170e:	e8 c3 28 00 00       	call   3fd6 <unlink>
    1713:	83 c4 10             	add    $0x10,%esp
    1716:	83 ec 08             	sub    $0x8,%esp
    1719:	68 02 02 00 00       	push   $0x202
    171e:	68 ab 4c 00 00       	push   $0x4cab
    1723:	e8 9e 28 00 00       	call   3fc6 <open>
    1728:	83 c4 10             	add    $0x10,%esp
    172b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    172e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1732:	79 17                	jns    174b <linktest+0x6d>
    1734:	83 ec 08             	sub    $0x8,%esp
    1737:	68 b3 4c 00 00       	push   $0x4cb3
    173c:	6a 01                	push   $0x1
    173e:	e8 d3 29 00 00       	call   4116 <printf>
    1743:	83 c4 10             	add    $0x10,%esp
    1746:	e8 3b 28 00 00       	call   3f86 <exit>
    174b:	83 ec 04             	sub    $0x4,%esp
    174e:	6a 05                	push   $0x5
    1750:	68 0f 4c 00 00       	push   $0x4c0f
    1755:	ff 75 f4             	pushl  -0xc(%ebp)
    1758:	e8 49 28 00 00       	call   3fa6 <write>
    175d:	83 c4 10             	add    $0x10,%esp
    1760:	83 f8 05             	cmp    $0x5,%eax
    1763:	74 17                	je     177c <linktest+0x9e>
    1765:	83 ec 08             	sub    $0x8,%esp
    1768:	68 c6 4c 00 00       	push   $0x4cc6
    176d:	6a 01                	push   $0x1
    176f:	e8 a2 29 00 00       	call   4116 <printf>
    1774:	83 c4 10             	add    $0x10,%esp
    1777:	e8 0a 28 00 00       	call   3f86 <exit>
    177c:	83 ec 0c             	sub    $0xc,%esp
    177f:	ff 75 f4             	pushl  -0xc(%ebp)
    1782:	e8 27 28 00 00       	call   3fae <close>
    1787:	83 c4 10             	add    $0x10,%esp
    178a:	83 ec 08             	sub    $0x8,%esp
    178d:	68 af 4c 00 00       	push   $0x4caf
    1792:	68 ab 4c 00 00       	push   $0x4cab
    1797:	e8 4a 28 00 00       	call   3fe6 <link>
    179c:	83 c4 10             	add    $0x10,%esp
    179f:	85 c0                	test   %eax,%eax
    17a1:	79 17                	jns    17ba <linktest+0xdc>
    17a3:	83 ec 08             	sub    $0x8,%esp
    17a6:	68 d8 4c 00 00       	push   $0x4cd8
    17ab:	6a 01                	push   $0x1
    17ad:	e8 64 29 00 00       	call   4116 <printf>
    17b2:	83 c4 10             	add    $0x10,%esp
    17b5:	e8 cc 27 00 00       	call   3f86 <exit>
    17ba:	83 ec 0c             	sub    $0xc,%esp
    17bd:	68 ab 4c 00 00       	push   $0x4cab
    17c2:	e8 0f 28 00 00       	call   3fd6 <unlink>
    17c7:	83 c4 10             	add    $0x10,%esp
    17ca:	83 ec 08             	sub    $0x8,%esp
    17cd:	6a 00                	push   $0x0
    17cf:	68 ab 4c 00 00       	push   $0x4cab
    17d4:	e8 ed 27 00 00       	call   3fc6 <open>
    17d9:	83 c4 10             	add    $0x10,%esp
    17dc:	85 c0                	test   %eax,%eax
    17de:	78 17                	js     17f7 <linktest+0x119>
    17e0:	83 ec 08             	sub    $0x8,%esp
    17e3:	68 f0 4c 00 00       	push   $0x4cf0
    17e8:	6a 01                	push   $0x1
    17ea:	e8 27 29 00 00       	call   4116 <printf>
    17ef:	83 c4 10             	add    $0x10,%esp
    17f2:	e8 8f 27 00 00       	call   3f86 <exit>
    17f7:	83 ec 08             	sub    $0x8,%esp
    17fa:	6a 00                	push   $0x0
    17fc:	68 af 4c 00 00       	push   $0x4caf
    1801:	e8 c0 27 00 00       	call   3fc6 <open>
    1806:	83 c4 10             	add    $0x10,%esp
    1809:	89 45 f4             	mov    %eax,-0xc(%ebp)
    180c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1810:	79 17                	jns    1829 <linktest+0x14b>
    1812:	83 ec 08             	sub    $0x8,%esp
    1815:	68 15 4d 00 00       	push   $0x4d15
    181a:	6a 01                	push   $0x1
    181c:	e8 f5 28 00 00       	call   4116 <printf>
    1821:	83 c4 10             	add    $0x10,%esp
    1824:	e8 5d 27 00 00       	call   3f86 <exit>
    1829:	83 ec 04             	sub    $0x4,%esp
    182c:	68 00 20 00 00       	push   $0x2000
    1831:	68 00 8c 00 00       	push   $0x8c00
    1836:	ff 75 f4             	pushl  -0xc(%ebp)
    1839:	e8 60 27 00 00       	call   3f9e <read>
    183e:	83 c4 10             	add    $0x10,%esp
    1841:	83 f8 05             	cmp    $0x5,%eax
    1844:	74 17                	je     185d <linktest+0x17f>
    1846:	83 ec 08             	sub    $0x8,%esp
    1849:	68 26 4d 00 00       	push   $0x4d26
    184e:	6a 01                	push   $0x1
    1850:	e8 c1 28 00 00       	call   4116 <printf>
    1855:	83 c4 10             	add    $0x10,%esp
    1858:	e8 29 27 00 00       	call   3f86 <exit>
    185d:	83 ec 0c             	sub    $0xc,%esp
    1860:	ff 75 f4             	pushl  -0xc(%ebp)
    1863:	e8 46 27 00 00       	call   3fae <close>
    1868:	83 c4 10             	add    $0x10,%esp
    186b:	83 ec 08             	sub    $0x8,%esp
    186e:	68 af 4c 00 00       	push   $0x4caf
    1873:	68 af 4c 00 00       	push   $0x4caf
    1878:	e8 69 27 00 00       	call   3fe6 <link>
    187d:	83 c4 10             	add    $0x10,%esp
    1880:	85 c0                	test   %eax,%eax
    1882:	78 17                	js     189b <linktest+0x1bd>
    1884:	83 ec 08             	sub    $0x8,%esp
    1887:	68 37 4d 00 00       	push   $0x4d37
    188c:	6a 01                	push   $0x1
    188e:	e8 83 28 00 00       	call   4116 <printf>
    1893:	83 c4 10             	add    $0x10,%esp
    1896:	e8 eb 26 00 00       	call   3f86 <exit>
    189b:	83 ec 0c             	sub    $0xc,%esp
    189e:	68 af 4c 00 00       	push   $0x4caf
    18a3:	e8 2e 27 00 00       	call   3fd6 <unlink>
    18a8:	83 c4 10             	add    $0x10,%esp
    18ab:	83 ec 08             	sub    $0x8,%esp
    18ae:	68 ab 4c 00 00       	push   $0x4cab
    18b3:	68 af 4c 00 00       	push   $0x4caf
    18b8:	e8 29 27 00 00       	call   3fe6 <link>
    18bd:	83 c4 10             	add    $0x10,%esp
    18c0:	85 c0                	test   %eax,%eax
    18c2:	78 17                	js     18db <linktest+0x1fd>
    18c4:	83 ec 08             	sub    $0x8,%esp
    18c7:	68 58 4d 00 00       	push   $0x4d58
    18cc:	6a 01                	push   $0x1
    18ce:	e8 43 28 00 00       	call   4116 <printf>
    18d3:	83 c4 10             	add    $0x10,%esp
    18d6:	e8 ab 26 00 00       	call   3f86 <exit>
    18db:	83 ec 08             	sub    $0x8,%esp
    18de:	68 ab 4c 00 00       	push   $0x4cab
    18e3:	68 7b 4d 00 00       	push   $0x4d7b
    18e8:	e8 f9 26 00 00       	call   3fe6 <link>
    18ed:	83 c4 10             	add    $0x10,%esp
    18f0:	85 c0                	test   %eax,%eax
    18f2:	78 17                	js     190b <linktest+0x22d>
    18f4:	83 ec 08             	sub    $0x8,%esp
    18f7:	68 7d 4d 00 00       	push   $0x4d7d
    18fc:	6a 01                	push   $0x1
    18fe:	e8 13 28 00 00       	call   4116 <printf>
    1903:	83 c4 10             	add    $0x10,%esp
    1906:	e8 7b 26 00 00       	call   3f86 <exit>
    190b:	83 ec 08             	sub    $0x8,%esp
    190e:	68 99 4d 00 00       	push   $0x4d99
    1913:	6a 01                	push   $0x1
    1915:	e8 fc 27 00 00       	call   4116 <printf>
    191a:	83 c4 10             	add    $0x10,%esp
    191d:	90                   	nop
    191e:	c9                   	leave  
    191f:	c3                   	ret    

00001920 <concreate>:
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    1923:	83 ec 58             	sub    $0x58,%esp
    1926:	83 ec 08             	sub    $0x8,%esp
    1929:	68 a6 4d 00 00       	push   $0x4da6
    192e:	6a 01                	push   $0x1
    1930:	e8 e1 27 00 00       	call   4116 <printf>
    1935:	83 c4 10             	add    $0x10,%esp
    1938:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
    193c:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
    1940:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1947:	e9 fc 00 00 00       	jmp    1a48 <concreate+0x128>
    194c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    194f:	83 c0 30             	add    $0x30,%eax
    1952:	88 45 e6             	mov    %al,-0x1a(%ebp)
    1955:	83 ec 0c             	sub    $0xc,%esp
    1958:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    195b:	50                   	push   %eax
    195c:	e8 75 26 00 00       	call   3fd6 <unlink>
    1961:	83 c4 10             	add    $0x10,%esp
    1964:	e8 15 26 00 00       	call   3f7e <fork>
    1969:	89 45 ec             	mov    %eax,-0x14(%ebp)
    196c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1970:	74 3b                	je     19ad <concreate+0x8d>
    1972:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1975:	ba 56 55 55 55       	mov    $0x55555556,%edx
    197a:	89 c8                	mov    %ecx,%eax
    197c:	f7 ea                	imul   %edx
    197e:	89 c8                	mov    %ecx,%eax
    1980:	c1 f8 1f             	sar    $0x1f,%eax
    1983:	29 c2                	sub    %eax,%edx
    1985:	89 d0                	mov    %edx,%eax
    1987:	01 c0                	add    %eax,%eax
    1989:	01 d0                	add    %edx,%eax
    198b:	29 c1                	sub    %eax,%ecx
    198d:	89 ca                	mov    %ecx,%edx
    198f:	83 fa 01             	cmp    $0x1,%edx
    1992:	75 19                	jne    19ad <concreate+0x8d>
    1994:	83 ec 08             	sub    $0x8,%esp
    1997:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    199a:	50                   	push   %eax
    199b:	68 b6 4d 00 00       	push   $0x4db6
    19a0:	e8 41 26 00 00       	call   3fe6 <link>
    19a5:	83 c4 10             	add    $0x10,%esp
    19a8:	e9 87 00 00 00       	jmp    1a34 <concreate+0x114>
    19ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19b1:	75 3b                	jne    19ee <concreate+0xce>
    19b3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    19b6:	ba 67 66 66 66       	mov    $0x66666667,%edx
    19bb:	89 c8                	mov    %ecx,%eax
    19bd:	f7 ea                	imul   %edx
    19bf:	d1 fa                	sar    %edx
    19c1:	89 c8                	mov    %ecx,%eax
    19c3:	c1 f8 1f             	sar    $0x1f,%eax
    19c6:	29 c2                	sub    %eax,%edx
    19c8:	89 d0                	mov    %edx,%eax
    19ca:	c1 e0 02             	shl    $0x2,%eax
    19cd:	01 d0                	add    %edx,%eax
    19cf:	29 c1                	sub    %eax,%ecx
    19d1:	89 ca                	mov    %ecx,%edx
    19d3:	83 fa 01             	cmp    $0x1,%edx
    19d6:	75 16                	jne    19ee <concreate+0xce>
    19d8:	83 ec 08             	sub    $0x8,%esp
    19db:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19de:	50                   	push   %eax
    19df:	68 b6 4d 00 00       	push   $0x4db6
    19e4:	e8 fd 25 00 00       	call   3fe6 <link>
    19e9:	83 c4 10             	add    $0x10,%esp
    19ec:	eb 46                	jmp    1a34 <concreate+0x114>
    19ee:	83 ec 08             	sub    $0x8,%esp
    19f1:	68 02 02 00 00       	push   $0x202
    19f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19f9:	50                   	push   %eax
    19fa:	e8 c7 25 00 00       	call   3fc6 <open>
    19ff:	83 c4 10             	add    $0x10,%esp
    1a02:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1a05:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1a09:	79 1b                	jns    1a26 <concreate+0x106>
    1a0b:	83 ec 04             	sub    $0x4,%esp
    1a0e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a11:	50                   	push   %eax
    1a12:	68 b9 4d 00 00       	push   $0x4db9
    1a17:	6a 01                	push   $0x1
    1a19:	e8 f8 26 00 00       	call   4116 <printf>
    1a1e:	83 c4 10             	add    $0x10,%esp
    1a21:	e8 60 25 00 00       	call   3f86 <exit>
    1a26:	83 ec 0c             	sub    $0xc,%esp
    1a29:	ff 75 e8             	pushl  -0x18(%ebp)
    1a2c:	e8 7d 25 00 00       	call   3fae <close>
    1a31:	83 c4 10             	add    $0x10,%esp
    1a34:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a38:	75 05                	jne    1a3f <concreate+0x11f>
    1a3a:	e8 47 25 00 00       	call   3f86 <exit>
    1a3f:	e8 4a 25 00 00       	call   3f8e <wait>
    1a44:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a48:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1a4c:	0f 8e fa fe ff ff    	jle    194c <concreate+0x2c>
    1a52:	83 ec 04             	sub    $0x4,%esp
    1a55:	6a 28                	push   $0x28
    1a57:	6a 00                	push   $0x0
    1a59:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1a5c:	50                   	push   %eax
    1a5d:	e8 77 23 00 00       	call   3dd9 <memset>
    1a62:	83 c4 10             	add    $0x10,%esp
    1a65:	83 ec 08             	sub    $0x8,%esp
    1a68:	6a 00                	push   $0x0
    1a6a:	68 7b 4d 00 00       	push   $0x4d7b
    1a6f:	e8 52 25 00 00       	call   3fc6 <open>
    1a74:	83 c4 10             	add    $0x10,%esp
    1a77:	89 45 e8             	mov    %eax,-0x18(%ebp)
    1a7a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1a81:	e9 93 00 00 00       	jmp    1b19 <concreate+0x1f9>
    1a86:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1a8a:	66 85 c0             	test   %ax,%ax
    1a8d:	75 05                	jne    1a94 <concreate+0x174>
    1a8f:	e9 85 00 00 00       	jmp    1b19 <concreate+0x1f9>
    1a94:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1a98:	3c 43                	cmp    $0x43,%al
    1a9a:	75 7d                	jne    1b19 <concreate+0x1f9>
    1a9c:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1aa0:	84 c0                	test   %al,%al
    1aa2:	75 75                	jne    1b19 <concreate+0x1f9>
    1aa4:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1aa8:	0f be c0             	movsbl %al,%eax
    1aab:	83 e8 30             	sub    $0x30,%eax
    1aae:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1ab1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ab5:	78 08                	js     1abf <concreate+0x19f>
    1ab7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aba:	83 f8 27             	cmp    $0x27,%eax
    1abd:	76 1e                	jbe    1add <concreate+0x1bd>
    1abf:	83 ec 04             	sub    $0x4,%esp
    1ac2:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1ac5:	83 c0 02             	add    $0x2,%eax
    1ac8:	50                   	push   %eax
    1ac9:	68 d5 4d 00 00       	push   $0x4dd5
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 41 26 00 00       	call   4116 <printf>
    1ad5:	83 c4 10             	add    $0x10,%esp
    1ad8:	e8 a9 24 00 00       	call   3f86 <exit>
    1add:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae3:	01 d0                	add    %edx,%eax
    1ae5:	0f b6 00             	movzbl (%eax),%eax
    1ae8:	84 c0                	test   %al,%al
    1aea:	74 1e                	je     1b0a <concreate+0x1ea>
    1aec:	83 ec 04             	sub    $0x4,%esp
    1aef:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1af2:	83 c0 02             	add    $0x2,%eax
    1af5:	50                   	push   %eax
    1af6:	68 ee 4d 00 00       	push   $0x4dee
    1afb:	6a 01                	push   $0x1
    1afd:	e8 14 26 00 00       	call   4116 <printf>
    1b02:	83 c4 10             	add    $0x10,%esp
    1b05:	e8 7c 24 00 00       	call   3f86 <exit>
    1b0a:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1b0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b10:	01 d0                	add    %edx,%eax
    1b12:	c6 00 01             	movb   $0x1,(%eax)
    1b15:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1b19:	83 ec 04             	sub    $0x4,%esp
    1b1c:	6a 10                	push   $0x10
    1b1e:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1b21:	50                   	push   %eax
    1b22:	ff 75 e8             	pushl  -0x18(%ebp)
    1b25:	e8 74 24 00 00       	call   3f9e <read>
    1b2a:	83 c4 10             	add    $0x10,%esp
    1b2d:	85 c0                	test   %eax,%eax
    1b2f:	0f 8f 51 ff ff ff    	jg     1a86 <concreate+0x166>
    1b35:	83 ec 0c             	sub    $0xc,%esp
    1b38:	ff 75 e8             	pushl  -0x18(%ebp)
    1b3b:	e8 6e 24 00 00       	call   3fae <close>
    1b40:	83 c4 10             	add    $0x10,%esp
    1b43:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1b47:	74 17                	je     1b60 <concreate+0x240>
    1b49:	83 ec 08             	sub    $0x8,%esp
    1b4c:	68 0c 4e 00 00       	push   $0x4e0c
    1b51:	6a 01                	push   $0x1
    1b53:	e8 be 25 00 00       	call   4116 <printf>
    1b58:	83 c4 10             	add    $0x10,%esp
    1b5b:	e8 26 24 00 00       	call   3f86 <exit>
    1b60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b67:	e9 45 01 00 00       	jmp    1cb1 <concreate+0x391>
    1b6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b6f:	83 c0 30             	add    $0x30,%eax
    1b72:	88 45 e6             	mov    %al,-0x1a(%ebp)
    1b75:	e8 04 24 00 00       	call   3f7e <fork>
    1b7a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b7d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b81:	79 17                	jns    1b9a <concreate+0x27a>
    1b83:	83 ec 08             	sub    $0x8,%esp
    1b86:	68 91 45 00 00       	push   $0x4591
    1b8b:	6a 01                	push   $0x1
    1b8d:	e8 84 25 00 00       	call   4116 <printf>
    1b92:	83 c4 10             	add    $0x10,%esp
    1b95:	e8 ec 23 00 00       	call   3f86 <exit>
    1b9a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1b9d:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1ba2:	89 c8                	mov    %ecx,%eax
    1ba4:	f7 ea                	imul   %edx
    1ba6:	89 c8                	mov    %ecx,%eax
    1ba8:	c1 f8 1f             	sar    $0x1f,%eax
    1bab:	29 c2                	sub    %eax,%edx
    1bad:	89 d0                	mov    %edx,%eax
    1baf:	89 c2                	mov    %eax,%edx
    1bb1:	01 d2                	add    %edx,%edx
    1bb3:	01 c2                	add    %eax,%edx
    1bb5:	89 c8                	mov    %ecx,%eax
    1bb7:	29 d0                	sub    %edx,%eax
    1bb9:	85 c0                	test   %eax,%eax
    1bbb:	75 06                	jne    1bc3 <concreate+0x2a3>
    1bbd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bc1:	74 28                	je     1beb <concreate+0x2cb>
    1bc3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1bc6:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1bcb:	89 c8                	mov    %ecx,%eax
    1bcd:	f7 ea                	imul   %edx
    1bcf:	89 c8                	mov    %ecx,%eax
    1bd1:	c1 f8 1f             	sar    $0x1f,%eax
    1bd4:	29 c2                	sub    %eax,%edx
    1bd6:	89 d0                	mov    %edx,%eax
    1bd8:	01 c0                	add    %eax,%eax
    1bda:	01 d0                	add    %edx,%eax
    1bdc:	29 c1                	sub    %eax,%ecx
    1bde:	89 ca                	mov    %ecx,%edx
    1be0:	83 fa 01             	cmp    $0x1,%edx
    1be3:	75 7c                	jne    1c61 <concreate+0x341>
    1be5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1be9:	74 76                	je     1c61 <concreate+0x341>
    1beb:	83 ec 08             	sub    $0x8,%esp
    1bee:	6a 00                	push   $0x0
    1bf0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bf3:	50                   	push   %eax
    1bf4:	e8 cd 23 00 00       	call   3fc6 <open>
    1bf9:	83 c4 10             	add    $0x10,%esp
    1bfc:	83 ec 0c             	sub    $0xc,%esp
    1bff:	50                   	push   %eax
    1c00:	e8 a9 23 00 00       	call   3fae <close>
    1c05:	83 c4 10             	add    $0x10,%esp
    1c08:	83 ec 08             	sub    $0x8,%esp
    1c0b:	6a 00                	push   $0x0
    1c0d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c10:	50                   	push   %eax
    1c11:	e8 b0 23 00 00       	call   3fc6 <open>
    1c16:	83 c4 10             	add    $0x10,%esp
    1c19:	83 ec 0c             	sub    $0xc,%esp
    1c1c:	50                   	push   %eax
    1c1d:	e8 8c 23 00 00       	call   3fae <close>
    1c22:	83 c4 10             	add    $0x10,%esp
    1c25:	83 ec 08             	sub    $0x8,%esp
    1c28:	6a 00                	push   $0x0
    1c2a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c2d:	50                   	push   %eax
    1c2e:	e8 93 23 00 00       	call   3fc6 <open>
    1c33:	83 c4 10             	add    $0x10,%esp
    1c36:	83 ec 0c             	sub    $0xc,%esp
    1c39:	50                   	push   %eax
    1c3a:	e8 6f 23 00 00       	call   3fae <close>
    1c3f:	83 c4 10             	add    $0x10,%esp
    1c42:	83 ec 08             	sub    $0x8,%esp
    1c45:	6a 00                	push   $0x0
    1c47:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c4a:	50                   	push   %eax
    1c4b:	e8 76 23 00 00       	call   3fc6 <open>
    1c50:	83 c4 10             	add    $0x10,%esp
    1c53:	83 ec 0c             	sub    $0xc,%esp
    1c56:	50                   	push   %eax
    1c57:	e8 52 23 00 00       	call   3fae <close>
    1c5c:	83 c4 10             	add    $0x10,%esp
    1c5f:	eb 3c                	jmp    1c9d <concreate+0x37d>
    1c61:	83 ec 0c             	sub    $0xc,%esp
    1c64:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c67:	50                   	push   %eax
    1c68:	e8 69 23 00 00       	call   3fd6 <unlink>
    1c6d:	83 c4 10             	add    $0x10,%esp
    1c70:	83 ec 0c             	sub    $0xc,%esp
    1c73:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c76:	50                   	push   %eax
    1c77:	e8 5a 23 00 00       	call   3fd6 <unlink>
    1c7c:	83 c4 10             	add    $0x10,%esp
    1c7f:	83 ec 0c             	sub    $0xc,%esp
    1c82:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c85:	50                   	push   %eax
    1c86:	e8 4b 23 00 00       	call   3fd6 <unlink>
    1c8b:	83 c4 10             	add    $0x10,%esp
    1c8e:	83 ec 0c             	sub    $0xc,%esp
    1c91:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c94:	50                   	push   %eax
    1c95:	e8 3c 23 00 00       	call   3fd6 <unlink>
    1c9a:	83 c4 10             	add    $0x10,%esp
    1c9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ca1:	75 05                	jne    1ca8 <concreate+0x388>
    1ca3:	e8 de 22 00 00       	call   3f86 <exit>
    1ca8:	e8 e1 22 00 00       	call   3f8e <wait>
    1cad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cb1:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1cb5:	0f 8e b1 fe ff ff    	jle    1b6c <concreate+0x24c>
    1cbb:	83 ec 08             	sub    $0x8,%esp
    1cbe:	68 3d 4e 00 00       	push   $0x4e3d
    1cc3:	6a 01                	push   $0x1
    1cc5:	e8 4c 24 00 00       	call   4116 <printf>
    1cca:	83 c4 10             	add    $0x10,%esp
    1ccd:	90                   	nop
    1cce:	c9                   	leave  
    1ccf:	c3                   	ret    

00001cd0 <linkunlink>:
    1cd0:	55                   	push   %ebp
    1cd1:	89 e5                	mov    %esp,%ebp
    1cd3:	83 ec 18             	sub    $0x18,%esp
    1cd6:	83 ec 08             	sub    $0x8,%esp
    1cd9:	68 4b 4e 00 00       	push   $0x4e4b
    1cde:	6a 01                	push   $0x1
    1ce0:	e8 31 24 00 00       	call   4116 <printf>
    1ce5:	83 c4 10             	add    $0x10,%esp
    1ce8:	83 ec 0c             	sub    $0xc,%esp
    1ceb:	68 c7 49 00 00       	push   $0x49c7
    1cf0:	e8 e1 22 00 00       	call   3fd6 <unlink>
    1cf5:	83 c4 10             	add    $0x10,%esp
    1cf8:	e8 81 22 00 00       	call   3f7e <fork>
    1cfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d00:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d04:	79 17                	jns    1d1d <linkunlink+0x4d>
    1d06:	83 ec 08             	sub    $0x8,%esp
    1d09:	68 91 45 00 00       	push   $0x4591
    1d0e:	6a 01                	push   $0x1
    1d10:	e8 01 24 00 00       	call   4116 <printf>
    1d15:	83 c4 10             	add    $0x10,%esp
    1d18:	e8 69 22 00 00       	call   3f86 <exit>
    1d1d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d21:	74 07                	je     1d2a <linkunlink+0x5a>
    1d23:	b8 01 00 00 00       	mov    $0x1,%eax
    1d28:	eb 05                	jmp    1d2f <linkunlink+0x5f>
    1d2a:	b8 61 00 00 00       	mov    $0x61,%eax
    1d2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d39:	e9 9a 00 00 00       	jmp    1dd8 <linkunlink+0x108>
    1d3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d41:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1d47:	05 39 30 00 00       	add    $0x3039,%eax
    1d4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d4f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d52:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1d57:	89 c8                	mov    %ecx,%eax
    1d59:	f7 e2                	mul    %edx
    1d5b:	89 d0                	mov    %edx,%eax
    1d5d:	d1 e8                	shr    %eax
    1d5f:	89 c2                	mov    %eax,%edx
    1d61:	01 d2                	add    %edx,%edx
    1d63:	01 c2                	add    %eax,%edx
    1d65:	89 c8                	mov    %ecx,%eax
    1d67:	29 d0                	sub    %edx,%eax
    1d69:	85 c0                	test   %eax,%eax
    1d6b:	75 23                	jne    1d90 <linkunlink+0xc0>
    1d6d:	83 ec 08             	sub    $0x8,%esp
    1d70:	68 02 02 00 00       	push   $0x202
    1d75:	68 c7 49 00 00       	push   $0x49c7
    1d7a:	e8 47 22 00 00       	call   3fc6 <open>
    1d7f:	83 c4 10             	add    $0x10,%esp
    1d82:	83 ec 0c             	sub    $0xc,%esp
    1d85:	50                   	push   %eax
    1d86:	e8 23 22 00 00       	call   3fae <close>
    1d8b:	83 c4 10             	add    $0x10,%esp
    1d8e:	eb 44                	jmp    1dd4 <linkunlink+0x104>
    1d90:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d93:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1d98:	89 c8                	mov    %ecx,%eax
    1d9a:	f7 e2                	mul    %edx
    1d9c:	d1 ea                	shr    %edx
    1d9e:	89 d0                	mov    %edx,%eax
    1da0:	01 c0                	add    %eax,%eax
    1da2:	01 d0                	add    %edx,%eax
    1da4:	29 c1                	sub    %eax,%ecx
    1da6:	89 ca                	mov    %ecx,%edx
    1da8:	83 fa 01             	cmp    $0x1,%edx
    1dab:	75 17                	jne    1dc4 <linkunlink+0xf4>
    1dad:	83 ec 08             	sub    $0x8,%esp
    1db0:	68 c7 49 00 00       	push   $0x49c7
    1db5:	68 5c 4e 00 00       	push   $0x4e5c
    1dba:	e8 27 22 00 00       	call   3fe6 <link>
    1dbf:	83 c4 10             	add    $0x10,%esp
    1dc2:	eb 10                	jmp    1dd4 <linkunlink+0x104>
    1dc4:	83 ec 0c             	sub    $0xc,%esp
    1dc7:	68 c7 49 00 00       	push   $0x49c7
    1dcc:	e8 05 22 00 00       	call   3fd6 <unlink>
    1dd1:	83 c4 10             	add    $0x10,%esp
    1dd4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1dd8:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1ddc:	0f 8e 5c ff ff ff    	jle    1d3e <linkunlink+0x6e>
    1de2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1de6:	74 07                	je     1def <linkunlink+0x11f>
    1de8:	e8 a1 21 00 00       	call   3f8e <wait>
    1ded:	eb 05                	jmp    1df4 <linkunlink+0x124>
    1def:	e8 92 21 00 00       	call   3f86 <exit>
    1df4:	83 ec 08             	sub    $0x8,%esp
    1df7:	68 60 4e 00 00       	push   $0x4e60
    1dfc:	6a 01                	push   $0x1
    1dfe:	e8 13 23 00 00       	call   4116 <printf>
    1e03:	83 c4 10             	add    $0x10,%esp
    1e06:	90                   	nop
    1e07:	c9                   	leave  
    1e08:	c3                   	ret    

00001e09 <bigdir>:
    1e09:	55                   	push   %ebp
    1e0a:	89 e5                	mov    %esp,%ebp
    1e0c:	83 ec 28             	sub    $0x28,%esp
    1e0f:	83 ec 08             	sub    $0x8,%esp
    1e12:	68 6f 4e 00 00       	push   $0x4e6f
    1e17:	6a 01                	push   $0x1
    1e19:	e8 f8 22 00 00       	call   4116 <printf>
    1e1e:	83 c4 10             	add    $0x10,%esp
    1e21:	83 ec 0c             	sub    $0xc,%esp
    1e24:	68 7c 4e 00 00       	push   $0x4e7c
    1e29:	e8 a8 21 00 00       	call   3fd6 <unlink>
    1e2e:	83 c4 10             	add    $0x10,%esp
    1e31:	83 ec 08             	sub    $0x8,%esp
    1e34:	68 00 02 00 00       	push   $0x200
    1e39:	68 7c 4e 00 00       	push   $0x4e7c
    1e3e:	e8 83 21 00 00       	call   3fc6 <open>
    1e43:	83 c4 10             	add    $0x10,%esp
    1e46:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e49:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e4d:	79 17                	jns    1e66 <bigdir+0x5d>
    1e4f:	83 ec 08             	sub    $0x8,%esp
    1e52:	68 7f 4e 00 00       	push   $0x4e7f
    1e57:	6a 01                	push   $0x1
    1e59:	e8 b8 22 00 00       	call   4116 <printf>
    1e5e:	83 c4 10             	add    $0x10,%esp
    1e61:	e8 20 21 00 00       	call   3f86 <exit>
    1e66:	83 ec 0c             	sub    $0xc,%esp
    1e69:	ff 75 f0             	pushl  -0x10(%ebp)
    1e6c:	e8 3d 21 00 00       	call   3fae <close>
    1e71:	83 c4 10             	add    $0x10,%esp
    1e74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e7b:	eb 63                	jmp    1ee0 <bigdir+0xd7>
    1e7d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    1e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e84:	8d 50 3f             	lea    0x3f(%eax),%edx
    1e87:	85 c0                	test   %eax,%eax
    1e89:	0f 48 c2             	cmovs  %edx,%eax
    1e8c:	c1 f8 06             	sar    $0x6,%eax
    1e8f:	83 c0 30             	add    $0x30,%eax
    1e92:	88 45 e7             	mov    %al,-0x19(%ebp)
    1e95:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e98:	99                   	cltd   
    1e99:	c1 ea 1a             	shr    $0x1a,%edx
    1e9c:	01 d0                	add    %edx,%eax
    1e9e:	83 e0 3f             	and    $0x3f,%eax
    1ea1:	29 d0                	sub    %edx,%eax
    1ea3:	83 c0 30             	add    $0x30,%eax
    1ea6:	88 45 e8             	mov    %al,-0x18(%ebp)
    1ea9:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    1ead:	83 ec 08             	sub    $0x8,%esp
    1eb0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1eb3:	50                   	push   %eax
    1eb4:	68 7c 4e 00 00       	push   $0x4e7c
    1eb9:	e8 28 21 00 00       	call   3fe6 <link>
    1ebe:	83 c4 10             	add    $0x10,%esp
    1ec1:	85 c0                	test   %eax,%eax
    1ec3:	74 17                	je     1edc <bigdir+0xd3>
    1ec5:	83 ec 08             	sub    $0x8,%esp
    1ec8:	68 95 4e 00 00       	push   $0x4e95
    1ecd:	6a 01                	push   $0x1
    1ecf:	e8 42 22 00 00       	call   4116 <printf>
    1ed4:	83 c4 10             	add    $0x10,%esp
    1ed7:	e8 aa 20 00 00       	call   3f86 <exit>
    1edc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ee0:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1ee7:	7e 94                	jle    1e7d <bigdir+0x74>
    1ee9:	83 ec 0c             	sub    $0xc,%esp
    1eec:	68 7c 4e 00 00       	push   $0x4e7c
    1ef1:	e8 e0 20 00 00       	call   3fd6 <unlink>
    1ef6:	83 c4 10             	add    $0x10,%esp
    1ef9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f00:	eb 5e                	jmp    1f60 <bigdir+0x157>
    1f02:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    1f06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f09:	8d 50 3f             	lea    0x3f(%eax),%edx
    1f0c:	85 c0                	test   %eax,%eax
    1f0e:	0f 48 c2             	cmovs  %edx,%eax
    1f11:	c1 f8 06             	sar    $0x6,%eax
    1f14:	83 c0 30             	add    $0x30,%eax
    1f17:	88 45 e7             	mov    %al,-0x19(%ebp)
    1f1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f1d:	99                   	cltd   
    1f1e:	c1 ea 1a             	shr    $0x1a,%edx
    1f21:	01 d0                	add    %edx,%eax
    1f23:	83 e0 3f             	and    $0x3f,%eax
    1f26:	29 d0                	sub    %edx,%eax
    1f28:	83 c0 30             	add    $0x30,%eax
    1f2b:	88 45 e8             	mov    %al,-0x18(%ebp)
    1f2e:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    1f32:	83 ec 0c             	sub    $0xc,%esp
    1f35:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1f38:	50                   	push   %eax
    1f39:	e8 98 20 00 00       	call   3fd6 <unlink>
    1f3e:	83 c4 10             	add    $0x10,%esp
    1f41:	85 c0                	test   %eax,%eax
    1f43:	74 17                	je     1f5c <bigdir+0x153>
    1f45:	83 ec 08             	sub    $0x8,%esp
    1f48:	68 a9 4e 00 00       	push   $0x4ea9
    1f4d:	6a 01                	push   $0x1
    1f4f:	e8 c2 21 00 00       	call   4116 <printf>
    1f54:	83 c4 10             	add    $0x10,%esp
    1f57:	e8 2a 20 00 00       	call   3f86 <exit>
    1f5c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f60:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1f67:	7e 99                	jle    1f02 <bigdir+0xf9>
    1f69:	83 ec 08             	sub    $0x8,%esp
    1f6c:	68 be 4e 00 00       	push   $0x4ebe
    1f71:	6a 01                	push   $0x1
    1f73:	e8 9e 21 00 00       	call   4116 <printf>
    1f78:	83 c4 10             	add    $0x10,%esp
    1f7b:	90                   	nop
    1f7c:	c9                   	leave  
    1f7d:	c3                   	ret    

00001f7e <subdir>:
    1f7e:	55                   	push   %ebp
    1f7f:	89 e5                	mov    %esp,%ebp
    1f81:	83 ec 18             	sub    $0x18,%esp
    1f84:	83 ec 08             	sub    $0x8,%esp
    1f87:	68 c9 4e 00 00       	push   $0x4ec9
    1f8c:	6a 01                	push   $0x1
    1f8e:	e8 83 21 00 00       	call   4116 <printf>
    1f93:	83 c4 10             	add    $0x10,%esp
    1f96:	83 ec 0c             	sub    $0xc,%esp
    1f99:	68 d6 4e 00 00       	push   $0x4ed6
    1f9e:	e8 33 20 00 00       	call   3fd6 <unlink>
    1fa3:	83 c4 10             	add    $0x10,%esp
    1fa6:	83 ec 0c             	sub    $0xc,%esp
    1fa9:	68 d9 4e 00 00       	push   $0x4ed9
    1fae:	e8 3b 20 00 00       	call   3fee <mkdir>
    1fb3:	83 c4 10             	add    $0x10,%esp
    1fb6:	85 c0                	test   %eax,%eax
    1fb8:	74 17                	je     1fd1 <subdir+0x53>
    1fba:	83 ec 08             	sub    $0x8,%esp
    1fbd:	68 dc 4e 00 00       	push   $0x4edc
    1fc2:	6a 01                	push   $0x1
    1fc4:	e8 4d 21 00 00       	call   4116 <printf>
    1fc9:	83 c4 10             	add    $0x10,%esp
    1fcc:	e8 b5 1f 00 00       	call   3f86 <exit>
    1fd1:	83 ec 08             	sub    $0x8,%esp
    1fd4:	68 02 02 00 00       	push   $0x202
    1fd9:	68 f4 4e 00 00       	push   $0x4ef4
    1fde:	e8 e3 1f 00 00       	call   3fc6 <open>
    1fe3:	83 c4 10             	add    $0x10,%esp
    1fe6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1fe9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fed:	79 17                	jns    2006 <subdir+0x88>
    1fef:	83 ec 08             	sub    $0x8,%esp
    1ff2:	68 fa 4e 00 00       	push   $0x4efa
    1ff7:	6a 01                	push   $0x1
    1ff9:	e8 18 21 00 00       	call   4116 <printf>
    1ffe:	83 c4 10             	add    $0x10,%esp
    2001:	e8 80 1f 00 00       	call   3f86 <exit>
    2006:	83 ec 04             	sub    $0x4,%esp
    2009:	6a 02                	push   $0x2
    200b:	68 d6 4e 00 00       	push   $0x4ed6
    2010:	ff 75 f4             	pushl  -0xc(%ebp)
    2013:	e8 8e 1f 00 00       	call   3fa6 <write>
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	83 ec 0c             	sub    $0xc,%esp
    201e:	ff 75 f4             	pushl  -0xc(%ebp)
    2021:	e8 88 1f 00 00       	call   3fae <close>
    2026:	83 c4 10             	add    $0x10,%esp
    2029:	83 ec 0c             	sub    $0xc,%esp
    202c:	68 d9 4e 00 00       	push   $0x4ed9
    2031:	e8 a0 1f 00 00       	call   3fd6 <unlink>
    2036:	83 c4 10             	add    $0x10,%esp
    2039:	85 c0                	test   %eax,%eax
    203b:	78 17                	js     2054 <subdir+0xd6>
    203d:	83 ec 08             	sub    $0x8,%esp
    2040:	68 10 4f 00 00       	push   $0x4f10
    2045:	6a 01                	push   $0x1
    2047:	e8 ca 20 00 00       	call   4116 <printf>
    204c:	83 c4 10             	add    $0x10,%esp
    204f:	e8 32 1f 00 00       	call   3f86 <exit>
    2054:	83 ec 0c             	sub    $0xc,%esp
    2057:	68 36 4f 00 00       	push   $0x4f36
    205c:	e8 8d 1f 00 00       	call   3fee <mkdir>
    2061:	83 c4 10             	add    $0x10,%esp
    2064:	85 c0                	test   %eax,%eax
    2066:	74 17                	je     207f <subdir+0x101>
    2068:	83 ec 08             	sub    $0x8,%esp
    206b:	68 3d 4f 00 00       	push   $0x4f3d
    2070:	6a 01                	push   $0x1
    2072:	e8 9f 20 00 00       	call   4116 <printf>
    2077:	83 c4 10             	add    $0x10,%esp
    207a:	e8 07 1f 00 00       	call   3f86 <exit>
    207f:	83 ec 08             	sub    $0x8,%esp
    2082:	68 02 02 00 00       	push   $0x202
    2087:	68 58 4f 00 00       	push   $0x4f58
    208c:	e8 35 1f 00 00       	call   3fc6 <open>
    2091:	83 c4 10             	add    $0x10,%esp
    2094:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2097:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    209b:	79 17                	jns    20b4 <subdir+0x136>
    209d:	83 ec 08             	sub    $0x8,%esp
    20a0:	68 61 4f 00 00       	push   $0x4f61
    20a5:	6a 01                	push   $0x1
    20a7:	e8 6a 20 00 00       	call   4116 <printf>
    20ac:	83 c4 10             	add    $0x10,%esp
    20af:	e8 d2 1e 00 00       	call   3f86 <exit>
    20b4:	83 ec 04             	sub    $0x4,%esp
    20b7:	6a 02                	push   $0x2
    20b9:	68 79 4f 00 00       	push   $0x4f79
    20be:	ff 75 f4             	pushl  -0xc(%ebp)
    20c1:	e8 e0 1e 00 00       	call   3fa6 <write>
    20c6:	83 c4 10             	add    $0x10,%esp
    20c9:	83 ec 0c             	sub    $0xc,%esp
    20cc:	ff 75 f4             	pushl  -0xc(%ebp)
    20cf:	e8 da 1e 00 00       	call   3fae <close>
    20d4:	83 c4 10             	add    $0x10,%esp
    20d7:	83 ec 08             	sub    $0x8,%esp
    20da:	6a 00                	push   $0x0
    20dc:	68 7c 4f 00 00       	push   $0x4f7c
    20e1:	e8 e0 1e 00 00       	call   3fc6 <open>
    20e6:	83 c4 10             	add    $0x10,%esp
    20e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    20ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20f0:	79 17                	jns    2109 <subdir+0x18b>
    20f2:	83 ec 08             	sub    $0x8,%esp
    20f5:	68 88 4f 00 00       	push   $0x4f88
    20fa:	6a 01                	push   $0x1
    20fc:	e8 15 20 00 00       	call   4116 <printf>
    2101:	83 c4 10             	add    $0x10,%esp
    2104:	e8 7d 1e 00 00       	call   3f86 <exit>
    2109:	83 ec 04             	sub    $0x4,%esp
    210c:	68 00 20 00 00       	push   $0x2000
    2111:	68 00 8c 00 00       	push   $0x8c00
    2116:	ff 75 f4             	pushl  -0xc(%ebp)
    2119:	e8 80 1e 00 00       	call   3f9e <read>
    211e:	83 c4 10             	add    $0x10,%esp
    2121:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2124:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    2128:	75 0b                	jne    2135 <subdir+0x1b7>
    212a:	0f b6 05 00 8c 00 00 	movzbl 0x8c00,%eax
    2131:	3c 66                	cmp    $0x66,%al
    2133:	74 17                	je     214c <subdir+0x1ce>
    2135:	83 ec 08             	sub    $0x8,%esp
    2138:	68 a1 4f 00 00       	push   $0x4fa1
    213d:	6a 01                	push   $0x1
    213f:	e8 d2 1f 00 00       	call   4116 <printf>
    2144:	83 c4 10             	add    $0x10,%esp
    2147:	e8 3a 1e 00 00       	call   3f86 <exit>
    214c:	83 ec 0c             	sub    $0xc,%esp
    214f:	ff 75 f4             	pushl  -0xc(%ebp)
    2152:	e8 57 1e 00 00       	call   3fae <close>
    2157:	83 c4 10             	add    $0x10,%esp
    215a:	83 ec 08             	sub    $0x8,%esp
    215d:	68 bc 4f 00 00       	push   $0x4fbc
    2162:	68 58 4f 00 00       	push   $0x4f58
    2167:	e8 7a 1e 00 00       	call   3fe6 <link>
    216c:	83 c4 10             	add    $0x10,%esp
    216f:	85 c0                	test   %eax,%eax
    2171:	74 17                	je     218a <subdir+0x20c>
    2173:	83 ec 08             	sub    $0x8,%esp
    2176:	68 c8 4f 00 00       	push   $0x4fc8
    217b:	6a 01                	push   $0x1
    217d:	e8 94 1f 00 00       	call   4116 <printf>
    2182:	83 c4 10             	add    $0x10,%esp
    2185:	e8 fc 1d 00 00       	call   3f86 <exit>
    218a:	83 ec 0c             	sub    $0xc,%esp
    218d:	68 58 4f 00 00       	push   $0x4f58
    2192:	e8 3f 1e 00 00       	call   3fd6 <unlink>
    2197:	83 c4 10             	add    $0x10,%esp
    219a:	85 c0                	test   %eax,%eax
    219c:	74 17                	je     21b5 <subdir+0x237>
    219e:	83 ec 08             	sub    $0x8,%esp
    21a1:	68 e9 4f 00 00       	push   $0x4fe9
    21a6:	6a 01                	push   $0x1
    21a8:	e8 69 1f 00 00       	call   4116 <printf>
    21ad:	83 c4 10             	add    $0x10,%esp
    21b0:	e8 d1 1d 00 00       	call   3f86 <exit>
    21b5:	83 ec 08             	sub    $0x8,%esp
    21b8:	6a 00                	push   $0x0
    21ba:	68 58 4f 00 00       	push   $0x4f58
    21bf:	e8 02 1e 00 00       	call   3fc6 <open>
    21c4:	83 c4 10             	add    $0x10,%esp
    21c7:	85 c0                	test   %eax,%eax
    21c9:	78 17                	js     21e2 <subdir+0x264>
    21cb:	83 ec 08             	sub    $0x8,%esp
    21ce:	68 04 50 00 00       	push   $0x5004
    21d3:	6a 01                	push   $0x1
    21d5:	e8 3c 1f 00 00       	call   4116 <printf>
    21da:	83 c4 10             	add    $0x10,%esp
    21dd:	e8 a4 1d 00 00       	call   3f86 <exit>
    21e2:	83 ec 0c             	sub    $0xc,%esp
    21e5:	68 d9 4e 00 00       	push   $0x4ed9
    21ea:	e8 07 1e 00 00       	call   3ff6 <chdir>
    21ef:	83 c4 10             	add    $0x10,%esp
    21f2:	85 c0                	test   %eax,%eax
    21f4:	74 17                	je     220d <subdir+0x28f>
    21f6:	83 ec 08             	sub    $0x8,%esp
    21f9:	68 28 50 00 00       	push   $0x5028
    21fe:	6a 01                	push   $0x1
    2200:	e8 11 1f 00 00       	call   4116 <printf>
    2205:	83 c4 10             	add    $0x10,%esp
    2208:	e8 79 1d 00 00       	call   3f86 <exit>
    220d:	83 ec 0c             	sub    $0xc,%esp
    2210:	68 39 50 00 00       	push   $0x5039
    2215:	e8 dc 1d 00 00       	call   3ff6 <chdir>
    221a:	83 c4 10             	add    $0x10,%esp
    221d:	85 c0                	test   %eax,%eax
    221f:	74 17                	je     2238 <subdir+0x2ba>
    2221:	83 ec 08             	sub    $0x8,%esp
    2224:	68 45 50 00 00       	push   $0x5045
    2229:	6a 01                	push   $0x1
    222b:	e8 e6 1e 00 00       	call   4116 <printf>
    2230:	83 c4 10             	add    $0x10,%esp
    2233:	e8 4e 1d 00 00       	call   3f86 <exit>
    2238:	83 ec 0c             	sub    $0xc,%esp
    223b:	68 5f 50 00 00       	push   $0x505f
    2240:	e8 b1 1d 00 00       	call   3ff6 <chdir>
    2245:	83 c4 10             	add    $0x10,%esp
    2248:	85 c0                	test   %eax,%eax
    224a:	74 17                	je     2263 <subdir+0x2e5>
    224c:	83 ec 08             	sub    $0x8,%esp
    224f:	68 45 50 00 00       	push   $0x5045
    2254:	6a 01                	push   $0x1
    2256:	e8 bb 1e 00 00       	call   4116 <printf>
    225b:	83 c4 10             	add    $0x10,%esp
    225e:	e8 23 1d 00 00       	call   3f86 <exit>
    2263:	83 ec 0c             	sub    $0xc,%esp
    2266:	68 6e 50 00 00       	push   $0x506e
    226b:	e8 86 1d 00 00       	call   3ff6 <chdir>
    2270:	83 c4 10             	add    $0x10,%esp
    2273:	85 c0                	test   %eax,%eax
    2275:	74 17                	je     228e <subdir+0x310>
    2277:	83 ec 08             	sub    $0x8,%esp
    227a:	68 73 50 00 00       	push   $0x5073
    227f:	6a 01                	push   $0x1
    2281:	e8 90 1e 00 00       	call   4116 <printf>
    2286:	83 c4 10             	add    $0x10,%esp
    2289:	e8 f8 1c 00 00       	call   3f86 <exit>
    228e:	83 ec 08             	sub    $0x8,%esp
    2291:	6a 00                	push   $0x0
    2293:	68 bc 4f 00 00       	push   $0x4fbc
    2298:	e8 29 1d 00 00       	call   3fc6 <open>
    229d:	83 c4 10             	add    $0x10,%esp
    22a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    22a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22a7:	79 17                	jns    22c0 <subdir+0x342>
    22a9:	83 ec 08             	sub    $0x8,%esp
    22ac:	68 86 50 00 00       	push   $0x5086
    22b1:	6a 01                	push   $0x1
    22b3:	e8 5e 1e 00 00       	call   4116 <printf>
    22b8:	83 c4 10             	add    $0x10,%esp
    22bb:	e8 c6 1c 00 00       	call   3f86 <exit>
    22c0:	83 ec 04             	sub    $0x4,%esp
    22c3:	68 00 20 00 00       	push   $0x2000
    22c8:	68 00 8c 00 00       	push   $0x8c00
    22cd:	ff 75 f4             	pushl  -0xc(%ebp)
    22d0:	e8 c9 1c 00 00       	call   3f9e <read>
    22d5:	83 c4 10             	add    $0x10,%esp
    22d8:	83 f8 02             	cmp    $0x2,%eax
    22db:	74 17                	je     22f4 <subdir+0x376>
    22dd:	83 ec 08             	sub    $0x8,%esp
    22e0:	68 9e 50 00 00       	push   $0x509e
    22e5:	6a 01                	push   $0x1
    22e7:	e8 2a 1e 00 00       	call   4116 <printf>
    22ec:	83 c4 10             	add    $0x10,%esp
    22ef:	e8 92 1c 00 00       	call   3f86 <exit>
    22f4:	83 ec 0c             	sub    $0xc,%esp
    22f7:	ff 75 f4             	pushl  -0xc(%ebp)
    22fa:	e8 af 1c 00 00       	call   3fae <close>
    22ff:	83 c4 10             	add    $0x10,%esp
    2302:	83 ec 08             	sub    $0x8,%esp
    2305:	6a 00                	push   $0x0
    2307:	68 58 4f 00 00       	push   $0x4f58
    230c:	e8 b5 1c 00 00       	call   3fc6 <open>
    2311:	83 c4 10             	add    $0x10,%esp
    2314:	85 c0                	test   %eax,%eax
    2316:	78 17                	js     232f <subdir+0x3b1>
    2318:	83 ec 08             	sub    $0x8,%esp
    231b:	68 bc 50 00 00       	push   $0x50bc
    2320:	6a 01                	push   $0x1
    2322:	e8 ef 1d 00 00       	call   4116 <printf>
    2327:	83 c4 10             	add    $0x10,%esp
    232a:	e8 57 1c 00 00       	call   3f86 <exit>
    232f:	83 ec 08             	sub    $0x8,%esp
    2332:	68 02 02 00 00       	push   $0x202
    2337:	68 e1 50 00 00       	push   $0x50e1
    233c:	e8 85 1c 00 00       	call   3fc6 <open>
    2341:	83 c4 10             	add    $0x10,%esp
    2344:	85 c0                	test   %eax,%eax
    2346:	78 17                	js     235f <subdir+0x3e1>
    2348:	83 ec 08             	sub    $0x8,%esp
    234b:	68 ea 50 00 00       	push   $0x50ea
    2350:	6a 01                	push   $0x1
    2352:	e8 bf 1d 00 00       	call   4116 <printf>
    2357:	83 c4 10             	add    $0x10,%esp
    235a:	e8 27 1c 00 00       	call   3f86 <exit>
    235f:	83 ec 08             	sub    $0x8,%esp
    2362:	68 02 02 00 00       	push   $0x202
    2367:	68 06 51 00 00       	push   $0x5106
    236c:	e8 55 1c 00 00       	call   3fc6 <open>
    2371:	83 c4 10             	add    $0x10,%esp
    2374:	85 c0                	test   %eax,%eax
    2376:	78 17                	js     238f <subdir+0x411>
    2378:	83 ec 08             	sub    $0x8,%esp
    237b:	68 0f 51 00 00       	push   $0x510f
    2380:	6a 01                	push   $0x1
    2382:	e8 8f 1d 00 00       	call   4116 <printf>
    2387:	83 c4 10             	add    $0x10,%esp
    238a:	e8 f7 1b 00 00       	call   3f86 <exit>
    238f:	83 ec 08             	sub    $0x8,%esp
    2392:	68 00 02 00 00       	push   $0x200
    2397:	68 d9 4e 00 00       	push   $0x4ed9
    239c:	e8 25 1c 00 00       	call   3fc6 <open>
    23a1:	83 c4 10             	add    $0x10,%esp
    23a4:	85 c0                	test   %eax,%eax
    23a6:	78 17                	js     23bf <subdir+0x441>
    23a8:	83 ec 08             	sub    $0x8,%esp
    23ab:	68 2b 51 00 00       	push   $0x512b
    23b0:	6a 01                	push   $0x1
    23b2:	e8 5f 1d 00 00       	call   4116 <printf>
    23b7:	83 c4 10             	add    $0x10,%esp
    23ba:	e8 c7 1b 00 00       	call   3f86 <exit>
    23bf:	83 ec 08             	sub    $0x8,%esp
    23c2:	6a 02                	push   $0x2
    23c4:	68 d9 4e 00 00       	push   $0x4ed9
    23c9:	e8 f8 1b 00 00       	call   3fc6 <open>
    23ce:	83 c4 10             	add    $0x10,%esp
    23d1:	85 c0                	test   %eax,%eax
    23d3:	78 17                	js     23ec <subdir+0x46e>
    23d5:	83 ec 08             	sub    $0x8,%esp
    23d8:	68 41 51 00 00       	push   $0x5141
    23dd:	6a 01                	push   $0x1
    23df:	e8 32 1d 00 00       	call   4116 <printf>
    23e4:	83 c4 10             	add    $0x10,%esp
    23e7:	e8 9a 1b 00 00       	call   3f86 <exit>
    23ec:	83 ec 08             	sub    $0x8,%esp
    23ef:	6a 01                	push   $0x1
    23f1:	68 d9 4e 00 00       	push   $0x4ed9
    23f6:	e8 cb 1b 00 00       	call   3fc6 <open>
    23fb:	83 c4 10             	add    $0x10,%esp
    23fe:	85 c0                	test   %eax,%eax
    2400:	78 17                	js     2419 <subdir+0x49b>
    2402:	83 ec 08             	sub    $0x8,%esp
    2405:	68 5a 51 00 00       	push   $0x515a
    240a:	6a 01                	push   $0x1
    240c:	e8 05 1d 00 00       	call   4116 <printf>
    2411:	83 c4 10             	add    $0x10,%esp
    2414:	e8 6d 1b 00 00       	call   3f86 <exit>
    2419:	83 ec 08             	sub    $0x8,%esp
    241c:	68 75 51 00 00       	push   $0x5175
    2421:	68 e1 50 00 00       	push   $0x50e1
    2426:	e8 bb 1b 00 00       	call   3fe6 <link>
    242b:	83 c4 10             	add    $0x10,%esp
    242e:	85 c0                	test   %eax,%eax
    2430:	75 17                	jne    2449 <subdir+0x4cb>
    2432:	83 ec 08             	sub    $0x8,%esp
    2435:	68 80 51 00 00       	push   $0x5180
    243a:	6a 01                	push   $0x1
    243c:	e8 d5 1c 00 00       	call   4116 <printf>
    2441:	83 c4 10             	add    $0x10,%esp
    2444:	e8 3d 1b 00 00       	call   3f86 <exit>
    2449:	83 ec 08             	sub    $0x8,%esp
    244c:	68 75 51 00 00       	push   $0x5175
    2451:	68 06 51 00 00       	push   $0x5106
    2456:	e8 8b 1b 00 00       	call   3fe6 <link>
    245b:	83 c4 10             	add    $0x10,%esp
    245e:	85 c0                	test   %eax,%eax
    2460:	75 17                	jne    2479 <subdir+0x4fb>
    2462:	83 ec 08             	sub    $0x8,%esp
    2465:	68 a4 51 00 00       	push   $0x51a4
    246a:	6a 01                	push   $0x1
    246c:	e8 a5 1c 00 00       	call   4116 <printf>
    2471:	83 c4 10             	add    $0x10,%esp
    2474:	e8 0d 1b 00 00       	call   3f86 <exit>
    2479:	83 ec 08             	sub    $0x8,%esp
    247c:	68 bc 4f 00 00       	push   $0x4fbc
    2481:	68 f4 4e 00 00       	push   $0x4ef4
    2486:	e8 5b 1b 00 00       	call   3fe6 <link>
    248b:	83 c4 10             	add    $0x10,%esp
    248e:	85 c0                	test   %eax,%eax
    2490:	75 17                	jne    24a9 <subdir+0x52b>
    2492:	83 ec 08             	sub    $0x8,%esp
    2495:	68 c8 51 00 00       	push   $0x51c8
    249a:	6a 01                	push   $0x1
    249c:	e8 75 1c 00 00       	call   4116 <printf>
    24a1:	83 c4 10             	add    $0x10,%esp
    24a4:	e8 dd 1a 00 00       	call   3f86 <exit>
    24a9:	83 ec 0c             	sub    $0xc,%esp
    24ac:	68 e1 50 00 00       	push   $0x50e1
    24b1:	e8 38 1b 00 00       	call   3fee <mkdir>
    24b6:	83 c4 10             	add    $0x10,%esp
    24b9:	85 c0                	test   %eax,%eax
    24bb:	75 17                	jne    24d4 <subdir+0x556>
    24bd:	83 ec 08             	sub    $0x8,%esp
    24c0:	68 ea 51 00 00       	push   $0x51ea
    24c5:	6a 01                	push   $0x1
    24c7:	e8 4a 1c 00 00       	call   4116 <printf>
    24cc:	83 c4 10             	add    $0x10,%esp
    24cf:	e8 b2 1a 00 00       	call   3f86 <exit>
    24d4:	83 ec 0c             	sub    $0xc,%esp
    24d7:	68 06 51 00 00       	push   $0x5106
    24dc:	e8 0d 1b 00 00       	call   3fee <mkdir>
    24e1:	83 c4 10             	add    $0x10,%esp
    24e4:	85 c0                	test   %eax,%eax
    24e6:	75 17                	jne    24ff <subdir+0x581>
    24e8:	83 ec 08             	sub    $0x8,%esp
    24eb:	68 05 52 00 00       	push   $0x5205
    24f0:	6a 01                	push   $0x1
    24f2:	e8 1f 1c 00 00       	call   4116 <printf>
    24f7:	83 c4 10             	add    $0x10,%esp
    24fa:	e8 87 1a 00 00       	call   3f86 <exit>
    24ff:	83 ec 0c             	sub    $0xc,%esp
    2502:	68 bc 4f 00 00       	push   $0x4fbc
    2507:	e8 e2 1a 00 00       	call   3fee <mkdir>
    250c:	83 c4 10             	add    $0x10,%esp
    250f:	85 c0                	test   %eax,%eax
    2511:	75 17                	jne    252a <subdir+0x5ac>
    2513:	83 ec 08             	sub    $0x8,%esp
    2516:	68 20 52 00 00       	push   $0x5220
    251b:	6a 01                	push   $0x1
    251d:	e8 f4 1b 00 00       	call   4116 <printf>
    2522:	83 c4 10             	add    $0x10,%esp
    2525:	e8 5c 1a 00 00       	call   3f86 <exit>
    252a:	83 ec 0c             	sub    $0xc,%esp
    252d:	68 06 51 00 00       	push   $0x5106
    2532:	e8 9f 1a 00 00       	call   3fd6 <unlink>
    2537:	83 c4 10             	add    $0x10,%esp
    253a:	85 c0                	test   %eax,%eax
    253c:	75 17                	jne    2555 <subdir+0x5d7>
    253e:	83 ec 08             	sub    $0x8,%esp
    2541:	68 3d 52 00 00       	push   $0x523d
    2546:	6a 01                	push   $0x1
    2548:	e8 c9 1b 00 00       	call   4116 <printf>
    254d:	83 c4 10             	add    $0x10,%esp
    2550:	e8 31 1a 00 00       	call   3f86 <exit>
    2555:	83 ec 0c             	sub    $0xc,%esp
    2558:	68 e1 50 00 00       	push   $0x50e1
    255d:	e8 74 1a 00 00       	call   3fd6 <unlink>
    2562:	83 c4 10             	add    $0x10,%esp
    2565:	85 c0                	test   %eax,%eax
    2567:	75 17                	jne    2580 <subdir+0x602>
    2569:	83 ec 08             	sub    $0x8,%esp
    256c:	68 59 52 00 00       	push   $0x5259
    2571:	6a 01                	push   $0x1
    2573:	e8 9e 1b 00 00       	call   4116 <printf>
    2578:	83 c4 10             	add    $0x10,%esp
    257b:	e8 06 1a 00 00       	call   3f86 <exit>
    2580:	83 ec 0c             	sub    $0xc,%esp
    2583:	68 f4 4e 00 00       	push   $0x4ef4
    2588:	e8 69 1a 00 00       	call   3ff6 <chdir>
    258d:	83 c4 10             	add    $0x10,%esp
    2590:	85 c0                	test   %eax,%eax
    2592:	75 17                	jne    25ab <subdir+0x62d>
    2594:	83 ec 08             	sub    $0x8,%esp
    2597:	68 75 52 00 00       	push   $0x5275
    259c:	6a 01                	push   $0x1
    259e:	e8 73 1b 00 00       	call   4116 <printf>
    25a3:	83 c4 10             	add    $0x10,%esp
    25a6:	e8 db 19 00 00       	call   3f86 <exit>
    25ab:	83 ec 0c             	sub    $0xc,%esp
    25ae:	68 8d 52 00 00       	push   $0x528d
    25b3:	e8 3e 1a 00 00       	call   3ff6 <chdir>
    25b8:	83 c4 10             	add    $0x10,%esp
    25bb:	85 c0                	test   %eax,%eax
    25bd:	75 17                	jne    25d6 <subdir+0x658>
    25bf:	83 ec 08             	sub    $0x8,%esp
    25c2:	68 93 52 00 00       	push   $0x5293
    25c7:	6a 01                	push   $0x1
    25c9:	e8 48 1b 00 00       	call   4116 <printf>
    25ce:	83 c4 10             	add    $0x10,%esp
    25d1:	e8 b0 19 00 00       	call   3f86 <exit>
    25d6:	83 ec 0c             	sub    $0xc,%esp
    25d9:	68 bc 4f 00 00       	push   $0x4fbc
    25de:	e8 f3 19 00 00       	call   3fd6 <unlink>
    25e3:	83 c4 10             	add    $0x10,%esp
    25e6:	85 c0                	test   %eax,%eax
    25e8:	74 17                	je     2601 <subdir+0x683>
    25ea:	83 ec 08             	sub    $0x8,%esp
    25ed:	68 e9 4f 00 00       	push   $0x4fe9
    25f2:	6a 01                	push   $0x1
    25f4:	e8 1d 1b 00 00       	call   4116 <printf>
    25f9:	83 c4 10             	add    $0x10,%esp
    25fc:	e8 85 19 00 00       	call   3f86 <exit>
    2601:	83 ec 0c             	sub    $0xc,%esp
    2604:	68 f4 4e 00 00       	push   $0x4ef4
    2609:	e8 c8 19 00 00       	call   3fd6 <unlink>
    260e:	83 c4 10             	add    $0x10,%esp
    2611:	85 c0                	test   %eax,%eax
    2613:	74 17                	je     262c <subdir+0x6ae>
    2615:	83 ec 08             	sub    $0x8,%esp
    2618:	68 ab 52 00 00       	push   $0x52ab
    261d:	6a 01                	push   $0x1
    261f:	e8 f2 1a 00 00       	call   4116 <printf>
    2624:	83 c4 10             	add    $0x10,%esp
    2627:	e8 5a 19 00 00       	call   3f86 <exit>
    262c:	83 ec 0c             	sub    $0xc,%esp
    262f:	68 d9 4e 00 00       	push   $0x4ed9
    2634:	e8 9d 19 00 00       	call   3fd6 <unlink>
    2639:	83 c4 10             	add    $0x10,%esp
    263c:	85 c0                	test   %eax,%eax
    263e:	75 17                	jne    2657 <subdir+0x6d9>
    2640:	83 ec 08             	sub    $0x8,%esp
    2643:	68 c0 52 00 00       	push   $0x52c0
    2648:	6a 01                	push   $0x1
    264a:	e8 c7 1a 00 00       	call   4116 <printf>
    264f:	83 c4 10             	add    $0x10,%esp
    2652:	e8 2f 19 00 00       	call   3f86 <exit>
    2657:	83 ec 0c             	sub    $0xc,%esp
    265a:	68 e0 52 00 00       	push   $0x52e0
    265f:	e8 72 19 00 00       	call   3fd6 <unlink>
    2664:	83 c4 10             	add    $0x10,%esp
    2667:	85 c0                	test   %eax,%eax
    2669:	79 17                	jns    2682 <subdir+0x704>
    266b:	83 ec 08             	sub    $0x8,%esp
    266e:	68 e6 52 00 00       	push   $0x52e6
    2673:	6a 01                	push   $0x1
    2675:	e8 9c 1a 00 00       	call   4116 <printf>
    267a:	83 c4 10             	add    $0x10,%esp
    267d:	e8 04 19 00 00       	call   3f86 <exit>
    2682:	83 ec 0c             	sub    $0xc,%esp
    2685:	68 d9 4e 00 00       	push   $0x4ed9
    268a:	e8 47 19 00 00       	call   3fd6 <unlink>
    268f:	83 c4 10             	add    $0x10,%esp
    2692:	85 c0                	test   %eax,%eax
    2694:	79 17                	jns    26ad <subdir+0x72f>
    2696:	83 ec 08             	sub    $0x8,%esp
    2699:	68 fb 52 00 00       	push   $0x52fb
    269e:	6a 01                	push   $0x1
    26a0:	e8 71 1a 00 00       	call   4116 <printf>
    26a5:	83 c4 10             	add    $0x10,%esp
    26a8:	e8 d9 18 00 00       	call   3f86 <exit>
    26ad:	83 ec 08             	sub    $0x8,%esp
    26b0:	68 0d 53 00 00       	push   $0x530d
    26b5:	6a 01                	push   $0x1
    26b7:	e8 5a 1a 00 00       	call   4116 <printf>
    26bc:	83 c4 10             	add    $0x10,%esp
    26bf:	90                   	nop
    26c0:	c9                   	leave  
    26c1:	c3                   	ret    

000026c2 <bigwrite>:
    26c2:	55                   	push   %ebp
    26c3:	89 e5                	mov    %esp,%ebp
    26c5:	83 ec 18             	sub    $0x18,%esp
    26c8:	83 ec 08             	sub    $0x8,%esp
    26cb:	68 18 53 00 00       	push   $0x5318
    26d0:	6a 01                	push   $0x1
    26d2:	e8 3f 1a 00 00       	call   4116 <printf>
    26d7:	83 c4 10             	add    $0x10,%esp
    26da:	83 ec 0c             	sub    $0xc,%esp
    26dd:	68 27 53 00 00       	push   $0x5327
    26e2:	e8 ef 18 00 00       	call   3fd6 <unlink>
    26e7:	83 c4 10             	add    $0x10,%esp
    26ea:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    26f1:	e9 a8 00 00 00       	jmp    279e <bigwrite+0xdc>
    26f6:	83 ec 08             	sub    $0x8,%esp
    26f9:	68 02 02 00 00       	push   $0x202
    26fe:	68 27 53 00 00       	push   $0x5327
    2703:	e8 be 18 00 00       	call   3fc6 <open>
    2708:	83 c4 10             	add    $0x10,%esp
    270b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    270e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2712:	79 17                	jns    272b <bigwrite+0x69>
    2714:	83 ec 08             	sub    $0x8,%esp
    2717:	68 30 53 00 00       	push   $0x5330
    271c:	6a 01                	push   $0x1
    271e:	e8 f3 19 00 00       	call   4116 <printf>
    2723:	83 c4 10             	add    $0x10,%esp
    2726:	e8 5b 18 00 00       	call   3f86 <exit>
    272b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2732:	eb 3f                	jmp    2773 <bigwrite+0xb1>
    2734:	83 ec 04             	sub    $0x4,%esp
    2737:	ff 75 f4             	pushl  -0xc(%ebp)
    273a:	68 00 8c 00 00       	push   $0x8c00
    273f:	ff 75 ec             	pushl  -0x14(%ebp)
    2742:	e8 5f 18 00 00       	call   3fa6 <write>
    2747:	83 c4 10             	add    $0x10,%esp
    274a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    274d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2750:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2753:	74 1a                	je     276f <bigwrite+0xad>
    2755:	ff 75 e8             	pushl  -0x18(%ebp)
    2758:	ff 75 f4             	pushl  -0xc(%ebp)
    275b:	68 48 53 00 00       	push   $0x5348
    2760:	6a 01                	push   $0x1
    2762:	e8 af 19 00 00       	call   4116 <printf>
    2767:	83 c4 10             	add    $0x10,%esp
    276a:	e8 17 18 00 00       	call   3f86 <exit>
    276f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2773:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2777:	7e bb                	jle    2734 <bigwrite+0x72>
    2779:	83 ec 0c             	sub    $0xc,%esp
    277c:	ff 75 ec             	pushl  -0x14(%ebp)
    277f:	e8 2a 18 00 00       	call   3fae <close>
    2784:	83 c4 10             	add    $0x10,%esp
    2787:	83 ec 0c             	sub    $0xc,%esp
    278a:	68 27 53 00 00       	push   $0x5327
    278f:	e8 42 18 00 00       	call   3fd6 <unlink>
    2794:	83 c4 10             	add    $0x10,%esp
    2797:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    279e:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    27a5:	0f 8e 4b ff ff ff    	jle    26f6 <bigwrite+0x34>
    27ab:	83 ec 08             	sub    $0x8,%esp
    27ae:	68 5a 53 00 00       	push   $0x535a
    27b3:	6a 01                	push   $0x1
    27b5:	e8 5c 19 00 00       	call   4116 <printf>
    27ba:	83 c4 10             	add    $0x10,%esp
    27bd:	90                   	nop
    27be:	c9                   	leave  
    27bf:	c3                   	ret    

000027c0 <bigfile>:
    27c0:	55                   	push   %ebp
    27c1:	89 e5                	mov    %esp,%ebp
    27c3:	83 ec 18             	sub    $0x18,%esp
    27c6:	83 ec 08             	sub    $0x8,%esp
    27c9:	68 67 53 00 00       	push   $0x5367
    27ce:	6a 01                	push   $0x1
    27d0:	e8 41 19 00 00       	call   4116 <printf>
    27d5:	83 c4 10             	add    $0x10,%esp
    27d8:	83 ec 0c             	sub    $0xc,%esp
    27db:	68 75 53 00 00       	push   $0x5375
    27e0:	e8 f1 17 00 00       	call   3fd6 <unlink>
    27e5:	83 c4 10             	add    $0x10,%esp
    27e8:	83 ec 08             	sub    $0x8,%esp
    27eb:	68 02 02 00 00       	push   $0x202
    27f0:	68 75 53 00 00       	push   $0x5375
    27f5:	e8 cc 17 00 00       	call   3fc6 <open>
    27fa:	83 c4 10             	add    $0x10,%esp
    27fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    2800:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2804:	79 17                	jns    281d <bigfile+0x5d>
    2806:	83 ec 08             	sub    $0x8,%esp
    2809:	68 7d 53 00 00       	push   $0x537d
    280e:	6a 01                	push   $0x1
    2810:	e8 01 19 00 00       	call   4116 <printf>
    2815:	83 c4 10             	add    $0x10,%esp
    2818:	e8 69 17 00 00       	call   3f86 <exit>
    281d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2824:	eb 52                	jmp    2878 <bigfile+0xb8>
    2826:	83 ec 04             	sub    $0x4,%esp
    2829:	68 58 02 00 00       	push   $0x258
    282e:	ff 75 f4             	pushl  -0xc(%ebp)
    2831:	68 00 8c 00 00       	push   $0x8c00
    2836:	e8 9e 15 00 00       	call   3dd9 <memset>
    283b:	83 c4 10             	add    $0x10,%esp
    283e:	83 ec 04             	sub    $0x4,%esp
    2841:	68 58 02 00 00       	push   $0x258
    2846:	68 00 8c 00 00       	push   $0x8c00
    284b:	ff 75 ec             	pushl  -0x14(%ebp)
    284e:	e8 53 17 00 00       	call   3fa6 <write>
    2853:	83 c4 10             	add    $0x10,%esp
    2856:	3d 58 02 00 00       	cmp    $0x258,%eax
    285b:	74 17                	je     2874 <bigfile+0xb4>
    285d:	83 ec 08             	sub    $0x8,%esp
    2860:	68 93 53 00 00       	push   $0x5393
    2865:	6a 01                	push   $0x1
    2867:	e8 aa 18 00 00       	call   4116 <printf>
    286c:	83 c4 10             	add    $0x10,%esp
    286f:	e8 12 17 00 00       	call   3f86 <exit>
    2874:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2878:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    287c:	7e a8                	jle    2826 <bigfile+0x66>
    287e:	83 ec 0c             	sub    $0xc,%esp
    2881:	ff 75 ec             	pushl  -0x14(%ebp)
    2884:	e8 25 17 00 00       	call   3fae <close>
    2889:	83 c4 10             	add    $0x10,%esp
    288c:	83 ec 08             	sub    $0x8,%esp
    288f:	6a 00                	push   $0x0
    2891:	68 75 53 00 00       	push   $0x5375
    2896:	e8 2b 17 00 00       	call   3fc6 <open>
    289b:	83 c4 10             	add    $0x10,%esp
    289e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    28a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    28a5:	79 17                	jns    28be <bigfile+0xfe>
    28a7:	83 ec 08             	sub    $0x8,%esp
    28aa:	68 a9 53 00 00       	push   $0x53a9
    28af:	6a 01                	push   $0x1
    28b1:	e8 60 18 00 00       	call   4116 <printf>
    28b6:	83 c4 10             	add    $0x10,%esp
    28b9:	e8 c8 16 00 00       	call   3f86 <exit>
    28be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    28c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    28cc:	83 ec 04             	sub    $0x4,%esp
    28cf:	68 2c 01 00 00       	push   $0x12c
    28d4:	68 00 8c 00 00       	push   $0x8c00
    28d9:	ff 75 ec             	pushl  -0x14(%ebp)
    28dc:	e8 bd 16 00 00       	call   3f9e <read>
    28e1:	83 c4 10             	add    $0x10,%esp
    28e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    28e7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28eb:	79 17                	jns    2904 <bigfile+0x144>
    28ed:	83 ec 08             	sub    $0x8,%esp
    28f0:	68 be 53 00 00       	push   $0x53be
    28f5:	6a 01                	push   $0x1
    28f7:	e8 1a 18 00 00       	call   4116 <printf>
    28fc:	83 c4 10             	add    $0x10,%esp
    28ff:	e8 82 16 00 00       	call   3f86 <exit>
    2904:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2908:	74 7a                	je     2984 <bigfile+0x1c4>
    290a:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2911:	74 17                	je     292a <bigfile+0x16a>
    2913:	83 ec 08             	sub    $0x8,%esp
    2916:	68 d3 53 00 00       	push   $0x53d3
    291b:	6a 01                	push   $0x1
    291d:	e8 f4 17 00 00       	call   4116 <printf>
    2922:	83 c4 10             	add    $0x10,%esp
    2925:	e8 5c 16 00 00       	call   3f86 <exit>
    292a:	0f b6 05 00 8c 00 00 	movzbl 0x8c00,%eax
    2931:	0f be d0             	movsbl %al,%edx
    2934:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2937:	89 c1                	mov    %eax,%ecx
    2939:	c1 e9 1f             	shr    $0x1f,%ecx
    293c:	01 c8                	add    %ecx,%eax
    293e:	d1 f8                	sar    %eax
    2940:	39 c2                	cmp    %eax,%edx
    2942:	75 1a                	jne    295e <bigfile+0x19e>
    2944:	0f b6 05 2b 8d 00 00 	movzbl 0x8d2b,%eax
    294b:	0f be d0             	movsbl %al,%edx
    294e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2951:	89 c1                	mov    %eax,%ecx
    2953:	c1 e9 1f             	shr    $0x1f,%ecx
    2956:	01 c8                	add    %ecx,%eax
    2958:	d1 f8                	sar    %eax
    295a:	39 c2                	cmp    %eax,%edx
    295c:	74 17                	je     2975 <bigfile+0x1b5>
    295e:	83 ec 08             	sub    $0x8,%esp
    2961:	68 e7 53 00 00       	push   $0x53e7
    2966:	6a 01                	push   $0x1
    2968:	e8 a9 17 00 00       	call   4116 <printf>
    296d:	83 c4 10             	add    $0x10,%esp
    2970:	e8 11 16 00 00       	call   3f86 <exit>
    2975:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2978:	01 45 f0             	add    %eax,-0x10(%ebp)
    297b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    297f:	e9 48 ff ff ff       	jmp    28cc <bigfile+0x10c>
    2984:	90                   	nop
    2985:	83 ec 0c             	sub    $0xc,%esp
    2988:	ff 75 ec             	pushl  -0x14(%ebp)
    298b:	e8 1e 16 00 00       	call   3fae <close>
    2990:	83 c4 10             	add    $0x10,%esp
    2993:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    299a:	74 17                	je     29b3 <bigfile+0x1f3>
    299c:	83 ec 08             	sub    $0x8,%esp
    299f:	68 00 54 00 00       	push   $0x5400
    29a4:	6a 01                	push   $0x1
    29a6:	e8 6b 17 00 00       	call   4116 <printf>
    29ab:	83 c4 10             	add    $0x10,%esp
    29ae:	e8 d3 15 00 00       	call   3f86 <exit>
    29b3:	83 ec 0c             	sub    $0xc,%esp
    29b6:	68 75 53 00 00       	push   $0x5375
    29bb:	e8 16 16 00 00       	call   3fd6 <unlink>
    29c0:	83 c4 10             	add    $0x10,%esp
    29c3:	83 ec 08             	sub    $0x8,%esp
    29c6:	68 1a 54 00 00       	push   $0x541a
    29cb:	6a 01                	push   $0x1
    29cd:	e8 44 17 00 00       	call   4116 <printf>
    29d2:	83 c4 10             	add    $0x10,%esp
    29d5:	90                   	nop
    29d6:	c9                   	leave  
    29d7:	c3                   	ret    

000029d8 <fourteen>:
    29d8:	55                   	push   %ebp
    29d9:	89 e5                	mov    %esp,%ebp
    29db:	83 ec 18             	sub    $0x18,%esp
    29de:	83 ec 08             	sub    $0x8,%esp
    29e1:	68 2b 54 00 00       	push   $0x542b
    29e6:	6a 01                	push   $0x1
    29e8:	e8 29 17 00 00       	call   4116 <printf>
    29ed:	83 c4 10             	add    $0x10,%esp
    29f0:	83 ec 0c             	sub    $0xc,%esp
    29f3:	68 3a 54 00 00       	push   $0x543a
    29f8:	e8 f1 15 00 00       	call   3fee <mkdir>
    29fd:	83 c4 10             	add    $0x10,%esp
    2a00:	85 c0                	test   %eax,%eax
    2a02:	74 17                	je     2a1b <fourteen+0x43>
    2a04:	83 ec 08             	sub    $0x8,%esp
    2a07:	68 49 54 00 00       	push   $0x5449
    2a0c:	6a 01                	push   $0x1
    2a0e:	e8 03 17 00 00       	call   4116 <printf>
    2a13:	83 c4 10             	add    $0x10,%esp
    2a16:	e8 6b 15 00 00       	call   3f86 <exit>
    2a1b:	83 ec 0c             	sub    $0xc,%esp
    2a1e:	68 68 54 00 00       	push   $0x5468
    2a23:	e8 c6 15 00 00       	call   3fee <mkdir>
    2a28:	83 c4 10             	add    $0x10,%esp
    2a2b:	85 c0                	test   %eax,%eax
    2a2d:	74 17                	je     2a46 <fourteen+0x6e>
    2a2f:	83 ec 08             	sub    $0x8,%esp
    2a32:	68 88 54 00 00       	push   $0x5488
    2a37:	6a 01                	push   $0x1
    2a39:	e8 d8 16 00 00       	call   4116 <printf>
    2a3e:	83 c4 10             	add    $0x10,%esp
    2a41:	e8 40 15 00 00       	call   3f86 <exit>
    2a46:	83 ec 08             	sub    $0x8,%esp
    2a49:	68 00 02 00 00       	push   $0x200
    2a4e:	68 b8 54 00 00       	push   $0x54b8
    2a53:	e8 6e 15 00 00       	call   3fc6 <open>
    2a58:	83 c4 10             	add    $0x10,%esp
    2a5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2a5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a62:	79 17                	jns    2a7b <fourteen+0xa3>
    2a64:	83 ec 08             	sub    $0x8,%esp
    2a67:	68 e8 54 00 00       	push   $0x54e8
    2a6c:	6a 01                	push   $0x1
    2a6e:	e8 a3 16 00 00       	call   4116 <printf>
    2a73:	83 c4 10             	add    $0x10,%esp
    2a76:	e8 0b 15 00 00       	call   3f86 <exit>
    2a7b:	83 ec 0c             	sub    $0xc,%esp
    2a7e:	ff 75 f4             	pushl  -0xc(%ebp)
    2a81:	e8 28 15 00 00       	call   3fae <close>
    2a86:	83 c4 10             	add    $0x10,%esp
    2a89:	83 ec 08             	sub    $0x8,%esp
    2a8c:	6a 00                	push   $0x0
    2a8e:	68 28 55 00 00       	push   $0x5528
    2a93:	e8 2e 15 00 00       	call   3fc6 <open>
    2a98:	83 c4 10             	add    $0x10,%esp
    2a9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2a9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2aa2:	79 17                	jns    2abb <fourteen+0xe3>
    2aa4:	83 ec 08             	sub    $0x8,%esp
    2aa7:	68 58 55 00 00       	push   $0x5558
    2aac:	6a 01                	push   $0x1
    2aae:	e8 63 16 00 00       	call   4116 <printf>
    2ab3:	83 c4 10             	add    $0x10,%esp
    2ab6:	e8 cb 14 00 00       	call   3f86 <exit>
    2abb:	83 ec 0c             	sub    $0xc,%esp
    2abe:	ff 75 f4             	pushl  -0xc(%ebp)
    2ac1:	e8 e8 14 00 00       	call   3fae <close>
    2ac6:	83 c4 10             	add    $0x10,%esp
    2ac9:	83 ec 0c             	sub    $0xc,%esp
    2acc:	68 92 55 00 00       	push   $0x5592
    2ad1:	e8 18 15 00 00       	call   3fee <mkdir>
    2ad6:	83 c4 10             	add    $0x10,%esp
    2ad9:	85 c0                	test   %eax,%eax
    2adb:	75 17                	jne    2af4 <fourteen+0x11c>
    2add:	83 ec 08             	sub    $0x8,%esp
    2ae0:	68 b0 55 00 00       	push   $0x55b0
    2ae5:	6a 01                	push   $0x1
    2ae7:	e8 2a 16 00 00       	call   4116 <printf>
    2aec:	83 c4 10             	add    $0x10,%esp
    2aef:	e8 92 14 00 00       	call   3f86 <exit>
    2af4:	83 ec 0c             	sub    $0xc,%esp
    2af7:	68 e0 55 00 00       	push   $0x55e0
    2afc:	e8 ed 14 00 00       	call   3fee <mkdir>
    2b01:	83 c4 10             	add    $0x10,%esp
    2b04:	85 c0                	test   %eax,%eax
    2b06:	75 17                	jne    2b1f <fourteen+0x147>
    2b08:	83 ec 08             	sub    $0x8,%esp
    2b0b:	68 00 56 00 00       	push   $0x5600
    2b10:	6a 01                	push   $0x1
    2b12:	e8 ff 15 00 00       	call   4116 <printf>
    2b17:	83 c4 10             	add    $0x10,%esp
    2b1a:	e8 67 14 00 00       	call   3f86 <exit>
    2b1f:	83 ec 08             	sub    $0x8,%esp
    2b22:	68 31 56 00 00       	push   $0x5631
    2b27:	6a 01                	push   $0x1
    2b29:	e8 e8 15 00 00       	call   4116 <printf>
    2b2e:	83 c4 10             	add    $0x10,%esp
    2b31:	90                   	nop
    2b32:	c9                   	leave  
    2b33:	c3                   	ret    

00002b34 <rmdot>:
    2b34:	55                   	push   %ebp
    2b35:	89 e5                	mov    %esp,%ebp
    2b37:	83 ec 08             	sub    $0x8,%esp
    2b3a:	83 ec 08             	sub    $0x8,%esp
    2b3d:	68 3e 56 00 00       	push   $0x563e
    2b42:	6a 01                	push   $0x1
    2b44:	e8 cd 15 00 00       	call   4116 <printf>
    2b49:	83 c4 10             	add    $0x10,%esp
    2b4c:	83 ec 0c             	sub    $0xc,%esp
    2b4f:	68 4a 56 00 00       	push   $0x564a
    2b54:	e8 95 14 00 00       	call   3fee <mkdir>
    2b59:	83 c4 10             	add    $0x10,%esp
    2b5c:	85 c0                	test   %eax,%eax
    2b5e:	74 17                	je     2b77 <rmdot+0x43>
    2b60:	83 ec 08             	sub    $0x8,%esp
    2b63:	68 4f 56 00 00       	push   $0x564f
    2b68:	6a 01                	push   $0x1
    2b6a:	e8 a7 15 00 00       	call   4116 <printf>
    2b6f:	83 c4 10             	add    $0x10,%esp
    2b72:	e8 0f 14 00 00       	call   3f86 <exit>
    2b77:	83 ec 0c             	sub    $0xc,%esp
    2b7a:	68 4a 56 00 00       	push   $0x564a
    2b7f:	e8 72 14 00 00       	call   3ff6 <chdir>
    2b84:	83 c4 10             	add    $0x10,%esp
    2b87:	85 c0                	test   %eax,%eax
    2b89:	74 17                	je     2ba2 <rmdot+0x6e>
    2b8b:	83 ec 08             	sub    $0x8,%esp
    2b8e:	68 62 56 00 00       	push   $0x5662
    2b93:	6a 01                	push   $0x1
    2b95:	e8 7c 15 00 00       	call   4116 <printf>
    2b9a:	83 c4 10             	add    $0x10,%esp
    2b9d:	e8 e4 13 00 00       	call   3f86 <exit>
    2ba2:	83 ec 0c             	sub    $0xc,%esp
    2ba5:	68 7b 4d 00 00       	push   $0x4d7b
    2baa:	e8 27 14 00 00       	call   3fd6 <unlink>
    2baf:	83 c4 10             	add    $0x10,%esp
    2bb2:	85 c0                	test   %eax,%eax
    2bb4:	75 17                	jne    2bcd <rmdot+0x99>
    2bb6:	83 ec 08             	sub    $0x8,%esp
    2bb9:	68 75 56 00 00       	push   $0x5675
    2bbe:	6a 01                	push   $0x1
    2bc0:	e8 51 15 00 00       	call   4116 <printf>
    2bc5:	83 c4 10             	add    $0x10,%esp
    2bc8:	e8 b9 13 00 00       	call   3f86 <exit>
    2bcd:	83 ec 0c             	sub    $0xc,%esp
    2bd0:	68 0e 49 00 00       	push   $0x490e
    2bd5:	e8 fc 13 00 00       	call   3fd6 <unlink>
    2bda:	83 c4 10             	add    $0x10,%esp
    2bdd:	85 c0                	test   %eax,%eax
    2bdf:	75 17                	jne    2bf8 <rmdot+0xc4>
    2be1:	83 ec 08             	sub    $0x8,%esp
    2be4:	68 83 56 00 00       	push   $0x5683
    2be9:	6a 01                	push   $0x1
    2beb:	e8 26 15 00 00       	call   4116 <printf>
    2bf0:	83 c4 10             	add    $0x10,%esp
    2bf3:	e8 8e 13 00 00       	call   3f86 <exit>
    2bf8:	83 ec 0c             	sub    $0xc,%esp
    2bfb:	68 62 45 00 00       	push   $0x4562
    2c00:	e8 f1 13 00 00       	call   3ff6 <chdir>
    2c05:	83 c4 10             	add    $0x10,%esp
    2c08:	85 c0                	test   %eax,%eax
    2c0a:	74 17                	je     2c23 <rmdot+0xef>
    2c0c:	83 ec 08             	sub    $0x8,%esp
    2c0f:	68 64 45 00 00       	push   $0x4564
    2c14:	6a 01                	push   $0x1
    2c16:	e8 fb 14 00 00       	call   4116 <printf>
    2c1b:	83 c4 10             	add    $0x10,%esp
    2c1e:	e8 63 13 00 00       	call   3f86 <exit>
    2c23:	83 ec 0c             	sub    $0xc,%esp
    2c26:	68 92 56 00 00       	push   $0x5692
    2c2b:	e8 a6 13 00 00       	call   3fd6 <unlink>
    2c30:	83 c4 10             	add    $0x10,%esp
    2c33:	85 c0                	test   %eax,%eax
    2c35:	75 17                	jne    2c4e <rmdot+0x11a>
    2c37:	83 ec 08             	sub    $0x8,%esp
    2c3a:	68 99 56 00 00       	push   $0x5699
    2c3f:	6a 01                	push   $0x1
    2c41:	e8 d0 14 00 00       	call   4116 <printf>
    2c46:	83 c4 10             	add    $0x10,%esp
    2c49:	e8 38 13 00 00       	call   3f86 <exit>
    2c4e:	83 ec 0c             	sub    $0xc,%esp
    2c51:	68 b0 56 00 00       	push   $0x56b0
    2c56:	e8 7b 13 00 00       	call   3fd6 <unlink>
    2c5b:	83 c4 10             	add    $0x10,%esp
    2c5e:	85 c0                	test   %eax,%eax
    2c60:	75 17                	jne    2c79 <rmdot+0x145>
    2c62:	83 ec 08             	sub    $0x8,%esp
    2c65:	68 b8 56 00 00       	push   $0x56b8
    2c6a:	6a 01                	push   $0x1
    2c6c:	e8 a5 14 00 00       	call   4116 <printf>
    2c71:	83 c4 10             	add    $0x10,%esp
    2c74:	e8 0d 13 00 00       	call   3f86 <exit>
    2c79:	83 ec 0c             	sub    $0xc,%esp
    2c7c:	68 4a 56 00 00       	push   $0x564a
    2c81:	e8 50 13 00 00       	call   3fd6 <unlink>
    2c86:	83 c4 10             	add    $0x10,%esp
    2c89:	85 c0                	test   %eax,%eax
    2c8b:	74 17                	je     2ca4 <rmdot+0x170>
    2c8d:	83 ec 08             	sub    $0x8,%esp
    2c90:	68 d0 56 00 00       	push   $0x56d0
    2c95:	6a 01                	push   $0x1
    2c97:	e8 7a 14 00 00       	call   4116 <printf>
    2c9c:	83 c4 10             	add    $0x10,%esp
    2c9f:	e8 e2 12 00 00       	call   3f86 <exit>
    2ca4:	83 ec 08             	sub    $0x8,%esp
    2ca7:	68 e5 56 00 00       	push   $0x56e5
    2cac:	6a 01                	push   $0x1
    2cae:	e8 63 14 00 00       	call   4116 <printf>
    2cb3:	83 c4 10             	add    $0x10,%esp
    2cb6:	90                   	nop
    2cb7:	c9                   	leave  
    2cb8:	c3                   	ret    

00002cb9 <dirfile>:
    2cb9:	55                   	push   %ebp
    2cba:	89 e5                	mov    %esp,%ebp
    2cbc:	83 ec 18             	sub    $0x18,%esp
    2cbf:	83 ec 08             	sub    $0x8,%esp
    2cc2:	68 ef 56 00 00       	push   $0x56ef
    2cc7:	6a 01                	push   $0x1
    2cc9:	e8 48 14 00 00       	call   4116 <printf>
    2cce:	83 c4 10             	add    $0x10,%esp
    2cd1:	83 ec 08             	sub    $0x8,%esp
    2cd4:	68 00 02 00 00       	push   $0x200
    2cd9:	68 fc 56 00 00       	push   $0x56fc
    2cde:	e8 e3 12 00 00       	call   3fc6 <open>
    2ce3:	83 c4 10             	add    $0x10,%esp
    2ce6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2ce9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ced:	79 17                	jns    2d06 <dirfile+0x4d>
    2cef:	83 ec 08             	sub    $0x8,%esp
    2cf2:	68 04 57 00 00       	push   $0x5704
    2cf7:	6a 01                	push   $0x1
    2cf9:	e8 18 14 00 00       	call   4116 <printf>
    2cfe:	83 c4 10             	add    $0x10,%esp
    2d01:	e8 80 12 00 00       	call   3f86 <exit>
    2d06:	83 ec 0c             	sub    $0xc,%esp
    2d09:	ff 75 f4             	pushl  -0xc(%ebp)
    2d0c:	e8 9d 12 00 00       	call   3fae <close>
    2d11:	83 c4 10             	add    $0x10,%esp
    2d14:	83 ec 0c             	sub    $0xc,%esp
    2d17:	68 fc 56 00 00       	push   $0x56fc
    2d1c:	e8 d5 12 00 00       	call   3ff6 <chdir>
    2d21:	83 c4 10             	add    $0x10,%esp
    2d24:	85 c0                	test   %eax,%eax
    2d26:	75 17                	jne    2d3f <dirfile+0x86>
    2d28:	83 ec 08             	sub    $0x8,%esp
    2d2b:	68 1b 57 00 00       	push   $0x571b
    2d30:	6a 01                	push   $0x1
    2d32:	e8 df 13 00 00       	call   4116 <printf>
    2d37:	83 c4 10             	add    $0x10,%esp
    2d3a:	e8 47 12 00 00       	call   3f86 <exit>
    2d3f:	83 ec 08             	sub    $0x8,%esp
    2d42:	6a 00                	push   $0x0
    2d44:	68 35 57 00 00       	push   $0x5735
    2d49:	e8 78 12 00 00       	call   3fc6 <open>
    2d4e:	83 c4 10             	add    $0x10,%esp
    2d51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2d54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d58:	78 17                	js     2d71 <dirfile+0xb8>
    2d5a:	83 ec 08             	sub    $0x8,%esp
    2d5d:	68 40 57 00 00       	push   $0x5740
    2d62:	6a 01                	push   $0x1
    2d64:	e8 ad 13 00 00       	call   4116 <printf>
    2d69:	83 c4 10             	add    $0x10,%esp
    2d6c:	e8 15 12 00 00       	call   3f86 <exit>
    2d71:	83 ec 08             	sub    $0x8,%esp
    2d74:	68 00 02 00 00       	push   $0x200
    2d79:	68 35 57 00 00       	push   $0x5735
    2d7e:	e8 43 12 00 00       	call   3fc6 <open>
    2d83:	83 c4 10             	add    $0x10,%esp
    2d86:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2d89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d8d:	78 17                	js     2da6 <dirfile+0xed>
    2d8f:	83 ec 08             	sub    $0x8,%esp
    2d92:	68 40 57 00 00       	push   $0x5740
    2d97:	6a 01                	push   $0x1
    2d99:	e8 78 13 00 00       	call   4116 <printf>
    2d9e:	83 c4 10             	add    $0x10,%esp
    2da1:	e8 e0 11 00 00       	call   3f86 <exit>
    2da6:	83 ec 0c             	sub    $0xc,%esp
    2da9:	68 35 57 00 00       	push   $0x5735
    2dae:	e8 3b 12 00 00       	call   3fee <mkdir>
    2db3:	83 c4 10             	add    $0x10,%esp
    2db6:	85 c0                	test   %eax,%eax
    2db8:	75 17                	jne    2dd1 <dirfile+0x118>
    2dba:	83 ec 08             	sub    $0x8,%esp
    2dbd:	68 5e 57 00 00       	push   $0x575e
    2dc2:	6a 01                	push   $0x1
    2dc4:	e8 4d 13 00 00       	call   4116 <printf>
    2dc9:	83 c4 10             	add    $0x10,%esp
    2dcc:	e8 b5 11 00 00       	call   3f86 <exit>
    2dd1:	83 ec 0c             	sub    $0xc,%esp
    2dd4:	68 35 57 00 00       	push   $0x5735
    2dd9:	e8 f8 11 00 00       	call   3fd6 <unlink>
    2dde:	83 c4 10             	add    $0x10,%esp
    2de1:	85 c0                	test   %eax,%eax
    2de3:	75 17                	jne    2dfc <dirfile+0x143>
    2de5:	83 ec 08             	sub    $0x8,%esp
    2de8:	68 7b 57 00 00       	push   $0x577b
    2ded:	6a 01                	push   $0x1
    2def:	e8 22 13 00 00       	call   4116 <printf>
    2df4:	83 c4 10             	add    $0x10,%esp
    2df7:	e8 8a 11 00 00       	call   3f86 <exit>
    2dfc:	83 ec 08             	sub    $0x8,%esp
    2dff:	68 35 57 00 00       	push   $0x5735
    2e04:	68 99 57 00 00       	push   $0x5799
    2e09:	e8 d8 11 00 00       	call   3fe6 <link>
    2e0e:	83 c4 10             	add    $0x10,%esp
    2e11:	85 c0                	test   %eax,%eax
    2e13:	75 17                	jne    2e2c <dirfile+0x173>
    2e15:	83 ec 08             	sub    $0x8,%esp
    2e18:	68 a0 57 00 00       	push   $0x57a0
    2e1d:	6a 01                	push   $0x1
    2e1f:	e8 f2 12 00 00       	call   4116 <printf>
    2e24:	83 c4 10             	add    $0x10,%esp
    2e27:	e8 5a 11 00 00       	call   3f86 <exit>
    2e2c:	83 ec 0c             	sub    $0xc,%esp
    2e2f:	68 fc 56 00 00       	push   $0x56fc
    2e34:	e8 9d 11 00 00       	call   3fd6 <unlink>
    2e39:	83 c4 10             	add    $0x10,%esp
    2e3c:	85 c0                	test   %eax,%eax
    2e3e:	74 17                	je     2e57 <dirfile+0x19e>
    2e40:	83 ec 08             	sub    $0x8,%esp
    2e43:	68 bf 57 00 00       	push   $0x57bf
    2e48:	6a 01                	push   $0x1
    2e4a:	e8 c7 12 00 00       	call   4116 <printf>
    2e4f:	83 c4 10             	add    $0x10,%esp
    2e52:	e8 2f 11 00 00       	call   3f86 <exit>
    2e57:	83 ec 08             	sub    $0x8,%esp
    2e5a:	6a 02                	push   $0x2
    2e5c:	68 7b 4d 00 00       	push   $0x4d7b
    2e61:	e8 60 11 00 00       	call   3fc6 <open>
    2e66:	83 c4 10             	add    $0x10,%esp
    2e69:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2e6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e70:	78 17                	js     2e89 <dirfile+0x1d0>
    2e72:	83 ec 08             	sub    $0x8,%esp
    2e75:	68 d8 57 00 00       	push   $0x57d8
    2e7a:	6a 01                	push   $0x1
    2e7c:	e8 95 12 00 00       	call   4116 <printf>
    2e81:	83 c4 10             	add    $0x10,%esp
    2e84:	e8 fd 10 00 00       	call   3f86 <exit>
    2e89:	83 ec 08             	sub    $0x8,%esp
    2e8c:	6a 00                	push   $0x0
    2e8e:	68 7b 4d 00 00       	push   $0x4d7b
    2e93:	e8 2e 11 00 00       	call   3fc6 <open>
    2e98:	83 c4 10             	add    $0x10,%esp
    2e9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    2e9e:	83 ec 04             	sub    $0x4,%esp
    2ea1:	6a 01                	push   $0x1
    2ea3:	68 c7 49 00 00       	push   $0x49c7
    2ea8:	ff 75 f4             	pushl  -0xc(%ebp)
    2eab:	e8 f6 10 00 00       	call   3fa6 <write>
    2eb0:	83 c4 10             	add    $0x10,%esp
    2eb3:	85 c0                	test   %eax,%eax
    2eb5:	7e 17                	jle    2ece <dirfile+0x215>
    2eb7:	83 ec 08             	sub    $0x8,%esp
    2eba:	68 f7 57 00 00       	push   $0x57f7
    2ebf:	6a 01                	push   $0x1
    2ec1:	e8 50 12 00 00       	call   4116 <printf>
    2ec6:	83 c4 10             	add    $0x10,%esp
    2ec9:	e8 b8 10 00 00       	call   3f86 <exit>
    2ece:	83 ec 0c             	sub    $0xc,%esp
    2ed1:	ff 75 f4             	pushl  -0xc(%ebp)
    2ed4:	e8 d5 10 00 00       	call   3fae <close>
    2ed9:	83 c4 10             	add    $0x10,%esp
    2edc:	83 ec 08             	sub    $0x8,%esp
    2edf:	68 0b 58 00 00       	push   $0x580b
    2ee4:	6a 01                	push   $0x1
    2ee6:	e8 2b 12 00 00       	call   4116 <printf>
    2eeb:	83 c4 10             	add    $0x10,%esp
    2eee:	90                   	nop
    2eef:	c9                   	leave  
    2ef0:	c3                   	ret    

00002ef1 <iref>:
    2ef1:	55                   	push   %ebp
    2ef2:	89 e5                	mov    %esp,%ebp
    2ef4:	83 ec 18             	sub    $0x18,%esp
    2ef7:	83 ec 08             	sub    $0x8,%esp
    2efa:	68 1b 58 00 00       	push   $0x581b
    2eff:	6a 01                	push   $0x1
    2f01:	e8 10 12 00 00       	call   4116 <printf>
    2f06:	83 c4 10             	add    $0x10,%esp
    2f09:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2f10:	e9 e7 00 00 00       	jmp    2ffc <iref+0x10b>
    2f15:	83 ec 0c             	sub    $0xc,%esp
    2f18:	68 2c 58 00 00       	push   $0x582c
    2f1d:	e8 cc 10 00 00       	call   3fee <mkdir>
    2f22:	83 c4 10             	add    $0x10,%esp
    2f25:	85 c0                	test   %eax,%eax
    2f27:	74 17                	je     2f40 <iref+0x4f>
    2f29:	83 ec 08             	sub    $0x8,%esp
    2f2c:	68 32 58 00 00       	push   $0x5832
    2f31:	6a 01                	push   $0x1
    2f33:	e8 de 11 00 00       	call   4116 <printf>
    2f38:	83 c4 10             	add    $0x10,%esp
    2f3b:	e8 46 10 00 00       	call   3f86 <exit>
    2f40:	83 ec 0c             	sub    $0xc,%esp
    2f43:	68 2c 58 00 00       	push   $0x582c
    2f48:	e8 a9 10 00 00       	call   3ff6 <chdir>
    2f4d:	83 c4 10             	add    $0x10,%esp
    2f50:	85 c0                	test   %eax,%eax
    2f52:	74 17                	je     2f6b <iref+0x7a>
    2f54:	83 ec 08             	sub    $0x8,%esp
    2f57:	68 46 58 00 00       	push   $0x5846
    2f5c:	6a 01                	push   $0x1
    2f5e:	e8 b3 11 00 00       	call   4116 <printf>
    2f63:	83 c4 10             	add    $0x10,%esp
    2f66:	e8 1b 10 00 00       	call   3f86 <exit>
    2f6b:	83 ec 0c             	sub    $0xc,%esp
    2f6e:	68 5a 58 00 00       	push   $0x585a
    2f73:	e8 76 10 00 00       	call   3fee <mkdir>
    2f78:	83 c4 10             	add    $0x10,%esp
    2f7b:	83 ec 08             	sub    $0x8,%esp
    2f7e:	68 5a 58 00 00       	push   $0x585a
    2f83:	68 99 57 00 00       	push   $0x5799
    2f88:	e8 59 10 00 00       	call   3fe6 <link>
    2f8d:	83 c4 10             	add    $0x10,%esp
    2f90:	83 ec 08             	sub    $0x8,%esp
    2f93:	68 00 02 00 00       	push   $0x200
    2f98:	68 5a 58 00 00       	push   $0x585a
    2f9d:	e8 24 10 00 00       	call   3fc6 <open>
    2fa2:	83 c4 10             	add    $0x10,%esp
    2fa5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2fa8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fac:	78 0e                	js     2fbc <iref+0xcb>
    2fae:	83 ec 0c             	sub    $0xc,%esp
    2fb1:	ff 75 f0             	pushl  -0x10(%ebp)
    2fb4:	e8 f5 0f 00 00       	call   3fae <close>
    2fb9:	83 c4 10             	add    $0x10,%esp
    2fbc:	83 ec 08             	sub    $0x8,%esp
    2fbf:	68 00 02 00 00       	push   $0x200
    2fc4:	68 5b 58 00 00       	push   $0x585b
    2fc9:	e8 f8 0f 00 00       	call   3fc6 <open>
    2fce:	83 c4 10             	add    $0x10,%esp
    2fd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    2fd4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fd8:	78 0e                	js     2fe8 <iref+0xf7>
    2fda:	83 ec 0c             	sub    $0xc,%esp
    2fdd:	ff 75 f0             	pushl  -0x10(%ebp)
    2fe0:	e8 c9 0f 00 00       	call   3fae <close>
    2fe5:	83 c4 10             	add    $0x10,%esp
    2fe8:	83 ec 0c             	sub    $0xc,%esp
    2feb:	68 5b 58 00 00       	push   $0x585b
    2ff0:	e8 e1 0f 00 00       	call   3fd6 <unlink>
    2ff5:	83 c4 10             	add    $0x10,%esp
    2ff8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2ffc:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    3000:	0f 8e 0f ff ff ff    	jle    2f15 <iref+0x24>
    3006:	83 ec 0c             	sub    $0xc,%esp
    3009:	68 62 45 00 00       	push   $0x4562
    300e:	e8 e3 0f 00 00       	call   3ff6 <chdir>
    3013:	83 c4 10             	add    $0x10,%esp
    3016:	83 ec 08             	sub    $0x8,%esp
    3019:	68 5e 58 00 00       	push   $0x585e
    301e:	6a 01                	push   $0x1
    3020:	e8 f1 10 00 00       	call   4116 <printf>
    3025:	83 c4 10             	add    $0x10,%esp
    3028:	90                   	nop
    3029:	c9                   	leave  
    302a:	c3                   	ret    

0000302b <forktest>:
    302b:	55                   	push   %ebp
    302c:	89 e5                	mov    %esp,%ebp
    302e:	83 ec 18             	sub    $0x18,%esp
    3031:	83 ec 08             	sub    $0x8,%esp
    3034:	68 72 58 00 00       	push   $0x5872
    3039:	6a 01                	push   $0x1
    303b:	e8 d6 10 00 00       	call   4116 <printf>
    3040:	83 c4 10             	add    $0x10,%esp
    3043:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    304a:	eb 1d                	jmp    3069 <forktest+0x3e>
    304c:	e8 2d 0f 00 00       	call   3f7e <fork>
    3051:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3054:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3058:	78 1a                	js     3074 <forktest+0x49>
    305a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    305e:	75 05                	jne    3065 <forktest+0x3a>
    3060:	e8 21 0f 00 00       	call   3f86 <exit>
    3065:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3069:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    3070:	7e da                	jle    304c <forktest+0x21>
    3072:	eb 01                	jmp    3075 <forktest+0x4a>
    3074:	90                   	nop
    3075:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    307c:	75 3b                	jne    30b9 <forktest+0x8e>
    307e:	83 ec 08             	sub    $0x8,%esp
    3081:	68 80 58 00 00       	push   $0x5880
    3086:	6a 01                	push   $0x1
    3088:	e8 89 10 00 00       	call   4116 <printf>
    308d:	83 c4 10             	add    $0x10,%esp
    3090:	e8 f1 0e 00 00       	call   3f86 <exit>
    3095:	e8 f4 0e 00 00       	call   3f8e <wait>
    309a:	85 c0                	test   %eax,%eax
    309c:	79 17                	jns    30b5 <forktest+0x8a>
    309e:	83 ec 08             	sub    $0x8,%esp
    30a1:	68 a2 58 00 00       	push   $0x58a2
    30a6:	6a 01                	push   $0x1
    30a8:	e8 69 10 00 00       	call   4116 <printf>
    30ad:	83 c4 10             	add    $0x10,%esp
    30b0:	e8 d1 0e 00 00       	call   3f86 <exit>
    30b5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    30b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30bd:	7f d6                	jg     3095 <forktest+0x6a>
    30bf:	e8 ca 0e 00 00       	call   3f8e <wait>
    30c4:	83 f8 ff             	cmp    $0xffffffff,%eax
    30c7:	74 17                	je     30e0 <forktest+0xb5>
    30c9:	83 ec 08             	sub    $0x8,%esp
    30cc:	68 b6 58 00 00       	push   $0x58b6
    30d1:	6a 01                	push   $0x1
    30d3:	e8 3e 10 00 00       	call   4116 <printf>
    30d8:	83 c4 10             	add    $0x10,%esp
    30db:	e8 a6 0e 00 00       	call   3f86 <exit>
    30e0:	83 ec 08             	sub    $0x8,%esp
    30e3:	68 c9 58 00 00       	push   $0x58c9
    30e8:	6a 01                	push   $0x1
    30ea:	e8 27 10 00 00       	call   4116 <printf>
    30ef:	83 c4 10             	add    $0x10,%esp
    30f2:	90                   	nop
    30f3:	c9                   	leave  
    30f4:	c3                   	ret    

000030f5 <sbrktest>:
    30f5:	55                   	push   %ebp
    30f6:	89 e5                	mov    %esp,%ebp
    30f8:	53                   	push   %ebx
    30f9:	83 ec 64             	sub    $0x64,%esp
    30fc:	a1 0c 64 00 00       	mov    0x640c,%eax
    3101:	83 ec 08             	sub    $0x8,%esp
    3104:	68 d7 58 00 00       	push   $0x58d7
    3109:	50                   	push   %eax
    310a:	e8 07 10 00 00       	call   4116 <printf>
    310f:	83 c4 10             	add    $0x10,%esp
    3112:	83 ec 0c             	sub    $0xc,%esp
    3115:	6a 00                	push   $0x0
    3117:	e8 f2 0e 00 00       	call   400e <sbrk>
    311c:	83 c4 10             	add    $0x10,%esp
    311f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3122:	83 ec 0c             	sub    $0xc,%esp
    3125:	6a 00                	push   $0x0
    3127:	e8 e2 0e 00 00       	call   400e <sbrk>
    312c:	83 c4 10             	add    $0x10,%esp
    312f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3132:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3139:	eb 4f                	jmp    318a <sbrktest+0x95>
    313b:	83 ec 0c             	sub    $0xc,%esp
    313e:	6a 01                	push   $0x1
    3140:	e8 c9 0e 00 00       	call   400e <sbrk>
    3145:	83 c4 10             	add    $0x10,%esp
    3148:	89 45 e8             	mov    %eax,-0x18(%ebp)
    314b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    314e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3151:	74 24                	je     3177 <sbrktest+0x82>
    3153:	a1 0c 64 00 00       	mov    0x640c,%eax
    3158:	83 ec 0c             	sub    $0xc,%esp
    315b:	ff 75 e8             	pushl  -0x18(%ebp)
    315e:	ff 75 f4             	pushl  -0xc(%ebp)
    3161:	ff 75 f0             	pushl  -0x10(%ebp)
    3164:	68 e2 58 00 00       	push   $0x58e2
    3169:	50                   	push   %eax
    316a:	e8 a7 0f 00 00       	call   4116 <printf>
    316f:	83 c4 20             	add    $0x20,%esp
    3172:	e8 0f 0e 00 00       	call   3f86 <exit>
    3177:	8b 45 e8             	mov    -0x18(%ebp),%eax
    317a:	c6 00 01             	movb   $0x1,(%eax)
    317d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3180:	83 c0 01             	add    $0x1,%eax
    3183:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3186:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    318a:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    3191:	7e a8                	jle    313b <sbrktest+0x46>
    3193:	e8 e6 0d 00 00       	call   3f7e <fork>
    3198:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    319b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    319f:	79 1b                	jns    31bc <sbrktest+0xc7>
    31a1:	a1 0c 64 00 00       	mov    0x640c,%eax
    31a6:	83 ec 08             	sub    $0x8,%esp
    31a9:	68 fd 58 00 00       	push   $0x58fd
    31ae:	50                   	push   %eax
    31af:	e8 62 0f 00 00       	call   4116 <printf>
    31b4:	83 c4 10             	add    $0x10,%esp
    31b7:	e8 ca 0d 00 00       	call   3f86 <exit>
    31bc:	83 ec 0c             	sub    $0xc,%esp
    31bf:	6a 01                	push   $0x1
    31c1:	e8 48 0e 00 00       	call   400e <sbrk>
    31c6:	83 c4 10             	add    $0x10,%esp
    31c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    31cc:	83 ec 0c             	sub    $0xc,%esp
    31cf:	6a 01                	push   $0x1
    31d1:	e8 38 0e 00 00       	call   400e <sbrk>
    31d6:	83 c4 10             	add    $0x10,%esp
    31d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    31dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    31df:	83 c0 01             	add    $0x1,%eax
    31e2:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    31e5:	74 1b                	je     3202 <sbrktest+0x10d>
    31e7:	a1 0c 64 00 00       	mov    0x640c,%eax
    31ec:	83 ec 08             	sub    $0x8,%esp
    31ef:	68 14 59 00 00       	push   $0x5914
    31f4:	50                   	push   %eax
    31f5:	e8 1c 0f 00 00       	call   4116 <printf>
    31fa:	83 c4 10             	add    $0x10,%esp
    31fd:	e8 84 0d 00 00       	call   3f86 <exit>
    3202:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3206:	75 05                	jne    320d <sbrktest+0x118>
    3208:	e8 79 0d 00 00       	call   3f86 <exit>
    320d:	e8 7c 0d 00 00       	call   3f8e <wait>
    3212:	83 ec 0c             	sub    $0xc,%esp
    3215:	6a 00                	push   $0x0
    3217:	e8 f2 0d 00 00       	call   400e <sbrk>
    321c:	83 c4 10             	add    $0x10,%esp
    321f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3222:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3225:	ba 00 00 40 06       	mov    $0x6400000,%edx
    322a:	29 c2                	sub    %eax,%edx
    322c:	89 d0                	mov    %edx,%eax
    322e:	89 45 dc             	mov    %eax,-0x24(%ebp)
    3231:	8b 45 dc             	mov    -0x24(%ebp),%eax
    3234:	83 ec 0c             	sub    $0xc,%esp
    3237:	50                   	push   %eax
    3238:	e8 d1 0d 00 00       	call   400e <sbrk>
    323d:	83 c4 10             	add    $0x10,%esp
    3240:	89 45 d8             	mov    %eax,-0x28(%ebp)
    3243:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3246:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3249:	74 1b                	je     3266 <sbrktest+0x171>
    324b:	a1 0c 64 00 00       	mov    0x640c,%eax
    3250:	83 ec 08             	sub    $0x8,%esp
    3253:	68 30 59 00 00       	push   $0x5930
    3258:	50                   	push   %eax
    3259:	e8 b8 0e 00 00       	call   4116 <printf>
    325e:	83 c4 10             	add    $0x10,%esp
    3261:	e8 20 0d 00 00       	call   3f86 <exit>
    3266:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
    326d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3270:	c6 00 63             	movb   $0x63,(%eax)
    3273:	83 ec 0c             	sub    $0xc,%esp
    3276:	6a 00                	push   $0x0
    3278:	e8 91 0d 00 00       	call   400e <sbrk>
    327d:	83 c4 10             	add    $0x10,%esp
    3280:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3283:	83 ec 0c             	sub    $0xc,%esp
    3286:	68 00 f0 ff ff       	push   $0xfffff000
    328b:	e8 7e 0d 00 00       	call   400e <sbrk>
    3290:	83 c4 10             	add    $0x10,%esp
    3293:	89 45 e0             	mov    %eax,-0x20(%ebp)
    3296:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    329a:	75 1b                	jne    32b7 <sbrktest+0x1c2>
    329c:	a1 0c 64 00 00       	mov    0x640c,%eax
    32a1:	83 ec 08             	sub    $0x8,%esp
    32a4:	68 6e 59 00 00       	push   $0x596e
    32a9:	50                   	push   %eax
    32aa:	e8 67 0e 00 00       	call   4116 <printf>
    32af:	83 c4 10             	add    $0x10,%esp
    32b2:	e8 cf 0c 00 00       	call   3f86 <exit>
    32b7:	83 ec 0c             	sub    $0xc,%esp
    32ba:	6a 00                	push   $0x0
    32bc:	e8 4d 0d 00 00       	call   400e <sbrk>
    32c1:	83 c4 10             	add    $0x10,%esp
    32c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
    32c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    32ca:	2d 00 10 00 00       	sub    $0x1000,%eax
    32cf:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    32d2:	74 1e                	je     32f2 <sbrktest+0x1fd>
    32d4:	a1 0c 64 00 00       	mov    0x640c,%eax
    32d9:	ff 75 e0             	pushl  -0x20(%ebp)
    32dc:	ff 75 f4             	pushl  -0xc(%ebp)
    32df:	68 8c 59 00 00       	push   $0x598c
    32e4:	50                   	push   %eax
    32e5:	e8 2c 0e 00 00       	call   4116 <printf>
    32ea:	83 c4 10             	add    $0x10,%esp
    32ed:	e8 94 0c 00 00       	call   3f86 <exit>
    32f2:	83 ec 0c             	sub    $0xc,%esp
    32f5:	6a 00                	push   $0x0
    32f7:	e8 12 0d 00 00       	call   400e <sbrk>
    32fc:	83 c4 10             	add    $0x10,%esp
    32ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3302:	83 ec 0c             	sub    $0xc,%esp
    3305:	68 00 10 00 00       	push   $0x1000
    330a:	e8 ff 0c 00 00       	call   400e <sbrk>
    330f:	83 c4 10             	add    $0x10,%esp
    3312:	89 45 e0             	mov    %eax,-0x20(%ebp)
    3315:	8b 45 e0             	mov    -0x20(%ebp),%eax
    3318:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    331b:	75 1b                	jne    3338 <sbrktest+0x243>
    331d:	83 ec 0c             	sub    $0xc,%esp
    3320:	6a 00                	push   $0x0
    3322:	e8 e7 0c 00 00       	call   400e <sbrk>
    3327:	83 c4 10             	add    $0x10,%esp
    332a:	89 c2                	mov    %eax,%edx
    332c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    332f:	05 00 10 00 00       	add    $0x1000,%eax
    3334:	39 c2                	cmp    %eax,%edx
    3336:	74 1e                	je     3356 <sbrktest+0x261>
    3338:	a1 0c 64 00 00       	mov    0x640c,%eax
    333d:	ff 75 e0             	pushl  -0x20(%ebp)
    3340:	ff 75 f4             	pushl  -0xc(%ebp)
    3343:	68 c4 59 00 00       	push   $0x59c4
    3348:	50                   	push   %eax
    3349:	e8 c8 0d 00 00       	call   4116 <printf>
    334e:	83 c4 10             	add    $0x10,%esp
    3351:	e8 30 0c 00 00       	call   3f86 <exit>
    3356:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3359:	0f b6 00             	movzbl (%eax),%eax
    335c:	3c 63                	cmp    $0x63,%al
    335e:	75 1b                	jne    337b <sbrktest+0x286>
    3360:	a1 0c 64 00 00       	mov    0x640c,%eax
    3365:	83 ec 08             	sub    $0x8,%esp
    3368:	68 ec 59 00 00       	push   $0x59ec
    336d:	50                   	push   %eax
    336e:	e8 a3 0d 00 00       	call   4116 <printf>
    3373:	83 c4 10             	add    $0x10,%esp
    3376:	e8 0b 0c 00 00       	call   3f86 <exit>
    337b:	83 ec 0c             	sub    $0xc,%esp
    337e:	6a 00                	push   $0x0
    3380:	e8 89 0c 00 00       	call   400e <sbrk>
    3385:	83 c4 10             	add    $0x10,%esp
    3388:	89 45 f4             	mov    %eax,-0xc(%ebp)
    338b:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    338e:	83 ec 0c             	sub    $0xc,%esp
    3391:	6a 00                	push   $0x0
    3393:	e8 76 0c 00 00       	call   400e <sbrk>
    3398:	83 c4 10             	add    $0x10,%esp
    339b:	29 c3                	sub    %eax,%ebx
    339d:	89 d8                	mov    %ebx,%eax
    339f:	83 ec 0c             	sub    $0xc,%esp
    33a2:	50                   	push   %eax
    33a3:	e8 66 0c 00 00       	call   400e <sbrk>
    33a8:	83 c4 10             	add    $0x10,%esp
    33ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
    33ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
    33b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    33b4:	74 1e                	je     33d4 <sbrktest+0x2df>
    33b6:	a1 0c 64 00 00       	mov    0x640c,%eax
    33bb:	ff 75 e0             	pushl  -0x20(%ebp)
    33be:	ff 75 f4             	pushl  -0xc(%ebp)
    33c1:	68 1c 5a 00 00       	push   $0x5a1c
    33c6:	50                   	push   %eax
    33c7:	e8 4a 0d 00 00       	call   4116 <printf>
    33cc:	83 c4 10             	add    $0x10,%esp
    33cf:	e8 b2 0b 00 00       	call   3f86 <exit>
    33d4:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    33db:	eb 76                	jmp    3453 <sbrktest+0x35e>
    33dd:	e8 24 0c 00 00       	call   4006 <getpid>
    33e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
    33e5:	e8 94 0b 00 00       	call   3f7e <fork>
    33ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    33ed:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    33f1:	79 1b                	jns    340e <sbrktest+0x319>
    33f3:	a1 0c 64 00 00       	mov    0x640c,%eax
    33f8:	83 ec 08             	sub    $0x8,%esp
    33fb:	68 91 45 00 00       	push   $0x4591
    3400:	50                   	push   %eax
    3401:	e8 10 0d 00 00       	call   4116 <printf>
    3406:	83 c4 10             	add    $0x10,%esp
    3409:	e8 78 0b 00 00       	call   3f86 <exit>
    340e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3412:	75 33                	jne    3447 <sbrktest+0x352>
    3414:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3417:	0f b6 00             	movzbl (%eax),%eax
    341a:	0f be d0             	movsbl %al,%edx
    341d:	a1 0c 64 00 00       	mov    0x640c,%eax
    3422:	52                   	push   %edx
    3423:	ff 75 f4             	pushl  -0xc(%ebp)
    3426:	68 3d 5a 00 00       	push   $0x5a3d
    342b:	50                   	push   %eax
    342c:	e8 e5 0c 00 00       	call   4116 <printf>
    3431:	83 c4 10             	add    $0x10,%esp
    3434:	83 ec 0c             	sub    $0xc,%esp
    3437:	ff 75 d0             	pushl  -0x30(%ebp)
    343a:	e8 77 0b 00 00       	call   3fb6 <kill>
    343f:	83 c4 10             	add    $0x10,%esp
    3442:	e8 3f 0b 00 00       	call   3f86 <exit>
    3447:	e8 42 0b 00 00       	call   3f8e <wait>
    344c:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3453:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    345a:	76 81                	jbe    33dd <sbrktest+0x2e8>
    345c:	83 ec 0c             	sub    $0xc,%esp
    345f:	8d 45 c8             	lea    -0x38(%ebp),%eax
    3462:	50                   	push   %eax
    3463:	e8 2e 0b 00 00       	call   3f96 <pipe>
    3468:	83 c4 10             	add    $0x10,%esp
    346b:	85 c0                	test   %eax,%eax
    346d:	74 17                	je     3486 <sbrktest+0x391>
    346f:	83 ec 08             	sub    $0x8,%esp
    3472:	68 62 49 00 00       	push   $0x4962
    3477:	6a 01                	push   $0x1
    3479:	e8 98 0c 00 00       	call   4116 <printf>
    347e:	83 c4 10             	add    $0x10,%esp
    3481:	e8 00 0b 00 00       	call   3f86 <exit>
    3486:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    348d:	e9 88 00 00 00       	jmp    351a <sbrktest+0x425>
    3492:	e8 e7 0a 00 00       	call   3f7e <fork>
    3497:	89 c2                	mov    %eax,%edx
    3499:	8b 45 f0             	mov    -0x10(%ebp),%eax
    349c:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    34a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34a3:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34a7:	85 c0                	test   %eax,%eax
    34a9:	75 4a                	jne    34f5 <sbrktest+0x400>
    34ab:	83 ec 0c             	sub    $0xc,%esp
    34ae:	6a 00                	push   $0x0
    34b0:	e8 59 0b 00 00       	call   400e <sbrk>
    34b5:	83 c4 10             	add    $0x10,%esp
    34b8:	ba 00 00 40 06       	mov    $0x6400000,%edx
    34bd:	29 c2                	sub    %eax,%edx
    34bf:	89 d0                	mov    %edx,%eax
    34c1:	83 ec 0c             	sub    $0xc,%esp
    34c4:	50                   	push   %eax
    34c5:	e8 44 0b 00 00       	call   400e <sbrk>
    34ca:	83 c4 10             	add    $0x10,%esp
    34cd:	8b 45 cc             	mov    -0x34(%ebp),%eax
    34d0:	83 ec 04             	sub    $0x4,%esp
    34d3:	6a 01                	push   $0x1
    34d5:	68 c7 49 00 00       	push   $0x49c7
    34da:	50                   	push   %eax
    34db:	e8 c6 0a 00 00       	call   3fa6 <write>
    34e0:	83 c4 10             	add    $0x10,%esp
    34e3:	83 ec 0c             	sub    $0xc,%esp
    34e6:	68 e8 03 00 00       	push   $0x3e8
    34eb:	e8 26 0b 00 00       	call   4016 <sleep>
    34f0:	83 c4 10             	add    $0x10,%esp
    34f3:	eb ee                	jmp    34e3 <sbrktest+0x3ee>
    34f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34f8:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34fc:	83 f8 ff             	cmp    $0xffffffff,%eax
    34ff:	74 15                	je     3516 <sbrktest+0x421>
    3501:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3504:	83 ec 04             	sub    $0x4,%esp
    3507:	6a 01                	push   $0x1
    3509:	8d 55 9f             	lea    -0x61(%ebp),%edx
    350c:	52                   	push   %edx
    350d:	50                   	push   %eax
    350e:	e8 8b 0a 00 00       	call   3f9e <read>
    3513:	83 c4 10             	add    $0x10,%esp
    3516:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    351a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    351d:	83 f8 09             	cmp    $0x9,%eax
    3520:	0f 86 6c ff ff ff    	jbe    3492 <sbrktest+0x39d>
    3526:	83 ec 0c             	sub    $0xc,%esp
    3529:	68 00 10 00 00       	push   $0x1000
    352e:	e8 db 0a 00 00       	call   400e <sbrk>
    3533:	83 c4 10             	add    $0x10,%esp
    3536:	89 45 e0             	mov    %eax,-0x20(%ebp)
    3539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3540:	eb 2b                	jmp    356d <sbrktest+0x478>
    3542:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3545:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3549:	83 f8 ff             	cmp    $0xffffffff,%eax
    354c:	74 1a                	je     3568 <sbrktest+0x473>
    354e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3551:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3555:	83 ec 0c             	sub    $0xc,%esp
    3558:	50                   	push   %eax
    3559:	e8 58 0a 00 00       	call   3fb6 <kill>
    355e:	83 c4 10             	add    $0x10,%esp
    3561:	e8 28 0a 00 00       	call   3f8e <wait>
    3566:	eb 01                	jmp    3569 <sbrktest+0x474>
    3568:	90                   	nop
    3569:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    356d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3570:	83 f8 09             	cmp    $0x9,%eax
    3573:	76 cd                	jbe    3542 <sbrktest+0x44d>
    3575:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    3579:	75 1b                	jne    3596 <sbrktest+0x4a1>
    357b:	a1 0c 64 00 00       	mov    0x640c,%eax
    3580:	83 ec 08             	sub    $0x8,%esp
    3583:	68 56 5a 00 00       	push   $0x5a56
    3588:	50                   	push   %eax
    3589:	e8 88 0b 00 00       	call   4116 <printf>
    358e:	83 c4 10             	add    $0x10,%esp
    3591:	e8 f0 09 00 00       	call   3f86 <exit>
    3596:	83 ec 0c             	sub    $0xc,%esp
    3599:	6a 00                	push   $0x0
    359b:	e8 6e 0a 00 00       	call   400e <sbrk>
    35a0:	83 c4 10             	add    $0x10,%esp
    35a3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    35a6:	76 20                	jbe    35c8 <sbrktest+0x4d3>
    35a8:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    35ab:	83 ec 0c             	sub    $0xc,%esp
    35ae:	6a 00                	push   $0x0
    35b0:	e8 59 0a 00 00       	call   400e <sbrk>
    35b5:	83 c4 10             	add    $0x10,%esp
    35b8:	29 c3                	sub    %eax,%ebx
    35ba:	89 d8                	mov    %ebx,%eax
    35bc:	83 ec 0c             	sub    $0xc,%esp
    35bf:	50                   	push   %eax
    35c0:	e8 49 0a 00 00       	call   400e <sbrk>
    35c5:	83 c4 10             	add    $0x10,%esp
    35c8:	a1 0c 64 00 00       	mov    0x640c,%eax
    35cd:	83 ec 08             	sub    $0x8,%esp
    35d0:	68 71 5a 00 00       	push   $0x5a71
    35d5:	50                   	push   %eax
    35d6:	e8 3b 0b 00 00       	call   4116 <printf>
    35db:	83 c4 10             	add    $0x10,%esp
    35de:	90                   	nop
    35df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    35e2:	c9                   	leave  
    35e3:	c3                   	ret    

000035e4 <validateint>:
    35e4:	55                   	push   %ebp
    35e5:	89 e5                	mov    %esp,%ebp
    35e7:	53                   	push   %ebx
    35e8:	83 ec 10             	sub    $0x10,%esp
    35eb:	b8 0d 00 00 00       	mov    $0xd,%eax
    35f0:	8b 55 08             	mov    0x8(%ebp),%edx
    35f3:	89 d1                	mov    %edx,%ecx
    35f5:	89 e3                	mov    %esp,%ebx
    35f7:	89 cc                	mov    %ecx,%esp
    35f9:	cd 40                	int    $0x40
    35fb:	89 dc                	mov    %ebx,%esp
    35fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3600:	90                   	nop
    3601:	83 c4 10             	add    $0x10,%esp
    3604:	5b                   	pop    %ebx
    3605:	5d                   	pop    %ebp
    3606:	c3                   	ret    

00003607 <validatetest>:
    3607:	55                   	push   %ebp
    3608:	89 e5                	mov    %esp,%ebp
    360a:	83 ec 18             	sub    $0x18,%esp
    360d:	a1 0c 64 00 00       	mov    0x640c,%eax
    3612:	83 ec 08             	sub    $0x8,%esp
    3615:	68 7f 5a 00 00       	push   $0x5a7f
    361a:	50                   	push   %eax
    361b:	e8 f6 0a 00 00       	call   4116 <printf>
    3620:	83 c4 10             	add    $0x10,%esp
    3623:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)
    362a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3631:	e9 8a 00 00 00       	jmp    36c0 <validatetest+0xb9>
    3636:	e8 43 09 00 00       	call   3f7e <fork>
    363b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    363e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3642:	75 14                	jne    3658 <validatetest+0x51>
    3644:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3647:	83 ec 0c             	sub    $0xc,%esp
    364a:	50                   	push   %eax
    364b:	e8 94 ff ff ff       	call   35e4 <validateint>
    3650:	83 c4 10             	add    $0x10,%esp
    3653:	e8 2e 09 00 00       	call   3f86 <exit>
    3658:	83 ec 0c             	sub    $0xc,%esp
    365b:	6a 00                	push   $0x0
    365d:	e8 b4 09 00 00       	call   4016 <sleep>
    3662:	83 c4 10             	add    $0x10,%esp
    3665:	83 ec 0c             	sub    $0xc,%esp
    3668:	6a 00                	push   $0x0
    366a:	e8 a7 09 00 00       	call   4016 <sleep>
    366f:	83 c4 10             	add    $0x10,%esp
    3672:	83 ec 0c             	sub    $0xc,%esp
    3675:	ff 75 ec             	pushl  -0x14(%ebp)
    3678:	e8 39 09 00 00       	call   3fb6 <kill>
    367d:	83 c4 10             	add    $0x10,%esp
    3680:	e8 09 09 00 00       	call   3f8e <wait>
    3685:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3688:	83 ec 08             	sub    $0x8,%esp
    368b:	50                   	push   %eax
    368c:	68 8e 5a 00 00       	push   $0x5a8e
    3691:	e8 50 09 00 00       	call   3fe6 <link>
    3696:	83 c4 10             	add    $0x10,%esp
    3699:	83 f8 ff             	cmp    $0xffffffff,%eax
    369c:	74 1b                	je     36b9 <validatetest+0xb2>
    369e:	a1 0c 64 00 00       	mov    0x640c,%eax
    36a3:	83 ec 08             	sub    $0x8,%esp
    36a6:	68 99 5a 00 00       	push   $0x5a99
    36ab:	50                   	push   %eax
    36ac:	e8 65 0a 00 00       	call   4116 <printf>
    36b1:	83 c4 10             	add    $0x10,%esp
    36b4:	e8 cd 08 00 00       	call   3f86 <exit>
    36b9:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    36c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    36c3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    36c6:	0f 86 6a ff ff ff    	jbe    3636 <validatetest+0x2f>
    36cc:	a1 0c 64 00 00       	mov    0x640c,%eax
    36d1:	83 ec 08             	sub    $0x8,%esp
    36d4:	68 b2 5a 00 00       	push   $0x5ab2
    36d9:	50                   	push   %eax
    36da:	e8 37 0a 00 00       	call   4116 <printf>
    36df:	83 c4 10             	add    $0x10,%esp
    36e2:	90                   	nop
    36e3:	c9                   	leave  
    36e4:	c3                   	ret    

000036e5 <bsstest>:
    36e5:	55                   	push   %ebp
    36e6:	89 e5                	mov    %esp,%ebp
    36e8:	83 ec 18             	sub    $0x18,%esp
    36eb:	a1 0c 64 00 00       	mov    0x640c,%eax
    36f0:	83 ec 08             	sub    $0x8,%esp
    36f3:	68 bf 5a 00 00       	push   $0x5abf
    36f8:	50                   	push   %eax
    36f9:	e8 18 0a 00 00       	call   4116 <printf>
    36fe:	83 c4 10             	add    $0x10,%esp
    3701:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3708:	eb 2e                	jmp    3738 <bsstest+0x53>
    370a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    370d:	05 e0 64 00 00       	add    $0x64e0,%eax
    3712:	0f b6 00             	movzbl (%eax),%eax
    3715:	84 c0                	test   %al,%al
    3717:	74 1b                	je     3734 <bsstest+0x4f>
    3719:	a1 0c 64 00 00       	mov    0x640c,%eax
    371e:	83 ec 08             	sub    $0x8,%esp
    3721:	68 c9 5a 00 00       	push   $0x5ac9
    3726:	50                   	push   %eax
    3727:	e8 ea 09 00 00       	call   4116 <printf>
    372c:	83 c4 10             	add    $0x10,%esp
    372f:	e8 52 08 00 00       	call   3f86 <exit>
    3734:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3738:	8b 45 f4             	mov    -0xc(%ebp),%eax
    373b:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3740:	76 c8                	jbe    370a <bsstest+0x25>
    3742:	a1 0c 64 00 00       	mov    0x640c,%eax
    3747:	83 ec 08             	sub    $0x8,%esp
    374a:	68 da 5a 00 00       	push   $0x5ada
    374f:	50                   	push   %eax
    3750:	e8 c1 09 00 00       	call   4116 <printf>
    3755:	83 c4 10             	add    $0x10,%esp
    3758:	90                   	nop
    3759:	c9                   	leave  
    375a:	c3                   	ret    

0000375b <bigargtest>:
    375b:	55                   	push   %ebp
    375c:	89 e5                	mov    %esp,%ebp
    375e:	83 ec 18             	sub    $0x18,%esp
    3761:	83 ec 0c             	sub    $0xc,%esp
    3764:	68 e7 5a 00 00       	push   $0x5ae7
    3769:	e8 68 08 00 00       	call   3fd6 <unlink>
    376e:	83 c4 10             	add    $0x10,%esp
    3771:	e8 08 08 00 00       	call   3f7e <fork>
    3776:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3779:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    377d:	0f 85 97 00 00 00    	jne    381a <bigargtest+0xbf>
    3783:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    378a:	eb 12                	jmp    379e <bigargtest+0x43>
    378c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    378f:	c7 04 85 40 64 00 00 	movl   $0x5af4,0x6440(,%eax,4)
    3796:	f4 5a 00 00 
    379a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    379e:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    37a2:	7e e8                	jle    378c <bigargtest+0x31>
    37a4:	c7 05 bc 64 00 00 00 	movl   $0x0,0x64bc
    37ab:	00 00 00 
    37ae:	a1 0c 64 00 00       	mov    0x640c,%eax
    37b3:	83 ec 08             	sub    $0x8,%esp
    37b6:	68 d1 5b 00 00       	push   $0x5bd1
    37bb:	50                   	push   %eax
    37bc:	e8 55 09 00 00       	call   4116 <printf>
    37c1:	83 c4 10             	add    $0x10,%esp
    37c4:	83 ec 08             	sub    $0x8,%esp
    37c7:	68 40 64 00 00       	push   $0x6440
    37cc:	68 f0 44 00 00       	push   $0x44f0
    37d1:	e8 e8 07 00 00       	call   3fbe <exec>
    37d6:	83 c4 10             	add    $0x10,%esp
    37d9:	a1 0c 64 00 00       	mov    0x640c,%eax
    37de:	83 ec 08             	sub    $0x8,%esp
    37e1:	68 de 5b 00 00       	push   $0x5bde
    37e6:	50                   	push   %eax
    37e7:	e8 2a 09 00 00       	call   4116 <printf>
    37ec:	83 c4 10             	add    $0x10,%esp
    37ef:	83 ec 08             	sub    $0x8,%esp
    37f2:	68 00 02 00 00       	push   $0x200
    37f7:	68 e7 5a 00 00       	push   $0x5ae7
    37fc:	e8 c5 07 00 00       	call   3fc6 <open>
    3801:	83 c4 10             	add    $0x10,%esp
    3804:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3807:	83 ec 0c             	sub    $0xc,%esp
    380a:	ff 75 ec             	pushl  -0x14(%ebp)
    380d:	e8 9c 07 00 00       	call   3fae <close>
    3812:	83 c4 10             	add    $0x10,%esp
    3815:	e8 6c 07 00 00       	call   3f86 <exit>
    381a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    381e:	79 1b                	jns    383b <bigargtest+0xe0>
    3820:	a1 0c 64 00 00       	mov    0x640c,%eax
    3825:	83 ec 08             	sub    $0x8,%esp
    3828:	68 ee 5b 00 00       	push   $0x5bee
    382d:	50                   	push   %eax
    382e:	e8 e3 08 00 00       	call   4116 <printf>
    3833:	83 c4 10             	add    $0x10,%esp
    3836:	e8 4b 07 00 00       	call   3f86 <exit>
    383b:	e8 4e 07 00 00       	call   3f8e <wait>
    3840:	83 ec 08             	sub    $0x8,%esp
    3843:	6a 00                	push   $0x0
    3845:	68 e7 5a 00 00       	push   $0x5ae7
    384a:	e8 77 07 00 00       	call   3fc6 <open>
    384f:	83 c4 10             	add    $0x10,%esp
    3852:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3855:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3859:	79 1b                	jns    3876 <bigargtest+0x11b>
    385b:	a1 0c 64 00 00       	mov    0x640c,%eax
    3860:	83 ec 08             	sub    $0x8,%esp
    3863:	68 07 5c 00 00       	push   $0x5c07
    3868:	50                   	push   %eax
    3869:	e8 a8 08 00 00       	call   4116 <printf>
    386e:	83 c4 10             	add    $0x10,%esp
    3871:	e8 10 07 00 00       	call   3f86 <exit>
    3876:	83 ec 0c             	sub    $0xc,%esp
    3879:	ff 75 ec             	pushl  -0x14(%ebp)
    387c:	e8 2d 07 00 00       	call   3fae <close>
    3881:	83 c4 10             	add    $0x10,%esp
    3884:	83 ec 0c             	sub    $0xc,%esp
    3887:	68 e7 5a 00 00       	push   $0x5ae7
    388c:	e8 45 07 00 00       	call   3fd6 <unlink>
    3891:	83 c4 10             	add    $0x10,%esp
    3894:	90                   	nop
    3895:	c9                   	leave  
    3896:	c3                   	ret    

00003897 <fsfull>:
    3897:	55                   	push   %ebp
    3898:	89 e5                	mov    %esp,%ebp
    389a:	53                   	push   %ebx
    389b:	83 ec 64             	sub    $0x64,%esp
    389e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    38a5:	83 ec 08             	sub    $0x8,%esp
    38a8:	68 1c 5c 00 00       	push   $0x5c1c
    38ad:	6a 01                	push   $0x1
    38af:	e8 62 08 00 00       	call   4116 <printf>
    38b4:	83 c4 10             	add    $0x10,%esp
    38b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    38be:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    38c2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    38c5:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    38ca:	89 c8                	mov    %ecx,%eax
    38cc:	f7 ea                	imul   %edx
    38ce:	c1 fa 06             	sar    $0x6,%edx
    38d1:	89 c8                	mov    %ecx,%eax
    38d3:	c1 f8 1f             	sar    $0x1f,%eax
    38d6:	29 c2                	sub    %eax,%edx
    38d8:	89 d0                	mov    %edx,%eax
    38da:	83 c0 30             	add    $0x30,%eax
    38dd:	88 45 a5             	mov    %al,-0x5b(%ebp)
    38e0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    38e3:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    38e8:	89 d8                	mov    %ebx,%eax
    38ea:	f7 ea                	imul   %edx
    38ec:	c1 fa 06             	sar    $0x6,%edx
    38ef:	89 d8                	mov    %ebx,%eax
    38f1:	c1 f8 1f             	sar    $0x1f,%eax
    38f4:	89 d1                	mov    %edx,%ecx
    38f6:	29 c1                	sub    %eax,%ecx
    38f8:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    38fe:	29 c3                	sub    %eax,%ebx
    3900:	89 d9                	mov    %ebx,%ecx
    3902:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3907:	89 c8                	mov    %ecx,%eax
    3909:	f7 ea                	imul   %edx
    390b:	c1 fa 05             	sar    $0x5,%edx
    390e:	89 c8                	mov    %ecx,%eax
    3910:	c1 f8 1f             	sar    $0x1f,%eax
    3913:	29 c2                	sub    %eax,%edx
    3915:	89 d0                	mov    %edx,%eax
    3917:	83 c0 30             	add    $0x30,%eax
    391a:	88 45 a6             	mov    %al,-0x5a(%ebp)
    391d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3920:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3925:	89 d8                	mov    %ebx,%eax
    3927:	f7 ea                	imul   %edx
    3929:	c1 fa 05             	sar    $0x5,%edx
    392c:	89 d8                	mov    %ebx,%eax
    392e:	c1 f8 1f             	sar    $0x1f,%eax
    3931:	89 d1                	mov    %edx,%ecx
    3933:	29 c1                	sub    %eax,%ecx
    3935:	6b c1 64             	imul   $0x64,%ecx,%eax
    3938:	29 c3                	sub    %eax,%ebx
    393a:	89 d9                	mov    %ebx,%ecx
    393c:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3941:	89 c8                	mov    %ecx,%eax
    3943:	f7 ea                	imul   %edx
    3945:	c1 fa 02             	sar    $0x2,%edx
    3948:	89 c8                	mov    %ecx,%eax
    394a:	c1 f8 1f             	sar    $0x1f,%eax
    394d:	29 c2                	sub    %eax,%edx
    394f:	89 d0                	mov    %edx,%eax
    3951:	83 c0 30             	add    $0x30,%eax
    3954:	88 45 a7             	mov    %al,-0x59(%ebp)
    3957:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    395a:	ba 67 66 66 66       	mov    $0x66666667,%edx
    395f:	89 c8                	mov    %ecx,%eax
    3961:	f7 ea                	imul   %edx
    3963:	c1 fa 02             	sar    $0x2,%edx
    3966:	89 c8                	mov    %ecx,%eax
    3968:	c1 f8 1f             	sar    $0x1f,%eax
    396b:	29 c2                	sub    %eax,%edx
    396d:	89 d0                	mov    %edx,%eax
    396f:	c1 e0 02             	shl    $0x2,%eax
    3972:	01 d0                	add    %edx,%eax
    3974:	01 c0                	add    %eax,%eax
    3976:	29 c1                	sub    %eax,%ecx
    3978:	89 ca                	mov    %ecx,%edx
    397a:	89 d0                	mov    %edx,%eax
    397c:	83 c0 30             	add    $0x30,%eax
    397f:	88 45 a8             	mov    %al,-0x58(%ebp)
    3982:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    3986:	83 ec 04             	sub    $0x4,%esp
    3989:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    398c:	50                   	push   %eax
    398d:	68 29 5c 00 00       	push   $0x5c29
    3992:	6a 01                	push   $0x1
    3994:	e8 7d 07 00 00       	call   4116 <printf>
    3999:	83 c4 10             	add    $0x10,%esp
    399c:	83 ec 08             	sub    $0x8,%esp
    399f:	68 02 02 00 00       	push   $0x202
    39a4:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    39a7:	50                   	push   %eax
    39a8:	e8 19 06 00 00       	call   3fc6 <open>
    39ad:	83 c4 10             	add    $0x10,%esp
    39b0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    39b3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    39b7:	79 18                	jns    39d1 <fsfull+0x13a>
    39b9:	83 ec 04             	sub    $0x4,%esp
    39bc:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    39bf:	50                   	push   %eax
    39c0:	68 35 5c 00 00       	push   $0x5c35
    39c5:	6a 01                	push   $0x1
    39c7:	e8 4a 07 00 00       	call   4116 <printf>
    39cc:	83 c4 10             	add    $0x10,%esp
    39cf:	eb 6b                	jmp    3a3c <fsfull+0x1a5>
    39d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    39d8:	83 ec 04             	sub    $0x4,%esp
    39db:	68 00 02 00 00       	push   $0x200
    39e0:	68 00 8c 00 00       	push   $0x8c00
    39e5:	ff 75 e8             	pushl  -0x18(%ebp)
    39e8:	e8 b9 05 00 00       	call   3fa6 <write>
    39ed:	83 c4 10             	add    $0x10,%esp
    39f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    39f3:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    39fa:	7e 0c                	jle    3a08 <fsfull+0x171>
    39fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    39ff:	01 45 ec             	add    %eax,-0x14(%ebp)
    3a02:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3a06:	eb d0                	jmp    39d8 <fsfull+0x141>
    3a08:	90                   	nop
    3a09:	83 ec 04             	sub    $0x4,%esp
    3a0c:	ff 75 ec             	pushl  -0x14(%ebp)
    3a0f:	68 45 5c 00 00       	push   $0x5c45
    3a14:	6a 01                	push   $0x1
    3a16:	e8 fb 06 00 00       	call   4116 <printf>
    3a1b:	83 c4 10             	add    $0x10,%esp
    3a1e:	83 ec 0c             	sub    $0xc,%esp
    3a21:	ff 75 e8             	pushl  -0x18(%ebp)
    3a24:	e8 85 05 00 00       	call   3fae <close>
    3a29:	83 c4 10             	add    $0x10,%esp
    3a2c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3a30:	74 09                	je     3a3b <fsfull+0x1a4>
    3a32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3a36:	e9 83 fe ff ff       	jmp    38be <fsfull+0x27>
    3a3b:	90                   	nop
    3a3c:	e9 db 00 00 00       	jmp    3b1c <fsfull+0x285>
    3a41:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    3a45:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3a48:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3a4d:	89 c8                	mov    %ecx,%eax
    3a4f:	f7 ea                	imul   %edx
    3a51:	c1 fa 06             	sar    $0x6,%edx
    3a54:	89 c8                	mov    %ecx,%eax
    3a56:	c1 f8 1f             	sar    $0x1f,%eax
    3a59:	29 c2                	sub    %eax,%edx
    3a5b:	89 d0                	mov    %edx,%eax
    3a5d:	83 c0 30             	add    $0x30,%eax
    3a60:	88 45 a5             	mov    %al,-0x5b(%ebp)
    3a63:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3a66:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3a6b:	89 d8                	mov    %ebx,%eax
    3a6d:	f7 ea                	imul   %edx
    3a6f:	c1 fa 06             	sar    $0x6,%edx
    3a72:	89 d8                	mov    %ebx,%eax
    3a74:	c1 f8 1f             	sar    $0x1f,%eax
    3a77:	89 d1                	mov    %edx,%ecx
    3a79:	29 c1                	sub    %eax,%ecx
    3a7b:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3a81:	29 c3                	sub    %eax,%ebx
    3a83:	89 d9                	mov    %ebx,%ecx
    3a85:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3a8a:	89 c8                	mov    %ecx,%eax
    3a8c:	f7 ea                	imul   %edx
    3a8e:	c1 fa 05             	sar    $0x5,%edx
    3a91:	89 c8                	mov    %ecx,%eax
    3a93:	c1 f8 1f             	sar    $0x1f,%eax
    3a96:	29 c2                	sub    %eax,%edx
    3a98:	89 d0                	mov    %edx,%eax
    3a9a:	83 c0 30             	add    $0x30,%eax
    3a9d:	88 45 a6             	mov    %al,-0x5a(%ebp)
    3aa0:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3aa3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3aa8:	89 d8                	mov    %ebx,%eax
    3aaa:	f7 ea                	imul   %edx
    3aac:	c1 fa 05             	sar    $0x5,%edx
    3aaf:	89 d8                	mov    %ebx,%eax
    3ab1:	c1 f8 1f             	sar    $0x1f,%eax
    3ab4:	89 d1                	mov    %edx,%ecx
    3ab6:	29 c1                	sub    %eax,%ecx
    3ab8:	6b c1 64             	imul   $0x64,%ecx,%eax
    3abb:	29 c3                	sub    %eax,%ebx
    3abd:	89 d9                	mov    %ebx,%ecx
    3abf:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3ac4:	89 c8                	mov    %ecx,%eax
    3ac6:	f7 ea                	imul   %edx
    3ac8:	c1 fa 02             	sar    $0x2,%edx
    3acb:	89 c8                	mov    %ecx,%eax
    3acd:	c1 f8 1f             	sar    $0x1f,%eax
    3ad0:	29 c2                	sub    %eax,%edx
    3ad2:	89 d0                	mov    %edx,%eax
    3ad4:	83 c0 30             	add    $0x30,%eax
    3ad7:	88 45 a7             	mov    %al,-0x59(%ebp)
    3ada:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3add:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3ae2:	89 c8                	mov    %ecx,%eax
    3ae4:	f7 ea                	imul   %edx
    3ae6:	c1 fa 02             	sar    $0x2,%edx
    3ae9:	89 c8                	mov    %ecx,%eax
    3aeb:	c1 f8 1f             	sar    $0x1f,%eax
    3aee:	29 c2                	sub    %eax,%edx
    3af0:	89 d0                	mov    %edx,%eax
    3af2:	c1 e0 02             	shl    $0x2,%eax
    3af5:	01 d0                	add    %edx,%eax
    3af7:	01 c0                	add    %eax,%eax
    3af9:	29 c1                	sub    %eax,%ecx
    3afb:	89 ca                	mov    %ecx,%edx
    3afd:	89 d0                	mov    %edx,%eax
    3aff:	83 c0 30             	add    $0x30,%eax
    3b02:	88 45 a8             	mov    %al,-0x58(%ebp)
    3b05:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    3b09:	83 ec 0c             	sub    $0xc,%esp
    3b0c:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3b0f:	50                   	push   %eax
    3b10:	e8 c1 04 00 00       	call   3fd6 <unlink>
    3b15:	83 c4 10             	add    $0x10,%esp
    3b18:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3b1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b20:	0f 89 1b ff ff ff    	jns    3a41 <fsfull+0x1aa>
    3b26:	83 ec 08             	sub    $0x8,%esp
    3b29:	68 55 5c 00 00       	push   $0x5c55
    3b2e:	6a 01                	push   $0x1
    3b30:	e8 e1 05 00 00       	call   4116 <printf>
    3b35:	83 c4 10             	add    $0x10,%esp
    3b38:	90                   	nop
    3b39:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b3c:	c9                   	leave  
    3b3d:	c3                   	ret    

00003b3e <uio>:
    3b3e:	55                   	push   %ebp
    3b3f:	89 e5                	mov    %esp,%ebp
    3b41:	83 ec 18             	sub    $0x18,%esp
    3b44:	66 c7 45 f6 00 00    	movw   $0x0,-0xa(%ebp)
    3b4a:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
    3b4e:	83 ec 08             	sub    $0x8,%esp
    3b51:	68 6b 5c 00 00       	push   $0x5c6b
    3b56:	6a 01                	push   $0x1
    3b58:	e8 b9 05 00 00       	call   4116 <printf>
    3b5d:	83 c4 10             	add    $0x10,%esp
    3b60:	e8 19 04 00 00       	call   3f7e <fork>
    3b65:	89 45 f0             	mov    %eax,-0x10(%ebp)
    3b68:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b6c:	75 3a                	jne    3ba8 <uio+0x6a>
    3b6e:	66 c7 45 f6 70 00    	movw   $0x70,-0xa(%ebp)
    3b74:	c6 45 f5 09          	movb   $0x9,-0xb(%ebp)
    3b78:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    3b7c:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
    3b80:	ee                   	out    %al,(%dx)
    3b81:	66 c7 45 f6 71 00    	movw   $0x71,-0xa(%ebp)
    3b87:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
    3b8b:	89 c2                	mov    %eax,%edx
    3b8d:	ec                   	in     (%dx),%al
    3b8e:	88 45 f5             	mov    %al,-0xb(%ebp)
    3b91:	83 ec 08             	sub    $0x8,%esp
    3b94:	68 78 5c 00 00       	push   $0x5c78
    3b99:	6a 01                	push   $0x1
    3b9b:	e8 76 05 00 00       	call   4116 <printf>
    3ba0:	83 c4 10             	add    $0x10,%esp
    3ba3:	e8 de 03 00 00       	call   3f86 <exit>
    3ba8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3bac:	79 17                	jns    3bc5 <uio+0x87>
    3bae:	83 ec 08             	sub    $0x8,%esp
    3bb1:	68 91 45 00 00       	push   $0x4591
    3bb6:	6a 01                	push   $0x1
    3bb8:	e8 59 05 00 00       	call   4116 <printf>
    3bbd:	83 c4 10             	add    $0x10,%esp
    3bc0:	e8 c1 03 00 00       	call   3f86 <exit>
    3bc5:	e8 c4 03 00 00       	call   3f8e <wait>
    3bca:	83 ec 08             	sub    $0x8,%esp
    3bcd:	68 99 5c 00 00       	push   $0x5c99
    3bd2:	6a 01                	push   $0x1
    3bd4:	e8 3d 05 00 00       	call   4116 <printf>
    3bd9:	83 c4 10             	add    $0x10,%esp
    3bdc:	90                   	nop
    3bdd:	c9                   	leave  
    3bde:	c3                   	ret    

00003bdf <rand>:
    3bdf:	55                   	push   %ebp
    3be0:	89 e5                	mov    %esp,%ebp
    3be2:	a1 10 64 00 00       	mov    0x6410,%eax
    3be7:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    3bed:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3bf2:	a3 10 64 00 00       	mov    %eax,0x6410
    3bf7:	a1 10 64 00 00       	mov    0x6410,%eax
    3bfc:	5d                   	pop    %ebp
    3bfd:	c3                   	ret    

00003bfe <main>:
    3bfe:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3c02:	83 e4 f0             	and    $0xfffffff0,%esp
    3c05:	ff 71 fc             	pushl  -0x4(%ecx)
    3c08:	55                   	push   %ebp
    3c09:	89 e5                	mov    %esp,%ebp
    3c0b:	51                   	push   %ecx
    3c0c:	83 ec 04             	sub    $0x4,%esp
    3c0f:	83 ec 08             	sub    $0x8,%esp
    3c12:	68 a8 5c 00 00       	push   $0x5ca8
    3c17:	6a 01                	push   $0x1
    3c19:	e8 f8 04 00 00       	call   4116 <printf>
    3c1e:	83 c4 10             	add    $0x10,%esp
    3c21:	83 ec 08             	sub    $0x8,%esp
    3c24:	6a 00                	push   $0x0
    3c26:	68 bc 5c 00 00       	push   $0x5cbc
    3c2b:	e8 96 03 00 00       	call   3fc6 <open>
    3c30:	83 c4 10             	add    $0x10,%esp
    3c33:	85 c0                	test   %eax,%eax
    3c35:	78 17                	js     3c4e <main+0x50>
    3c37:	83 ec 08             	sub    $0x8,%esp
    3c3a:	68 cc 5c 00 00       	push   $0x5ccc
    3c3f:	6a 01                	push   $0x1
    3c41:	e8 d0 04 00 00       	call   4116 <printf>
    3c46:	83 c4 10             	add    $0x10,%esp
    3c49:	e8 38 03 00 00       	call   3f86 <exit>
    3c4e:	83 ec 08             	sub    $0x8,%esp
    3c51:	68 00 02 00 00       	push   $0x200
    3c56:	68 bc 5c 00 00       	push   $0x5cbc
    3c5b:	e8 66 03 00 00       	call   3fc6 <open>
    3c60:	83 c4 10             	add    $0x10,%esp
    3c63:	83 ec 0c             	sub    $0xc,%esp
    3c66:	50                   	push   %eax
    3c67:	e8 42 03 00 00       	call   3fae <close>
    3c6c:	83 c4 10             	add    $0x10,%esp
    3c6f:	e8 36 d6 ff ff       	call   12aa <createdelete>
    3c74:	e8 57 e0 ff ff       	call   1cd0 <linkunlink>
    3c79:	e8 a2 dc ff ff       	call   1920 <concreate>
    3c7e:	e8 d6 d3 ff ff       	call   1059 <fourfiles>
    3c83:	e8 ee d1 ff ff       	call   e76 <sharedfd>
    3c88:	e8 ce fa ff ff       	call   375b <bigargtest>
    3c8d:	e8 30 ea ff ff       	call   26c2 <bigwrite>
    3c92:	e8 c4 fa ff ff       	call   375b <bigargtest>
    3c97:	e8 49 fa ff ff       	call   36e5 <bsstest>
    3c9c:	e8 54 f4 ff ff       	call   30f5 <sbrktest>
    3ca1:	e8 61 f9 ff ff       	call   3607 <validatetest>
    3ca6:	e8 54 c6 ff ff       	call   2ff <opentest>
    3cab:	e8 fe c6 ff ff       	call   3ae <writetest>
    3cb0:	e8 09 c9 ff ff       	call   5be <writetest1>
    3cb5:	e8 00 cb ff ff       	call   7ba <createtest>
    3cba:	e8 31 c5 ff ff       	call   1f0 <openiputtest>
    3cbf:	e8 2d c4 ff ff       	call   f1 <exitiputtest>
    3cc4:	e8 37 c3 ff ff       	call   0 <iputtest>
    3cc9:	e8 b7 d0 ff ff       	call   d85 <mem>
    3cce:	e8 ee cc ff ff       	call   9c1 <pipe1>
    3cd3:	e8 d2 ce ff ff       	call   baa <preempt>
    3cd8:	e8 30 d0 ff ff       	call   d0d <exitwait>
    3cdd:	e8 52 ee ff ff       	call   2b34 <rmdot>
    3ce2:	e8 f1 ec ff ff       	call   29d8 <fourteen>
    3ce7:	e8 d4 ea ff ff       	call   27c0 <bigfile>
    3cec:	e8 8d e2 ff ff       	call   1f7e <subdir>
    3cf1:	e8 e8 d9 ff ff       	call   16de <linktest>
    3cf6:	e8 21 d8 ff ff       	call   151c <unlinkread>
    3cfb:	e8 b9 ef ff ff       	call   2cb9 <dirfile>
    3d00:	e8 ec f1 ff ff       	call   2ef1 <iref>
    3d05:	e8 21 f3 ff ff       	call   302b <forktest>
    3d0a:	e8 fa e0 ff ff       	call   1e09 <bigdir>
    3d0f:	e8 2a fe ff ff       	call   3b3e <uio>
    3d14:	e8 55 cc ff ff       	call   96e <exectest>
    3d19:	e8 68 02 00 00       	call   3f86 <exit>

00003d1e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3d1e:	55                   	push   %ebp
    3d1f:	89 e5                	mov    %esp,%ebp
    3d21:	57                   	push   %edi
    3d22:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3d23:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3d26:	8b 55 10             	mov    0x10(%ebp),%edx
    3d29:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d2c:	89 cb                	mov    %ecx,%ebx
    3d2e:	89 df                	mov    %ebx,%edi
    3d30:	89 d1                	mov    %edx,%ecx
    3d32:	fc                   	cld    
    3d33:	f3 aa                	rep stos %al,%es:(%edi)
    3d35:	89 ca                	mov    %ecx,%edx
    3d37:	89 fb                	mov    %edi,%ebx
    3d39:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3d3c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3d3f:	5b                   	pop    %ebx
    3d40:	5f                   	pop    %edi
    3d41:	5d                   	pop    %ebp
    3d42:	c3                   	ret    

00003d43 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3d43:	55                   	push   %ebp
    3d44:	89 e5                	mov    %esp,%ebp
    3d46:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3d49:	8b 45 08             	mov    0x8(%ebp),%eax
    3d4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3d4f:	90                   	nop
    3d50:	8b 45 08             	mov    0x8(%ebp),%eax
    3d53:	8d 50 01             	lea    0x1(%eax),%edx
    3d56:	89 55 08             	mov    %edx,0x8(%ebp)
    3d59:	8b 55 0c             	mov    0xc(%ebp),%edx
    3d5c:	8d 4a 01             	lea    0x1(%edx),%ecx
    3d5f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    3d62:	0f b6 12             	movzbl (%edx),%edx
    3d65:	88 10                	mov    %dl,(%eax)
    3d67:	0f b6 00             	movzbl (%eax),%eax
    3d6a:	84 c0                	test   %al,%al
    3d6c:	75 e2                	jne    3d50 <strcpy+0xd>
    ;
  return os;
    3d6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3d71:	c9                   	leave  
    3d72:	c3                   	ret    

00003d73 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3d73:	55                   	push   %ebp
    3d74:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3d76:	eb 08                	jmp    3d80 <strcmp+0xd>
    p++, q++;
    3d78:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3d7c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3d80:	8b 45 08             	mov    0x8(%ebp),%eax
    3d83:	0f b6 00             	movzbl (%eax),%eax
    3d86:	84 c0                	test   %al,%al
    3d88:	74 10                	je     3d9a <strcmp+0x27>
    3d8a:	8b 45 08             	mov    0x8(%ebp),%eax
    3d8d:	0f b6 10             	movzbl (%eax),%edx
    3d90:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d93:	0f b6 00             	movzbl (%eax),%eax
    3d96:	38 c2                	cmp    %al,%dl
    3d98:	74 de                	je     3d78 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3d9a:	8b 45 08             	mov    0x8(%ebp),%eax
    3d9d:	0f b6 00             	movzbl (%eax),%eax
    3da0:	0f b6 d0             	movzbl %al,%edx
    3da3:	8b 45 0c             	mov    0xc(%ebp),%eax
    3da6:	0f b6 00             	movzbl (%eax),%eax
    3da9:	0f b6 c0             	movzbl %al,%eax
    3dac:	29 c2                	sub    %eax,%edx
    3dae:	89 d0                	mov    %edx,%eax
}
    3db0:	5d                   	pop    %ebp
    3db1:	c3                   	ret    

00003db2 <strlen>:

uint
strlen(char *s)
{
    3db2:	55                   	push   %ebp
    3db3:	89 e5                	mov    %esp,%ebp
    3db5:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3db8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3dbf:	eb 04                	jmp    3dc5 <strlen+0x13>
    3dc1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3dc5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3dc8:	8b 45 08             	mov    0x8(%ebp),%eax
    3dcb:	01 d0                	add    %edx,%eax
    3dcd:	0f b6 00             	movzbl (%eax),%eax
    3dd0:	84 c0                	test   %al,%al
    3dd2:	75 ed                	jne    3dc1 <strlen+0xf>
    ;
  return n;
    3dd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3dd7:	c9                   	leave  
    3dd8:	c3                   	ret    

00003dd9 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3dd9:	55                   	push   %ebp
    3dda:	89 e5                	mov    %esp,%ebp
    3ddc:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    3ddf:	8b 45 10             	mov    0x10(%ebp),%eax
    3de2:	89 44 24 08          	mov    %eax,0x8(%esp)
    3de6:	8b 45 0c             	mov    0xc(%ebp),%eax
    3de9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ded:	8b 45 08             	mov    0x8(%ebp),%eax
    3df0:	89 04 24             	mov    %eax,(%esp)
    3df3:	e8 26 ff ff ff       	call   3d1e <stosb>
  return dst;
    3df8:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3dfb:	c9                   	leave  
    3dfc:	c3                   	ret    

00003dfd <strchr>:

char*
strchr(const char *s, char c)
{
    3dfd:	55                   	push   %ebp
    3dfe:	89 e5                	mov    %esp,%ebp
    3e00:	83 ec 04             	sub    $0x4,%esp
    3e03:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e06:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3e09:	eb 14                	jmp    3e1f <strchr+0x22>
    if(*s == c)
    3e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    3e0e:	0f b6 00             	movzbl (%eax),%eax
    3e11:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3e14:	75 05                	jne    3e1b <strchr+0x1e>
      return (char*)s;
    3e16:	8b 45 08             	mov    0x8(%ebp),%eax
    3e19:	eb 13                	jmp    3e2e <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3e1b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3e1f:	8b 45 08             	mov    0x8(%ebp),%eax
    3e22:	0f b6 00             	movzbl (%eax),%eax
    3e25:	84 c0                	test   %al,%al
    3e27:	75 e2                	jne    3e0b <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    3e29:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3e2e:	c9                   	leave  
    3e2f:	c3                   	ret    

00003e30 <gets>:

char*
gets(char *buf, int max)
{
    3e30:	55                   	push   %ebp
    3e31:	89 e5                	mov    %esp,%ebp
    3e33:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3e36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3e3d:	eb 4c                	jmp    3e8b <gets+0x5b>
    cc = read(0, &c, 1);
    3e3f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3e46:	00 
    3e47:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3e4a:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e4e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e55:	e8 44 01 00 00       	call   3f9e <read>
    3e5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3e5d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3e61:	7f 02                	jg     3e65 <gets+0x35>
      break;
    3e63:	eb 31                	jmp    3e96 <gets+0x66>
    buf[i++] = c;
    3e65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e68:	8d 50 01             	lea    0x1(%eax),%edx
    3e6b:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3e6e:	89 c2                	mov    %eax,%edx
    3e70:	8b 45 08             	mov    0x8(%ebp),%eax
    3e73:	01 c2                	add    %eax,%edx
    3e75:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3e79:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3e7b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3e7f:	3c 0a                	cmp    $0xa,%al
    3e81:	74 13                	je     3e96 <gets+0x66>
    3e83:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3e87:	3c 0d                	cmp    $0xd,%al
    3e89:	74 0b                	je     3e96 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3e8e:	83 c0 01             	add    $0x1,%eax
    3e91:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3e94:	7c a9                	jl     3e3f <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3e96:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3e99:	8b 45 08             	mov    0x8(%ebp),%eax
    3e9c:	01 d0                	add    %edx,%eax
    3e9e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3ea1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3ea4:	c9                   	leave  
    3ea5:	c3                   	ret    

00003ea6 <stat>:

int
stat(char *n, struct stat *st)
{
    3ea6:	55                   	push   %ebp
    3ea7:	89 e5                	mov    %esp,%ebp
    3ea9:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3eac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3eb3:	00 
    3eb4:	8b 45 08             	mov    0x8(%ebp),%eax
    3eb7:	89 04 24             	mov    %eax,(%esp)
    3eba:	e8 07 01 00 00       	call   3fc6 <open>
    3ebf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3ec2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3ec6:	79 07                	jns    3ecf <stat+0x29>
    return -1;
    3ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3ecd:	eb 23                	jmp    3ef2 <stat+0x4c>
  r = fstat(fd, st);
    3ecf:	8b 45 0c             	mov    0xc(%ebp),%eax
    3ed2:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ed6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ed9:	89 04 24             	mov    %eax,(%esp)
    3edc:	e8 fd 00 00 00       	call   3fde <fstat>
    3ee1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3ee4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ee7:	89 04 24             	mov    %eax,(%esp)
    3eea:	e8 bf 00 00 00       	call   3fae <close>
  return r;
    3eef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3ef2:	c9                   	leave  
    3ef3:	c3                   	ret    

00003ef4 <atoi>:

int
atoi(const char *s)
{
    3ef4:	55                   	push   %ebp
    3ef5:	89 e5                	mov    %esp,%ebp
    3ef7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3efa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3f01:	eb 25                	jmp    3f28 <atoi+0x34>
    n = n*10 + *s++ - '0';
    3f03:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3f06:	89 d0                	mov    %edx,%eax
    3f08:	c1 e0 02             	shl    $0x2,%eax
    3f0b:	01 d0                	add    %edx,%eax
    3f0d:	01 c0                	add    %eax,%eax
    3f0f:	89 c1                	mov    %eax,%ecx
    3f11:	8b 45 08             	mov    0x8(%ebp),%eax
    3f14:	8d 50 01             	lea    0x1(%eax),%edx
    3f17:	89 55 08             	mov    %edx,0x8(%ebp)
    3f1a:	0f b6 00             	movzbl (%eax),%eax
    3f1d:	0f be c0             	movsbl %al,%eax
    3f20:	01 c8                	add    %ecx,%eax
    3f22:	83 e8 30             	sub    $0x30,%eax
    3f25:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3f28:	8b 45 08             	mov    0x8(%ebp),%eax
    3f2b:	0f b6 00             	movzbl (%eax),%eax
    3f2e:	3c 2f                	cmp    $0x2f,%al
    3f30:	7e 0a                	jle    3f3c <atoi+0x48>
    3f32:	8b 45 08             	mov    0x8(%ebp),%eax
    3f35:	0f b6 00             	movzbl (%eax),%eax
    3f38:	3c 39                	cmp    $0x39,%al
    3f3a:	7e c7                	jle    3f03 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    3f3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3f3f:	c9                   	leave  
    3f40:	c3                   	ret    

00003f41 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3f41:	55                   	push   %ebp
    3f42:	89 e5                	mov    %esp,%ebp
    3f44:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
    3f47:	8b 45 08             	mov    0x8(%ebp),%eax
    3f4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3f4d:	8b 45 0c             	mov    0xc(%ebp),%eax
    3f50:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3f53:	eb 17                	jmp    3f6c <memmove+0x2b>
    *dst++ = *src++;
    3f55:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f58:	8d 50 01             	lea    0x1(%eax),%edx
    3f5b:	89 55 fc             	mov    %edx,-0x4(%ebp)
    3f5e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3f61:	8d 4a 01             	lea    0x1(%edx),%ecx
    3f64:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    3f67:	0f b6 12             	movzbl (%edx),%edx
    3f6a:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3f6c:	8b 45 10             	mov    0x10(%ebp),%eax
    3f6f:	8d 50 ff             	lea    -0x1(%eax),%edx
    3f72:	89 55 10             	mov    %edx,0x10(%ebp)
    3f75:	85 c0                	test   %eax,%eax
    3f77:	7f dc                	jg     3f55 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    3f79:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3f7c:	c9                   	leave  
    3f7d:	c3                   	ret    

00003f7e <fork>:
    3f7e:	b8 01 00 00 00       	mov    $0x1,%eax
    3f83:	cd 40                	int    $0x40
    3f85:	c3                   	ret    

00003f86 <exit>:
    3f86:	b8 02 00 00 00       	mov    $0x2,%eax
    3f8b:	cd 40                	int    $0x40
    3f8d:	c3                   	ret    

00003f8e <wait>:
    3f8e:	b8 03 00 00 00       	mov    $0x3,%eax
    3f93:	cd 40                	int    $0x40
    3f95:	c3                   	ret    

00003f96 <pipe>:
    3f96:	b8 04 00 00 00       	mov    $0x4,%eax
    3f9b:	cd 40                	int    $0x40
    3f9d:	c3                   	ret    

00003f9e <read>:
    3f9e:	b8 05 00 00 00       	mov    $0x5,%eax
    3fa3:	cd 40                	int    $0x40
    3fa5:	c3                   	ret    

00003fa6 <write>:
    3fa6:	b8 10 00 00 00       	mov    $0x10,%eax
    3fab:	cd 40                	int    $0x40
    3fad:	c3                   	ret    

00003fae <close>:
    3fae:	b8 15 00 00 00       	mov    $0x15,%eax
    3fb3:	cd 40                	int    $0x40
    3fb5:	c3                   	ret    

00003fb6 <kill>:
    3fb6:	b8 06 00 00 00       	mov    $0x6,%eax
    3fbb:	cd 40                	int    $0x40
    3fbd:	c3                   	ret    

00003fbe <exec>:
    3fbe:	b8 07 00 00 00       	mov    $0x7,%eax
    3fc3:	cd 40                	int    $0x40
    3fc5:	c3                   	ret    

00003fc6 <open>:
    3fc6:	b8 0f 00 00 00       	mov    $0xf,%eax
    3fcb:	cd 40                	int    $0x40
    3fcd:	c3                   	ret    

00003fce <mknod>:
    3fce:	b8 11 00 00 00       	mov    $0x11,%eax
    3fd3:	cd 40                	int    $0x40
    3fd5:	c3                   	ret    

00003fd6 <unlink>:
    3fd6:	b8 12 00 00 00       	mov    $0x12,%eax
    3fdb:	cd 40                	int    $0x40
    3fdd:	c3                   	ret    

00003fde <fstat>:
    3fde:	b8 08 00 00 00       	mov    $0x8,%eax
    3fe3:	cd 40                	int    $0x40
    3fe5:	c3                   	ret    

00003fe6 <link>:
    3fe6:	b8 13 00 00 00       	mov    $0x13,%eax
    3feb:	cd 40                	int    $0x40
    3fed:	c3                   	ret    

00003fee <mkdir>:
    3fee:	b8 14 00 00 00       	mov    $0x14,%eax
    3ff3:	cd 40                	int    $0x40
    3ff5:	c3                   	ret    

00003ff6 <chdir>:
    3ff6:	b8 09 00 00 00       	mov    $0x9,%eax
    3ffb:	cd 40                	int    $0x40
    3ffd:	c3                   	ret    

00003ffe <dup>:
    3ffe:	b8 0a 00 00 00       	mov    $0xa,%eax
    4003:	cd 40                	int    $0x40
    4005:	c3                   	ret    

00004006 <getpid>:
    4006:	b8 0b 00 00 00       	mov    $0xb,%eax
    400b:	cd 40                	int    $0x40
    400d:	c3                   	ret    

0000400e <sbrk>:
    400e:	b8 0c 00 00 00       	mov    $0xc,%eax
    4013:	cd 40                	int    $0x40
    4015:	c3                   	ret    

00004016 <sleep>:
    4016:	b8 0d 00 00 00       	mov    $0xd,%eax
    401b:	cd 40                	int    $0x40
    401d:	c3                   	ret    

0000401e <uptime>:
    401e:	b8 0e 00 00 00       	mov    $0xe,%eax
    4023:	cd 40                	int    $0x40
    4025:	c3                   	ret    

00004026 <date>:
    4026:	b8 16 00 00 00       	mov    $0x16,%eax
    402b:	cd 40                	int    $0x40
    402d:	c3                   	ret    

0000402e <dup2>:
    402e:	b8 17 00 00 00       	mov    $0x17,%eax
    4033:	cd 40                	int    $0x40
    4035:	c3                   	ret    

00004036 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    4036:	55                   	push   %ebp
    4037:	89 e5                	mov    %esp,%ebp
    4039:	83 ec 18             	sub    $0x18,%esp
    403c:	8b 45 0c             	mov    0xc(%ebp),%eax
    403f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    4042:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    4049:	00 
    404a:	8d 45 f4             	lea    -0xc(%ebp),%eax
    404d:	89 44 24 04          	mov    %eax,0x4(%esp)
    4051:	8b 45 08             	mov    0x8(%ebp),%eax
    4054:	89 04 24             	mov    %eax,(%esp)
    4057:	e8 4a ff ff ff       	call   3fa6 <write>
}
    405c:	c9                   	leave  
    405d:	c3                   	ret    

0000405e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    405e:	55                   	push   %ebp
    405f:	89 e5                	mov    %esp,%ebp
    4061:	56                   	push   %esi
    4062:	53                   	push   %ebx
    4063:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    4066:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    406d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4071:	74 17                	je     408a <printint+0x2c>
    4073:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    4077:	79 11                	jns    408a <printint+0x2c>
    neg = 1;
    4079:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    4080:	8b 45 0c             	mov    0xc(%ebp),%eax
    4083:	f7 d8                	neg    %eax
    4085:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4088:	eb 06                	jmp    4090 <printint+0x32>
  } else {
    x = xx;
    408a:	8b 45 0c             	mov    0xc(%ebp),%eax
    408d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    4090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    4097:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    409a:	8d 41 01             	lea    0x1(%ecx),%eax
    409d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    40a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
    40a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    40a6:	ba 00 00 00 00       	mov    $0x0,%edx
    40ab:	f7 f3                	div    %ebx
    40ad:	89 d0                	mov    %edx,%eax
    40af:	0f b6 80 14 64 00 00 	movzbl 0x6414(%eax),%eax
    40b6:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    40ba:	8b 75 10             	mov    0x10(%ebp),%esi
    40bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    40c0:	ba 00 00 00 00       	mov    $0x0,%edx
    40c5:	f7 f6                	div    %esi
    40c7:	89 45 ec             	mov    %eax,-0x14(%ebp)
    40ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    40ce:	75 c7                	jne    4097 <printint+0x39>
  if(neg)
    40d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40d4:	74 10                	je     40e6 <printint+0x88>
    buf[i++] = '-';
    40d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40d9:	8d 50 01             	lea    0x1(%eax),%edx
    40dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
    40df:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    40e4:	eb 1f                	jmp    4105 <printint+0xa7>
    40e6:	eb 1d                	jmp    4105 <printint+0xa7>
    putc(fd, buf[i]);
    40e8:	8d 55 dc             	lea    -0x24(%ebp),%edx
    40eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    40ee:	01 d0                	add    %edx,%eax
    40f0:	0f b6 00             	movzbl (%eax),%eax
    40f3:	0f be c0             	movsbl %al,%eax
    40f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    40fa:	8b 45 08             	mov    0x8(%ebp),%eax
    40fd:	89 04 24             	mov    %eax,(%esp)
    4100:	e8 31 ff ff ff       	call   4036 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    4105:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    4109:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    410d:	79 d9                	jns    40e8 <printint+0x8a>
    putc(fd, buf[i]);
}
    410f:	83 c4 30             	add    $0x30,%esp
    4112:	5b                   	pop    %ebx
    4113:	5e                   	pop    %esi
    4114:	5d                   	pop    %ebp
    4115:	c3                   	ret    

00004116 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4116:	55                   	push   %ebp
    4117:	89 e5                	mov    %esp,%ebp
    4119:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    411c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    4123:	8d 45 0c             	lea    0xc(%ebp),%eax
    4126:	83 c0 04             	add    $0x4,%eax
    4129:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    412c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4133:	e9 7c 01 00 00       	jmp    42b4 <printf+0x19e>
    c = fmt[i] & 0xff;
    4138:	8b 55 0c             	mov    0xc(%ebp),%edx
    413b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    413e:	01 d0                	add    %edx,%eax
    4140:	0f b6 00             	movzbl (%eax),%eax
    4143:	0f be c0             	movsbl %al,%eax
    4146:	25 ff 00 00 00       	and    $0xff,%eax
    414b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    414e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4152:	75 2c                	jne    4180 <printf+0x6a>
      if(c == '%'){
    4154:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4158:	75 0c                	jne    4166 <printf+0x50>
        state = '%';
    415a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    4161:	e9 4a 01 00 00       	jmp    42b0 <printf+0x19a>
      } else {
        putc(fd, c);
    4166:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4169:	0f be c0             	movsbl %al,%eax
    416c:	89 44 24 04          	mov    %eax,0x4(%esp)
    4170:	8b 45 08             	mov    0x8(%ebp),%eax
    4173:	89 04 24             	mov    %eax,(%esp)
    4176:	e8 bb fe ff ff       	call   4036 <putc>
    417b:	e9 30 01 00 00       	jmp    42b0 <printf+0x19a>
      }
    } else if(state == '%'){
    4180:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    4184:	0f 85 26 01 00 00    	jne    42b0 <printf+0x19a>
      if(c == 'd'){
    418a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    418e:	75 2d                	jne    41bd <printf+0xa7>
        printint(fd, *ap, 10, 1);
    4190:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4193:	8b 00                	mov    (%eax),%eax
    4195:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    419c:	00 
    419d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    41a4:	00 
    41a5:	89 44 24 04          	mov    %eax,0x4(%esp)
    41a9:	8b 45 08             	mov    0x8(%ebp),%eax
    41ac:	89 04 24             	mov    %eax,(%esp)
    41af:	e8 aa fe ff ff       	call   405e <printint>
        ap++;
    41b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    41b8:	e9 ec 00 00 00       	jmp    42a9 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
    41bd:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    41c1:	74 06                	je     41c9 <printf+0xb3>
    41c3:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    41c7:	75 2d                	jne    41f6 <printf+0xe0>
        printint(fd, *ap, 16, 0);
    41c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41cc:	8b 00                	mov    (%eax),%eax
    41ce:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    41d5:	00 
    41d6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    41dd:	00 
    41de:	89 44 24 04          	mov    %eax,0x4(%esp)
    41e2:	8b 45 08             	mov    0x8(%ebp),%eax
    41e5:	89 04 24             	mov    %eax,(%esp)
    41e8:	e8 71 fe ff ff       	call   405e <printint>
        ap++;
    41ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    41f1:	e9 b3 00 00 00       	jmp    42a9 <printf+0x193>
      } else if(c == 's'){
    41f6:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    41fa:	75 45                	jne    4241 <printf+0x12b>
        s = (char*)*ap;
    41fc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    41ff:	8b 00                	mov    (%eax),%eax
    4201:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    4204:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    4208:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    420c:	75 09                	jne    4217 <printf+0x101>
          s = "(null)";
    420e:	c7 45 f4 f6 5c 00 00 	movl   $0x5cf6,-0xc(%ebp)
        while(*s != 0){
    4215:	eb 1e                	jmp    4235 <printf+0x11f>
    4217:	eb 1c                	jmp    4235 <printf+0x11f>
          putc(fd, *s);
    4219:	8b 45 f4             	mov    -0xc(%ebp),%eax
    421c:	0f b6 00             	movzbl (%eax),%eax
    421f:	0f be c0             	movsbl %al,%eax
    4222:	89 44 24 04          	mov    %eax,0x4(%esp)
    4226:	8b 45 08             	mov    0x8(%ebp),%eax
    4229:	89 04 24             	mov    %eax,(%esp)
    422c:	e8 05 fe ff ff       	call   4036 <putc>
          s++;
    4231:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    4235:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4238:	0f b6 00             	movzbl (%eax),%eax
    423b:	84 c0                	test   %al,%al
    423d:	75 da                	jne    4219 <printf+0x103>
    423f:	eb 68                	jmp    42a9 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4241:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    4245:	75 1d                	jne    4264 <printf+0x14e>
        putc(fd, *ap);
    4247:	8b 45 e8             	mov    -0x18(%ebp),%eax
    424a:	8b 00                	mov    (%eax),%eax
    424c:	0f be c0             	movsbl %al,%eax
    424f:	89 44 24 04          	mov    %eax,0x4(%esp)
    4253:	8b 45 08             	mov    0x8(%ebp),%eax
    4256:	89 04 24             	mov    %eax,(%esp)
    4259:	e8 d8 fd ff ff       	call   4036 <putc>
        ap++;
    425e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4262:	eb 45                	jmp    42a9 <printf+0x193>
      } else if(c == '%'){
    4264:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4268:	75 17                	jne    4281 <printf+0x16b>
        putc(fd, c);
    426a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    426d:	0f be c0             	movsbl %al,%eax
    4270:	89 44 24 04          	mov    %eax,0x4(%esp)
    4274:	8b 45 08             	mov    0x8(%ebp),%eax
    4277:	89 04 24             	mov    %eax,(%esp)
    427a:	e8 b7 fd ff ff       	call   4036 <putc>
    427f:	eb 28                	jmp    42a9 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4281:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    4288:	00 
    4289:	8b 45 08             	mov    0x8(%ebp),%eax
    428c:	89 04 24             	mov    %eax,(%esp)
    428f:	e8 a2 fd ff ff       	call   4036 <putc>
        putc(fd, c);
    4294:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4297:	0f be c0             	movsbl %al,%eax
    429a:	89 44 24 04          	mov    %eax,0x4(%esp)
    429e:	8b 45 08             	mov    0x8(%ebp),%eax
    42a1:	89 04 24             	mov    %eax,(%esp)
    42a4:	e8 8d fd ff ff       	call   4036 <putc>
      }
      state = 0;
    42a9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    42b0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    42b4:	8b 55 0c             	mov    0xc(%ebp),%edx
    42b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    42ba:	01 d0                	add    %edx,%eax
    42bc:	0f b6 00             	movzbl (%eax),%eax
    42bf:	84 c0                	test   %al,%al
    42c1:	0f 85 71 fe ff ff    	jne    4138 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    42c7:	c9                   	leave  
    42c8:	c3                   	ret    

000042c9 <free>:
    42c9:	55                   	push   %ebp
    42ca:	89 e5                	mov    %esp,%ebp
    42cc:	83 ec 10             	sub    $0x10,%esp
    42cf:	8b 45 08             	mov    0x8(%ebp),%eax
    42d2:	83 e8 08             	sub    $0x8,%eax
    42d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    42d8:	a1 c8 64 00 00       	mov    0x64c8,%eax
    42dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
    42e0:	eb 24                	jmp    4306 <free+0x3d>
    42e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42e5:	8b 00                	mov    (%eax),%eax
    42e7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    42ea:	77 12                	ja     42fe <free+0x35>
    42ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    42ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    42f2:	77 24                	ja     4318 <free+0x4f>
    42f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    42f7:	8b 00                	mov    (%eax),%eax
    42f9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    42fc:	77 1a                	ja     4318 <free+0x4f>
    42fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4301:	8b 00                	mov    (%eax),%eax
    4303:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4306:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4309:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    430c:	76 d4                	jbe    42e2 <free+0x19>
    430e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4311:	8b 00                	mov    (%eax),%eax
    4313:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4316:	76 ca                	jbe    42e2 <free+0x19>
    4318:	8b 45 f8             	mov    -0x8(%ebp),%eax
    431b:	8b 40 04             	mov    0x4(%eax),%eax
    431e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4325:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4328:	01 c2                	add    %eax,%edx
    432a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    432d:	8b 00                	mov    (%eax),%eax
    432f:	39 c2                	cmp    %eax,%edx
    4331:	75 24                	jne    4357 <free+0x8e>
    4333:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4336:	8b 50 04             	mov    0x4(%eax),%edx
    4339:	8b 45 fc             	mov    -0x4(%ebp),%eax
    433c:	8b 00                	mov    (%eax),%eax
    433e:	8b 40 04             	mov    0x4(%eax),%eax
    4341:	01 c2                	add    %eax,%edx
    4343:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4346:	89 50 04             	mov    %edx,0x4(%eax)
    4349:	8b 45 fc             	mov    -0x4(%ebp),%eax
    434c:	8b 00                	mov    (%eax),%eax
    434e:	8b 10                	mov    (%eax),%edx
    4350:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4353:	89 10                	mov    %edx,(%eax)
    4355:	eb 0a                	jmp    4361 <free+0x98>
    4357:	8b 45 fc             	mov    -0x4(%ebp),%eax
    435a:	8b 10                	mov    (%eax),%edx
    435c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    435f:	89 10                	mov    %edx,(%eax)
    4361:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4364:	8b 40 04             	mov    0x4(%eax),%eax
    4367:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    436e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4371:	01 d0                	add    %edx,%eax
    4373:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4376:	75 20                	jne    4398 <free+0xcf>
    4378:	8b 45 fc             	mov    -0x4(%ebp),%eax
    437b:	8b 50 04             	mov    0x4(%eax),%edx
    437e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4381:	8b 40 04             	mov    0x4(%eax),%eax
    4384:	01 c2                	add    %eax,%edx
    4386:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4389:	89 50 04             	mov    %edx,0x4(%eax)
    438c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    438f:	8b 10                	mov    (%eax),%edx
    4391:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4394:	89 10                	mov    %edx,(%eax)
    4396:	eb 08                	jmp    43a0 <free+0xd7>
    4398:	8b 45 fc             	mov    -0x4(%ebp),%eax
    439b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    439e:	89 10                	mov    %edx,(%eax)
    43a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43a3:	a3 c8 64 00 00       	mov    %eax,0x64c8
    43a8:	90                   	nop
    43a9:	c9                   	leave  
    43aa:	c3                   	ret    

000043ab <morecore>:
    43ab:	55                   	push   %ebp
    43ac:	89 e5                	mov    %esp,%ebp
    43ae:	83 ec 18             	sub    $0x18,%esp
    43b1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    43b8:	77 07                	ja     43c1 <morecore+0x16>
    43ba:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
    43c1:	8b 45 08             	mov    0x8(%ebp),%eax
    43c4:	c1 e0 03             	shl    $0x3,%eax
    43c7:	83 ec 0c             	sub    $0xc,%esp
    43ca:	50                   	push   %eax
    43cb:	e8 3e fc ff ff       	call   400e <sbrk>
    43d0:	83 c4 10             	add    $0x10,%esp
    43d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    43d6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    43da:	75 07                	jne    43e3 <morecore+0x38>
    43dc:	b8 00 00 00 00       	mov    $0x0,%eax
    43e1:	eb 26                	jmp    4409 <morecore+0x5e>
    43e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    43e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    43e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43ec:	8b 55 08             	mov    0x8(%ebp),%edx
    43ef:	89 50 04             	mov    %edx,0x4(%eax)
    43f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    43f5:	83 c0 08             	add    $0x8,%eax
    43f8:	83 ec 0c             	sub    $0xc,%esp
    43fb:	50                   	push   %eax
    43fc:	e8 c8 fe ff ff       	call   42c9 <free>
    4401:	83 c4 10             	add    $0x10,%esp
    4404:	a1 c8 64 00 00       	mov    0x64c8,%eax
    4409:	c9                   	leave  
    440a:	c3                   	ret    

0000440b <malloc>:
    440b:	55                   	push   %ebp
    440c:	89 e5                	mov    %esp,%ebp
    440e:	83 ec 18             	sub    $0x18,%esp
    4411:	8b 45 08             	mov    0x8(%ebp),%eax
    4414:	83 c0 07             	add    $0x7,%eax
    4417:	c1 e8 03             	shr    $0x3,%eax
    441a:	83 c0 01             	add    $0x1,%eax
    441d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    4420:	a1 c8 64 00 00       	mov    0x64c8,%eax
    4425:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4428:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    442c:	75 23                	jne    4451 <malloc+0x46>
    442e:	c7 45 f0 c0 64 00 00 	movl   $0x64c0,-0x10(%ebp)
    4435:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4438:	a3 c8 64 00 00       	mov    %eax,0x64c8
    443d:	a1 c8 64 00 00       	mov    0x64c8,%eax
    4442:	a3 c0 64 00 00       	mov    %eax,0x64c0
    4447:	c7 05 c4 64 00 00 00 	movl   $0x0,0x64c4
    444e:	00 00 00 
    4451:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4454:	8b 00                	mov    (%eax),%eax
    4456:	89 45 f4             	mov    %eax,-0xc(%ebp)
    4459:	8b 45 f4             	mov    -0xc(%ebp),%eax
    445c:	8b 40 04             	mov    0x4(%eax),%eax
    445f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4462:	72 4d                	jb     44b1 <malloc+0xa6>
    4464:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4467:	8b 40 04             	mov    0x4(%eax),%eax
    446a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    446d:	75 0c                	jne    447b <malloc+0x70>
    446f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4472:	8b 10                	mov    (%eax),%edx
    4474:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4477:	89 10                	mov    %edx,(%eax)
    4479:	eb 26                	jmp    44a1 <malloc+0x96>
    447b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    447e:	8b 40 04             	mov    0x4(%eax),%eax
    4481:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4484:	89 c2                	mov    %eax,%edx
    4486:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4489:	89 50 04             	mov    %edx,0x4(%eax)
    448c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    448f:	8b 40 04             	mov    0x4(%eax),%eax
    4492:	c1 e0 03             	shl    $0x3,%eax
    4495:	01 45 f4             	add    %eax,-0xc(%ebp)
    4498:	8b 45 f4             	mov    -0xc(%ebp),%eax
    449b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    449e:	89 50 04             	mov    %edx,0x4(%eax)
    44a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    44a4:	a3 c8 64 00 00       	mov    %eax,0x64c8
    44a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44ac:	83 c0 08             	add    $0x8,%eax
    44af:	eb 3b                	jmp    44ec <malloc+0xe1>
    44b1:	a1 c8 64 00 00       	mov    0x64c8,%eax
    44b6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    44b9:	75 1e                	jne    44d9 <malloc+0xce>
    44bb:	83 ec 0c             	sub    $0xc,%esp
    44be:	ff 75 ec             	pushl  -0x14(%ebp)
    44c1:	e8 e5 fe ff ff       	call   43ab <morecore>
    44c6:	83 c4 10             	add    $0x10,%esp
    44c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    44cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    44d0:	75 07                	jne    44d9 <malloc+0xce>
    44d2:	b8 00 00 00 00       	mov    $0x0,%eax
    44d7:	eb 13                	jmp    44ec <malloc+0xe1>
    44d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    44df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    44e2:	8b 00                	mov    (%eax),%eax
    44e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    44e7:	e9 6d ff ff ff       	jmp    4459 <malloc+0x4e>
    44ec:	c9                   	leave  
    44ed:	c3                   	ret    
