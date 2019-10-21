[TOC]



------

# 网络协议逆向分析

> Network Protocol Reverse

### Capturing Application Traffic

> Chapter 2 捕获应用流量
>
> This chapter describes two different capture techniques: passive and active.
>
> 被动捕获 Passive capture doesn’t directly interact with the traffic. Instead, it extracts the data as it travels on the wire, which should be familiar from tools like Wireshark.
>
> 主动捕获 Active capture interferes with traffic between a client application and the server; this has great power but can cause some complications. You can think of active capture in terms of proxies or even a man-in-the-middle attack.

Passive network capture can take place either on the network by tapping the traffic as it passes in some way or by sniffing directly on either the client or server host. 被动抓取可以通过在流量通过某介质时抓取，或者直接在客户端或服务端嗅探。



### Analysis from the Wire

> Chapter 5 
>
> Analysis of an unknown protocol is typically incremental. You begin by capturing network traffic, and then analyze it to try to understand what each part of the traffic represents.
>
> 本章使用 2018 James Forshaw - Attacking Network Protocols 在github上提供的客户端服务端



#### wireshark+Lua

Wireshark’s Lua interpreter starts by loading a file named `init.lua` in Wireshark’s global configuration directory. It is enabled by default. To disable Lua the line variable *enable_lua* should be set to *false* in *init.lua*.

因此可以在init.lua后面添加类似以下语句来加载脚本

```lua
dofile("/path/to/file.lua") --加载lua脚本
```

> If Lua is enabled Wireshark will then try to load a file named *init.lua* in the user’s personal configuration directory. Wireshark will also load all files with a *.lua* suffix from both the global and the personal plugins directory.
>
> The command line option ```-X lua_script:file.lua``` can be used to load Lua scripts as well.



#### Using a Proxy to Actively Analyze Traffic

> port-forwarding proxy

```csharp
// name.csx
using static System.Console;
using static CANAPE.Cli.ConsoleUtils;

var template = new FixedProxyTemplate();
// Local port of 4444, destination 127.0.0.1:12345
template.LocalPort = 4444;
template.Host = "127.0.0.1";
template.Port = 12345;
var service = template.Create();
// Add an event handler to log a packet. Just print to console.
service.LogPacketEvent += (s,e) => WritePacket(e.Packet);
// Print to console when a connection is created or closed.
service.NewConnectionEvent += (s,e) =>WriteLine("New Connection: {0}", e.Description);
service.CloseConnectionEvent += (s,e) =>WriteLine("Closed Connection: {0}", e.Description);
service.Start();
WriteLine("Created {0}", service);
WriteLine("Press Enter to exit...");
ReadLine();
service.Stop();
```





### 协议逆向分析系统工作流程

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Network_Protocol_Reverse_WrokFlow.png>)

### 序列比对

序列比对(Sequence Alignment): 通过在序列中搜索一系列单个性状或性状模式来比较2个或更多序列的方法

序列比对分类

- 双序列比对：两条序列(Alignment)的比对
- 多序列比对：三条或以上序列的比对



- 全局序列比对
  - 定义：在全局范围内对两条序列进行比对打分的方法
  - 适合于非常相似且长度近似相等的序列
- 局部序列比对
  - 定义：一种寻找匹配子序列的序列比对方法 
  - 适合于一些片段相似而另一些片段相异的序列



最优的序列比对通常具有以下两个特征：

1. 尽可能多的匹配
2. 尽可能少的空位

插入任意多的空位会产生较高的分数，但找到的并不一定是真正相似序列

为了获得两个序列最佳比对，必须使用空位和空位罚分

空位罚分分为：空位开放罚分(Gap opening penalty)和空位扩展罚分(Gap extension penalty)

双序列对比方法：

- 点阵序列比较(Dot Matrix Sequence Comparison): 点阵分析是一种简单的图形显示序列相似性的方法
- 动态规划算法(Dynamic Programming Algorithm)
- 词或K串方法(Word or *K*-tuple Methods)
- 贝叶斯统计方法(Bayesian Statistical Methods)



点阵分析优缺点

优点

- 直观性，整体性
- 点阵分析不依赖空位(gap)参数，可寻找两序列间所有可能的匹配
- 不依赖任何先决条件，是一种可用于初步分析的理想工具
- 点阵分析允许随时动态地改变最高和最低界限值，可以用来摸索区分信号和背景标准的严格程度

