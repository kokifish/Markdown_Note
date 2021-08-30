[TOC]



---

协议逆向工程(Protocol Reverse Engineering)，是指在不依赖于协议描述的情况下，通过对协议实体的网络输入/输出、系统行为和指令执行流程进行监控和分析，提取协议语法、语义和同步信息的过程，是工程化的协议逆向分析方法。





# Introduction



# Principles of Protocol Design

> 协议设计原理



**TPDU**,全称Transport Protocol Data Unit，是指传送协议数据单元。代表从一个传输实体发送至另一个传输实体的消息



## 协议模型

- 将n层对等实体间为实现该层协议所交换的信息单元称为协议数据单元(Protocol Data Unit, PDU)
- PDU通常由两部分组成：
  - 1. 用户数据
    2. 协议控制信息(Protocol Control Information, PCI). PCI一般作为首部加在用户数据的前面，但有时也可作为尾部加在用户数据的后面，例如用于差错检测的检验和(checksum)常放在尾部
- 根据PDU中是否携带用户数据，可将其分为两类：
  - 1. 数据PDU。SDU(Service Data Unit, 服务数据单元)就是数据PDU中的用户数据
    2. 控制PDU: 不携带用户数据
- 不同协议层次中，PDU有不同称呼：物理层比特bit，数据链路层帧frame信元cell，网络层分组 包packet，运输层以上 报文message



- 服务访问点(Service Accessing Point, SAP)： 同一系统中相邻两层的实体进行交互（交换信息）之处。上层访问下层所提供服务的点
- 服务原语(Service Primitives): 再进行交互时所要交换的一些必需信息(或命令),以表明需要本地或远端的对等实体做哪些事情

OSI规定每一层均可使用四种服务原语：

| 服务原语类型 | 译名 | 意义                                 |
| ------------ | ---- | ------------------------------------ |
| Request      | 请求 | 一个实体希望得到某种服务             |
| Indication   | 指示 | 把关于某一事件的信息告诉某一实体     |
| Response     | 响应 | 一个实体愿意响应某一事件             |
| Confirm      | 证实 | 把一个实体的服务请求加以确认并告诉它 |

SDU(Service Data Unit, 服务数据单元)就是数据PDU中的用户数据，但不一定是一一对应关系。多个SDU合成为一个PDU为拼装，一个SDU划分为几个PDU为分段

协议是水平的，是控制对等实体之间通信的规则。服务是垂直的，服务是由下层向上层通过层间接口提供的。只有能够被高一层看见的功能才能称为服务。

服务原语：上层使用下层所提供的服务必须通过与下层交换一些命令，这些命令再OSI中称为服务原语。

某一层向上一层提供的服务实际上包括了在它以下各层所提供的服务。



## 协议设计的基本内容



### 协议的通信环境

n层协议的通信环境：用户要求，(n-1)层通道的性质，n层协议运行时的操作系统和硬件环境。

通道类别：

1. 空通道empty channels: 报文的发送时间和延时时间为0的通道，即任何时刻通道中不容纳报文
2. 非缓冲通道 non-buffered channels: 再任何时刻，最多只有一个正在传送中的报文的通道
3. 缓冲通道 buffered channels: 允许有多个报文停留的通道

n-1层通道的性质对n层协议的构成有非常重要的影响，主要包括(p17)：

1. 通道的队列性质
2. 回程延时(Round Trip Time, RTT): 报文从n层源端实体发出到该报文的应答信息达到该实体之间的时间。包含目标实体收到报文后对报文进行处理，然后发出认可信息的时间。是协议最重要的参数之一。
3. 通道的差错特性。主要包括：报文的出错率、丢失率、重复率、失序率
4. 通道的可靠性。指通道故障，如断连、复位
5. 报文的最大长度。
6. 通道的工作方式。单工、半双工、全双工。同步、异步。全双工可以视为两个分离的单工通道。
7. 通道的带宽(bandwidth)。通道上能够传送的数字信号的速率，即数据率、比特率。可进一步分为前向带宽、后向带宽、峰值带宽



### 协议提供的服务

