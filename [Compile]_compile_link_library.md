> 《程序员的自我修养——链接、装载与库》         记录一些比较重要的概念、关系、逻辑，以及读时不理解的东西。
>
> # Diary
>
> - 20220406 烦躁，觉得研究生读亏了，觉得技术退步了，做了很多自己不喜欢做的事。重拾回一些东西吧，温故完第一章，第二章P49。
> - 20220407 干饭。从前有个人，想学会用剪子修建花草，便师从园丁。后来园丁让他用电锯修剪灌木，他没有怨言，照做了，每周汇报着修剪的进度。园林局验收前两周，园丁：“我觉得用电锯修建灌木不太合理，你应该用更大一点的电锯，把花园里的那几棵树锯了”。P74。一两页一个错误，校对扣钱！
> - 20220408 冷静。“如果你觉得不合理，为什么之前报告的时候不说，非得等到验收将至才说？之前项目验收也是，验收前两周说要验收了，要达到什么效果，要录怎么样的视频”。P92





# Basis

- PCI bus: PCI总线，高速。连接北桥、SCSI、USB、GPU、monitor、PCI
- ISA bus: ISA总线，低速。声卡、调制解调器、打印机
- PCI Bridge/Northbridge: 北桥。连接CPU、内存、PCI总线、PCIE



- Symmetrical Multi-Processing (SMP): 对称多处理器。多商用
- Multi-core Processor: 多核处理器。民用，现商用也多采用。



运行库使用操作系统提供的系统调用接口（System call Interface），系统调用接口在实现中往往以软件中断（Software Interrupt）的方式提供。Linux用`0x80`中断作为系统调用接口，Windows用`0x2e`，从XP SP2开始用一种新的系统调用方式。

抢占式（Preemptive）：操作系统可以强制剥夺CPU资源并且分配给它认为目前最需要的进程。

内存：

- 分段segmentation: 虚拟地址（Virtual Address）直接map到物理地址（Physical Address）
- 分页paging: VA切分成页(一般为4k)之后map到物理地址上。访问不在内存中的虚拟页（Virtual Page）会产生页错误（Page Fault），由系统接管

虚拟存储依靠硬件支持，大多采用MMU（Memory Management Unit）来进行页映射。MMU集成在CPU内部



线程 Thread: 轻量级进程（Lightweight Process，LWP），程序执行的最小单元，由进程ID、当前指令指针PC、寄存器集合、栈组成。与同一进程的线程间共享程序的内存空间（代码段、数据段、堆...），进程级资源（文件、信号）

线程局部存储（Thread Local Storage, TLS）是某些操作系统为线程单独提供的私有空间、通常只有有限的容量。



Linux将所有的执行实体（线程、进程）都称为任务（Task），每一个任务概念上都类似于一个单线程的进程，具有内存空间、执行实体、文件资源等。Linux下不同任务之间可以选择共享内存空间，在实际意义上，共享了同一内存空间的多个任务构成一个进程，这些任务成了这个进程里的线程。

Linux创建一个新任务的方法：

| System Call | Function                                       |
| ----------- | ---------------------------------------------- |
| fork        | 复制当前进程。新任务返回0，父任务返回子任务pid |
| exec        | 使用新的可执行映像覆盖当前可执行映像           |
| clone       | 创建子进程并从指定位置开始执行                 |

fork产生新任务的速度很快，因为fork不复制原任务的内存空间、而是和原任务一起共享一个写时复制（Copy on Write，COW）的内存空间。

写时复制（Copy on Write，COW）：两个任务可以同时读取内存，任一内存写时，复制一份给修改方单独使用。

原子的（Atomic）

Windows由一套Interlocked API进行一些原子操作



锁Lock：获取、释放。