缺点

- 不能很好地兼容距离矩阵
- 滑动窗口和阈值的选择过于经验化
- 信噪比较低 
- 不适合进行高通量的数据分析

动态规划算法

动态规划算法(Dynamic Programming Algorithm)
综合运用分级决策方法和最优化原理而形成的数学方法。

- 主要思路是把一个复杂问题分成若干个关联的子问题
- 找出子问题的最优解，进而得出原来复杂问题的最优解
- 在序列比对尤其是双序列比对中非常重要
- 将比对过程分为若干步，每一步增加一个位置
- 可提供序列间最优的对位排列
- 应用最多的两种动态规划算法：
  - Needleman-Wunsch（全局比对）
  - Smith-Waterman（局部比对）

Needleman－Wunsch算法适用于整体水平上相似性程度较高的两个序列。
如果两个序列的亲缘关系较远，它们在整体上可能不具有相似性，但在一些较小的区域上却可能存在局部相似性。 

1981年Smith和Waterman提出了一种用来寻找并比较这些具有局部相似性区域的方法，即常用的Smith-Waterman算法 
同样是基于矩阵的方法，而且也同样是运用回溯法建立允许空位插入的比对
不同之处在于Smith-Waterman算法要从任何可能导致最大分值的地方才开始计分
矩阵中的每个单元均可以是比对结果序列片段的终点





### 动态插桩分析

> Instrumentation 插桩
>
> 

1. 动态污点分析 (Dynamic Taint Analysis, DTA)

2. 动态符号执行技术(Dynamic Symbolic Execution, DSE) 

是目前安全领域中实际应用最广泛的两种动态二进制程序分析技术

- 在真实运行环境下对程序进行自动化分析
- 向程序的关键位置插入代码段以获取相应位置的程序状态并加以分析
- 同时跟踪程序的关键属性在程序运行过程中的变化，从而掌握程序的行为和动态特征

> dynamic binary instrumentation, DBI
>
> http://shell-storm.org/blog/Taint-analysis-and-pattern-matching-with-Pin/#5.2.2

The purpose of the DBI is to add a pre/post handler on each instruction. When a handler is called, you are able to retrieve all the information you want about the instruction or the environment (memory).

- 插桩方法可以有两种类型：源插桩（Source instrumentation）和二进制插桩
- 源插桩会要求你掌握软件应用程序的源代码，否则无法进行插桩。而二进制插桩，可以与任何软件应用程序一起使用
- 二进制插桩通常又被称为动态二进制插桩或动态二进制修改（Dynamic Binary Modification）

#### 动态污点分析

> Dynamic Taint Analysis DTA

- 本质上属于信息流分析
- 目标是检查程序变量之间的信息传递
  - 追踪需要分析的数据片段在系统中的传播过程：如用户输入、网络报文等
  - 掌握目标程序对这些数据的详细处理流程
- 判断信息传递是否违背安全约束
- 防止信息从高密级客体流向低密级客体

动态污点分析主要涉及两部分内容：

1. 污点数据的标定
	- 明确源数据，即需要跟踪并加以分析的输入数据
	- 通常，把外来的或是不可信的数据标记为源数据，也称为污点数据。
	- 用户输入、网络报文、输入文件等都常被视为源数据
2. 污点数据的追踪
	- 即随着程序的执行，分析污点的扩散情况以及对系统的影响
	- 在程序运行过程中，污点数据可能作为源操作数参与运算
	- 运算结果往往依赖于污点数据，也需要标记为被污染
		- 这些被污染的数据，从安全的角度看，都被认为是不可信的，或者更明确地说，可能存在安全威胁



污点属性的传播特征

- 污点属性表示某一内存单元或者寄存器所依赖的污点源的集合
- 污点属性的传播具有重复性、重叠性和连续性等三种通用特征









#### 动态符号执行技术

> Dynamic Symbolic Execution  DSE

符号执行(Symbolic Execution, SE)指的是用抽象符号代替程序变量，模拟程序执行从而开展相关分析的技术

可以用于分析程序代码的全部语义信息，也可以根据实际需求只分析部分代码的语义信息