1. 面向连接的 connection-oriented. 有连接建立、数据传输、连接释放，3阶段。
2. 无连接的 connectionless. 无连接服务有以下三种类型：
   1. 数据报 datagram. 不需要接收端做任何响应，是一种不可靠的服务。“尽最大努力交付”(best effort delivery)
   2. 证实交付 confirmed delivery. 又称可靠的数据报。对每一个报文产生一个证实confirm给发端用户，confirm来自提供服务的层，而不是接收端用户。这种confirm只能保证报文已经发给远端目的站了，不能保证目的站用户已收到这个报文。
   3. 请求回答 request-reply. 收端用户每收到一个报文，就向发端用户发送一个应答报文。事务transaction中的一问一答方式的短报文以及数据库中的查询，很适合使用这种类型的服务。

### 协议功能

> p19

1. 连接管理
2. 差错控制
3. 流量控制
4. 拥塞控制
5. 无活动控制
6. 通信量控制
7. 通信量填充。产生虚假的(n)SDU以防止通信量分析
8. 通信量整形。
9. 路由选择
10. 带外数据或紧急数据的发送和接受
11. 安全控制



### 协议元素（一般6种）

第一章介绍了，从语言的角度看，协议包括三个要素：语法、语义、同步。

从协议的组成来看，协议一般由以下6种元素构成：

1. 服务原语和服务原语时序
2. 协议数据单元PDU和PDU交换时序
3. 协议状态
4. 协议事件
5. 协议变量
6. 协议操作和谓词



#### 服务原语和服务原语时序

一个完整的服务原语通常包括1. 原语名字; 2. 原语类型; 3. 原语参数





#### 协议事件

按事件的用途，可将协议事件分为输入事件和输出事件。

1. 输入事件：1. 收到一个PDU 2.收到n层服务用户的一条服务原语 3. 内部事件(如计时器超时)
2. 输出事件：1. 发出一个PDU 2. 向n层服务用户发出一条服务原语

根据时间的作用范围，可将事件分为

1. 通信事件。分为
   1. 同步事件。输入事件和输出事件发生在同一个事件点上，同时出现，也称为协同事件。
   2. 异步事件。输入事件和输出事件发生在两个事件点上，不同时出现，输出事件滞后输入事件
2. 内部事件。如计时器超时。不是成对出现的。





#### 协议操作和谓词

协议过程是指协议再一定条件下，在输入事件的驱动下，执行一系列的操作、动作。包括：

1. 产生输出事件
2. 清除和设置计时器
3. 修改协议变量
4. 改变协议状态

协议操作只在一定条件下才能够被执行。这些约束条件涉及协议参数、协议变量、协议运行环境等

谓词predicate: 描述这些约束条件的语句称为谓词





## 差错控制技术

1. 硬件途径：选用高可靠性的设备和传输媒体(e.g.光纤)及相应的辅助措施(e.g. 屏蔽)来提高传输的可靠性
2. 软件途径：通过差错控制编码(包括检错码和前向纠错码)实现的差错检测、肯定确认、超时重传、否认重传、选择重传等措施来实现差错控制。



### 报文丢失、重复、失序处理技术

> p38

1. 肯定确认
2. 否定确认
3. 选择确认



1. 独立确认。用一个确认PDU来携带确认信息
2. 应答携带piggy-backing。将确认信息放在数据PDU中发送



TCP协议设置了四个计时器：

1. 重传计时器
2. 坚持计时器
3. 保活计时器
4. 时间等待计时器



#### 重传

> p41，详情见Computer_Networ.md

发送者重传由确认所指出的数据PDU或重传计时器超时时重传未收到确认的数据PDU。主要有两种基于滑动窗口的重传方法

1. 回退n帧 Go-back-N
2. 选择重传 selective repeat





## 典型协议



### HDLC协议

> 属于数据链路层协议

- High-level Data Link Control 高级数据链路控制。国际标准ISO 3309
- HDLC可适用于链路的两种基本配置，即非平衡配置和平衡配置



- 标志字段F(Flag)。`01111110` 六个连续的1，两边各加一个0，作为标志字段。`0x7E`
- HDLC使用零比特填充法使帧中两个F字段之间不会出现6个连续的1。发送端只要发现有5个连续1，则立即填入一个0。接收端每当发现5个连续1，就将其后的一个0删除，即可还原成原来的比特流。采用零比特填充法可传送任意组合的比特流，或者说，可实现数据链路层的透明传输。故两个F字段之间叫透明传输区间。





### PPP协议

> 属于数据链路层协议

