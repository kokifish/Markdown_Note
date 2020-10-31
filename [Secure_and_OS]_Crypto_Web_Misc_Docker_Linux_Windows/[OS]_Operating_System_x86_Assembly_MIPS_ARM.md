[TOC]

http://edu.51cto.com/lesson/id-30821.html
18集2017.2.12

-   pe 可执行文件 Portable Executable
-   int 中断 Interrupt Request




# BIOS



-   Basic Input Output System 直译：基本输入输出系统
-   一组固化到计算机内主板上一个ROM芯片上的程序，它保存着计算机最重要的基本输入输出的程序、系统设置信息、开机后自检程序和系统自启动程序
-   其主要功能是为计算机提供最底层的、最直接的硬件设置和控制
-   初始化并测试系统硬件组件，并从大容量存储设备加载引导程序或操作系统
-   **是开机时运行的第一个程序**
-   此外BIOS还提供了一个抽象层，该抽象层能够让BIOS以一致的方式与键盘、显示器或其他的输入输出设备交互(通过调用"int + 中断号"的形式)

BIOS存放：

-   自诊断程序：通过读取CMOSRAM中的内容识别硬件配置，并对其进行自检和初始化；
-   CMOS设置程序：引导过程中，用特殊热键启动，进行设置后，存入CMOS RAM中
-   系统自举装载程序：在自检成功后将磁盘相对0道0扇区上的引导程序装入内存，让其运行以装入DOS系统
-   主要I/O设备的驱动程序和中断服务：由于BIOS直接和系统硬件资源打交道，因此总是针对某一类型的硬件系统，而各种硬件系统又各有不同，所以存在各种不同种类的BIOS，随着硬件技术的发展，同一种BIOS也先后出现了不同的版本，新版本的BIOS比起老版本来说，功能更强



-   BIOS中中断例程即BIOS中断服务程序，是微机系统软、硬件之间的一个可编程接口，用于程序软件功能与微机硬件实现的衔接。DOS/Windows操作系统对软、硬盘、光驱与键盘、显示器等外围设备的管理即建立在系统BIOS的基础上。程序员也可以通过 对INT 5、INT 13等终端的访问直接调用BIOS终端例程

```assembly
;调用BIOS中断服务程序的方法
;每个中断服务有特定的参数，一般使用指定的寄存器传递参数；利用软中断指令调用BIOS中断调用的一般格式为：
mov ah, 功能号
... ; 设置各种入口参数
int 中断号
```







### 操作系统启动过程



1.  pre-BIOS阶段
2.  BIOS阶段
3.  加载内核阶段
4.  初始化内核阶段





pre-BIOS阶段

按下开机键，电源供电，待供电稳定后，CPU就会从0xFFFF0处执行指令，这个地址处于BIOS的地址范围内，存放的是一条跳转指令，跳到系统BIOS中真正的启动代码处。

BIOS阶段

**POST**（Power－On Self Test，加电自检），主要检测计算机最基本设备的运转状态，如CPU、内存、显卡等。如果检测到异常，立即停机（可能伴随有蜂鸣声）。如果未发现错误，屏幕就会显示出CPU、内存、硬盘等信息,并且BIOS检测到的数据也将被保存在内存低1K--2K的区域,并将BIOS中断向量表,以及BIOS程序运行所需要的数据保存在内存低0K--1K的地方.

加载内核

以一定的启动顺序（可在BIOS的操作界面中查看）寻找启动设备（软盘、硬盘、光盘等），找到后读取启动设备的0号逻辑扇区（如果是软盘就读取0面0道1扇区的整个内容，硬盘的话稍微有点不一样）,并将读取的内容放到内存地址**0x7c00**

初始化内核

执行0x7c00的代码，此后的权限就交给内核了



#### interrupt 中断 

-   IVT ​中断向量表 Interrupt Vector Table
-   中断分类：1. 硬中断：外部设备引起的。2. 软中断：中断指令引起的
-   中断向量：一个中断对应一段中断处理程序，该程序的入口地址称为中断向量。中断向量包括段基址和偏移量，总占4字节。低2B存偏移地址，高2B存段基址
-   中断向量表：存中断向量的表，占系统内存的最低端1K Bytes(00000H\~003FFH)，按中断号从小到大存储256(00H\~FFH)个中断向量
-   中断响应过程：CPU从接口电路获得中断号，计算中断向量在表中的位置后，获取中断向量的值(CS:IP)后将控制权交给中断向量指向的程序入口
-   实模式下，DITR.base 指向的表格项直接给出**中断服务例程**（Interrupt Service Routine）的入口地址



