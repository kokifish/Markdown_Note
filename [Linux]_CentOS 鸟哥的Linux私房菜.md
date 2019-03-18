[TOC]



CentOS://VMware workstation
df911863 //root
897410 //tea

读书笔记 : 鸟哥的Linux私房菜 基础学习篇 第四版.pdf

所记录页码均为vbird-linux-basic-4e.pdf文件的对应页码

- 进度记录: p243 7.16



---

# 第零章 计算机概论

字组大小 word size 依据CPU设计有32位与64位

组合语言（Assembly Language）

得利于北桥整合到 CPU 内部的设计，CPU 得以“个别”跟各个元件进行沟通！因此，每
种元件与 CPU 的沟通具有很多不同的方式！如内存使用系统总线带宽来与 CPU 沟通。而
显卡则通过PCI-E的序列信道设计来与CPU沟通！



超线程 （Hyper-Threading, HT）

在每一个CPU内部将重要的寄存器 （register） 分成两群， 而让程序分别使用这两群寄存器



多通道设计
由于所有的数据都必须要存放在内存，所以内存的数据宽度当然是越大越好。 但传统的总线
宽度一般大约仅达64位，为了要加大这个宽度，因此芯片组厂商就将两个内存汇整在一起，
如果一支内存可达64位，两支内存就可以达到128位了，这就是双通道的设计理念。

### CMOS BIOS firmware 

CMOS是记录各项硬件参数且嵌入在主板上面的储存器，BIOS则是一个写入到主板上的一个固件

BIOS（Basic Input Output System）是一套程序，这套程序是写死到主板上面的一个内存芯片中， 这个内存芯片在没有通电时也能够将数据记录下来，那就是只读存储器(Read Only Memory, ROM) 系统在开机的时候首先会去读取的一个小程序

固件（firmware）很多也是使用ROM来进行软件的写入的。 固件像软件一样也是一个被电脑所执行的程序，然而他是对于硬件内部而言更加重要的部分。例如BIOS就是一个固件， BIOS虽然对于我们日常操作电脑系统没有什么太大的关系，但是他却控制着开机时各项硬件参数的取得！ 所以我们会知道很多的硬件上头都会有ROM来写入固件这个软件。

固件就是写入到硬件上的一个软件程序

显卡又称为VGA（Video Graphics Array） 一般对于图形影像的显示重点在于分辨率与色彩深度，因为每个图像显示的颜色会占用掉内存， 因此显卡上面会有一个内存的容量，这个显存容量将会影响到你的屏幕分辨率与色彩深度的喔！

磁盘(Hard Disk Drive, HDD), 固态硬盘(Solid State Disk 或 Solid State Driver, SSD)

每秒读写操作次数（Input/Output Operations Per Second, IOPS）！这个数值越大，代表可操作次数较高



IRQ中断（Interrupt）



CMOS主要的功能为记录主板上面的重要参数， 包括系统时间、CPU电压与频率、各项设备的I/O位址与IRQ等，由于这些数据的记录要花费电力，因此主板上面才有电池

BIOS为写入到主板上某一块 flash 或 EEPROM 的程序，他可以在开机的时候执行，以载入CMOS当中的参数， 并尝试调用储存设备中的开机程序，进一步进入操作系统当中。BIOS程序也可以修改CMOS中的数据， 每种主板调用BIOS设置程序的按键都不同，一般台式机常见的是使用[del]按键进入BIOS设置画面



为克服硬件方面老是需要重复撰写控制码的问题，所以就有操作系统（Operating System, OS）

操作系统（Operating System, OS）其实也是一组程序， 这组程序的重点在于管理电脑的所
有活动以及驱动系统中的所有硬件



系统调用（System Call）

操作系统通常会提供一整组的开发接口给工程师来开发软件！ 工程师只要遵守该开发接口那就很容易开发软件了！举例来说，我们学习C程序语言只要参考C程序语言的函数即可， 不需要再去考虑其他核心的相关功能，因为核心的系统调用接口会主动的将C程序语言的相关语法转成核心可以了解的任务函数， 那核心自然就能够顺利运行该程序了！

为了保护核心，并且让程序设计师比较容易开发软件，因此操作系统除了核心程序之外，通
常还会提供一整组开发接口， 那就是系统调用层







