> 《程序员的自我修养——链接、装载与库》         记录一些比较重要的概念、关系、逻辑，以及读时不理解的东西。
>
> # Diary
>
> - 20220406 烦躁，觉得研究生读亏了，觉得技术退步了，做了很多自己不喜欢做的事。重拾回一些东西吧，温故完第一章，第二章P49。





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





### 静态链接