- 信号量（Semaphore）初始值为N的信号量运行N个线程并发访问。二元信号量（Binary Semaphore）是最简单的一种锁。同一信号量可以被一个线程获取，被另一线程释放。进程间可见
- 互斥量（Mutex）与二元信号量类似，但获取和释放需由同一线程进行。进程间可见
- 临界区（Critical Section）：进程内可见，其余进程无法获取。
- 读写锁（Read-Write Lock）：分为共享的（Shared）和独占的（Exclusive），自由状态时两种都可，共享状态下只能被共享的获取。
- 条件变量（Condition Variable）：类似于栅栏，让多个线程一起等待某个事件发生（条件变量被唤醒），然后一起恢复执行



可重入（Reentrant）：一个函数被重入，指该函数没有执行完成，又一次进入该函数执行。被重入的情况：多个线程同时执行该函数；函数自身(经几层调用后)调用自身。

可重入函数需满足：

- 不适用（局部）静态或全局的非const变量
- 不返回（局部）静态或全局的非const变量的指针
- 仅依赖调用方提供的参数
- 不依赖任何单个资源的锁（mutex等）
- 不调用任何不可重入函数



# 编译和链接

> gcc命令实际上是预编译编译程序cc1、汇编器as、链接器ld的包装，根据不同的参数要求调用。

1. 预处理 Prepressing: 预编译， `.c .cpp .h -> .i`
2. 编译 Compilation: `.i -> .s`  把预处理完的的文件进行 词法分析、语法分析、优化后产生汇编代码文件
3. 汇编 Assembly: `.s -> .o` 把汇编代码转变为机器可执行的指令
4. 链接 Linking: `.o .a -> .out` 



## 预处理

预编译

```bash
gcc -E a.c -o a.i       cpp a.c > a.i
```

- 将所有`#define`删除，并展开所有宏定义
- 处理所有条件预编译指令，e.g. `#if #ifdef #elif #else #endif`
- 处理`#include`预编译指令，将被包含的文件插入到该预编译指令的位置。递归进行，被包含文件可能包含其他文件
- 删除所有注释
- 添加行号和文件名标识，便于编译时编译器产生调试用行号信息、显示编译错误、警告的行号
- 保留所有`#pragma`编译器指令



## 编译

编译后输出汇编。现在GCC把预编译和编译两个步骤合并成一个步骤，叫做`cc1`，位于`/usr/lib/gcc/.../VER/`

```bash
gcc -S a.i -o a.s     /   cc1 a.c    /    gcc -S a.c -o a.s
```

编译过程一般分为6步：

1. 扫描: Scanner，词法分析
2. 语法分析: Parser
3. 语义分析: Semantic Analyzer
4. 源代码优化: Source Code Optimizer
5. 代码生成: Code Generator
6. 目标码优化: Code Optimizer

### 词法分析

扫描器Scanner进行词法分析，用类似于有限状态机的算法将源代码的字符序列分割成一系列的记号Token

记号Token一般分为：关键字、标识符、字面量（数字 字符串...）、特殊符号（`+ = -...`）

将标识符放到符号表、将数字、字符串常量存放到文字表

### 语法分析

语法分析器Grammar Parser对扫描器产生的记号做语法分析，产生语法树。采用上下文无关语法Context-free Grammar

语法分析器生成的语法树是以表达式为节点的树

符号和数字是最小的表达式，通常作为整个语法树的叶节点

多重含义的符号(e.g. `*`)在语法分析阶段确定具体含义

表达式不合法，如括号不匹配、表达式缺少操作符，编译器报告语法分析阶段错误

语法分析工具：yacc(Yet Another Compiler Compiler)，根据用户给定的语法规则对输入的记号序列进行解析，构建出语法树。编译器编译器Compiler Compiler

### 语义分析

语义分析器Semantic Analyzer

静态语义 Static Semantic：编译器所能分析的语义，编译器可以确定的语义。声明、类型匹配、类型转换。隐式转换会在语法树中插入相应转换节点

动态语义 Dynamic Semantic：只有在运行期才能确定的语义。例如除0错误



### 中间语言生成

源码级优化器Source Code Optimizer

源码级优化器一般将语法树转换成中间代码Intermediate Code，是语法树的顺序表示。

中间代码常见形式：三地址码Three-address Code；P-代码 P-Code