![](http://op4fcrj8y.bkt.clouddn.com/18-4-19/40547325.jpg)



| 中断号             | 功能                      |
| --------------- | ----------------------- |
| 00H~0FH 70H~77H | 系统硬件中断                  |
| 10H             | 视频BIOS中断                |
| 11H~1FH         | 其他BIOS中断                |
| 20H~2FH         | DOS中断号(21H：DOS系统服务功能调用) |
|                 |                         |







###### 08H & 中断处理程序

-   系统时钟中断为08H
-   中断向量位置：位置=中断号X4，4字节CS-IP
-   08H的中断向量位置：0x20 0x21 IP, 0x22 0x23 CS//0x8 * 4 = 32 = 0x20

```asm
;NASM
	org 100h ; 程序加载到100h，可用于生成COM
; 设置时钟中断向量（08h），初始化段寄存器
	xor ax,ax ;AX = 0
	mov es,ax ;ES = 0
	mov word [es:20h],Timer ;设置时钟中断向量的偏移地址：[0:20h]的地址变成Timer的偏移地址 
	mov ax,cs 
	mov word [es:22h],ax ;设置时钟中断向量的段地址：[0:22h]=cs 
	mov ds,ax ;DS = CS
	mov es,ax ;ES = CS
	
; 在屏幕右下角显示字符‘!’	
	mov	ax,0B800h ;文本窗口显存起始地址
	mov	gs,ax ;GS = B800h
	mov ah,0Fh ;0000：黑底、1111：亮白字（默认值为07h）
	mov al,'!' ;AL = 显示字符值（默认值为20h=空格符）
	mov [gs:((80*12+39)*2)],ax ;12行39列
	jmp $ ; 死循环
; 时钟中断处理程序
	delay equ 4 ;计时器延迟计数，每四个时钟中断
	count db delay ;计时器计数变量，初值=delay
	
;;;;每4个时钟中断，递增一次12行39列的ASCII码
;中断处理程序////////////////////////////////////////////
Timer:
	dec byte [count] ;递减计数变量
	jnz end ;>0：跳转
	inc byte [gs:((80*12+39)*2)] ;=0：递增显示字符的ASCII码值
	mov byte[count],delay ;重置计数变量=初值delay
end: ;中断返回的过程
	mov al,20h ; AL = EOI
	;每个可编程中断控制器8259A都有两个I/O端口 主8259A所对应的端口地址为20h和21h 从8259A所对应的端口地址为A0h和A1h 
	;可以通过in/out指令读写这些端口，来操作这两个中断控制器
	out 20h,al ;发送EOI到主8529A 
	out 0A0h,al ;发送EOI到从8529A 
	iret ;从中断返回
;中断返回完毕////////////////////////////////////////////
```







###### 10H 字符(串)显示

-   BIOS 的10H提供了显示字符串的调用





###### 13H 磁盘读写

-   BIOS 的13H提供了磁盘读写的调用

```assembly
;ES:BX 读入数据在内存中的存储地址
	mov ax, cs ;段地址 ; 存放数据的内存基地址
	mov es, ax ;设置段地址(不能直接mov es,段地址)
	mov bx, OffSetOfUserPrg ;偏移地址; 存放数据的内存偏移地址
	mov ah, 2 ;AH功能号
	mov al, 1 ;AL扇区数1-255
	mov dl, 0 ;DL驱动器号: 0和1表示软盘，80H和81H等表示硬盘/U盘
	mov dh, 0 ;DH磁头号0-15; 起始编号为0
	mov ch, 0 ;CH柱面号的低八位 ; 起始编号为0
	mov cl, 2 ;CL 0-5位为起始扇区号(1-63),6-7位为磁盘柱面号的高2位(总共10bit柱面号0-1023)
	int 13H ;调用读磁盘BIOS的13h功能
	
;操作完成后ES:BX指向数据区域的起始地址
;出错时进位标志CF=1，错误代码存在AH中
;成功时CF=0 AL=0
```



```assembly
public _load
_load proc
	push ax
	push bx
	push cx
	push dx
	push es
	push bp
	push ds
	mov bp, sp
	mov ax, cs              
    mov es, ax ;设置段地址
    mov bx,word ptr [bp+14+2] ;偏移地址
    mov ah, 2 ; 功能号
    mov al, 1 ;扇区数
    mov dl, 0 ;驱动器号
    mov dh, 0 ;磁头号
    mov ch, 0 ;柱面号
    mov cl, byte ptr [bp+14+4];pos_section 起始扇区号
    int 13H ; 
	call _clear_time_interrupted
	call bx
	pop ds
	pop bp
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	ret
_load endp
```









###### 16H 输入

-   功能号为00H时，读下一个按键









###### 0x7C00 与 Boot Sector

-   引导扇区 Boot Sector 相关语句 org 07c00
-   0x7c00 B = 30 KB起始处
-   启动区内容装载地址 0x7c00 - 0x7dff 共512B

1. 计算机电源被打开时，首先进行加电自检(POST **P**ower-**O**n **S**elf-**T**est)
2. 寻找启动盘，如果选择从软盘启动，计算机会检查**软盘的0面0磁道1扇区**，如果它以0xAA55(若将扇区看成字符数组sector[512], 即 sector[510] = 0x55, sector[511] = 0xAA)结束，BIOS认为是一个引导扇区Boot Sector
3. 一旦BIOS发现了Boot Sector就会将这512B的内容装载到内存0000:7c00处，然后跳转到0000:7c00将控制权彻底交给这段引导代码。至此，计算机交由操作系统的一部分来控制




MBR，“Master Boot Record”，中文“主引导记录”。MBR为存储设备的第一个扇区，也就是该存储设备的最前面的512字节



-   当时，搭配的操作系统是86-DOS。这个操作系统需要的内存最少是32KB。我们知道，内存地址从0x0000开始编号，32KB的内存就是`0x0000～0x7FFF`
-   8088芯片本身需要占用`0x0000～0x03FF`，用来保存各种中断处理程序的储存位置。（主引导记录本身就是中断信号INT 19h的处理程序。）所以，内存只剩下`0x0400～0x7FFF`可以使用
-   为了把尽量多的连续内存留给操作系统，主引导记录就被放到了内存地址的尾部。由于一个扇区是512字节，主引导记录本身也会产生数据，需要另外留出512字节保存。所以，它的预留位置就变成了：
-   0x7FFF - 512 - 512 + 1 = 0x7C00    1KB空间

+——————— 0×0
| Interrupts vectors（中断向量表）
+——————— 0×400
| BIOS data area（BIOS的数据区域）
+——————— 0×5??
| OS load area（操作系统加载区域）
+——————— 0x7C00 //主引导记录起始地址
| Boot sector（引导区域）
+——————— 0x7E00
| Boot data/stack（引导数据/堆栈）
+——————— 0x7FFF
| (not used)
+——————— (…)

-   00000~9FFFF  主存地址空间（内存条）



###### 0xB800与文本模式

-   文本模式下，`0xB8000`\~`0xBFFFF`这段物理地址被映射到显存
-   写`0xB8000`\~`0xBFFFF`可以控制显示内容
-   显示时，每个word(16bits 2Bytes)的低8bit存ASCII码，高8bit存属性
-   加电自检后自动初始化到al=03H的文字模式，此时一行80char, 25rows

| AL取值说明 | 文字/图形 | 分辨率     | 颜色   |
| ------ | ----- | ------- | ---- |
| 00H    | 文字    | 40*25   | 2    |
| 01H    | 文字    | 40*25   | 16   |
| 02H    | 文字    | 80*25   | 2    |
| 03H    | 文字    | 80*25   | 16   |
| 04H    | 图形    | 320*200 | 2    |
| 05H    | 图形    | 320*200 | 4    |
| 06H    | 图形    | 640*200 | 2    |



| bit  | [7]           | [6:4] | [3:0] |
| ---- | ------------- | ----- | ----- |
| 含义   | 1:字闪烁; 0:字不闪烁 | 背景色   | 前景色   |

| [6:4] | 0    | 1    | 2    | 3    | 4    | 5    | 6    | 7    |
| ----- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 背景色   | 黑    | 深蓝   | 绿    | 青    | 红    | 粉红   | 棕    | 灰白   |



| [3:0] | 0    | 1    | 2    | 3    | 4    | 5    | 6    | 7    | 8    | 9    | A    | B    | C    | D    | E    | F    |
| ----- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 前景色   | 黑    | 深蓝   | 绿    | 青    | 红    | 粉红   | 棕    | 灰白   | 灰    | 亮蓝   | 亮绿   | 亮青   | 亮红   | 亮粉红  | 黄    | 亮白   |









###### 0x100000

-   BIOS的约定，启动后会将内核代码载入到内存物理地址0x100000的位置











### COM格式

-   COM(command file，命令文件)是CP/M和DOS的一种原始二进制可执行格式，.com为扩展名
-   COM文件非常简单，没有文件头、没有元数据，只有代码和数据
-   COM文件会被装载到当前段的0x100（256）处，不能重新定位。由于不能分段，所以COM文件的大小必须≤64KB-256B，且不能有独立的数据段和堆栈段，程序的所有代码和数据都必须位于一个段中
-   Windows 64位中，不再支持COM程序的运行






# 存储器



### 内存



### 软盘

-   软盘文件大小 1474560字节 = 1440 * 1024 字节
-   计算机读写软盘时，以512字节为一个单位进行读写，因此软盘的512字节称为一个扇区，一张软盘有1440KB，除以512B得2880，故一张软盘有2880个扇区。
-   IPL 启动程序加载器 initial program loader启动区仅有512字节，所以几乎所有操作系统都是把加载OS本身的程序放在启动区里，因此有时也将启动区称为IPL



### 硬盘

-   磁存储技术包含硬盘，软盘和磁带等
-   接口：PATA（IDE） SATA  SCSI
-   一张单面的盘片需要一个磁头，双面的盘片则需要两个磁头
-   磁道离主轴最近的，即线速度最小的地方，是一个特殊的区域，不存放任何数据，称为启停区或着陆区(Landing Zone)，启停区外就是数据区。在最外圈，离主轴最远的地方是“0”磁道，硬盘数据的存放就是从最外圈开始的

![](http://op4fcrj8y.bkt.clouddn.com/18-3-23/89268116.jpg)



-   磁头：磁头用来读取或者修改盘片上磁性物质的状态，每个盘片可以有两个面(Side)，可称为0面，1面等。每个面对应一个磁头。磁头号指明了盘面
-   磁道Track：由于磁盘是旋转的，则连续写入的数据是排列在一个圆周上的。称这样的圆周为一个磁道
-   柱面Cylinder：不同面上(不同盘片的正反面)相同磁道编号则组成的一个圆柱面
-   扇区Sector：每个磁道划发为相同数量的扇区段。扇区是硬盘上存储的物理单位，包括512个字节的数据和一些其他信息。即使计算机只需要硬盘上存储的某个字节，也须一次把这个字节所在的扇区中的全部512字节读入内存，再选择所需的那个字节。扇区数据主要有两个部分：存储数据的标识符和存储数据的数据段
-   簇Cluster：簇就是硬盘上存储文件的一个逻辑单位。物理相邻的若干个扇区其实就组成了一个簇。操作系统读写磁盘的基本单位是扇区，而文件系统的基本单位是簇。簇一般有这几类大小 4K，8K，16K，32K，64K等。簇越大存储性能越好，但空间浪费严重。簇越小性能相对越低，但空间利用率高





扇区数据：存储数据的标识符 存储数据的数据段

1.  标识符包括组成扇区三维地址的三个数字：扇区所在的磁头(或盘面)、磁道(或柱面号)以及扇区在磁道上位置(即扇区编号)。标识符还包括一个字段，显示扇区是否可以存储数据或者已有故障不宜使用的标记。有些硬盘控制器在扇区标志符中还记录提示信息，可在原扇区出错时指引磁盘转到对应替换扇区或磁道。标识符以循环冗余校验(CRC)值作为结束，以供控制器检验扇区标识符读出情况
2.  存储数据的数据段，可分为数据和保护数据的纠错码(ECC)


在硬盘磁道中，扇区号是按照某个间隔跳跃着编排。如，2号扇区并不是1号扇区后的按顺序的第一个而是第八个，3号扇区又是2号扇区后的按顺序的第八个，依此类推，这个“八”称为交叉因子



---


# x86 Assembly



-   什么是 Intel 8086
-   Intel 8086 (IAPX 86)Intel第一款16位微处理器Intel最成功的处理器系列x86架构的开端
-   8086有8个16比特的寄存器，包括栈寄存器SP与BP，但不包括指令寄存器IP、控制寄存器FLAGS以及四个段寄存器
-   字 WORD 一个字WORD=2Bytes 16位结构的CPU 8086为例子x86的CPU，一个通用寄存器如AX，有16bit=2B=1WORD
-   20位外部地址总线，因此物理寻址空间为1MiB (即220 = 1,048,576)
-   转换时，内部两个16bit，一个传段地址，一个传偏移地址，通过地址加法器，输出到控制电路
-   物理地址 = 段地址*16 + 偏移地址//即段地址左移4位(2进制) 可以通过不同的段地址和偏移地址访问同一个内存地址



-   什么是 16 bit CPU：
-   运算器一次最多可以处理16bit
-   寄存器最大宽度为16bit(某些如状态寄存器不止16bit)
-   寄存器和运算器之间的通路是16bit
-   所有的内部寄存器、内部及外部数据总线都是16位宽






-   汇编不区分大小写 NASM区分大小写
-   汇编指令操作的范围大小(Byte,WORD,DWORD)由寄存器的大小决定
-   内存和寄存器之间传送字型数据时，高地址单元和高8位寄存器，低地址单元和低8位寄存器相对应



---

### 寄存器

-   通用寄存器以 X 结尾 AX BX CX DX
-   段寄存器 提供段地址段寄存器以 S 结尾 根据需要将一组内存定义为一个段(代码段/数据段...)
-   AX, BX, CX, DX,这四个寄存器可以按照字节访问；但BP, SI, DI, SP,这四个地址寄存器只能按照16bit访问
-   8086不支持将数据直接mov进段寄存器 数据→通用寄存器→段寄存器




1.  数据寄存器,一般称之为通用寄存器组 

     8086 有8个8位数据寄存器， 这些8位寄存器可分别组成16位寄存器： 
​     AH&AL＝AX：accumulator累加寄存器，常用于运算
​     BH&BL＝BX：base基址寄存器，常用于地址索引
​     CH&CL＝CX：counter计数寄存器，常用于计数
​     DH&DL＝DX：data数据寄存器，常用于数据传递

2.  地址寄存器/段地址寄存器

为了运用所有的内存空间，8086设定了四个段寄存器，专门用来保存段地址： 

- CS（Code Segment）：代码段寄存器，存放指令的段地址
- DS（Data Segment）：数据段寄存器，存放数据的段地址
- SS（Stack Segment）：堆栈段寄存器，存放栈顶的段地址
- ES（Extra Segment）：附加段寄存器(配合DI)

3.  特殊功能的寄存器 
- IP（Instruction Pointer）：指令指针寄存器，与CS配合使用，可跟踪程序的执行过
- SP（Stack Pointer）：堆栈指针，与SS配合使用，可指向目前的堆栈位置
- SI（Source Index）：源变址寄存器可用来存放相对于DS段之源变址指针
- BP（Base Pointer）：基址指针寄存器，可用作SS的一个相对基址位置
- DI（Destination Index）：目的变址寄存器，可用来存放相对于 ES 段之目的变址指针





```assembly
ADD CX, 0x1234; 编译成 81 C1 34 12 四字节命令
ADD AX, 0x1234; 编译成 05 34 12 三字节命令
```

X for extend  E for extend

EAX 32bit DWORD     RAX 64bit QWORD







###### CS:IP

CS:IP 用于指向代码段 决定从何处执行指令
- IP 指令指针寄存器，存放指令的偏移地址
- CS:IP 任何时候，指向当前指令的 段地址:偏移地址
- CPU将CS:IP中的内容当作指令的段地址和偏移地址，用他们合成指令的物理地址，到内存中读取指令码，执行

8086PC工作过程简要描述:CS:IP指向的内容当作指令执行

1. 从CS:IP指向的内存但愿读取指令，读取的指令进入指令缓冲器//CS:IP是表示内存单元(物理地址)的一种方法
2. IP=IP+所读取指令的长度，从而指向下一条指令//自动增加
3. 执行指令，转向步骤1重复执行

8086CPU加电启动或复位后，CS=FFFFH,IP=0000H
即8086PC机刚启动时，CPU从内存FFFF0H单元中读取指令执行

一段信息若被CPU执行过，则被CS:IP指向过

能用指令读写的部件只有寄存器，可以通过改变寄存器中的内容实现对CPU的控制



---


### 指令解析



jmp转移指令 同时修改CS.IP的内容 一个操作对象
功能1 用指令中给出的段地址修改CS 偏移地址修改IP
jmp 段地址:偏移地址	物理地址
jmp 2AE3:3		2AE33
jmp 3:0B16		0B46

功能2 用寄存器中的值修改IP 仅修改IP的内容
jmp 某一合法寄存器
jmp ax	//类似于mov IP,ax
jmp bx



###### DS:[address]

DS 和 [address] mov 传送指令 数据段
- DS data segment 数据段寄存器，存放数据的段地址
- 定义数据段 将一组长度为N(N<=64K)、地址连续、起始地址为16的倍数的内存单元当作专门存储数据的内存空间//2^16=64K
- mov 传送指令，可改变8086大部分寄存器的值。但不能用于设置CS,IP的值
- 机器码大小 mov ax,0 机器码为3字节
- mov 格式
- mov 寄存器,内存单元(可逆)mov 段寄存器,寄存器(可逆)
- mov 寄存器,数据
- mov 寄存器,寄存器
- [] 意义 [...]表示一个内存单元，[]中的数据表示内存单元的偏移地址
- 8086默认取DS中的数据为内存单元的段地址
- 将数据直接送入寄存器
- 将寄存器中的内容送入另一个寄存器
- 将内存单元中的内容送入一个寄存器
- warning不能直接mov ds,1000H.必须通过通用寄存器 注意传送的数据是1字节还是1字

```assembly
;读取10000H单元的内容并放到al中
;al = ax low,8bit,1B
mov bx,1000H ;将1000H写到bx寄存器
mov ds,bx ;将bx的内容复制到ds//ds不能直接mov
mov al,[0] ;将偏移地址为0的内存单元中的内容送入al，大小为1Byte，因al大小为1Byte
;段地址(1000H)已经存在了ds中，直接索引偏移地址[0]

;将寄存器al中的数据送入内存单元10000H
mov bx,1000H ;将1000H写到bx寄存器//默认存的是16bit
mov ds,bx ;将bx中存的数据1000H存到ds中//2字节
mov [0],al ;将al中存的1Byte数据存入1000:0中

```



```assembly
mov ax,18 ;将18送入AX中 AX=18
mov ax,bx ;将寄存器BX中的数据送入寄存器AX AX=BX
add ax,8 ;将寄存器AC中的数值加上8 AX=AX+8
add ax,bx ;将AX,BX中的内容相加，结果存在ax中 AX=AX+BX

```



###### SS:SP

-   栈 Stack SS:SP PUSH 入栈 POP 出栈
-   现今CPU都有栈的数据，可以将一段内存当作栈来使用
-   FILO First In Last Out 先进后出 LIFO Last In First Out 后进先出//栈操作以字为单位
-   栈的最底层对应高地址，最顶层对应低地址
-   SS: stack segment堆栈段寄存器，存放栈顶的段地址
-   SP: 堆栈指针寄存器，存放**栈顶的偏移地址**
-   SP初始值 SS:SP栈空时指向栈空间最高地址的下一个地址//指在栈外
-   栈顶变换范围 PUSH POP修改SP，故栈顶变换范围0~FFFFH//64K
-   SS:SP 任意时刻，指向栈顶元素，决定PUSH POP指令访问的内存单元的地址，栈空时指向栈外
-   push 入栈 push ax 将寄存器ax中的数据送入栈
-   pop 出栈 pop ax 从栈顶取出数据送入ax

````assembly
;PUSH 过程
;假设执行 push ax //注意ax为2Byte
SP = SP - 2	//注意一定是先减2
将ax的数据存入SS:SP	//POP则顺序相反，操作相反

;POP 过程
;假设执行 pop bx //注意bx为2Byte
将SS:SP的数据送入bx
SP = SP + 2	//PUSH POP均会改变SP
````

-   函数调用时，实际上是将主函数中的数据入栈(保存)，调用完后将出栈(恢复)


当栈空间为10000H ~ 1FFFFH 时
**栈空时，SP = 0000H**	
//因为第一个元素SP = FFFEH，pop后SP + 2 则SP = 0000H

```assembly
;push pop 语法	//8086入栈出栈操作以WORD字为单位进行
push [2]	//将ds:2内存单元处的字入栈//段地址在执行时从DS取得
push AX		//将AX寄存器的数据入栈
```






>栈顶越界 溢出攻击
>
>PUSH POP 超出了栈的范围
>
>栈外空间可能存放了其它用途的数据/代码等
>
>一直PUSH POP后，因为SS不变，SP则会循环





### NASM

-   NASM是一个为可移植性与模块化而设计的一个8086的汇编器。它支持相当多的目标文件格式包括linux和windows
-   nasm的内存引用规则，任何对内存中内容的存取操作必须要在地址上加方括号。但任何地址值的操作不需要


-   byte 8 bit
-   word 16 bit
-   dword 32 bit
-   qword 64  bit
-   tword 80 bit
-   oword 128 bit
-   yword 256 bit






**NASM中不被方括号[]括起来的标签或变量名都被认为是地址，访问标签中的内容必须使用[]**

要地址就不加[]，要地址中的内容就加[]，不必额外使用Offset

```assembly
mov ax,BootMessage;把"Hello, OS world!"字符串的首地址传给ax
foo dw 1;等同于 foo: dw 1     NASM中，变量和标签是一样的
mov ax, foo;把foo的地址传给ax
mov bx, [foo];把bx的值赋为1

```



###### stone.asm

```assembly
;本程序在文本方式显示器上从左边射出一个A号,以45度向右下运动，撞到边框后反射
; 凌应标 2014/3
; NASM汇编格式
    Dn_Rt equ 1 ;D-Down,U-Up,R-right,L-Left
    Up_Rt equ 2 ;equ用来为标识符定义一个整型常量 类似#define
    Up_Lt equ 3 ;
    Dn_Lt equ 4 ;
    delay equ 50000 ;计时器延迟计数,用于控制画框的速度
    ddelay equ 580 ;计时器延迟计数,用于控制画框的速度

    org 07c00h ;指示程序将要加载到内存的起始地址 主引导记录起始位置
start:;程序的开始
	mov ax,cs ;ax = cs
	mov es,ax ; ES = ax
	mov ds,ax ; DS = CS
	mov	ax,0B800h ; 文本窗口显存起始地址
	mov	gs,ax ; GS = B800h 定位到文本显存段
    mov byte[char],'A'
loop1:
	;双重循环实现sleep
	dec word[count] ; 递减计数变量50000初始
	jnz loop1 ; 如果0标志没有置位则跳转;0标志被置位时，则该指令不跳转
	mov word[count],delay;恢复count的初始值
	dec word[dcount] ; dcount递减计数变量;初始为580
    jnz loop1;如果0标志没有置位则跳转
	mov word[count],delay
	mov word[dcount],ddelay
	;sleep结束
	
      mov al,1
      cmp al,byte[direction]
	jz  DnRt;如果0标志被置位则跳转
      mov al,2
      cmp al,byte[direction]
	jz  UpRt
      mov al,3
      cmp al,byte[direction]
	jz  UpLt
      mov al,4
      cmp al,byte[direction]
	jz  DnLt
      jmp $	;无限循环

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dr2ur
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  dr2dl
	jmp show
dr2ur:
      mov word[x],23
      mov byte[direction],Up_Rt	
      jmp show
dr2dl:
      mov word[y],78
      mov byte[direction],Dn_Lt	
      jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,80
	sub ax,bx
      jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ur2dr
	jmp show
ur2ul:
      mov word[y],78
      mov byte[direction],Up_Lt	
      jmp show
ur2dr:
      mov word[x],1
      mov byte[direction],Dn_Rt	
      jmp show

	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
      jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  ul2ur
	jmp show

ul2dl:
      mov word[x],1
      mov byte[direction],Dn_Lt	
      jmp show
ul2ur:
      mov word[y],1
      mov byte[direction],Up_Rt	
      jmp show

	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
      jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
      jz  dl2ul
	jmp show

dl2dr:
      mov word[y],1
      mov byte[direction],Dn_Rt	
      jmp show
	
dl2ul:
      mov word[x],23
      mov byte[direction],Up_Lt	
      jmp show
	
show:	
    mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2
	mul bx
	mov bp,ax
	mov ah,0Fh ;  0000：黑底、1111：亮白字（默认值为07h）
	mov al,byte[char] ;  AL = 显示字符值（默认值为20h=空格符）
	mov word[gs:bp],ax ;gs:bp 指向文本显示方式的地址
	jmp loop1
	
end:
    jmp $ ; 不断跳转到当前位置，是个死循环
	
datadef:	
    count dw delay ; dw define word 
    dcount dw ddelay
    direction db Up_Lt ; db define byte 定义初化常量?
    x    dw 7
    y    dw 0
    char db 'A'

times 510 - ($ - $$) db 0 ;填充0
dw 0xAA55;== db 0x55,0xaa
```








### 汇编指令





###### mul imul 乘指令

-   mul 无符号乘法指令
-   三种格式:将8位的操作数于al相乘; 将16位的操作数与ax相乘; 将32位的操作数与eax相乘
-   乘数和被乘数大小必须相同，乘积的尺寸是乘数/被乘数大小的两倍
-   三种格式都既接受寄存器操作数，也接受内存操作数。但是不接受立即操作数
-   imul 有符号整数的乘法运算

```assembly
mov ax, 6000 
mov bx, 5000 
mul bx;检查进位标志得cf = 1,所以结果是dx:ax ，此时dx = 1E00, ax = 0000
;所以 最后积为1E000000
```







###### 跳转指令





















###### test

-   test命令将两个操作数进行逻辑与运算，并根据运算结果设置相关的标志位
-   但是，test命令的两个操作数不会被改变。运算结果在设置过相关标记位后会被丢弃

将两个操作数进行按位AND,设结果是TEMP
SF = 将结果的最高位赋给SF标志位，例如结果最高位是1，SF就是1
　　
看TEMP是不是0
如果TEMP是0，ZF位置1
如果TEMP不是0，ZF位置0

```assembly
;测试一寄存器是否为空
test al, al;al不为空时，ZF被置0
jz .2;ZF为0时跳转
```





###### lds

```assembly
LDS DI,[BX];功能是把BX所指的32位地址指针的段地址送入DS,偏移地址送入DI
```





---

# MIPS体系结构

- ISA(Instruction Set Architecture，指令集体系结构)是计算机硬件与底层软件之间的接口，它是程序员为使一个二进制机器语言程序正确运行所需要了解的属性
- 指令集是存储在CPU内部，对CPU运算进行指导和优化的硬程序。拥有这些指令集，CPU就可以更高效地运行
- 指令集，就是用来计算和控制计算机系统的一套命令的集合，而每一种新型的处理器在设计时就规定了一系列与硬件电路相配合的指令系统
- 用助记符表示指令，助记符形式的指令的集合组成了汇编语言
- 汇编语言的助记符形式的指令必须翻译成机器语言二进制指令才能在计算机上执行，实现这种翻译的程序称为汇编器(assembler)
- RISC的杰出代表有ARM、POWERPC、MIPS
- CISC的处理器大家天天用，intel＆amd的x86
- MIPS:无内部互锁流水级的微处理器









### 寄存器

MIPS下一共有32个通用寄存器，在汇编中，寄存器标志由\$符开头

直接使用该寄存器对应的编号，例如：从$0到$31 ，使用对应的寄存器名称，例如：\$t1, \$sp

|   0   | zero   | the value 0永远返回零                                        |
| :---: | :------ | :----------------------------------------------------------- |
|   1   | at     | (**a**ssembler **t**emporary)用做汇编器的临时变量（不可做其他用途） |
|  2-3  | v0-v1 | (**v**alues)用于过程调用时返回结果                           |
|  4-7  | a0-a3 | (**a**rguments)用于过程调用时传递参数                        |
| 8-15  | t0-t7 | (**t**emporaries)临时寄存器，在过程调用中被调用者不需要保存与恢复 |
| 16-23 | s0-s7 | (**s**aved values)保存寄存器。在过程调用中被调用者一旦使用这些寄存器时，必须负责保存和恢复这些寄存器的原值 |
| 24-25 | t8-t9 | (**t**emporaries) 算是前面0\~7的一个继续，属性同t0\~t7   |
| 26-27 | k0-k1 | (brea**k** off)通常被中断或异常处理程序使用，用来保存一些系统参数 |
|  28   | gp     | 全局指针**g**lobal **p**ointer 一些运行系统维护这个指针更方便的存取静态(static)/外部(extern)变量 |
|  29   | $sp     | 堆栈指针 **s**tack **p**ointer                               |
|  30   | s8/fp | 帧指针 **f**rame **p**ointer                                 |
|  31   | ra     | **r**eturn **a**ddress 返回地址                              |

MIPS CPU的一次操作可加载或存储1到8个字节的数据

寄存器为什么只有32个？因为电信号传输距离越远，传输时间就越长，寄存器太多将会延长时钟周期

MIPS中字的地址必须是4的倍数 //存储器对齐限制



| 名称          | 实例                  | 注释                                                         |
| ------------- | --------------------- | ------------------------------------------------------------ |
| 32个寄存器    | s0 \~ s7 t0\~t7   | 数据的快速定位，算术运算指令的操作数必须在寄存器中           |
| 2^30^个存储字 | 存储器[1]…存储器[230] | MIPS只能使用数据传送指令访问MIPS中使用字寻址，相邻数据字的字地址相差4 |



### 字节序

**字节顺序**，又称**端序**或**尾序**（英语：**Endianness**）。在计算机科学领域中，是跨越多字节的程序对象的存储规则

如果最低有效位在最高有效位的前面，则称**小端序**；反之则称**大端序**

> 例如一个类型为`int`的变量`x`地址为`0x100`,十六进制值为`0x01234567`地址范围为`0x100~0x103`字节
>
> 大端序：0x100: 01, 0x101: 23, 0x102: 45, 0x103: 67
>
> 小端序：0x100: 67, 0x101: 45, 0x102: 23, 0x103: 01

- x86、MOS Technology 6502、Z80、VAX、PDP-11等处理器为小端序；
- Motorola 6800、Motorola 68000、PowerPC 970、System/370、SPARC（除V9外）等处理器为大端序；
- ARM、PowerPC（除PowerPC 970外）、DEC Alpha、SPARC V9、MIPS、PA-RISC及IA64的字节序是可配置的

网络传输一般采用大端序，也被称之为**网络字节序**，或**网络序**。IP协议中定义大端序为网络字节序







------

# MIPS 汇编

所有的MIPS指令都是32位长

只有装入lw（从内存中读出数据）和存储sw （写入内存中）指令实现对内存的访问

存储器寻址方式： c(\$rx) 寄存器rx的地址值+立即数c

MIPS算术运算指令的操作数必须从32个32位寄存器中选取



### 程序结构

- 数据声明+普通文本+程序编码(文件后缀为.s，或者.asm也行)
- 数据段以 .data为开始标志
- 代码段以 .text为开始标志 程序入口为**main**：标志

```assembly
.data # 数据声明部分
# ... 变量类型：
# 字符串：
# .ascii string
# .asciiz string ；以空字符null 结束
# 字类型：
# .word w1,w2,... ;32 位，4 个字节
# 半字类型：
# .half h1,h2,... ; 16 位，2 个字节
# 字节类型：
# .byte b1,b2,... ; 8 位，1 个字节
# 浮点数类型：
# .float f1,f2,... ; 32 位，4 个字节
# 双精度浮点数：
# .double d1,d2,... ; 64 位，8 个字节
# 空格符：
# .space n ; 8 位，1 个字节。n 个字节空间
.text # 代码声明部分
.globl main # 定义main 为全程量
main: #主程序名称main，以下为程序代码部分
# 编写的MIPS 汇编语言程序是MIPS 指令和伪指令的组合。
# 伪指令（pseudo instructions）是为了编程方便而对指令集进行的扩展。
# 程序结束
```



数据声明

```assembly
name: storage_type	value(s)#变量名：（冒号别少了）  数据类型      变量值
var1: .word 3 #声明一个 word 类型的变量 var1, 同时给其赋值为 3
array1: .byte  'a','b'# 声明一个存储2个字符的数组 array1，并赋值 'a', 'b'
array2: .space 40 # 为变量 array2 分配 40字节（bytes)未使用的连续空间
```



### MIPS 指令系统

MIPS一个字为4字节

1. 数据处理类（算术/逻辑运算指令）
2. 数据传送类（装入/存储指令）
3. 控制类（分支与跳转指令）



虽然MIPS有32个通用寄存器，但是在某些情况下(例如子程序调用)仍然需要将寄存器的内容换出到内存中，在这种情形下，栈是保存寄存器内容的理想场所
MIPS有一个$sp寄存器可以用做栈指针
将数据放入栈中称为压栈(PUSH)，从栈中取出数据称为出栈(POP)

```assembly
#算术运算指令
add $t0,$t1,$t2 # $t0 = $t1 + $t2
sub $t2,$t3,$t4 # $t2 = $t3 - $t4
addi $t2,$t3, 5 # $t2 = $t3 + 5

#逻辑运算指令
and $t0,$t1,$t2 # $t0 = $t1 & $t2
or $t0,$t1,$t2 # $t0 = $t1 | $t2
xor $t0,$t1,$t2 # $t0 = $t1  $t2
nor $t0,$t1,$t2 # $t0 = ~($t1 | $t2)

#移位运算，移位量为立即数
sll $t0, $t1, 10 # $t0 = $t1 << 10， shift left logical
srl $t0, $t1, 10 # $t0 = $t1 >> 10， shift right logical
sra $t0, $t1, 10 # $t0 = $t1 >> 10， shift right arithm

#移位运算，移位量在某个寄存器
sllv $t0, $t1, $t3 # $t0 = $t1 << ($t3%32)
srlv $t0, $t1, $t3 # $t0 = $t1 >> ($t3%32)
srav $t0, $t1, $t3 # $t0 = $t1 >> ($t3%32)

#立即数逻辑运算
andi $t0,$t1,10
ori $t0,$t1,10
xori $t0,$t1,10

#比较指令
slt $t1,$t2,$t3 # if ($t2 < $t3) $t1=1; # else $t1=0
sltu $t1,$t2,$t3 # 无符号比较
slti $t1,$t2,10 # 与立即数比较
sltui $t1,$t2,10 # 与无符号立即数比较

#装入/存储指令 #实现内存与寄存器之间的数据传送
#MIPS只支持基址(变址)+位移量的内存寻址方式
#存放基址的寄存器称为基址寄存器，指令中的常量称为位移量
lw $t1, 32($t2) #Load word #
sw $t3, 500($t4) #Store word # [t4+500]←$t3


lui $t1, 30 #装入高位立即数(load upper immediate)
```



```assembly
#栈操作
#例，将$s1、 $s2、$s3寄存器的内容压入栈
addi $sp, $sp, -12 #堆栈指针sp向低地址移动12B #栈按照从高到到低的地址顺序增长
sw $s1, 8($sp)
sw $s2, 4($sp)
sw $s3, 0($sp)
```

![](http://op4fcrj8y.bkt.clouddn.com/17-10-15/81968243.jpg)

![](http://op4fcrj8y.bkt.clouddn.com/17-10-15/21097606.jpg)

![](http://op4fcrj8y.bkt.clouddn.com/17-10-15/47358550.jpg)



```assembly
#分支(branch)指令
beq $t0, $t1, Target #如果$t0=$t1，则分支执
#行标号为Target的指令
bne $t0, $t1, Target #如果$t0!=$t1，则分支执
#行标号为Target的指令
```

分支指令与比较指令相结合，可以实现各种条件分支：相等、不等、小于、小于或等于、大于、大于或等于

```assembly
#跳转(jump)指令
j Lable #无条件跳转到标号Lable处无条件分支
```



MIPS的过程调用遵循如下约定：
–通过\$a0～\$a3四个参数寄存器传递参数
–通过\$v0～\$v1两个返回值寄存器传递返回值
–通过\$ra寄存器保存返回地址
•子程序调用通过跳转与链接指令jal进行
jal Procedure # 将返回地址保存在\$ra寄存器中 # 程序跳转到过程Procedure处执行
•子程序返回通过寄存器跳转指令jr进行
jr $ra # 跳转到寄存器指定的地址





### demo

```assembly
#把一个32位长的常数装入寄存器$s0中
#0000 0000 0011 1101 0000 1001 0000 0000
#                61                 2304
#Lui  ==  Load Upper Immediate
Lui $ s0, 61 # $ s0= 0000 0000 0011 1101 0000 0000 0000 0000
addi $ s0, $s0, 2340 # $ s0= 0000 0000 0011 1101 0000 1001 0000 0000
```

```assembly
#将32位立即数0x1234abcd装入$t1寄存器
lui $t1, 0x1234 #装入高位立即数(load upper immediate)
ori $t1, $t1, 0xabcd #立即数的or
```

```c++
unsigned int i, j;//假设变量f、g、h 、i、j分配给寄存器$s0~$s4
if(i <= j)
f = g + h;
else
f = g - h;
```

```assembly
sltu $t2, $s4, $s3 #无符号数比较
beq $t2, $zero, Else
sub $s0, $s1, $s2
j Exit
Else: add $s0, $s1, $s2
Exit: …
```





---

# C与汇编混合编程





###### C函数传参/栈帧

-   C函数传参时，参数从右向左依次push，最后push返回地址，而后的栈由被调用者生成

![](http://op4fcrj8y.bkt.clouddn.com/18-5-16/52320076.jpg)





### TCC & TASM

```c
//TCC编译命令
tcc -mt -c –oupper.obj upper.c >ccmsg.txt//attention: -oupper.obj o和后面连起来
//[>ccmsg.txt]编译输出重定向到ccmsg.txt//实际可去除 不影响编译

//TASM汇编命令
tasm showstr.asm  showstr.obj  > amsg.txt//编译输出重定向到amsg.txt

//链接命令
tlink /3 /t showstr.obj upper.obj , showstr.com,,//注意字符,
```





# 分时系统



```assembly
ds_save dw ?
ret_save dw ?
si_save dw ?
kernelsp dw ?	
public save
save proc
	push ds
	push cs
	pop ds
	pop word ptr [ds_save]
	pop word ptr [ret_save]
	mov word ptr[si_save],si
	mov si,word ptr [_CurrentProc]
	add si,22
	pop word ptr [si]
	add si,2
	pop word ptr [si]
	add si,2
	pop word ptr [si]
	mov word ptr [si-6],sp
	mov word ptr [si-8], ss
	mov si,ds
	mov ss,si
	mov ss,si
	mov sp,word ptr [_CurrentProc]
	add sp,18
	push word ptr[ds_save]
	push es
	push bp
	push di
	push word ptr[si_save]
	push dx
	push cx
	push bx
	push ax
	mov sp,word ptr[kernelsp]
	mov ax,word ptr [ret_save]
	jmp ax
save endp

```



---

# 未经整理

以下部分未经整理 是以前的笔记




编写→编译连接→执行可执行文件中的程序

MASN.exe对源程序文件程序进行编译，产生obj文件

连接程序LINK.exe对目标文件进行连接

 

【汇编程序的段】	一个汇编程序由多个段组成，用来存放代码，数据或栈


- 编译 伪指令 汇编指令转换成机器码
- 连接 多个源程序文件，每个源程序编译成为目标文件后，再用连接程序将它们连接到一起
  调用库文件中的子程序，需要把库文件和该程序生成的目标文件连接到一起


```assembly
;MASM 格式
assume cs:codesg//cs代码段寄存器与codesg关联

codesg segment	//codesg是一个段的名称

start:	mov ax,0123H	//start只是一个标记，end时相对应即可
mov bx, 0456H
add ax, bx
add ax, ax
	
	mov ax,4c00H	//以下两条实现程序返回
	int 21H		//中断，属于汇编指令
codesg ends
end start
```

- 定义一个段 segment和ends是一对成对使用的伪指令
  abc segment//abc是一个标号
  abc ends
- 标号 一个标号指代一个地址，放在segment前，最终被编译链接成一个段的段地址

- assume 假设，寄存器与段的关联假设
- end 汇编程序结束标记
- DOS系统 单任务操作系统
  - 系统返回 mov ax,4c00H+     int 21H	

编译链接 demo
cd 文件夹
masm 1.asm	//saaembling 1.asm 成功编译
link 1.obj	//链接，生成1.exe


简化方式编译连接
masm 1.asm;
link 1.obj;

ml 1.asm //Masm + Link

debug 1.exe↙ // debug 下运行1.exe
r //查看各寄存器信息
可以发现 CX 存放可执行文件的长度
程序加载后，DS存放程序所在内存区的段地址，偏移地址为 0，程序所在的内存区的地址为 DS:0
CS比DS大10H(算上地址偏移，则相差0x100bytes，256bytes)
创建PSP，段空间，DOS要利用PSP来和被加载程序进行通信
空闲内存区	SA:0
PSP区		SA:0 //程序与操作系统通信
程序区		SA+10H:0 //为和PSP段区分，段地址不一样(实质上是两个不同的段)
CS:IP		SA+10H:XXXXH //一开始CS:IP指向SA+10H:0
//attention: PSP区和程序区虽然物理地址连续，却有不同的段地址

u 13eb:0 //查看13eb0H地址附近的反汇编代码
U //查看CS:IP指向的内存区域的指令
int 21 需要P命令执行!!	//否则将跳转掉乱七八糟的地方
int 21 执行后，显示"Program terminated normally"，返回到debug中

q //退出 debug





---

# 保护模式 protected-mode

-   CPU启动环境为16位实模式，之后可以切换到保护模式。但从保护模式无法切换回实模式
-   保护模式同实模式的根本区别是**进程内存受保护与否**



-   从80386开始，CPU有三种工作方式：**实模式**，**保护模式**和**虚拟8086模式**
-   只有在刚刚启动的时候是real-mode，等到操作系统运行起来以后就切换到protected-mode
-   实模式只能访问地址在1M以下的内存称为常规内存，我们把地址在1M 以上的内存称为扩展内存。在保护模式下，全部32条地址线有效，可寻址高达4G字节的物理地址空间; 扩充的存储器分段管理机制和可选的存储器分页管理机制，不仅为存储器共享和保护提供了硬件支持，而且为实现虚拟存储器提供了硬件支持; 支持多任务，能够快速地进行任务切换(switch)和保护任务环境(context); 4个特权级和完善的特权检查机制，既能实现资源共享又能保证代码和数据的安全和保密及任务的隔离; 支持虚拟8086方式，便于执行8086程序





---

# DOSBox

```c
mount c f:new//将f:new挂载到doxbox里面的c盘中
```







```c
命令提示符中的 debug模式win10环境下利用DOSBox运行debug
Program Files (x86)\DOSBox-0.74\Documentation README有提示
warning debug模式下默认使用16进制
输入以下进入debug模式
mount c c:\
c:

debug	//进入debug模式
r	查看各寄存器信息
r cs	查看cs的值并改变
a 2000:0	进入汇编状态，段地址2000，基地址0//可不加
q	退出debug模式
t	单步执行并查看各寄存器信息
d 地址	查看该地址的16进制数

--- e.g.
a 2000:0	从2000:0000的地址开始写汇编代码
mov ax,333	
add ax,ax
jmp 2000:3
r cs 回车2000	修改cs的值为2000
r ip 回车0	修改ip的值为0

--- e.g.
d fff0:0 ff	//查看FFF00H~FFFFFH的内容
e fff:05↙ 30.48	往内存中写数据//30是原来的数据，48是写入后的
e b810:0 01 01 02 02 03 03 04 04//往显存中直接写数据

-   命令提示符的相关操作
    -   cls	//清屏//清除屏幕
    -   cd try↙//打开trt文件夹
-   D:\TRY abc.exe↙//执行可执行文件abc.exe
-   dir//查看文件夹内的文件
```