![](http://op4fcrj8y.bkt.clouddn.com/17-7-14/85386291.jpg)



操作系统必须要能够驱动硬件，如此应用程序才能够使用该硬件功能
一般来说，操作系统会提供开发接口，让开发商制作他们的驱动程序
要使用新硬件功能，必须要安装厂商提供的驱动程序才行
驱动程序是由厂商提供的，与操作系统开发者无关



新的 CPU 设计中，已经将北桥的内存控制芯片整合到 CPU 内，而 CPU 与内存、显卡
沟通的总线通常称为系统总线。 南桥就是所谓的输入输出（I/O）总线，主要在联系硬
盘、USB、网卡等周边设备；



---

# 第一章 Linux是什么与如何学习





GNU C Compiler（gcc）

自由软件基金会（FSF, Free Software Foundation

图形使用者接口（Graphical User Interface, GUI）

“Kernel + Softwares + Tools + 可完整安装程序”的咚咚，我们称之为Linux distribution， 一般中文翻译成可完整安装套件，或者Linux发布商套件等

![](http://op4fcrj8y.bkt.clouddn.com/17-7-14/8161740.jpg)





大型网际网络供应商 （ISP）

“虚拟化”指的是：在一部实体主机上面仿真出多个逻辑上完全独立的硬件，这个
假的虚拟出来的硬件主机，可以用来安装一部逻辑上完全独立的操作系统！ 因此，通过虚拟
化技术，你可以将一部实体主机安装多个同时运行的操作系统 （非多重开机），以达到将硬
件资源完整利用的效果。 很多 ISP 就是通过贩售这个虚拟机的使用权来赚钱的喔！

















---

# 第二章 主机规划与磁盘分区

Linux对于计算机各元件/设备的分辨， 与大家惯用的Windows系统完全不一样！因为，各个元件或设备在Linux下面都是“一个文件”

SATA接口的硬盘的文件名称即为/dev/sd[a-d]，其中， 括号内的字母为a-d当中的任意一个，
亦即有/dev/sda, /dev/sdb, /dev/sdc, 及 /dev/sdd这四个文件的意思



###### Linux中的设备文件名

![](http://op4fcrj8y.bkt.clouddn.com/17-7-15/65809024.jpg)

> p128 https://www.kernel.org/doc/Documentation/devices.txt



## 2.2 磁盘分区





### 2.2.2 MSDOS(MBR) & GPT

![](http://op4fcrj8y.bkt.clouddn.com/17-7-15/50888194.jpg)



所有盘片的同一个磁道我们称为柱面 （Cylinder）通常那是文件系统的最小单位，也就是分区的最小单位

近来有 GPT 这个可达到 64bit 纪录功能的分区表， 现在甚至可以使用扇区 （sector） 号码来作为分区单位//GUID

早期磁盘第一个扇区里面含有的重要信息我们称为MBR (Master Boot Record) 格式。早期的 Linux 系统为了相容于 Windows 的磁盘，因此使用的是支持 Windows 的MBR（Master Boot Record, 主要开机纪录区） 的方式来处理开机管理程序与分区表

开机管理程序纪录区与分区表则通通放在磁盘的第一个扇区， 这个扇区通常是 512Bytes 的大小 （旧的磁盘扇区都是 512Bytes），第一个扇区 512Bytes 会有这两个数据：
主要开机记录区（Master Boot Record, MBR）：可以安装开机管理程序的地方，有446 Bytes
分区表（partition table）：记录整颗硬盘分区的状态，有64 Bytes

由于分区表所在区块仅有64 Bytes容量，因此最多仅能有四组记录区，每组记录区记录了该区段的启始与结束的柱面号码。四个分区的记录被称为主要（Primary）或延伸（Extended）分区

所谓的“分区”只是针对64 Bytes的分区表进行设置

硬盘默认的分区表仅能写入四组分区信息

当系统要写入磁盘时，一定会参考磁盘分区表，才能针对某个分区进行数据的处理

![](http://op4fcrj8y.bkt.clouddn.com/17-7-15/59122495.jpg)

假设上面的硬盘设备文件名为/dev/sda时，那么这四个分区在Linux系统中的设备文件名如下:
P1:/dev/sda1 //文件名后面会再接一个数字，这个数字与该分区所在的位置有关
P2:/dev/sda2
P3:/dev/sda3
P4:/dev/sda4

//1-4是保留给Primary或Extended用的，逻辑分区的设备名称将从5开始

> 在Windows/Linux系统中， 通过延伸分区（Extended）的方式，用额外的扇区来记录更多的分区信息，以达到分配更多分区的目的
>
> http://en.wikipedia.org/wiki/Extended_boot_record

延伸分区最多只能有一个（操作系统的限制）

逻辑分区是由延伸分区持续切割出来的分区

能够被格式化后，作为数据存取的分区为主要分区与逻辑分区。延伸分区无法格式化

逻辑分区的数量依操作系统而不同，在Linux系统中SATA硬盘已经可以突破63个以上的分区限制





由于第一个扇区所记录的分区表与MBR很重要，几乎只要读取硬盘都会先由这个扇区先读起。 因此，如果整颗硬盘的第一个扇区（就是MBR与partition table所在的扇区）物理实体坏掉了，那这个硬盘大概就没有用了



考虑到磁盘的连续性，一般建议将Extended的柱面号码分配在最后面的柱面内

![](http://op4fcrj8y.bkt.clouddn.com/17-7-15/78989848.jpg)



由于每组分区表仅有16Bytes:

- 操作系统无法抓取到 2.2T 以上的磁盘容量
- MBR 仅有一个区块，若被破坏后，经常无法或很难救援
- MBR 内的存放开机管理程序的区块仅 446Bytes，无法容纳较多的程序码




GUID partition table, GPT 磁盘分区表

GPT 分区已经没有延伸与逻辑分区的概念，你可以想像成所有的分区都是主分区

为了相容于所有的磁盘，因此在扇区的定义上面， 大多会使用所谓的逻辑区块位址（Logical Block Address, LBA）来处理。GPT 将磁盘所有区块以此 LBA（默认为 512Bytes 喔！） 来规划，而第一个 LBA 称为 LBA0 （从 0 开始编号

与 MBR 仅使用第一个 512Bytes 区块来纪录不同， GPT 使用了 34 个 LBA 区块来纪录分区信息。与过去 MBR 仅有一的区块不同， GPT 除了前面 34 个LBA 之外，整个磁盘的最后 33 个 LBA 也拿来作为另一个备份

![](http://op4fcrj8y.bkt.clouddn.com/17-7-15/50620912.jpg)

- LBA0 （MBR 相容区块）

与 MBR 模式相似的，这个相容区块也分为两个部份，一个就是跟之前 446 Bytes 相似的区块，储存了第一阶段的开机管理程序！ 而在原本的分区表的纪录区内，这个相容模式仅放入一个特殊标志的分区，用来表示此磁盘为 GPT 格式之意。而不懂 GPT 分区表的磁盘管理程序， 就不会认识这颗磁盘，除非用户有特别要求要处理这颗磁盘，否则该管理软件不能修改此分区信息，进一步保护了此磁盘

- LBA1 （GPT 表头纪录）

这个部份纪录了分区表本身的位置与大小，同时纪录了备份用的 GPT 分区 （最后 34 个 LBA 区块） 放置的位置， 同时放置了分区表的检验机制码（CRC32），操作系统可以根据这个检验码来判断 GPT 是否正确。若有错误，还可以通过这个纪录区来取得备份的 GPT（磁盘最后的那个备份区块） 来恢复 GPT 的正常运行！

- LBA2-33 （实际纪录分区信息处）

从 LBA2 区块开始，每个 LBA 都可以纪录 4 笔分区纪录，所以在默认的情况下，总共可以有 4 \* 32 = 128 笔分区纪录喔！因为每个 LBA 有 512Bytes，因此每笔纪录用到 128Bytes 的空间，除了每笔纪录所需要的识别码与相关的纪录之外，GPT 在每笔纪录中分别提供了 64bits 来记载开始/结束的扇区号码，因此，GPT 分区表对於单一分区来说，他的最大容量限制就会在 264 512Bytes = 263 1KBytes = 233TB = 8 ZB， 1ZB = 230TB



Linux 本身的核心设备纪录中，单一磁盘过去最多只能到达 15 个分区，由于 Linux kernel 通过 udev 等方式的处理，现在 Linux 也已经没有这个限制。GPT 分区已经没有所谓的主、延伸、逻辑分区的概念，每笔纪录都可以独立存在， 每个都可以视为是主分区！每一个分区都可以拿来格式化使用



### 2.2.3 BIOS 与 UEFI 开机检测程序

目前的主机系统在载入硬件驱动方面的程序，主要有早期的 BIOS 与新的 UEFI 两种机制



BIOS会去分析计算机里面有哪些储存设备，以硬盘为例，BIOS会依据使用者的设置去取得能够开机的硬盘， 并且到该硬盘里面去读取第一个扇区的MBR位置。 MBR这个仅有446 Bytes的硬盘容量里面会放置最基本的开机管理程序，接下来则交给是MBR内的开机管理程序

开机管理程序的目的是在载入（load）核心文件。由于开机管理程序是操作系统在安装的时候所提供的，所以会认识硬盘内的文件系统格式，因此就能够读取核心文件， 然后接下来就是核心文件的工作，开机管理程序与 BIOS 也功成圆满，将之后的工作就交给操作系统

1. BIOS：开机主动执行的固件，会认识第一个可开机的设备
2. MBR：第一个可开机设备的第一个扇区内的主要开机记录区块，内含开机管理程序
3. 开机管理程序(boot loader)：一支可读取核心文件来执行的软件
4. 核心文件：开始操作系统的功能

如果分区表为 GPT 格式的话，那么 BIOS 也能够从 LBA0 的 MBR 相容区块读取第一阶段的开机管理程序码， 如果开机管理程序能够认识 GPT 的话，那么使用BIOS 同样可以读取到正确的操作系统核心。例如 Windows XP 的环境，无法读取核心文件，开机就失败了

由于 LBA0 仅提供第一阶段的开机管理程序码，因此如果你使用类似 grub 的开机管理程
序的话，那么就得要额外分区出一个“ BIOS boot ”的分区， 这个分区才能够放置其他开机过
程所需的程序码！在 CentOS 当中，这个分区通常占用 2MB 左右



开机管理程序boot loader的主要任务:

1. 提供菜单：使用者可以选择不同的开机项目，这也是多重开机的重要功能
2. 载入核心文件：直接指向可开机的程序区段来开始操作系统
3. 转交其他loader：将开机管理功能转交给其他loader负责

开机管理程序除了可以安装在MBR之外， 还可以安装在每个分区的开机扇区（boot sector）

如果一个硬盘有四个分区，第一第二为win和Linux，开机流程如下图(MBR内为可同时认识Windows / Linux操作系统的开机管理程序)

![](http://op4fcrj8y.bkt.clouddn.com/17-7-16/34880007.jpg)

每个分区都拥有自己的开机扇区（boot sector）
图中的系统盘为第一及第二分区
实际可开机的核心文件是放置到各分区内的
loader只会认识自己的系统盘内的可开机核心文件，以及其他loader而已
loader可直接指向或者是间接将管理权转交给另一个管理程序

如果要安装多重开机， 最好先安装Windows再安装Linux:

Linux在安装的时候，你可以选择将开机管理程序安装在MBR或各别分区的开机扇区， 而且Linux的loader可以手动设置菜单（就是上图的M1, M2...），所以你可以在Linux的boot loader里面加入Windows开机的选项；
Windows在安装的时候，他的安装程序会主动的覆盖掉MBR以及自己所在分区的开机扇区，且没有选择菜单的功能





UEFI BIOS 搭配 GPT 开机的流程

Unified Extensible Firmware Interface 统一可延伸固件界面(UEFI可被称作UEFI BIOS)

UEFI 使用 C 程序语言，比起使用组合语言的传统 BIOS 要更容易开发！也因为使用 C 语言来撰写，因此可以在 UEFI 开机阶段就让该系统了解 TCP/IP 而直接上网

![](http://op4fcrj8y.bkt.clouddn.com/17-7-16/70290831.jpg)

UEFI的硬件资源管理使用轮询(polling)的方式管理，效率稍慢//p143

一般载入系统后，UEFI会停止工作，将系统交给操作系统，但在某些特定情况下，UEFI程序可以部分继续执行，以协助某些操作系统无法找到特定设备时，该设备还可以持续运行

过去cracker常借助BIOS开机阶段破坏系统，UEFI则加入了安全启动(secure boot)机制，即将开机的操作系统必须要被UEFI所验证，否则无法顺利开机(有时需将secure boot功能关闭，才能顺利进入系统如Linux)

UEFI可以直接取得GPT分区表

UEFI已克服了BIOS1024柱面的问题，因此开机管理程序与核心可以放置在磁盘开始的前2TB位置内即可，由于BIOS boot以及UEFI支持的分区，/boot目录几乎都是/dev/sda3之后的号码





### 2.2.4磁盘分区选择

目录树结构directory tree

根目录root directory: 最重要，一般以/表示

![](http://op4fcrj8y.bkt.clouddn.com/17-7-16/21979109.jpg)



挂载 mount

利用一个目录当成进入点，将磁盘分区的数据放置在该目录下

![](http://op4fcrj8y.bkt.clouddn.com/17-7-16/75041808.jpg)

上图，partition 1挂载到根目录，partition 2挂载到/home

判断某个文件在哪个partition：通过反向追踪





p150 Web服务器 mail服务器 NAT达成IP分享器的功能





---

# 第三章 安装CentOS7.x



![](http://op4fcrj8y.bkt.clouddn.com/17-7-16/90988809.jpg)

1. 正常安装 CentOS 7 的流程

2. 测试此光盘后再进入 CentOS 7 的流程

3. 进入除错模式

   以基本图形接口安装 CentOS 7 （使用标准显卡来设置安装流程图示）；
   救援 CentOS 系统
   执行内存测试 （Run a memory test）
   由本机磁盘正常开机，不由光盘开机



加入强制使用GPT分区表的安装参数: //因为如果磁盘容量小于2TB系统会默认用MBR模式

1. 使用方向键，将光标移动到“ Install CentOS 7 ”的项目中
2. 按下 [Tab] ，让光标跑到画面最下方等待输入额外的核心参数
3. 在出现的画面中，输入 //注意各项目之间需要有空格

![](http://op4fcrj8y.bkt.clouddn.com/17-7-16/16358481.jpg)

重点在输入 inst.gpt

建议练习机安装时的磁盘分区能有/, /boot, /home, swap四个分区

CentOS 7默认使用 xfs 作为文件系统

手动分区:

标准分区：就是我们一直谈的分区啊！类似 /dev/vda1 之类的分区就是了
LVM：这是一种可以弹性增加/削减文件系统容量的设备设置
LVM 紧张供应(简单配置)：是 LVM 的进阶版！与传统 LVM 直接分配固定的容量不同， 这个“ LVM 紧张供应”的项目，可以让你在使用多少容量才分配磁盘多少容量给你



ext2/ext3/ext4：Linux早期适用的文件系统类型。由于ext3/ext4文件系统多了日志的记录， 对于系统的复原比较快速。不过由于磁盘容量越来越大，所以除非你有特殊的设置需求，否则近来比较少使用 ext4 项目了
swap：磁盘仿真成为内存，由于swap不会使用到目录树挂载，所以用swap就不需要指定挂载点
BIOS Boot：就是 GPT 分区表可能会使用到的项目，若使用 MBR 分区，那就不需要这个项目了
xfs：这个是目前 CentOS 默认的文件系统，最早是由大型服务器所开发出来的！ 他对于大容量的磁盘管理非常好，而且格式化的时候速度相当快，很适合当今动不动就是好几个 TB 的磁盘的环境
vfat：同时被Linux与Windows所支持的文件系统类型。如果你的主机硬盘内同时存在Windows与Linux操作系统，为了数据的交换，确实可以创建一个vfat的文件系统

> p178



> 设定密码时，点击两次完成，可以强行设定弱密码





---

# 第四章 首次登陆与线上求助

Linux使用非同步的磁盘/内存数据传输模式，同时为多用户多任务环境，故不可随便不正常关机，错误关机可能损坏磁盘数据

root登录: 登录时点击没有列出来? 输入root及密码



> GNOME 一种GNU网络对象模型环境，GNU计划的一部分
>
> 一套纯粹自由的计算机软件，运行在操作系统上，提供图形桌面环境
>
> GNOME是类Unix操作系统上最常用的图形桌面环境之一
>
> The GNU Network Object Model Environment



只要文件名的开头是由小数点开始的，那么该文件名就不会在一般观察模式被显示出来，开头为小数点的则会被隐藏

文件夹图标上，带有箭头的指有“链接文件”的数据，件可以想像成 Windows的“捷径”

带有x符号的表示没有权限进入该目录



### 4.1.3 X window 与文字模式的切换

纯命令行模式，文字模式，终端机接口，terminal，console

Linux默认情况下提供六个Terminal来让使用者登录，切换的方式为:ctrl+alt+F1\~F6

系统将F1\~F6命名为tty1\~tty6的操作接口环境

CentOS 7 环境下，当开机完成之后，默认系统只会提供一个 tty 而已，因此无论是文字界面还是图形界面，都会出现在 tty1！tty2~tty6 一开始不存在！但切换时 （如按下 [ctrl]+[alt]+[F2]），系统才产生出额外的 tty2, tty3...



纯命令行下 （不能有 X 存在） 启动窗口界面的作法

[tea@study ~]$ startx //用户名为tea 主机名称

有效的要求：

没有启动其它X window

必须安装了X Window system，且X server能够顺利启动

最好要有窗口管理员，例如GNOME/KDE或者是阳春的TWM



[tea@CentOS ~]\$ //此处显示的是   \[用户名\] @ \[主机名称\]  \[当前目录的名称\] \$:“提示字符”

~ 符号代表的是“使用者的主文件夹”，例如此处~等于/home/tea

提示字符：默认root的提示字符为\#，一般身份使用者的提示字符为\$

登出Linux:  exit   //登出不是关机



## 4.2-3 指令的下达 & 线上求助

bash是我们的shell的名称，Linux的默认壳程序就是bash

文字模式登陆后所取得的程序被称为壳(shell)，因为这支程序负责最外面跟使用者沟通，故称为壳程序

[tea@CentOS ~]$ command [-options] parameter1 parameter2 ...

1. 一行指令中第一个输入的部分绝对是“指令（command）”或“可可执行文件案（例如批次脚,script）”
2. command 为指令的名称，例如变换工作目录的指令为 cd 
3. 中刮号[]并不存在于实际的指令中，而加入选项设置时，通常选项前会带 - 号，例如 -h；有时候会使用选项的完整全名，则选项前带有 -- 符号，例如 --help
4. parameter1 parameter2.. 为依附在选项后面的参数，或者是 command 的参数
5. 指令, 选项, 参数等这几个咚咚中间以空格来区分，不论空几格 shell 都视为一格
6. 按下[Enter]按键后，该指令就立即执行。[Enter]按键代表着一行指令的开始启动
7. 指令太长的时候，可以使用反斜线 （\） 来跳脱[Enter]符号，使指令连续到下一行。注意！反斜线后就立刻接特殊字符，才能跳脱！
8. 其他：指令是大小写敏感的




--help 该指令的基本用法与选项参数介绍

man date 查看date指令的manual操作说明//这些文件一般放在/usr/share/man

修改man page搜寻路径: 修改/etc/man_db.conf (maybe man.conf manpath.conf man.config)

进入指令的manual page后，指令后的数字的含义:

![](http://op4fcrj8y.bkt.clouddn.com/17-7-19/76821387.jpg)

在manual页面中，输入/test ，则会向下搜索、高亮含有test关键字的部分，并移动到那一部分，需要重复搜索时可以使用n / N来动作

![](http://op4fcrj8y.bkt.clouddn.com/17-7-19/86738825.jpg)

搜寻特定指令/文件的man page说明文档:

man -f man //取得更多与man相关的信息:

[tea@study ~]$ man -f man
man （1） - an interface to the on-line reference manuals
man （1p） - display system documentation
man （7） - macros to format man pages

man 1 man //进入man(1)的manual
man 7 man //进入man(7)的manual

使用man man查看的manual与搜寻顺序有关，一般通常会先找到数字较小的，即man 1 man

man -k man 查看说明文档中含有man字眼(不一定是单词是man)的文件



# 第六章 Linux档案与目录管理



## 6.3 档案内容查阅

- cat  由第一行開始顯示檔案內容
- tac  從最後一行開始顯示，可以看出 tac 是 cat 的倒著寫！
- nl   顯示的時候，順道輸出行號！
- more 一頁一頁的顯示檔案內容
- less 與 more 類似，但是比 more 更好的是，他可以往前翻頁！
- head 只看頭幾行
- tail 只看尾巴幾行
- od   以二進位的方式讀取檔案內容



---

# Ubuntu

```python
sudo -i #sudo whoami
sudo passwd #change the default blank root password and set root password
su #Once the root password is set, you can login as root by using the su command
```





# Case



### 无sudo配置conda

下载Anaconda3-2018.12-Linux-x86_64.sh    https://repo.continuum.io/archive/index.html

wget URL

安装：

1. bash Anaconda3-2018.12-Linux-x86_64.sh
2. Do you accept the license terms?  yes
3. 是否添加到环境变量 yes

conda --version 检查是否安装成功，如果command not found: export PATH="/home/hyhuang/anaconda3/bin/:$PATH"



### Linux系统信息 硬件信息



```cmd
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
#    24  Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz    #核心数 型号名 版本名 主频

cat /proc/cpuinfo      # 查看CPU信息
# 输出信息十分详细

top #查看 CPU 使用状况 q退出
# 输出信息实时刷新
top -u annms #查看annms用户的进程CPU内存等使用信息
```





### 后台执行命令

解决在后台执行作业，远程连接掉线后作业不受影响

#### &

**&**: Terminal运行程序时会被运行的作业占据，可以在命令后面加上&实现后台运行。e.g. sh a.sh &

使用&后，作业被提交到后台运行，当前terminal没有被占用，但是一旦把当前terminal断开后，比如远程连接时掉线，作业就会停止。

#### nohup

> no hang up  不挂起

nohup命令使得退出账户后，相应作业继续执行，不会被挂起通常形式如下

```cmd
nohup command
nohup command &
nohup command > out.file 2>&1 & #最后一个& 让该命令在后台执行
# command>out.file 将command的输出重定向到out.file文件，即不输出到terminal，而输出到out.file
# 2>&1 将标准出错重定向到标准输出。标准输出已经重定向到了out.file文件，即将标准出错也输出到out.file文件中
# 2>: 2与>结合代表错误重定向，&1: &与1结合代表标准输出. 2>&1就变成错误重定向到标准输出
```

nohup --help 部分信息

```cmd
hyhuang@inpluslab-ThinkStation-P900:~$ nohup --help
Usage: nohup COMMAND [ARG]...
  or:  nohup OPTION
Run COMMAND, ignoring hangup signals.   # 忽略hangup信号，实现后台运行，不挂断地运行命令

      --help     display this help and exit
      --version  output version information and exit

If standard input is a terminal, redirect it from /dev/null.
If standard output is a terminal, append output to 'nohup.out' if possible,
'$HOME/nohup.out' otherwise.
If standard error is a terminal, redirect it to standard output.
To save output to FILE, use 'nohup COMMAND > FILE'.  # 保存输出至文件

NOTE: your shell may have its own version of nohup, which usually supersedes
the version described here.  Please refer to your shell's documentation
for details about the options it supports.
```

setsid  disown  screen让进程在后台可靠运行，其中disown可以让已经运行了的作业免受hup信号影响

https://www.ibm.com/developerworks/cn/linux/l-cn-nohup/index.html





### 创建和删除软、硬链接

> https://www.ibm.com/developerworks/cn/linux/l-cn-hardandsymb-links/index.html

文件都有文件名与数据，这在Linux上被分成两个部分：用户数据 (user data) 与元数据 (metadata)。用户数据，即文件数据块 (data block)，数据块是记录文件真实内容的地方；而元数据则是文件的附加属性，如文件大小、创建时间、所有者等信息。

在 Linux 中，元数据中的 inode 号（inode 是文件元数据的一部分但其并不包含文件名，inode 号即索引节点号）才是文件的唯一标识而非文件名。

通过文件名打开文件的过程：filename -> inode ->(from metadata to user data)->data blocks

> Linux中查看inode号：stat或ls -i

为解决文件的共享使用，Linux 系统引入了两种链接

1. 硬链接 hard link
2. 软链接 符号链接 soft link symbolic link

链接好处：解决文件的共享使用，隐藏文件路径，增加权限安全，节省存储

若一个 inode 号对应多个文件名，则称这些文件为硬链接。换言之，硬链接就是同一个文件使用了多个别名。硬链接可由命令 link 或 ln 创建

```cmd
link oldfile newfile 
ln oldfile newfile
```

由于硬链接是有着相同 inode 号仅文件名不同的文件，因此硬链接存在以下几点特性：

1. 文件有相同的 inode 及 data block
2. 只能对已存在的文件进行创建
3. 不能交叉文件系统进行硬链接的创建
4. 不能对目录进行创建，只可对文件创建
5. 删除一个硬链接文件并不影响其他有相同 inode 号的文件

若文件用户数据块中存放的内容是另一文件的路径名的指向，则该文件就是软连接。软链接就是一个普通文件，只是数据块内容有点特殊。软链接有着自己的 inode 号以及用户数据块。因此软链接的创建与使用没有类似硬链接的诸多限制：

1. 软链接有自己的文件属性及权限等
2. 可对不存在的文件或目录创建软链接
3. 软链接可交叉文件系统
4. 软链接可对文件或目录创建
5. 创建软链接时，链接计数 i_nlink 不会增加
6. 删除软链接并不影响被指向的文件，但若被指向的原文件被删除，则相关软连接被称为死链接（即 dangling link，若被指向路径文件被重新创建，死链接可恢复为正常的软链接）

软链接访问：filename(soft link) -> inode -> datablock -> filename(ref file) -> inode -> data block

软链接可以指向软链接，解析过程是递归的。软链接尽量使用绝对路径，使用相对路径的话，文件移动后很可能成为dangling(悬挂的) link







# Linux Basis

一般著名的Linux分为两大类：

1. RedHat Series: RedHat, CentOS, Fedora
2. Debian Series: Debian, Ubuntu

> https://blog.51cto.com/494981/1383655

RedHat Series:

1. 常见的安装包格式: rpm包,安装rpm包的命令是“rpm -参数” 
2. 包管理工具 yum 
3. 支持tar包

Debian Series:

1. 常见的安装包格式 deb包,安装deb包的命令是“dpkg -参数” 
2. 包管理工具 apt-get 
3. 支持tar包

# Command Quick Find

```cmd
# apt-get等安装更新卸载相关
apt-get update # 列举本地更新
apt-get upgrade # 安装可用更新
apt-cache search package_name # 查询软件包
apt-get install package_name # 安装一个软件包
apt-get remove package # 删除一个软件包
dpkg -i package_file.deb ,sudo dpkg -r package_filename # install/unstall .deb files
sudo alien package # convert .rpm to .deb files
tar xfvz tarball_name # install tarballs

# 环境变量
export PATH=$PATH:/ssr-n #临时添加环境变量

uname -r #显示操作系统的发行编号/--release


bc #计算器(scale=3 显示小数点后3位，否则默认显示整数)
cal [month] [year] #显示日历(calendar)
date #显示日期
locale #显示目前所支持的语系
ls #列出文件 -a 包括隐藏文件 -l 详情
LANG=en_US.utf8 #修改语系为英文语系(当次登录有效)
ca[tab][tab] #命令补全(指令串的第一个字后):连按两次tab后，ca开头的命令被列出

# 网络相关
ip addr # 查看网路ip
```





### find / ls

​			

```cmd
find / -amin -10 # 查找在系统中最后10分钟访问的文件
find / -atime -2 # 查找在系统中最后48小时访问的文件
find / -empty # 查找在系统中为空的文件或者文件夹
find / -group cat # 查找在系统中属于 groupcat的文件
find / -mmin -5 # 查找在系统中最后5分钟里修改过的文件
find / -mtime -1 #查找在系统中最后24小时里修改过的文件
find / -nouser #查找在系统中属于作废用户的文件
find / -user fred #查找在系统中属于FRED这个用户的文件


ls -al ~/.bash[tab][tab] #//文件补全(指令串第二个字以后):列出该目录下以.bash开头的文件名
```



> https://blog.csdn.net/ydfok/article/details/1486451

### cat

1. 一次显示整个文件:cat filename
2. 从键盘创建一个文件:cat > filename 只能创建新文件,不能编辑已有文件.
3. 将几个文件合并为一个文件:cat file1 file2 > file

```cmd
cat afile.log # 显示文件内容
cat -n a.log b.log #把 a.log 的文件内容加上行号后输入 b.log 这个文件里
```

> http://www.cnblogs.com/peida/archive/2012/10/30/2746968.html



### grep / kill

> https://blog.csdn.net/andy572633/article/details/7211546

```cmd
# kill
kill -s 9 pid #传递信号9：强制、尽快终止进程
pkill -9 firefox #pgrep+kill
```

- pkill或者pgrep只要给出进程名的一部分就可以终止进程



# Shortcuts

- Ctrl+Shift+C: console下copy 
- Ctrl+Shift+V: console下paste
- Ctrl+Insert: console下复制 或 鼠标选中即为复制
- Shift+Insert: console下粘贴 或 鼠标中键即为粘贴

- ctrl + c 中断目前正在执行的指令串
- ctrl + d EOF键盘输入结束，输入时离开命令行，相当于输入exit
- shift + page up/down 文本页面翻页
- ctrl+alt+F1~6切换控制台