```assembly
x = y op z # 三地址码形式
t1 = 2 + 6 # 类似这样的会被源码级优化器优化掉
```

中间代码使得编译器可以分为前端、后端。前端产生机器无关的中间代码，后端将中间代码转换为目标机器代码。跨平台编译器可以使用一个前端和多个对应平台的后端



### 目标代码生成与优化

编译器后端主要包括：代码生成器Code Generator；目标代码优化器 Target Code Optimizer



## 汇编

将汇编代码装变为机器可执行的指令，每一条汇编语句几乎都对应一条机器指令

```bash
as a.s -o a.o     gcc -c a.s -o a.o     gcc -c a.c -o a.o
```

汇编的过程指的是编译里面的目标代码生成与优化。可能这就是常常把整个过程成为编译链接的原因？汇编被包含进编译的后端了？



## 链接

链接：解决模块间符号引用的问题，函数符号、变量符号。



### 静态链接

链接过程主要包括：地址和空间分配 Address and Storage Allocation、符号决议 Symbol Resolution、重定位 Relocation

符号决议有时也被叫做符号绑定 Symbol Binding、名称绑定 Name Binding、名称决议 Name Resolution、地址绑定 Address Binding、指令绑定 Instruction Binding。大体意思一样，但决议倾向于静态链接，绑定倾向于动态链接。静态链接统一称为符号决议。

基本的静态链接过程：每个模块的源代码`.c .cpp .h`文件经过编译器编译成目标文件**Object File** `.o .obj`，目标文件和库 Library 一起链接成最终的可执行文件。最常见的库是运行时库 Runtime Library，是支持程序运行的基本函数的集合。库其实是一组目标文件的包，将常用代码编译成目标文件后打包存放

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/compile_linking/source2executable.png)

重定位 Relocation：给程序中地址留空的引用位置填上真实的绝对地址。

重定位入口 Relocation Entry：需要重定位的地方。需要把留空地址改为正确的绝对地址的地方。





# Object File 目标文件



Windows: PE, Portable Executable

Linux: ELF, Executable Linkable Format

均为COFF Common File Format格式的变种

| ELF Format                      | Description                                                  | Example          |
| ------------------------------- | ------------------------------------------------------------ | ---------------- |
| 可重定位文件 Relocatable File   | 包含代码和数据，可以被用来链接成可执行文件或共享目标文件，静态链接库也可以归为这一类 | `.o .obj`        |
| 可执行文件 Executable File      | 包含可直接执行的程序，如ELF可执行文件                        | `/bin/bash .exe` |
| 共享目标文件 Shared Object File | 包含代码和数据。1. 连接器用这种文件和其他的可重定位文件和共享目标文件链接，产生新目标文件 2. 动态链接器可以将几个共享目标文件和可执行文件结合，作为进程映像的一部分运行 | `.so .dll`       |
| 核心转储文件 Core Dump File     | 进程意外终止，OS将进程地址空间内容及终止时的其他信息转储到核心转储文件 | `core dump`      |



ELF文件头有一个段表 Section Table，是描述文件中各个段的数组，描述各个段在文件中的偏移和段属性。

```bash
objdump -s -d a.o # -s 所有段以16进制打印  -d 将所有包含指令的段反汇编 -x 输出更多信息
```

```cpp
static int x1 = 0; // .bss 未初始化即为0 被优化掉了
static int x2 = 1; // .data 有非0初始值
```

将二进制文件如图片音乐作为目标文件的一个段：

```bash
objcopy -I binary -O elf32-i386 -B i386 image.jpg image.o
objdump -ht image.o # 查看image.o
```

GCC有扩展机制能将变量或某部分代码放到指定的段中：

```cpp
__attribute__((section("FOO"))) int global = 42; // 放到名字为FOO的段中去
__attribute__((section("BAR"))) void foo(){}
```



```bash
readelf -h a.o # 查看ELF文件
```



## ELF Header