- 点对点协议PPP(Point-to-Point Protocol)
- 当PPP用在同步传输链路时，采用硬件来完成比特填充(与HDLC做法一样)
- 当PPP用在异步传输时，使用一种特殊的字符填充法:
  - `0x7E` to `0x7E 0x5E`
  - `0x7D` to `0x7D 0x5D`
  - ASCII码的控制字符(数值小于`0x20`的字符)，则在该字符前面加入一个`0x7D`字节，同时将该字符的编码加以改变，例如`0x03`要变为`0x31`。目的时防止这些表面上的ASCII码控制符被错误地解释为控制符



p51描述了PPP协议与LCP、NCP协议的互动过程



### IP协议

> 目前分为两个版本 IPv4 IPv6

p53详细描述了IP数据报的格式





### TCP协议

> 传输层协议

P57详细解释了TCP连接的三次握手的详细过程



### HTTP协议

> 因特网应用最广泛的应用层协议

- 面向事务的客户服务器协议
- 虽然HTTP使用了TCP，但HTTP是无状态的stateless. 每一个事务都是独立地进行处理，当一个事务开始时，就在万维网客户与服务器之间产生一个TCp连接。当事务结束时就释放这个TCP连接。
- HTTP协议本身是无连接的，但是使用了面向连接的TCP向上提供的服务

p58说明了HTTP请求报文的格式



# Description Model of Protocol Specification

> 协议规范描述模型 《网络协议逆向分析及应用》Chap 3 p61



在网络协议工程领域，有两大类常见的形式描述技术(Formal Description Techniques, FDT): 

1. 形式描述模型 Formal Description Model, FDM.  有限状态机；扩展的有限状态机；Petri网模型；时序逻辑/时态逻辑；通信系统演算；通信顺序进程
2. 形式描述语言 Formal Description Language, FDL. ( Specification and Description Language, SDL ), ( Language of Temporal Ordering Specification, LOTOS ), (Extended State Transition Language, ESTELLE), 抽象语法记法(Abstract Syntax Notation One, ASN.1), 各种高级程序设计语言如Pascal, C



协议报文数据可划分为若干个字段。

- 字段：具有特定语义的最小不可分割的子序列

字段间结构关系：

1. 顺序
2. 并列
3. 层次

构建合法报文的关键：

1. 协议格式中字段边界
2. 报文结构
3. 字段语义
4. 取值约束



p64 

字段语义可分为静态语义和动态语义两类：

1. 静态语义
2. 动态语义



静态语义所蕴含的上下文相关性可以分为两类：

1. 语义与符号特征相关
2. 语义与结构相关









---

---

---

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







# PcapPlusPlus

> https://pcapplusplus.github.io/docs/tutorials/intro

- PcapPlusPlus is built of 3 libraries: Common++, Packet++ and Pcap++.

### Packet++

- 解析、创建、编辑多种支持的协议的包的库
- 可以独立运行，不依赖于Pcap++, libpcap/WinPcap/Npcap等

主要类与功能:

1. `RawPacket`: 表示从网络捕获的原始数据
2. `Layer`: 所有协议层的基类。每个协议层负责解析属于该协议的数据包中的特定字节
3. `Packet` - representing a packet that was parsed by the different PcapPlusPlus protocol parsers and contains the different protocol layers
4. Protocol layers (e.g. `EthLayer, IPv4Layer, IPv6Layer, TcpLayer, UdpLayer, DnsLayer, HttpRequestLayer, HttpResponseLayer, PayloadLayer`, etc.) - classes representing specific protocol parsers. 都继承了 `Layer` class
5. `PacketUtils`: 包含多种常用功能的类。e.g. 计算5元组/2元组的哈希值
6. `TcpReassembly`: TCP重组(a.k.a TCP reconstruction) of TCP streams
7. `IPv4Reassembly` - a class for providing IPv4 reassembly (a.k.a IPv4 de-fragmentation) of IPv4 packets

### Pcap++

- 拦截、发送数据包，提供网络、网卡信息，统计数据等的库
- 主要是包捕获引擎(libpcap, WinPcap, Npcap, DPDK, PF_RING...)的c++包装器，但也提供了这些引擎中不存在的一些独特特性和功能

主要类与功能:

1. `PcapLiveDevice`:表示Linux/MacOS/FreeBSD网络接口，并允许捕获和发送数据包以及检索接口信息
2. `WinPcapLiveDevice`: 表示一个Windows网络接口，并包含' PcapLiveDevice '中暴露的所有功能。这个类实际上继承了' PcapLiveDevice '并为WinPcap/Npcap和Windows操作系统做了相关的调整
3. `DpdkDevice`: 表示一个支持DPDK的网络接口，并封装了用于捕获和发送数据包以及检索接口信息的DPDK基本功能
4. `PfRingDevice`: 表示启用PF_RING的网络接口，并封装用于捕获和发送数据包以及检索接口信息的PF_RING功能
5. `PcapRemoteDevice`: 表示远程机器上的网络接口，并允许使用rpcap协议在该接口上捕获和发送数据包。这个类实际上封装了WinPcap的远程捕获功能，因此只能在Windows上使用
6. pcap and pcap-ng file readers and writers (`PcapFileReaderDevice, PcapFileWriterDevice, PcapNgFileReaderDevice, PcapNgFileWriterDevice, IFileReaderDevice, IFileWriterDevice`)
7. 数据包过滤引擎 Packet filtering engine - a C++ API for the [BPF (Berkeley Packet Filter)](https://en.wikipedia.org/wiki/Berkeley_Packet_Filter) format for easy-to-use packet filtering from a network interface or pcap/pcap-ng file
8. `NetworkUtils` - 包含需要网络交互的公共和基本操作的类。e.g. 通过发送ARP请求发现远程机器的MAC地址, 通过主机名(通过发送DNS请求)发现IPv4地址...



### Common++

- 包含`Packet++`和`Pcap++`使用的公共代码实用程序和类的库

主要类与功能:

1. `IPv4Address, IPv6Address`: 表示IPv4/IPv6地址的类
2. `MacAddress`: 表示MAC(以太网)地址的类
3. `IpUtils.h`: 各种有用的网络工具
4. `LoggerPP`: PcapPlusPlus中广泛使用的一个简单的日志基础设施
5. `SystemUtils.h`: 几个用于与操作系统交互的实用工具



原始数据仅在RawPacket对象中存一次，不同层仅指向对应数据开始的地方。e.g. UDP Layer指向UDP开始的地方

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/PcapPlusPlus_LayersAndRawData.png)



### PcapPlusPlus Build on Linux

> installation case on Fedora33, build from source

```python
git clone https://github.com/seladb/PcapPlusPlus.git
cd PcapPlusPlus/
./configure-linux.sh --default
make all
sudo make install
```



### Cases



```cpp
// author: hexhex16@outlook.com
// 小的pcap文件生成方式： editcap -i 60 ./data/202010041400.pcap small.pcap
#include <pcap.h>
#include "IPv4Layer.h"
#include "Packet.h"
#include "PcapFileDevice.h"
#include "stdlib.h"

int main(int argc, char* argv[]) {
    // open a pcap file for reading
    pcpp::PcapFileReaderDevice reader("small_00000_20201004130000.pcap");
    if (!reader.open()) {
        printf("Error opening the pcap file\n");
        return 1;
    }

    // read the first (and only) packet from the file
    pcpp::RawPacket rawPacket;
    if (!reader.getNextPacket(rawPacket)) {
        printf("Couldn't read the first packet in the file\n");
        return 1;
    }

    // parse the raw packet into a parsed packet
    pcpp::Packet parsedPacket(&rawPacket);

    // verify the packet is IPv4
    if (parsedPacket.isPacketOfType(pcpp::IPv4)) {
        // extract source and dest IPs
        pcpp::IPv4Address srcIP =
            parsedPacket.getLayerOfType<pcpp::IPv4Layer>()->getSrcIpAddress();
        pcpp::IPv4Address destIP =
            parsedPacket.getLayerOfType<pcpp::IPv4Layer>()->getDstIpAddress();
        printf("Source IP is '%s'; Dest IP is '%s'\n", srcIP.toString().c_str(),
               destIP.toString().c_str());  // print source and dest IPs
    }

    while (reader.getNextPacket(rawPacket)) {
    }
    pcpp::IPcapDevice::PcapStats stats;
    reader.getStatistics(stats);
    printf("Read %lu packets successfully and %lu packets could not be read\n",
           stats.packetsRecv, stats.packetsDrop);

    reader.close();  // close the file
}
```





---

# websites

- reg007找一下这个号码和两个月邮箱注册了哪些网站