程序状态包括：堆、栈、寄存器以及程序计数器的状态等信息。

表示相应执行位置上的取值。

符号执行的程序状态与常规执行相似
核心区别在于符号化执行时，在存储位置的取值可能涉及抽象符号

抽象符号值不是确定值
如果符号值满足相应的条件，多条分支路径都可能被执行。
如果要执行某一分支路径，必须对分支条件进行假设，并把这种假设记录下来。
对于某一特定的路径，在符号执行过程中所涉及的所有假设的交集就是该路径的路径条件( Path Condition, PC) 



符号执行技术的局限
最突出的一点是路径空间的爆炸问题。
符号执行需要沿不同的执行路径进行分析，路径的数量将出现增长。
特别是循环分支，每出现一次循环，就将多出一条执行路径。
如果程序代码中有大量的分支语句，则路径空间的增长将异常迅速，给分析带来很大困难。

路径爆炸问题无法彻底根除。
通常采取一些折中的办法进行应对。
例如，限定每个过程内分析路径的最大数量来降低问题所带来的影响
或者采用设置最长分析时间、最大内存空间等方法避免路径爆炸导致分析工具崩溃。



**动态符号执行技术**将常规执行与符号化执行技术相结合。
也称为**定向自动随机测试(Directed Automated Random Testing, DART)** 
或者CONCOLIC (CONCrete and symbOLIC)执行

与传统静态符号执行相比动态符号执行可以利用常规执行所得到的信息。
动态符号执行不需要所有的操作都符号化地执行，也不要求所有的变量一定取符号值。
在收集路径条件的过程中，变量可以根据需要采用具体值代替符号值，一些难以符号化处理的操作可以直接基于具体值执行。
由于分析基于具体的数据输入，动态符号执行每次只对单条路径进行分析，避免了路径爆炸。
同时，利用程序实际运行时的信息以实际数值代替难以符号模拟的指针数据，能够有效提高分析的精确性。
目前主要应用于二进制程序漏洞测试及安全性分析领域。
应用于漏洞测试领域主要有两大优势。
首先，动态符号执行发现的程序错误都是真实存在的错误，有具体的输入值可以使程序执行到出错位置。
其次，相对于传统的静态符号执行技术，动态符号执行能够缓解约束求解器能力不足的问题。
当出现分支指令时，如果约束求解器无法判定分支路径的可行性，伴随的常规执行可以指明一个可行的分支路径从而确保符号执行继续实施。

常用的二进制分析平台：

- 进程级动态二进制插桩平台：Intel Pin
- 系统级二进制分析平台：BitBlaze
- 插桩平台：DynamoRIO，Val-grind，BitBlaze

```python
<Pin executable> <Pin options> -t <Pintool> -support_jit_api <Other Pintool options> -- <Test application> <Test application options>
../../../pin -t obj-intel64/inscount0.so -- /bin/ls
../../../pin -t obj-intel64/MyPinTool.so -- /usr/bin/wps

sudo ../../../pin -pid 2214 -t  obj-intel64/MyPinTool.so
```





---

# Software

- cFosSpeed：流量塑形：数据接收确认（ACK）在上传时被划定优先级，从而允许下载以最大速度进行
- SnifferView：(封包嗅探分析工具)
- IDA Pro： 可执行文件的逆向
- ILSpy：decompile CIL data into C# or Visual Basic source
- JD-GUI：decompile Java programs
- ProGuard：Dealing with Obfuscation 困惑 模糊。
- OllyDbg
- SoftIce：二进制调试工具
- WinDbg：二进制调试工具
- Linux VServer
- KLEE：自动化的测试数据产生及漏洞查找工具
- cron: 不用cron的肯定不是Linux高级用户？？？
- 

These resources provide more details on reverse engineering.
OpenRCE Forums: http://www.openrce.org/
ELF File Format: http://refspecs.linuxbase.org/elf/elf.pdf
macOS Mach-O Format: 
	https://web.archive.org/web/20090901205800/
	http://developer.apple.com/mac/library/documentation/DeveloperTools/ Conceptual/MachORuntime/Reference/reference.html
PE File Format: https://msdn.microsoft.com/en-us/library/windows/desktop/ms680547(v=vs.85).aspx



---

# websites

- reg007找一下这个号码和两个月邮箱注册了哪些网站