ELF 文件格式支持 8 bit / 32 bit 体系结构，且可拓展支持更小/大位数的处理器架构。
Object File含一些控制数据，用以表明Object File所使用的架构，以便以通用的方式识别和解释。Object File的其他数据采用目的处理器的格式编码，与在何种机器上创建无关。即Object File可以交叉编译，e.g. x86平台生成arm可执行代码

| 名称          | 长度 | 对齐方式 | 用途           |
| ------------- | ---- | -------- | -------------- |
| Elf32_Addr    | 4    | 4        | 无符号程序地址 |
| Elf32_Half    | 2    | 2        | 无符号半整型   |
| Elf32_Off     | 4    | 4        | 无符号文件偏移 |
| Elf32_Sword   | 4    | 4        | 有符号大整型   |
| Elf32_Word    | 4    | 4        | 无符号大整型   |
| unsigned char | 1    | 1        | 无符号小整型   |

> 数据结构可以包含显式补齐来确保 4B 对象按 4B 对齐，强制数据结构的大小是 4 的整数倍... 包含 Elf32_Addr 类型成员的结构体会在文件中 4B 边界处对齐。为可移植性，ELF不使用位域

```cpp
#define EI_NIDENT   16 // 32bit ELF文件头结构

typedef struct {
    unsigned char   e_ident[EI_NIDENT]; // Magic Class Data Version OS/ABI ABI_Version
    ELF32_Half      e_type; // Type ELF文件类型
    ELF32_Half      e_machine; // ELF 文件的CPU平台属性 相关常量以 EM_ 开头
    ELF32_Word      e_version; // ELF 版本号 一般为1
    ELF32_Addr      e_entry; // Entry point address 人口地址 规定ELF程序的入口虚拟地址 可重定位文件一般没有入口地址，为0
    ELF32_Off       e_phoff; // Start of program headers
    ELF32_Off       e_shoff; // Start of section headers 段表在文件中的偏移
    ELF32_Word      e_flags; // 标志位 表示一些ELF文件平台相关的属性
    ELF32_Half      e_ehsize; // ELF文件头本身的大小
    ELF32_Half      e_phentsize; // Size of program headers
    ELF32_Half      e_phnum; // Number of program headers
    ELF32_Half      e_shentsize; // Size of section headers 段表描述符的大小 一般等于sizeof(ELF32_Shdr)
    ELF32_Half      e_shnum; // Number of section headers 段表描述符数量 等于ELF文件中拥有的段的数量
    ELF32_Half      e_shstrndx; // section header string table index 段表字符串表(.shstrtab)所在的段在段表中的下标
} Elf32_Ehdr; // 32bit ELF header
```



### e_ident

| Macro Name | idx  | Description    | Value                  |
| :--------- | :--- | :------------- | ---------------------- |
| EI_MAG0    | 0    | 文件标识       | 0x7f                   |
| EI_MAG1    | 1    | 文件标识       | 'E' 0x45               |
| EI_MAG2    | 2    | 文件标识       | 'L' 0x4c               |
| EI_MAG3    | 3    | 文件标识       | 'F' 0x46               |
| EI_CLASS   | 4    | 文件类         | 0:无效 1:32bit 2:64bit |
| EI_DATA    | 5    | 数据编码       | 0:无效 1:小端 2:大端   |
| EI_VERSION | 6    | 文件版本       | 1                      |
| EI_PAD     | 7    | 补齐字节开始处 | 0 0 0 0 ...            |



### e_type & e_machine

`e_type` 标识目标文件类型。

| 名称      | 值     | 意义           |
| :-------- | :----- | :------------- |
| ET_NONE   | 0      | 无文件类型     |
| ET_REL    | 1      | 可重定位文件   |
| ET_EXEC   | 2      | 可执行文件     |
| ET_DYN    | 3      | 共享目标文件   |
| ET_CORE   | 4      | 核心转储文件   |
| ET_LOPROC | 0xff00 | 处理器指定下限 |
| ET_HIPROC | 0xffff | 处理器指定上限 |

虽然核心转储文件的内容没有被详细说明，但 `ET_CORE` 还是被保留用于标志此类文件。从 `ET_LOPROC` 到 `ET_HIPROC` (包括边界) 被保留用于处理器指定的场景。其它值在未来必要时可被赋予新的目标文件类型。

`e_machine`标识ELF文件的平台属性，即能在什么机器上运行



| 名称    | 值   | 意义       |
| ------- | ---- | ---------- |
| EM_NONE | 0    | 无机器类型 |
| EM_M32 | 1 |AT&T WE 32100|
| EM_SPARC | 2 | SPARC |
| EM_386 | 3 | Intel 80386 |
| EM_68K | 4 | Motorola 68000 |
| EM_88K | 5 | Motorola 88000 |
| EM_860 | 7 | Intel 80860 |
| EM_MIPS | 8 | MIPS RS3000|



## Section Header Table 段表

段表 Section Header Table 用于保存ELF文件中段的基本属性，是以`Elf32_Shdr`结构体（段描述符 Section Descriptor）为元素的数组，数组元素数等于段的个数。

```bash
readelf -S a.o # 查看ELF文件的段表结构 较完整
# objdump -h 省略了很多辅助性的段e.g.符号表 字符串表 段名字符串表 重定位表
```



```cpp
typedef struct { // Elf32_Shdr段描述符结构
    ELF32_Word      sh_name; // 段名 这里存储段名字符串在字符串表 .shstrtab中的偏移
    ELF32_Word      sh_type; // section header type 段的类型 影响编译器连接器判断段属性
    ELF32_Word      sh_flags; // 段的标志位
    ELF32_Addr      sh_addr; // 段虚拟地址 若可被加载 则存储加载后在地址空间中的虚拟地址 否则为0
    ELF32_Off       sh_offset; // 段偏移 若该段位于文件中 则表示该段在文件中的偏移 否则无意义 例如对.bss无意义
    ELF32_Word      sh_size; // 段的长度
    ELF32_Word      sh_link; // 段链接信息
    ELF32_Word      sh_info; // 段链接信息
    ELF32_Word      sh_addralign; // 段地址对齐 sh_addr%(2**sh_addralign)=0, 0/1表示没有对齐要求
    ELF32_Word      sh_entsize; // section entry size 项的长度。
} Elf32_Shdr; // 4B x 10 = 40B 大小
```



- `sh_entsize` 有些段包含一些固定大小的项，如符号表，所包含的每个符号所占的大小是一样的，对于这种段，`sh_entsize`表示每个项的大小，如果为0，表示该段不包含固定大小的项

`sh_type`段的类型：对于编译器连接器，决定段的属性的是段的类型（`sh_type`）和段的标志位（`sh_flags`）

| sh_type name      | value     | desc           |
| :-------- | :----- | :------------- |
|SHT_NULL|0|无效段|
|SHT_PROGBITS|1|程序段 e.g.代码段 数据段|
|SHT_SYMTAB|2|符号表|
|SHT_STRTAB|3|字符串表|
|SHT_RELA|4|重定位表|
|SHT_HASH|5|符号表的哈希表|
|SHT_DYNAMIC|6|动态链接信息|
|SHT_NOTE|7|提示性信息|
|SHT_NOBITS|8|表示该段在文件中没内容 e.g. .bss|
|SHT_REL|9|包含重定位信息|
|SHT_SHLIB|10|保留|
|SHT_DNYSYM|11|动态链接的符号表|

`sh_flag`段的标志位 表示段在进程虚拟地址空间中的属性，比如是否可写、可执行

| sh_flag name | value | desc                 |
| ------------ | ----- | -------------------- |
| SHF_WRITE    | 1     | 该段在进程空间中可写 |
|SHF_ALLOC|2|该段在进程空间中需要分配空间。e.g. 代码段 数据段 .bss|
|SHF_EXECINSTR|4|该段在进程空间中可执行 一般指代码段 **EXECutable INSTRuction**|



`sh_link sh_info`段的链接信息，如果该段类型是与链接相关的（动态/静态），则`sh_link sh_info`的意义如下表所示，否则无意义

| sh_type | sh_link | sh_info |
| ------- | ------- | ------- |
|     SHT_DYNAMIC    | 该段所使用的字符串表在段表中的下标        |         0|
|SHT_HASH|该段所使用的符号表在段表中的下标|0|
|SHT_REL| 该段所使用的相应符号表在段表中的下标|该重定位表所作用的段在段表中的下标|
|SHT_RELA| 该段所使用的相应符号表在段表中的下标|该重定位表所作用的段在段表中的下标|
|SHT_SYMTAB| 操作系统相关的|操作系统相关的|
|SHT_SYNSYM| 操作系统相关的|操作系统相关的|
|other| SHN_UNDEF|0|



## Relocation Table 重定位表

`.rel.text`的段的类型`sh_type`为`SHT_REL`，是重定位表 Relocation Table。`.rel.text`表示这个重定位表是针对`.text`段的重定位表，例如`.text`段中有绝对地址引用`printf`

一个重定位表同时也是ELF的一个段，则段类型`sh_type`为`SHT_REL`，其`sh_link`表示符号表的下标，`sh_info`表示作用于那个段，例如上面这个案例指作用于哪个`.text`，若该`.text`段的下标为1，则`.rel.text`的`sh_info`为1



## String Table 字符串表

`.strtab` String Table 存储一些以NULL结尾的字符串，ELF使用这些符号来存储程序中的符号名，包含变量名 函数名。

`.shstrtab` 段表字符串表 Section Header String Table 保存段表中用到的字符串，最常见的是段名`sh_name`

```assembly
\0 h e l l o \0 V a r # 偏移： 0: 表示空串 1: hello 2: ello 7: Var
```

通过上面这种方法，ELF文件中引用字符串只需给出一个数字下标，不需要考虑字符串长度问题。



## Symbol and Symbol Table

符号 Symbol：将函数和变量统称为符号，函数名或变量名就是符号名 Symbol Name

每个目标文件有一个对应的符号表 Symbol Table，符号表记录目标文件中用到的所有符号，每个定义的符号有一个符号值 Symbol Value，对于变量和函数来说，符号值就是对应的地址

- 定义在本目标文件的全局符号，可以被其他目标文件引用。如`.o`里面的`func main global_init_var`
- 本目标文件中引用的全局符号，但没有定义在本目标文件内，称为 外部符号 External Symbol，e.g. `printf`
- 段名，往往由编译器产生，段名符号值为该段起始地址 e.g. `.text .data`
- 局部符号，这类符号仅编译单元内部可见，如main中定义的static变量。调试器用这些符号分析程序或崩溃时的核心转储文件。局部符号对链接过程没有作用，链接器往往忽略
- 行号信息，目标文件指令与源代码中代码行的对应关系，可选

```bash
nm a.o # 查看文件的符号表
```



有些符号没有在程序中定义，但是可以直接声明并使用，将这类符号称为特殊符号。部分特殊符号：

- `__executable_start` 程序起始位置，不是入口地址，是程序最开始的地址
- `__etext _etext etext` 代码段结束地址，即代码段最末尾的地址
- `_edata edata`  数据段结束地址，即数据段最末尾的地址
- `_end end` 程序结束地址

以上地址都为程序装载时的虚拟地址



### ELF Symbol Table Structure

ELF文件中符号表往往是文件中的一个段，段名一般为`.symtab`，是`Elf32_Sym`结构体的数组，一个`Elf32_Sym`结构体对应一个符号。该数组下标为0的元素为无效的未定义符号，作为所有未定义符号的索引。

```cpp
typedef struct
{
    Elf32_Word st_name;     // Symbol name (string tbl index) 该符号在字符串表中的下标
    Elf32_Addr st_value;    // Symbol value 可能是个绝对值 也可能是个地址 含义与符号有关
    Elf32_Word st_size;     // Symbol size 符号大小 如double型的符号大小为8   为0表示符号大小为0或未知
    unsigned char st_info;  // Symbol type and binding
    unsigned char st_other; // Symbol visibility 为0 没用
    Elf32_Section st_shndx; // Section index 符号所在的段
} Elf32_Sym;
```

```bash
readelf -s a.o
objdump -t # 可以查看段名符号
```



#### st_info

符号类型和绑定信息 `st_info`：低4b表示符号类型 Symbol Type，高28b表示符号绑定信息 Symbol Binding

```cpp
#define ELF32_ST_TYPE(i)    ((i)&0xf)
#define ELF32_ST_INFO(b, t) (((b)<<4) + ((t)&0xf))
```

高28bit：符号绑定信息 Symbol Binding

| Symbol Binding | Value | Desc                                                         |
| :------------- | :---- | :----------------------------------------------------------- |
| STB_LOCAL      | 0     | 表明该符号为局部符号，在包含该符号定义的目标文件以外不可见。相同名称的局部符号可以存在于多个文件中，互不影响。 |
| STB_GLOBAL     | 1     | 表明该符号为全局符号，对所有将被组合在一起的目标文件都是可见的。一个文件中对某个全局符号的定义将满足另一个文件对相同全局符号的未定义引用。我们称初始化非零变量的全局符号为强符号，只能定义一次。 |
| STB_WEAK       | 2     | 弱符号与全局符号类似，不过它们的定义优先级比较低。           |

低4bit：符号的类型 Symbol Type

| Symbol Type | Value | Desc                                                         |
| :---------- | :---- | :----------------------------------------------------------- |
| STT_NOTYPE  | 0     | 符号的类型没有定义。                                         |
| STT_OBJECT  | 1     | 该符号是个数据对象 e.g. 变量 数组                            |
| STT_FUNC    | 2     | 函数或其他可执行代码                                         |
| STT_SECTION | 3     | 一个段。这种类型的符号表项主要用于重定位，通常具有 STB_LOCAL 绑定 |
| STT_FILE    | 4     | 生成该目标文件的源文件名。STB_LOCAL 类型，其节区索引`st_shndx`是 SHN_ABS 且优先级比其他`STB_LOCAL`符号高 |



#### st_shndx

符号所在段 `st_shndx` 如果符号定义在本目标文件中，则这个成员表示符号所在的段在段表中的下标，如果符号不是定义在本目标文件，或对于有些特殊符号，`st_shndx` 有些特殊

- SHN_ABS `0xfff1`： 符号的取值具有绝对性，不会因为重定位而发生变化。
- SHN_COMMON `0xfff2`： 表示该符号是一个“COMMON块”类型的符号。符号标记了一个尚未分配的公共块。符号的取值给出了对齐约束，与节区的 sh_addralign 成员类似。就是说，链接编辑器将在地址位于 st_value 的倍数处为符号分配空间。符号的大小给出了所需要的字节数。未初始化全局变量一般属于该类型
- SHN_UNDEF `0x0`： 表示符号没有定义，定义在其他目标文件中。当链接编辑器将此目标文件与其他定义了该符号的目标文件进行组合时，此文件中对该符号的引用将被链接到实际定义的位置



### 符号修饰与函数签名

符号修饰 Name Decoration 符号改编 Name Mangling

函数签名 Function Signature：包含函数名、参数类型，所在的类、名称空间及其他信息

在编译器及连接器处理符号时，使用某种名称修饰方法，使得灭个函数签名对应一个修饰后名称Decorated Name

```bash
c++filt _ZN1N1C4funcEi # binutils提供的用于解析被修饰过程的工具 output: N::C::func(int)
```

C++为了与C兼容。系统头文件用`#ifdef __cplusplus extern "C" { #endif `来让c++ c在编译时能够使用同一个头文件e.g. `string.h`    编译c++时默认定义`__cplusplus `

```cpp
extern "C" { // 将大括号内的代码当作C代码处理 此时C++符号修饰机制不起效
    int func(int);
    int var;
}
extern "C" int func(int);
extern "C" int var;
```



### 弱符号 强符号

