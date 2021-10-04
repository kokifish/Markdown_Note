

# 计算机网络基础

-   network core  主干网
-   access network  接入网: e.g. WiFi
-   network edge  网络边界:e.g. 主机、网络程序



**网络序是大端的**



因特网的三个组成部分为: end system, communication links, routers



学会 协会 工作组 部门 缩写

-   IANA 互联网地址分派机构 Internet Assigned Numbers Authority : 分派AS编号，IP地址
-   IEEE 电气电子工程师学会 Institute of Electrical and Electronics Engineers 念成I triple E
-   -   RA 注册管理机构 Registration Authority
-   ISOC 互联网协会 Internet Society
-   IAB 因特网体系结构委员会 Internet Architecture Board
-   -   IETF 因特网工程部 互联网工程工作小组 Internet Engineering Task Force
    -   IRTF 因特网研究部 Internet Research Task Force
-   ICANN 因特网名字和数字分配机构 Internet Corporation for Assigned Names and Numbers
-   ISP 互联网服务提供商 Internet Service Provider
-   ICP 互联网内容提供商 Internet Content Provider


方法 协议 标准相关

-   10BASE-F 10代表数据率为10Mb/s BASE 连接线上的信号是基带信号 F 光纤
-   100BASE-T 在双绞线上传送100Mb/s基带信号的星型拓扑以太网  T 双绞线
-   MTU 最大传送单元 Maximum Transfer Unit
-   CRC 循环冗余校验 Cyclic Redundancy Check
-   FCS 帧检验序列 frame check sequence
-   TCP/IP suite TCP/IP协议族



设备 网络

-   ARPANET Advanced Research Projects Agency Network (美国国防)高等研究计划署网络
-   ONU 光网络单元 Optical Network Unit
-   NIC 网络接口卡 Network Interface Card


-   QoS Quality of Service
-   PDU 协议数据单元 Protocol Data Unit
-   peer entity 对等实体。实现相同协议的两个实体



### TCP/IP Protocol Suite

-   TCP/IP协议簇并不定义数据链路层和物理层，所以可以把它们合并在一起看成物理网络

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/TCP_IP_Protocol_Suite.gif)

-   第一层为物理层
-   每一抽象层建立在低一层提供的服务上，并且为高一层提供服务



### 五元组

- 源IP地址，源端口，目的IP地址，目的端口，传输层协议

五元组能够区分不同会话，并且对应的会话是唯一的

- 例如：192.168.1.1 10000 TCP 121.14.88.76 80 就构成了一个五元组。其意义是，一个IP地址为192.168.1.1的终端通过端口10000，利用TCP协议，和IP地址为121.14.88.76，端口为80的终端进行连接



### 计算机网络的性能



1.  (数据传输)速率 数据率data rate, 比特率**bit rate**: 连接在计算机网络上的主机在数字信道上传送数据的速率
2.  **带宽 bandwidth**: 网络的通信线路传送数据的能力。网络带宽表示单位时间内从网络中某一点到另一点所能通过的"最高数据率" 比特每秒 b/s
3.  **吞吐量 throughput(bps, b/s)**: 一条链路或通道的实际数据传送速率(bps)。单位时间内通过某个网络(或信道、接口)的数据量。有时吞吐量还可以用每秒传送的字节数或帧数来表示。一个100Mb/s的以太网，额定速率是100Mb/s，这是吞吐量的绝对上限值，对于100Mb/s的以太网，典型的吞吐量可能只有70Mb/s
4.  时延delay/latency 延迟 迟延。总时延 = 发送时延 + 传播时延 + 处理时延 + 排队时延
    1. **发送时延 transmission delay**: 主机或路由器**发送数据帧所需要的时间**。**数据帧长度(b) / 发送速率(b/s)**
    2. **传播时延 propagation delay**: 电器波在信道中传播一定的距离需要花费的时间。信道长度(m) / 电磁波在信道上的传播速率(m/s)
    3. 处理时延
    4. 排队时延
5.  时延带宽积: 时延带宽积 = 传播时延 X 带宽
6.  **往返时间 (RTT) Round-Trip Time**: 从源主机到目的主机再返回源主机所花的时间。发送方发送数据开始，到**发送方收到接收方的确认**所需的总时间
7.  利用率 信道利用率: 某信道有百分之几的时间是被利用的(有数据通过)。 网络利用率: 全网络的信道利用率的加权平均值。带宽的最大利用率=最大吞吐量/带宽





对等实体：指实现了同一个协议的软件或硬件。对等实体之间传输的数据包为协议数据单 protocol data unit (**PDU**)

---

# 五层协议的体系结构

-   五层协议的体系结构只是为介绍网络原理而设计的，实际应用的是TCP/IP四层体系结构



注意有的地方将ARP RARP protocol归类到网络层

五层协议的体系结构：

-   Application Layer: message 报文。提供对某些专门应用的支持
-   Transport Layer: segment 报文段
-   Networ Layer: **datagram** 数据报 //TCP/IP suite中的网络互连层(internet layer)
-   Data Link Layer: frame 帧
-   Physical Layer : bit 比特



-   应用层：HTTP，FTP，SMTP，DNS，Telnet，SSH，RIP，TFTP，SNMP，
-   传输层：TCP，UDP，TLS，DCCP，SCTP，RSVP，OSPF，
-   网络层：IP，ICMP，ARP，RARP，EIGRP，IGMP，
-   数据链路层：PPP，帧中继，PPTP，HDLC，SLIP，CSLIP，MTU，Wi-Fi(IEEE 802.11)，Ethernet
-   物理层：Ethernet，电力线通信(PLC)



# ISO/OSI 七层体系结构



-   表示层 **Presentation Layer** : 把**数据转换**为能与接收者的系统格式兼容并适合传输的格式。e.g. 数据转换服务，加密解密，压缩解压缩，数据格式变换
-   会话层 **Session Layer** : 负责在数据传输中设置和维护电脑网络中两台电脑之间的**通信连接**。简化会话实现机制。e.g. 音视频同步



![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_OSI_7_layers.gif)

---

# Physical Layer 物理层

> 第一层，TCP/IP四层模型中将物理层和数据链路层视为一层



两种直连网:

1.  点对点: 两个host直接相连
2.  多路访问: 多为局域网使用




-   信道channel：向**某一个方向**传送信息的媒体。故一条通信电路往往包含 发送信道+接收信道

1.  simplex 单向通信(单工): 只有一个方向的通信而没有反方向的交互
2.  half duplex 双向交替通信(半双工): 通信的双方都可以发送信息，但不能双方同时发送/接收。这种通信方式是一方发送另一方接收，过一段时间后再反过来(有时也称单工)
3.  full duplex 双向同时通信(全双工): 通信的双方可以同时发送和接收信息。传输效率最高

---


### 传输媒体

-   传输媒体 传输介质 传输媒介
-   数据传输系统中 发送器和接收器之间的物理通路
-   导引型传输媒体 非导引型传输媒体//导引型: guided


双绞线

-   屏蔽双绞线 STP Shielded Twisted Pair
-   无屏蔽双绞线 UTP Unshielded Twisted Pair

同轴电缆

-   内导体铜质芯线(单股实心线或多股绞合线)、绝缘线、网状编织的外导体屏蔽层(也可以是单股的)、保护塑料外层
-   抗干扰(外导体屏蔽层)，广泛用于传输较高速率的数据

##### 光纤

-   光纤通信利用光导纤维(光纤)传递光脉冲进行通信，有脉冲为1
-   全反射 total reflection    折射 refraction

1.  单模光纤 Single Mode Fiber: 只能传一种模式的光纤。Date Rate: > 40Gbps, Maximum Distance: 50km. //具有**最大的数据传输速率，最远传输距离**。
2.  多模光纤 : 在给定的工作波长上传输多种模式的光纤。按折射率的分布分为突变型和渐变型
    1.  阶跃stepped光纤 step-index multimode fiber: 折射率基本上是平均不变，而只有在包层(cladding)表面上才会突然降低。纤芯直径较大，传输模态较多，因而带宽较窄，传输容量较小。Date Rate: 4Gbps, Maximum Distance: 5000m.
    2.  渐变(梯度型)graded光纤 graded-index multimode fiber: 芯的折射率(refraction index)于芯的外围最小而逐渐向中心点不断增加，从而减少讯号的模式色散。纤芯中折射率随着半径的增加而减少，可获得比较小的模态色散，因而**频带较宽，传输容量较大**，目前一般都应用后者。速率和最大距离都在阶跃和单模之间。

-   单模传输距离远
-   多模传输带宽大
-   单模不会发生色散，质量可靠
-   单模通常使用激光作为光源，贵，而多模通常用便宜的LED
-   单模价格比较高
-   多模价格便宜，近距离传输可以



![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Net_light.png)




### Multiplexing 复用





-   时分多路复用 Time Division Multiplexing (STDM--Synchronous TDM): Every timesolt has equal length.
-   频分多路复用 Frequency Division Multiplexing: //e.g. 无线电台
-   波分多路复用 Wavelength Division Multiplexing(WDM): 利用多个激光器在单条光纤上同时发送多束不同波长激光的技术。WDM的每个信号经过数据（文本、语音、视频等）调制后都在它独有的色带内传输。WDM能使电话公司和其他运营商的现有光纤基础设施容量大增。
-   密集波分复用 Dense Wavelength Division Multiplexing(DWDM): 可以支持150多束不同波长的光波同时传输，每束光波最高达到10Gb/s的数据传输率
-   码分多路复用 Code Division Multiplexing:
-   统计多路复用 Statistical Multiplexing: 采用动态分配的方法共享通信链路，比如，先到先发送(FIFO)。对于多个可变速率的数据流，统计多路复用可以提高链路利用率。

> 如果有8个速率相同的数据流，且它们速率之和小于且非常接近一条链路的带宽，与用8个通道(channel)的TDM或FDM传送它们相比，采用统计多路复用技术的带宽利用率(传送有效数据的比率) 更差 //都可以用完整个带宽，只是统计复用需要地址(地址所占用的带宽会导致宽带利用率下降)

电路交换技术(Circuit-Switching)采用FDM、TDM、WDM和CDM技术。
包交换技术(Packet-Switching)采用统计多路复用技术。

---

### Hub 集线器

-   物理层设备，作用于比特而不是帧
-   当一个bit到达一个接口时，hub重新生成这个帧，将能量强度放大，并向其他所有接口传输出去
-   不可以隔离冲突域 collision domain





---

# Data Link Layer 数据链路层

> packet: **帧frame**
>
> node to node

-   计算机网络的低层，负责把数据从一node通过links传给相邻的另一个node(主机和路由器)



主要功能:

1.  封装成帧 framing: 在一段数据的前后分别添加首部和尾部
2.  差错检测 error detect: 比特错、纠错
3.  差错控制 error control: 丢包missing、重复、错序、流控制 flow control
4.  介质访问控制medium access control: 多路访问、碰撞collision


数据链路层使用的信道主要有:

1.  点对点信道
2.  广播信道

在广播式多路访问链路中（局域网），由于可能存在介质争用，分为两个子层:

1.  LLC 逻辑链路控制子层 Logical Link Control 与媒体传输无关 已成历史
2.  MAC 媒体接入控制子层 Media Access Control 与媒体传输有关

**链路层常用CRC检验**，因为容易用硬件实现，速度快，检错率很高。
CRC-CCITT(x16+x12+x5+1)的错误检测能力：可以检出所有随机奇数位错误和双位错，可以检出所有长度小于等于16位的突发错；对于长度等于17位的突发错误，检错率为99.9969%；长度大于等于18位的突发错误，检错率为99.9985%。



### 封装成帧&透明传输

> 以太网采用inter-frame space 成帧(framing)方法

-   Framing封装成帧
-   透明传输：不管所传数据是什么样的比特组合，都应当能够在链路上传送
-   每一个数据链路层协议都规定了所能传送的帧的数据部分长度上限：最大传送单元MTU(Maximum Transfer Unit)



字节填充 character stuffing / byte stuffing：

![](http://op4fcrj8y.bkt.clouddn.com/18-4-12/82128637.jpg)

-   转义字符"ESC": 0x1B，若数据链路层的帧数据中有SOH(Start Of Header)或EOT(End Of Transmission)则在前面插入ESC。若数据中出现ESC则在ESC前插入一个ESC
-   接收端在把数据送往网络层之前删除插入的转义字符

---

### MAC子层

> 多路访问链路（广播链路）采用共享介质连接所有站点。发送站点通过广播方式发送数据并占用整个共享介质的带宽。由于每个站点只需要一条线接入网络就可以访问所有站点，这种网络一般安装简单，价格便宜。局域网(Local Area Network, LAN)都是使用这种链路

-   介质访问控制(**Media Access Control**)子层。逻辑链路控制子层及物理层之间沟通的媒介
-   专职处理**介质访问的争用与冲突问题**，提供定址及媒体访问的控制方式
-   使得不同设备或网络上的节点可以在多点的网络上通信，而不会互相冲突
-   **硬件地址**：固化在网卡上的ROM中，又称**物理地址**，**MAC地址**，**以太地址**




MAC常用作多路访问（multiple access）协议的同义词。因为MAC提供配合特定通道访问（channel access method）需要的协议及控制机制。因此连接在同一传输媒体的几个设备可以共享其媒体。 这种的例子包括总线网、环状网、HUB网络、无线网络及半双工的链接





一些使用在有线网络的分组交换多路访问协议：

-   CSMA/CD 在Ethernet及IEEE 802.3使用
-   令牌环Token Ring, (IEEE 802.5))
-   令牌环总线 Token Bus,IEEE 802.4)
-   令牌传递Token Passing,在FDDI使用）

一些使用在无线网络的分组交换多路访问协议：

-   CSMA/CA
-   槽式ALOHA协议
-   动态TDMA
-   预约ALOHA协议
-   CDMA
-   OFDMA

---


### LLC子层

-   逻辑链路控制(Logical Link Control)子层
-   局域网中数据链路层的上层部分
-   用户的数据链路服务通过LLC子层**为网络层提供统一的接口**



LLC提供了两种无连接和一种面向连接的三种操作方式

1.  LLC1提供**无确认无连接**服务：多点和广播传输在同一信息需要发送到整个网络的情况下可以减少网络流量。单点传输不能保证接收端收到帧的次序和发送时的次序相同。发送端甚至无法确定接收端是否收到了帧。允许发送帧时：
    1.  给单一的目的地址（点到点协议或单点传输）
    2.  给相同网络中的多个目的地址（多点传输）
    3.  给网络中的所有地址（广播传输）
2.  LLC2提供**有确认面向连接**的服务：给每个帧进行编号，接收端就能保证它们按发送的次序接收，并且没有帧丢失。利用滑动窗口流控制协议可以让快的发送端也能流到慢的接收端
3.  LLC3提供**有确认无连接**的服务：仅限于点到点通信



---

## PPP 点对点协议

-   Point - to - Point Protocol 点对点协议
-   PPP包含: 基本的成帧功能 网络控制协议 NCP (Network Control Protocol)   
-   可以提供连接认证，传输加密，压缩
-   用于不同物理网络：串口线，电话线，中继链接，移动电话，特殊无线电链路，光纤链路
-   互联网接入连接(宽带)：ISP使用PPP为用户提供到Internet的拨号接入




PPP协议使用帧校验序列FCS(Frame Check Sequence)来检查每一个单独的帧是否发生错误，PPP也可以监控哪些帧在接受的时候总是发生错误，并且可以通过配置来降低这个发生过多错误的接口

PPP协议是一个协议集：

1.  LCP 链路控制协议 Link Control Protocol: 建立点对点链路，是 PPP 中实际工作的部分。LCP 位于物理层的上方，负责建立、配置和测试数据链路连接。LCP 还负责协商和设置 WAN 数据链路上的控制选项，这些选项由 NCP 处理。支持同步和异步线路，也支持面向字节的和面向位的编码方式，可用于启动路线、测试线路、协商参数、以及关闭线路
2.  **NCP** 网络控制协议 Network Control Protocol: 负责在PPP会话中协商使用的通讯协议和配置初始化参数(例如 IP网络控制协议是在PPP会话中传递IP协议的数据包时用来配置初始参数的协议。负责连接PPP(第二层)和网络协议 (第三层)。对于所使用的每个网络层协议，PPP 都分别使用独立的 NCP来连接。//e.g. **Internet 使用 IP 控制协议 (IPCP)**，IPX 使用 Novell IPX 控制协议 (IPXCP)
3.  PPP 的扩展协议(如Multilink Protocol)





PPP协议的六阶段

1.  链路不可用阶段：初始阶段 
2.  链路建立阶段：**LCP**协商，（协商认证方式等） 
3.  验证阶段：PAP/CHAP验证 
4.  网络层协议阶段：NCP协商。**IP 使用 IP 控制协议 (IPCP)获取IP地址**
5.  PPP会话维持阶段：维持PPP会话， 定时发送Echo Request报文，并等待Echo Reply报文 
6.  网络终止阶段：终止PPP会话，回到链路不可用阶段

### PPP Frame

-   PPP协议采用HDLC的广播地址(0xFF)和无编号帧(0x03)
-   PPP协议采用字节填充法(Byte-stuffing): 信息字段出现的标志字节(0x7E)用0x7D-5E 替
    换，0x7D用0x7D-5D替换。所有小于0x20的字节(控制字节)都加上值0x20，并在前面
    加上转义字符0x7D //e.g. 0x01用0x7D-21替换
-   PPP协议的16位CRC校验码的除数为x16 + x12 + x5 + 1
-   协议字段(Protocol)指明上层协议，例如, 0x802B-IPX，0x0021-IP，0xC021-LCP，
    0x8021-IPCP等
-   可以省略地址和控制字节(头部压缩)。PPP协议还可以进行TCP压缩和数据压缩
-   PPP协议没有纠错功能，也没有流控制和确保有序的功能

```c
|  1     |   1    |   1    |   1或2  |   ≤1500   |  2 or 4  |   1     |bytes
|  标志  |  地址   |  控制  |   协议   |   数据   |   校验码  |  标志   |
|01111110|  0xFF  |  0x03  |   ...   |   ...   |CRC-16/CRC-32|01111110|
```







---

## Ethernet 以太网

-   以太网：一种计算机局域网技术
-   IEEE 802.3标准制定了以太网的技术标准(涉及物理层 MAC子层)
-   使用MAC地址。使用 character-stuffing 字符填充实现透明传输
-   同一局域网中一台主机要和另一台主机进行直接通信必须知道目标主机MAC地址
-   以太网的标准拓扑结构为总线型拓扑，但目前的快速以太网（100BASE-T、1000BASE-T）为了减少冲突，将能提高的网络速度和使用效率最大化，使用交换机（Switch hub）来进行网络连接和组织。如此一来，以太网的拓扑结构就成了星型；但在逻辑上，以太网仍然使用总线型拓扑和CSMA/CD的总线技术

以太网采用的帧(framing)方法 ：inter-frame space. 每帧发送前要求信道空闲时间至少为96bits，这会造成每帧之间有空隙

### Ethernet Frame

-   Ethernet 采用inter-frame space的成帧(framing)方法//每帧发送前要求信道空闲时间至少为96bits，这会造成每帧之间有空隙

802.3的MAC帧格式：

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Net_802.3_MAC.png)

-   前导字符 Preamble：同步字符(7B)和起始定界符(Start of Frame Delimiter)(1B)

-   类型/长度字段 Type/Length：**指明上层协议(>1500)或有效载荷的长度(≤1500)**。0x0800 IP数据报、0x0806 ARP报文、0x0835 RARP报文

    DIXv2帧：类型。≥1536 （0x0600）。802.3帧（原）：长度。(SNAP格式)。802.3帧（1997年修订）：类型/长度


```python
# Ethernet_II Frame Format (Type >= 1536)
|   6 B   |   6 B   | 2B |  46-1500B  |  4B  |
| dst.MAC | src.MAC |Type|    Data    |  FCS |
```

1. dst.MAC: 目的MAC地址。目标地址可以是接收者的单播地址，也可以是多播地址和广播地址
2. src.MAC: 源MAC地址。源地址一般为发送者的单播地址
3. Type: 数据字段中包含的高层协议。Type>=1536(`0x0600`): Ethernet_II帧。46<= Type <=1500：IEEE 802.3帧。
4. Data: 网络层(IP层) 数据，有效载荷 Payload。最小长度必须为46字节以保证帧长度至少为64字节。以太网的最大传输单元(Maximum transmission unit MTU)是1500 Byte。不足46字节时加入填充字节(任何字节)至46字节
5. FCS(Frame Check Sequence): 帧校验序列，循环冗余校验字段。对目的地址、源地址、类型/长度和有效载荷（加填充位）字段进行CRC-32校验





-   单播地址：全球唯一。每个网卡(或接口)一个，最高字节的最低有效位为0。如：06-01-02-01-2C-4B。也称为网卡地址，烧录地址(Burned-In-Address，BIA)，MAC地址，硬件地址，物理地址
-   多播地址的字节0的第0位为1 ，并且地址非全1。如：01-00-5E-20-01-4B
-   广播地址的48位全为1
-   I/G:0-Individual(单播) 1-Group(多播)
-   U/L: 0-Universal(厂家给的)1-Local(管理员改的)
-   IEEE为每个厂商分配的唯一的厂商号(Organization Unique Identifier, OUI)。例如，00-00-0C和00-AA-00分别为思科和Intel的厂商号。厂商再为其生产的每个网卡或接口分配序号。从字节0开始发送，每个字节从低位(bit0)开始发送(802.3和802.4),802.5和802.6从高位(bit7)开始发送。




接收帧的方法

-   以太网站点(网卡)会缓存所有的帧
-   如果缓存的帧有错(长度错误，CRC错等)，则丢弃它
-   如果缓存的帧的目的地址为单播地址并且与接收该帧的网卡的MAC地址一致，则接收它。如果目的地址为多播地址并且为网卡预设的多播地址之一，或者为广播地址，也接收它。其它情况则丢弃它
-   如果把网卡设置为混杂模式则会接收所有无错的帧。



### CSMA/CD protocol

> Carrier Sense Multiple Access With Collision Detection 带有冲突检测的载波侦听多路存取(访问)协议

-   IEEE 802.3使用的一种媒体访问控制方法
-   起源: ALOHA网 美国夏威夷大学开发
-   在总线网使用(局域网按网络拓扑分为星形网 环形网 总线网)



发送帧的方法：

1.  发送数据帧之前先**监听**信道。如果**信道空闲，立即发送**(96bits空闲时间)。如果**信道忙，则持续监听**，直到信道空闲，立即发送
2.  边发送边检测冲突。如果发送完毕都没有检测到冲突，则发送成功
3.  如果检测到冲突，则停止发送，并发送**32位干扰位**(4B jamming signal)以加强冲突信号。采用**二进制指数退避算法**随机延迟一段时间后，转(1)

```
IEEE 802.3 MAC协议的10Mbps实现方案的参数值:
Slot Time（时间片） 512比特时间
Inter Frame Gap（帧问间隔） 9．6微秒
attempt limit（尝试极限） 16
Back off limit（退避极限） 10
Jam size（人为干扰长） 32比特
max Frame size（最大帧长） 1518字节
min Frame size（最小帧长） 64字节
address size（地址字段长） 48比特
```





-   1-persistent CSMA 1-持续CSMA：信道空，立即发送；信道忙，持续监听（以太网）长的传播延迟和同时发送帧,会导致多次冲突,降低系统性能
-   non-persistent CSMA 非持续CSMA：信道空，发送；信道忙，**随机延迟**一段时间。导致信道利用率降低，以及较长的延迟
-   p-persistent CSMA p-持续CSMA：信道空，立即**以概率p发送**，以概率1-p延迟一个时间槽；信道忙，延迟一个时间槽(分槽ALOHA)



### 二进制指数退避算法

> 二进制指数退避算法 binary exponential backoff

-   前十次冲突后可选时间片数量每次加倍, 后五次冲突后可选时间片数量不变,所以也称为截止式(truncated)二进制指数退避算法


-   第一次冲突从0个或1个时间片中随机选择一个进行延迟
-   第二次冲突从0，1，2，3个时间片中随机选择一个
-   ...
-   第i 次冲突从0，1，…，2^j-1^个时间片随机选择一个. i<16. j = min(i，10)
-   时间片τ的长度为512比特的时间，10Mbps的以太网为51.2 μs





### 最短帧&冲突域&广播域

-   以太网(10M bps 10Base5)相距最远的两个站点（2500m，A和B)之间的信号往返时间为51.2 μs
-   假如站点A发送的数据在快到达站点B时与其发送的数据冲突，因为发送站点只在发送时才检测冲突，为了检测到返回的冲突信号，则要求站点A此时还在发送，故帧长至少为512b(64B)
-   64B也称为**争用窗口(contention window)长度**

>   电磁波在1km电缆的传播时延为5μs





-   如果通过两个接口同时发送数据会产生冲突，则这两个接口属于同一个**冲突域(collision domain)**。**一个广播帧可以到达的所有接口属于同一个广播域**。
-   属于同一个**冲突域**的以太网部分称为**网段(segment)**
-   switch交换机可以分割冲突域，网桥可以分割冲突域，hub不分割冲突域

为什么二进制指数退避算法选择最短帧的发送时间作为其时间槽(time slot)τ的长度？因为最短帧的发送时间保证了首先发送的站点的信号可以到达最远的站点。如果先发送的只有一个站点，其他站点要不就检测到发送站点的信号而不能发送，要不就因为发送站点发送完毕而检测到信道空闲，总之不会与之冲突。也就是说，任何间隔τ或以上时间的两个准备发送数据的站点不会发生冲突。



## Switch 交换机

> 交换机 switch 是一个把多个网段连接起来的设备，也称为多端口网桥

-   第二层交换机工作在数据链路层
-   交换机可以工作在全双工模式下，因为没有冲突，CSMA/CD算法可以被关闭
-   交换机会增加冲突域的数量，减少冲突范围的大小
-   switch tracks MAC addresses of directly-connected devices

转发方法

- 存储转发(Store and forward): 交换机接收整个帧后转发它。大部分交换机都采用这种转发模式。
- 直通(Cut through): 交换机不用收到整个帧而是收到帧的硬件地址后立即转发它。如果输出(outgoing port)忙，则会转为存储转发。
- 无碎片(Fragment free): 交换机不用收到整个帧而是收到帧的前64个字节（冲突窗口）后立即转发它
- 适应性交换(Adaptive switching): 自动在上面三种方式进行选择

---

## bridge 网桥

-   用网桥(bridge)连接若干局域网(LAN)可以建造一个更大的局域网, 称为桥接的局域网(bridged LAN) 或扩展局域网(extended LAN)
-   原来的局域网就成为该扩展局域网的一部分，称为该扩展局域网的一个网段Segment(一个网段就是一个冲突域)





### flood/filter/forward

网桥收到一个单播帧，用该帧的目的地址查询MAC地址表

1.  如果没有查到，则**扩散**(**flood**)该帧
2.  如果查到，则看查到的端口是否为收到该帧的端口
    1.  欲发送端口等于接收端口，则**丢弃**(**filter过滤**)//同一网段的帧丢弃
    2.  否则把该帧从查询到的端口**发送**出去(**forward**)

当网桥收到多播或广播帧，直接扩散(flood)

>   **扩散 flood**: 把网桥收到的帧转发到**除了该帧的接收端口以外的所有端口**





### 透明网桥算法

-   透明网桥(transparent bridge)的标准是802.1D
-   网桥：即插即用设备，只要把网桥接入LAN，不需要改动硬件和软件，无需设置地址开关，无需装入路由表或参数，网桥就能工作

自学习：

1.  MAC地址表初始为空
2.  网桥从端口接收所有的帧，并把接收到的帧的源地址和接收端口记录到MAC地址表中：如果该源地址在MAC地址表中不存在，则增加一个新记录，并启动超时定时器；如果存在，则更新接口并重启超时定时器
3.  网桥会自动删除超时的记录





### Spanning Tree Protocol

-   **生成树协议** Spanning Tree Protocol, STP 工作在数据链路层 IEEE 802.1d
-   防止交换机冗余链路产生环路，确保以太网中无环路的逻辑拓扑结构，从而避免了广播风暴,大量占用交换机的资源
-   任意一交换机中如果到达根网桥有两条或者两条以上的链路.生成树协议都根据算法把其中一条切断,仅保留一条.从而保证任意两个交换机之间只有一条单一的活动链路

桥协议数据单元 BPDU Bridge Protocol Data Unit（以太网的多播帧）: <当前根BID，到根的距离，发送BID，发送端口>

网桥ID(Bridge ID, BID):优先权(2B)和网桥的MAC地址(6B)，这里用网桥下标表示。端口PID(Port ID, PID):优先权(1B)和序号(1B)，这里直接用序号表示。

根端口：网桥上离根最近的端口

指定网桥：网段上离根最近的网桥

指定端口：指定网桥上与网段连接的端口

阻塞端口：网桥上既非根端口又非指定端口



如果到根网桥的最短路径有多条，可以采用最短路径上的下一个网桥ID和下一个端口ID用于打破平衡（取更小的）。
网桥只在根端口和指定端口之间转发帧

工作过程:

1.  根网桥的选举，其依据是网桥优先级 bridge priority 和MAC地址组合生成的桥ID，优先级最高(数字最小)成为根桥 bridge root。否则看网桥ID: 桥ID最小的网桥将成为网络中的根桥。
2.  在此基础上，计算每个节点到根桥的距离，并由这些路径得到各冗余链路的代价，选择最小的成为通信路径(相应的端口状态变为forwarding)，其它的就成为备份路径(相应的端口状态变为blocking)

-   STP生成过程中的通信任务由BPDU完成，这种数据包又分为包含配置信息的配置BPDU（其大小不超过35B）和包含拓扑变化信息的通知BPDU（其长度不超过4B）



| STP端口状态        | STP端口能力                      |
| -------------- | ---------------------------- |
| **Blocking**   | 不接收或者转发数据，接收但不发送BPDU，不进行地址学习 |
| Disabled       | 不收发任何报文                      |
| **Forwarding** | 接收或者转发数据，接收并发送BPDU，进行地址学习    |
| Learning       | 不接收或者转发数据，接收并发送BPDU，开始进行地址学习 |
| Listening      | 不接收或者转发数据，接收并发送BPDU，不进行地址学习  |





## VLAN

> 虚拟局域网, Virtual LAN, VLAN

具有相同的VLAN ID的端口处于同一个VLAN，交换机端口的默认VLAN为VLAN 1。

一个VLAN的帧只能转发到属于同一个VLAN的端口或者干道端口。**只有发往干道trunk端口的帧才需要加上VLAN ID，非trunk端口的按照端口属于哪个VLAN确定VLAN ID，帧中不含VLAN ID**。从干道收到的帧中如果没有VLAN ID，则认为是本征VLAN(Native VLAN)，默认为VLAN 1。发往干道的Native VLAN的帧不加VLAN ID。



## MPLS 多协议标签交换

> Multi-Protocol Label Switching  一种高效的数据传输的技术     2.5层协议
>
> https://zhuanlan.zhihu.com/p/27232535

- MPLS是利用标记（label）进行数据转发的。当分组进入网络时，要为其分配固定长度的短的标记，并将标记与分组封装在一起，在整个转发过程中，交换节点仅根据标记进行转发
- MPLS 独立于第二和第三层协议，诸如ATM 和IP。它提供了一种方式，将IP地址映射为简单的具有固定长度的标签，用于不同的包转发和包交换技术。它是现有路由和交换协议的接口，如IP、ATM、帧中继、资源预留协议（RSVP）、开放最短路径优先（OSPF）等等



- 在MPLS网络中，路由决策是基于Label的，路由器不需要对数据包进行解包
- Label：是一个整数，可达到O(1)的查找时间，在MPLS网络里作为网络数据包的一部分传输
- MPLS的核心就是，一旦进入了MPLS网络，那么网络数据包的内容就不再重要，路由决策（包括FEC归属的计算，next hop的查找）都是基于Label来进行的
- MPLS把Label作为IP协议报文的一部分，存储在IP协议报文中。通常情况下，MPLS操作在OSI的2层（数据链路层）和3层（网络层）之间，因此也常常被认为是2.5层协议。这也就是MPLS能支持Multiprotocol的原因。Label不依赖于任何协议，直接定义在2-3层之间





- FEC（Forwarding Equivalence Class）：交换等价类，同样的转发路径的网络数据包的集合。

- MPLS网络：由支持MPLS的，相连的设备的构成。

- LSH（Label Switching hop）：IP协议报文从一个MPLS设备发送到另一个MPLS设备，区别于传统的路由交换，LSH是基于Label的转发。

- **NHLFE**（Next Hop Label Forwarding Entry）：LSR中用来转发条目，相当于路由表之于路由器。包含了：

- - 下一跳：nexthop

  - 对数据包的当前label需要做的操作，包括了：

  - - 替换（SWAP）
    - 删除（POP）
    - 添加（PUSH）

- LER（Label Edge Router）：有的地方也叫做 MPLS edge node。顾名思义，MPLS网络的边缘设备。

- - MPLS ingress node：进入MPLS网络的节点，也就是MPLS网络的入口路由器。该设备计算出IP协议报文归属的FEC，并把相应的Label放入IP协议报文。
  - MPLS egress node：出MPLS网络的节点，也就是MPLS的出口路由器。IP协议报文在这里回到传统的路由系统中。

- LSR（Label Switching Router）：支持MPLS转发的路由器。如果一个LSR有一个邻接的节点在MPLS网络之外，那么这个LSR就是LER。注意，这里的MPLS网络之外可以是：1.传统路由网络，2.另一个MPLS网络。

- LSP（Label Switching Path）：特定的FEC中的IP协议报文所经过的LSR的集合。LSP通常也被称为MPLS tunnel。





### MPLS 协议格式

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_MPLS_packet_MPLS_Label.jpg)

- Label：20bit的整数，容量是百万级的
- TC：之前的EXP，改名成TC，由[RFC5462](https://link.zhihu.com/?target=https%3A//tools.ietf.org/html/rfc5462)定义。
- S：bottom of stack。什么是stack，一种常见的数据结构类型，特点是后进先出。S为1表明这已经是栈底了，即当前Label是IP协议报文最后一个MPLS标签。再执行一个POP操作，就能变成正常的IP协议报文了
- TTL：TTL在IP协议里面的作用主要是防止环路和用于traceroute等工具。在之前的文章[Traceroute](https://zhuanlan.zhihu.com/p/24982540)里详细介绍过。MPLS里面的TTL作用是一样的。当数据包进入MPLS网络，网络层中的TTL会被拷贝至MPLS的TTL，每一次LSH，TTL减1，数据包出MPLS网络，MPLS中的TTL会拷贝至网络层



![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_MPLS_Multi_Label.png)











---

# Network Layer 网络层

> 第3层
>
> 同一个互联网络中要求网络层协议相同而链路层协议可不同

-   **网际层** internet layer 或 IP层 //是TCP/IP协议族中的网络互连层internet layer
-   网络层向上只提供简单灵活的、无连接的、尽最大努力交付(best effort delivery)的数据报服务，尽力而为服务(best-effort service)
-   不可靠交付 网络层不提供服务质量的承诺
-   IP地址是指互联网协议地址(Internet Protocol Address，又译 网际协议地址)，是IP Address的缩写。IP地址是IP协议提供的一种统一的地址格式，它为互联网上的每一个网络和每一台主机分配一个逻辑地址，以此来屏蔽物理地址的差异

网际协议IP是TCP/IP体系中两个最主要的协议之一

与IP协议配套使用的三个协议:

1.  ARP 地址解析协议 Address Resolution Protocol
2.  ICMP 网际控制报文协议 Internet Control Message Protocol
3.  IGMP 网际组管理协议 Internet Group Management Protocol




-   routing: determine route taken by packets from src to dst. //routing algorithms
-   forwarding: move packets from router’s input to appropriate router output

---

## IPv4

-   网际协议Internet Protocol
-   **互联网协议地址** Internet Protocol Address **网际协议地址** **IP地址** IP Address 是分配给网络上使用网际协议（Internet Protocol, IP）的设备的数字标签
-   IP协议是可路由的Routable. IP协议可以用于连接任何物理网络 
-   XXX.XXX.XXX.XXX点分十进制(dotted decimal) (XXX = 0 \~ 255)







### IPv4 datagram

```python
# IPv4 header format
  |0         |4         |8         |12        |16       19|20        |24        |28         31|Bit
 0| Version  |    IHL   |         TOS         |               Total Length                    |
 4|           Identification                  | Flags  |          Fragment Offset             |
 8|    Time To Live     |       Protocol      |                   Header Checksum             |
12|                                 Source IP Address                                         |
16|                               Destination IP Address                                      |
20|                      Options and Padding (optional) (if IHL > 5)                          |
```

- IPv4报头长度: **[20, 60]** Bytes

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_ipv4_datagram.png)


| 字段           | bit  | 说明                                                         |
| -------------- | :--- | ------------------------------------------------------------ |
| 版本           | 4    | 共两个版本：4 for IPv4, 6 for IPv6                           |
| 头部长度(IHL)  | 4    | 头部的长度，以字(**4B**、32-bit)为单位 **20B \~ 60B**        |
| 服务类型(TOS)  | 8    | (Type of Service)本IP数据报希望得到的服务。该字段被重新定义为**区分服务** |
| 总长度         | 16   | 整个数据报的长度，以**字节**为单位(含头部长度)               |
| 标识           | 16   | 每产生一个IP数据报，加一(被分段的IP数据报标识一样)           |
| Flags(DF,MF)   | 3    | Reserved. DF: Don’t Fragment(1:不分片). MF: More Fragment(1:还有分片). |
| 片偏移量offset | 13   | **片偏移量以8B(64bit)为单位**                                |
| 生存期TTL      | 8    | 记载经过的router数(跳数)hop count //TTL限制了因特网的直径    |
| 协议           | 8    | 定义数据部分的协议//**TCP:6**, **UDP:17**, ICMP:1, IGMP:2, ENCAP(IPv6 encapsulation): 41 |
| 头部校验       | 16   | 头部校验和checksum。路由器会丢弃出错的数据报                 |
| 源IP地址       | 32   | 发出本数据报的地址                                           |
| 目的IP地址     | 32   | 接收本数据报的地址                                           |
| 选项和填充位   | 可变 | 最多40B，填充位用于32bit(4B)对齐                             |

>   生存期 TTL(Time To live): 当收到IP数据报时，路由器或主机会把它的TTL减1。TTL限制了因特网的直径。防止数据报长时间滞留在因特网上
>   需设置为网络直径的两倍，router丢弃TTL为0的datagram(并发送一个ICMP packet告知source host)，host则接收(如果是发给自己的)
>   Win8 Linux默认64 Win10默认128 Unix默认255

- 服务类型(TOS) 8bit: 现在替换为两个字段:
  - Differentiated Services Code Point (DSCP) 6bit: 
  - Explicit Congestion Notification (ECN) 2bit: 



#### IP Datagram Fragment

-   一个物理网络的最大传输单元( maximum transmission unit, **MTU**)是该网络可以运载的最大有效载荷，即数据帧的数据部分的最大长度。例如：以太网(DIXv2)的MTU为1500, FDDI和令牌环的MTU分别为4353和4482
-   如果一个datagram的大小大于要承载它的网络的MTU，路由器需要先对该数据报进行**分段(fragment)**
-   源主机每次发送IP数据报时都会把标识(Identification)字段加1。**分段时标识的值保持不变**，并且用**偏移量字段(offset)**指出该片段的数据部分相对(最)原来数据报的偏移量(以**8B**为单位)
-   分段后会改变：头部校验，总长度，偏移量，MF

```python
# 一个没有选项的IP数据报的总长度为3000字节，标识(iden)是10034，DF=0，OFFSET=0，要转发到MTU=800的物理网络上。如果前面的片段尽量大，划分片段后的 
iden offset MF
10034 0     1
10034 97    1 # 在后面会再被分片
10034 194   1
10034 291   0 # 注意为0
# 如果第二个片段在后面的一个router要转发到MTU=300的物理网络上，分片后的iden offset MF
10034 97    1
10034 132   1
10034 167   1 # 注意仍为1
```

-   当目的主机收到该数据报的所有片段时，它会重组(**reassemble**)为原来的数据报
-   第一个片段到达目的主机时目的主机会启动一个重组定时器(默认超时值为15秒)。如果该定时器到期时没有收集到所有片段，目的主机会放弃本次重组并丢弃该数据报的所有片

#### IP Datagram Options

-   一般格式: 代码(1B)、总长度(1B)、数据(nB)

|     Field     | Size (bits) |                         Description                          |
| :-----------: | :---------: | :----------------------------------------------------------: |
|    Copied     |      1      | Set to **1** if the options need to be copied into all fragments of a fragmented packet. |
| Option Class  |      2      | A general options category. 0 is for "control" options, and 2 is for "debugging and measurement". 1 and 3 are reserved. |
| Option Number |      5      |                     Specifies an option.                     |
| Option Length |      8      | Indicates the size of the entire option (including this field). This field may not exist for simple options. |
|  Option Data  |  Variable   | Option-specific data. This field may not exist for simple options. |

-   选项码：
    1.  复制(1bit): **1: 将选项复制到所有分片中** 0: 将选项仅复制到第一个分片中
    2.  选项类(2bit): 指明选项的类别//00:数据报或网络控制 01:保留 10: 调试和度量 11: 保留
    3.  选项号(5bit): 表示选项类中的具体选项

> Note: Copied, Option Class, and Option Number are sometimes referred to as a single eight-bit field, the *Option Type*.
>
> 以上三个选项码有时会被视为一个8bit的**Option Type**域

![](http://op4fcrj8y.bkt.clouddn.com/18-4-25/60003712.jpg)

记录路由选项：

1B代码=7，1B长度，1B指针(初始为4)，空出1B(4B对齐)

指针指明在选项中下一个可存放地址的位置。初始值为4，即指针指向第一个IP地址的开始，每添加一个IP地址，指针值加4





### IPv4 & 有类网

-   IP地址由32 bits二进制数组成，常以XXX.XXX.XXX.XXX点分十进制(dotted decimal)表现
-   IP技术可能使用的IP地址最多可有4,294,967,296个(2^32^)
-   32位全为1的**IP地址**“255.255.255.255”为**受限广播地址**("limited broadcast" destination address)，用来将一个分组以广播方式发送给本网络中的所有主机，路由器则阻挡该分组通过，将其广播功能限制在本网内部






-   分类网络Classful Addressing 分级式定址
-   地址可分为A、B、C、D、E五大类：大型网络；中型网络；小型网络；多目地址；备用。常用BC
-   在A类、B类、C类IP地址中，如果主机号是全1，那么这个地址为直接广播地址，它是用来使路由器将一个分组以广播形式发送给特定网络上的所有主机
-   用长度来表示子网掩码：/26表示255.255.255.192(32bit中，前26bit为1)

| 分类    | 前缀码  | 开始地址      | 结束地址            | CIDR | 默认子网掩码        |
| ----- | ---- | --------- | --------------- | ---- | ------------- |
| A     | 0    | 0.0.0.0   | 127.255.255.255 | /8   | 255.0.0.0     |
| B     | 10   | 128.0.0.0 | 191.255.255.255 | /16  | 255.255.0.0   |
| C     | 110  | 192.0.0.0 | 223.255.255.255 | /24  | 255.255.255.0 |
| D(群播) | 1110 | 224.0.0.0 | 239.255.255.255 | /4   | 未定义           |
| E(保留) | 1111 | 240.0.0.0 | 255.255.255.255 | /4   | 未定义           |

>   有类网模型下，A B C类网个数应各自减2，因为网络号全为0或1不可用
>
>   现在子网号为全0或全1的子网可以使用
>
>   主机号为全1或全0的地址被保留不能使用

```cpp
n 表示该二进制位是网络位
H 表示该二进制位是主机位
X 表示该二进制位无特定作用
//0: A类地址//1Byte的网络号
  0.  0.  0.  0 = 00000000.00000000.00000000.00000000
127.255.255.255 = 01111111.11111111.11111111.11111111
                  0nnnnnnn.HHHHHHHH.HHHHHHHH.HHHHHHHH
//10: B类地址//2Byte的网络号
128.  0.  0.  0 = 10000000.00000000.00000000.00000000
191.255.255.255 = 10111111.11111111.11111111.11111111
                  10nnnnnn.nnnnnnnn.HHHHHHHH.HHHHHHHH
//110: C类地址//3Byte的网络号
192.  0.  0.  0 = 11000000.00000000.00000000.00000000
223.255.255.255 = 11011111.11111111.11111111.11111111
                  110nnnnn.nnnnnnnn.nnnnnnnn.HHHHHHHH
//1110: D类地址
224.  0.  0.  0 = 11100000.00000000.00000000.00000000
239.255.255.255 = 11101111.11111111.11111111.11111111
                  1110XXXX.XXXXXXXX.XXXXXXXX.XXXXXXXX
//1111: E类地址
240.  0.  0.  0 = 11110000.00000000.00000000.00000000
255.255.255.255 = 11111111.11111111.11111111.11111111
                  1111XXXX.XXXXXXXX.XXXXXXXX.XXXXXXXX
```







---

### 子网划分

>   子网 Subnetwork 指的是从分类网络中划分出来的一部分

-   网络掩码 子网掩码 地址掩码 子网路遮罩 subnet mask
-   一个有类网可以分为多个相同大小的子网
-   是一种用来指明一个IP地址的哪些位标识的是主机所在的网络地址以及哪些位标识的是主机地址的位掩码
-   通常情况下，子网掩码的表示方法和地址本身的表示方法是一样的。在IPv4中，就是点分十进制四组表示法或表示为一个八位十六进制数（如FF.80.00.00，它等同于255.128.0.0）



#### VLSM & CIDR

-   **变长子网掩码**(Variable-Length Subnet Mask  **VLSM**) 
-   允许把一个有类网划分为多个不同大小的子网

```c
子网1：199.1.12.0XXXXXXX/25 (128-2可用主机号)
子网2：199.1.12.10XXXXXX/26 (64-2可用主机号)//255.255.255.192
子网3：199.1.12.110XXXXX/27 (32-2可用主机号)
子网4：199.1.12.111XXXXX/27 (32-2可用主机号)
```



-   **无类域间路由选择协议**(Classless Inter-Domain Routing  **CIDR**)
-   允许把多个有类网合并为一个更大的网络，称为超网(supernet)
-   e.g. 把有类网192.24.8.0~192.24.15.0合并为网络号为192.24.8.0、子网掩码为255.255.248.0的超网
-   CIDR可以显著减少路由表中路由的数量，例如，上例就把八个路由减少路由减少为一个路由，称为**路由聚合(route aggregation)**
-   通过引入CIDR，加上子网掩码，现在的网络号(可能包含子网号)可以看成是没有边界，即是无类的





---

### NAT 网络地址转换

> **网络地址转换** (Network Address Translation  **NAT**)    网络掩蔽 IP掩蔽(IP masquerading)

-   把内部地址映射为外部地址的技术//e.g. 把私有地址映射为全局地址(公用IP)
-   一种在IP数据包通过Router或Firewall时重写来源IP地址或目的IP地址的技术
-   普遍使用在有多台主机但只通过一个公有IP地址访问Internet的私有网络中。根据规范，路由器是不能这样工作的，但它的确是一个方便且得到了广泛应用的技术
-   NAT让主机之间的通信变得复杂，导致了通信效率的降低

基本网络地址转换Basic NAT: 也可称作NAT或"静态NAT"。仅支持地址转换，不支持端口映射。要求对每一个当前连接都要对应一个公网IP地址，因此要维护一个公网的地址池。

动态NAT：出口路由器在内网数据报发往外网时自动把内网地址映射为外网地址。每个动态映射都关联一个TTL。如果在TTL时间内没有使用一个映射，该映射将被出口路由器删除。

静态NAT：直接由管理员加入映射。静态NAT加入的映射不会被自动删除



#### NAPT

> **网络地址端口转换** NAPT(Network Address Port Translation): 也称为PAT(Port Address Translation)、过载NAT(NAT with overload)

-   支持端口的映射，并允许多台主机共享一个公网IP地址。支持端口转换的NAT又可以分为两类：源地址转换和目的地址转换。源地址转换下发起连接的计算机的IP地址将会被重写，使得内网主机发出的数据包能够到达外网主机。目的地址转换下被连接计算机的IP地址将被重写，使得外网主机发出的数据包能够到达内网主机。
-   实际上，源地址转换和目的地址转换通常会一起被使用以支持双向通信。NAPT维护一个带有IP以及端口号的NAT表

![](http://op4fcrj8y.bkt.clouddn.com/18-4-25/89028454.jpg)

>   上图中，172.18.186.211:1030 经Router使用NAPT后-> 202.166.64.5:5039
>
>   Web Server回送packet时，Destinaton: 202.166.64.5:5039





### 特殊IP地址

-   

```c
00000000 00000000 00000000 00000000
未知或秘密IP地址，只用作源地址

000...0 | host
同一子网的主机，只用作源地址

11111111 11111111 11111111 11111111 
有限广播，对于一个直连物理网络的广播

network | 111...1
对于一个远程网络的广播

network | 000...0
用32比特表示的网络号(含子网号)
 
01111111 | any value //127...
环回地址(loopback) –本机127.0.0.1 -本地域名(localhost)
```

-   **环回地址**: 整个127.* 网段通常被用作**loopback**网络接口的默认地址，按惯例通常设置为 127.0.0.1
-   本机地址通常指的是绑定在物理或虚拟网络接口上的IP地址，可供其他设备访问到
-   localhost是个域名，不是地址。本地主机 给回路网络接口(loopback)的一个标准主机名。通常相对应的IP地址为127.0.0.1 (IPv4)和\[::1\] (IPv6)
-   127.0.0.1在其他计算机上不能访问，就算你想访问，访问的也是自己，因为每台带有TCP/IP协议栈的设备基本上都有 localhost/127.0.0.1





#### 私有IP地址

-   **私有IP地址** : 无需IANA分配、任何人都可以使用的IP地址

```c
10.0.0.0 ~ 10.255.255.255//A类网 10.
172.16.0.0 ~ 172.31.255.255//B类网 172.16~31 
192.168.0.0 ~ 192.168.255.255//C类网 192.168.
```

-   私有地址只能用于内部网络。主干网上的路由器会过滤掉目的地址为私有地址的IP数据报。因此，离开内部网络的IP数据报必须使用由IANA分配的全局地址作为目的地址





#### 多播IP地址



| 224.0.0.0--239.255.255.255 | IPv4的多播地址空间                              |
| -------------------------- | ---------------------------------------- |
| 224.0.0.0~224.0.0.255      | 本地保留。IANA分配的永久地址。Router不转发目的地址为这些地址的IP数据包。ttl=1 |
| 224.0.0.1                  | 本网所有Host接收                               |
| 224.0.0.2                  | 本网所有Router接收                             |
| 224.0.1.0~224.0.1.255      | IANA分配的永久地址。Router**会转发**目的地址为这些地址的IP数据包 |
| 232.0.0.0~232.255.255.255  | 用于指定源的多播应用                               |
| 233.0.0.0~233.255.255.255  | 由AS分配的全局多播地址                             |
| 239.0.0.0--239.255.255.255 | 私有组播地址                                   |
| 其它地址                       | 临时多播地址(transient address)                |

>   224.0.1.0--238.255.255.255 全球
>
>   http://www.networksorcery.com/enp/protocol/ip/multicast.htm



---

## IPv6

> RFC 2373和RFC 2374定义的IPv6地址 有128位长

-   IPv6地址的表达形式，一般采用32个十六进制数
-   2^128^≈3.4×10^38^个，具体数量为340,282,366,920,938,463,463,374,607,431,768,211,456个。也可以想象为1632个，因为32位地址每位可以取16个不同的值
-   很多场合，IPv6地址由两个逻辑部分组成：一个64位的网络前缀和一个64位的主机地址，主机地址通常根据物理地址自动生成，叫做EUI-64（或者64-位扩展唯一标识）
-   举例：2001:0db8:85a3:08d3:1319:8a2e:0370:7344
-   如果四个数字都是0，可以被省略：2001:0db8:85a3:0000:1319:8a2e:0370:7344  == 2001:0db8:85a3::1319:8a2e:0370:7344
-   遵从这些规则，如果因为省略而出现了两个以上的冒号的话，可以压缩为一个，但这种零压缩在地址中只能出现一次：2001:0DB8:0000:0000:0000:0000:1428:57ab == 2001:0DB8:0000:0000:0000::1428:57ab == 2001:0DB8:0:0:0:1428:57ab == 2001:0DB8:0::0:1428:57ab == 2001:0DB8::1428:57ab
-   前导的零可以省略：2001:0DB8:02de::0e13 == 2001:DB8:2de::e13
-   如果这个地址实际上是IPv4的地址，后32位可以用10进制数表示
-   ffff:192.168.89.9等价于::ffff:c0a8:5909，但不等价于::192.168.89.9和::c0a8:5909
-   ffff:1.2.3.4格式叫做**IPv4映射地址**，是不建议使用的。而::1.2.3.4格式叫做**IPv4一致地址**
-   IPv4地址可以很容易的转化为IPv6格式。举例来说，如果IPv4的一个地址为135.75.43.52（十六进制为0x874B2B34），它可以被转化为0000:0000:0000:0000:0000:0000:874B:2B34或者::874B:2B34。同时，还可以使用混合符号（IPv4-compatible address），则地址可以为::135.75.43.523

### IPv6 Datagram

```python
  |0        3|4        7|8       11|12      15|16      19|20      23|24      27|28      31|Bit
 0| Version  |Traffic Class(6+2bit)|                   Flow Label(20bit)                  |
 4|     Payload Length(16bit, in bytes)       |   Next Header(8bit) |   Hop Limit(8bit)   |
  |---------------------------------------------------------------------------------------|
 8|                                                                                       |
12|                                   Source Address(128bit)                              |
16|                                                                                       |
20|                                                                                       |
  |---------------------------------------------------------------------------------------|
24|                                                                                       |
28|                               Destination Address(128bit)                             |
32|                                                                                       |
36|                                                                                       |
```

- Version(4bit): 常数6(`0110`)
- Traffic Class(6+2 bits): 通信类，
- Flow Label(20bit): 流标签。
- Payload Length(16bit): 有效载荷长度，负载长度包括扩展头和上层PDU
- Next Header(8bit): 下一个头，8 位选定器。标识紧跟在 IPv6 header后面的头的类型（含扩展头，传输层协议头）。使用与 IPv4 协议字段相同的值
- Hop Limit(8bit): 跃点限制，8bit无符号整数。按转发包的每个节点逐一递减。如果跃点限制递减到零，包就会被丢弃
- Source Address(128bit): 源地址。包初始发送者的地址
- Destination Address(128bit): 目标地址。包预定接收者的地址。如果存在可选的路由头，则预定接收者不一定就是接收者

> In order to increase performance, and since current link layer technology and transport layer protocols are assumed to provide sufficient error detection, the header has no checksum to protect it. 为提升性能，且由于当前数据链路层和传输层都被假定提供有效的差错检测，IPv6报头不提供校验和



### Extension Headers

- IPv6 选项位于包中的 IPv6 数据包头和传输层头之间的单独扩展头中
- IPv6 扩展头使用Next Header 域组成链。最后一个扩展头的 Next Header 域指示的是上层(传输层)协议类型
- 所有IPv6扩展头都是8字节的整数倍。有些扩展头需要padding以满足条件
- 除了**Hop-by-Hop Options**需要在中间节点处理(甚至修改)，其他扩展头都仅需在包终点处理。
- 所有扩展头都是可选的且只能出现一次，除了**Destination Options**可能出现两次外





#### Hop-by-Hop Options and Destination Options

```python
# Hop-by-Hop Options and Destination Options Extension Header Format
  |0        3|4        7|8       11|12      15|16      19|20      23|24      27|28      31|Bit
 0|      Next Header    |     Hdr Ext Len     |            Options and Padding            |
 4|     Payload Length(16bit, in bytes)       |   Next Header(8bit) |   Hop Limit(8bit)   |
 8|                                 Options and Padding                                   |
12|                        Optional: more Options and Padding...                          |
```



#### Fragment

- 为了发送一个大于链路MTU(Maximum Transmission Unit)的包，发送节点会将包切分成分片。*Fragment* extension header携带重组原始(unfragmented)包的必要信息

```python
# Fragment extension header format
  |0        3|4        7|8       11|12      15|16      19|20      23|24      27|28      31|Bit
 0|      Next Header    |      Reserved       |     Fragment Offset               |Res |M |
 4|                                     Identification                                    |
```

- Next Header (8 bits): 下一个报头的类型
- Reserved (8 bits): 保留，初始化为0
- Fragment Offset (13 bits): Offset, in 8-octet units, relative to the start of the fragmentable part of the original packet.
- Res (2 bits): 保留，初始化为0
- M Flag (1 bit): 1 means more fragments follow; 0 means last fragment.
  Identification (32 bits)8
  Packet identification value, generated by the source node. Needed for reassembly of the original packet.



## DMZ

> sometimes referred to as a **perimeter network** or screened subnet
>
> 边界网络 周边网络 对外网络

- **非军事化区(Demilitarized Zone, DMZ)**是位于内部网络和外部网络之间并为双方提供因特网服务的区域
- 内网主机可以访问内网主机、DMZ和因特网。内网主机可以使用内部地址或全局地址访问DMZ的服务器。外部主机只能通过全局地址访问DMZ的服务器，不能访问内网主机
- 将部分用于提供对外服务的服务器主机划分到一个特定的子网——DMZ内，在DMZ的主机能与同处DMZ内的主机和外部网络的主机通信，而同内部网络主机的通信会被受到限制。这使DMZ的主机能被内部网络和外部网络所访问，而内部网络又能避免外部网络所得知。

![](http://op4fcrj8y.bkt.clouddn.com/18-4-25/73646272.jpg)

Any service provided to users on the public internet should be placed in the DMZ network. Some of the most common of these services include web servers and proxy servers, as well as servers for email, domain name system (DNS), File Transfer Protocol (FTP) and voice over IP (VoIP).



---

## ARP Protocol

-   **Address Resolution Protocol** 地址解析协议 //动态解析以太网硬件的地址
-   通过解析网络层IP地址来找寻数据链路层MAC地址的网络传输协议
-   地址解析(address resolution): 主机在发送帧前将目标IP地址转换成目标MAC地址的过程

>   IPv6中[邻居发现协议](https://zh.wikipedia.org/wiki/%E9%82%BB%E5%B1%85%E5%8F%91%E7%8E%B0%E5%8D%8F%E8%AE%AE) (NDP)用于代替地址解析协议

-   ARP协议**没有超时重传机制**。超时没有收到响应，则丢弃引发ARP查询的IP分组

ARP 协议工作过程: e.g. Host A(192.168.0.1)向Host B(192.168.0.2)发送IP数据报

1.  A在自己地ARP缓存表中查询是否有目标IP address(192.168.0.2)。若找到，则将对应地目标MAC地址写入帧里发送
2.  





-   Source Host: 源主机获得的映射结果缓存在ARP表中<IP address，MAC address，TTL>。TTL超时则会删除对应的ARP表项，TTL取值由系统确定，一般为2~20分钟
-   Destination Host: 当收到ARP请求，目的Host会**缓存源主机的映射**，其它host如果已缓存该映射，则会**重置TTL**
-   也可以把映射直接加入ARP缓存，称为**静态ARP映射**。静态ARP映射不会因超时而被删除

```c
IP 单播地址 ->ARP-> MAC单播地址
IP 广播地址 111...1(32bit) ->ARP-> MAC广播地址 111……1(48 bits)
IP 多播地址(1110开头)  ->ARP-> MAC多播地址(第1字节最后1位为1)//替换低23bit
e.g. 224.1.2.3 0xE0010203  ->ARP-> 0x01-00-5E-01-02-03//详见相关专题
```

>   ###### 免费ARP gratuitous ARP
>
>   免费ARP (gratuitous ARP)，他是指主机发送ARP查询（广播）自己的IP地址，当ARP功能被开启或者是端口初始配置完成，主机向网络发送免费ARP来查询自己的IP地址确认地址唯一可用
>
>   1.  确定网络中是否有其他主机使用了IP地址，如果有应答则产生错误消息。
>   2.  免费ARP可以做更新ARP缓存用，网络中的其他主机收到该广播则在缓存中更新条目，收到该广播的主机无论是否存在与IP地址相关的条目都会强制更新，如果存在旧条目则会将MAC更新为广播包中的MAC
>
>   ###### 委托ARP、ARP代理（ARP Proxy）
>
>   当发送主机和目的主机不在同一个LAN中时，即便知道目的主机的MAC地址，两者也不能直接通信，必须经过路由转发才可以。所以此时，发送主机通过ARP协议获得的将不是目的主机的真实MAC地址，而是一台可以通往局域网外的路由器的MAC地址。于是此后发送主机发往目的主机的所有帧，都将发往该路由器，通过它向外发送。
>
>   在**点对点链路中不使用ARP**，实际上在点对点网络中也不使用MAC地址，因为在此类网络中分别已经获取了对端的IP地址。故匹配路由表后，如果下一跳为PPP，直接把IP分组封装成帧发送出去



### ARP datagram

-   下图是ARP包的格式，在后面还需要封装成Ethernet packet(14B Ethernet首部 = 6B目标MAC + 6B源MAC + 2B帧类型 )

![](http://op4fcrj8y.bkt.clouddn.com/18-4-26/87865474.jpg)

-   操作字段后，依次：源MAC地址(6B)，源IP地址(4B)，目标MAC地址(6B)，目标IP地址(4B)
-   目标MAC/IP地址一般在请求时为0

>   RARP(Reverse ARP)用于无盘工作站把MAC地址映射为IP地址
>
>   InARP(Inverse ARP)用于NBMA(Non-Broadcast Multiple Access)网络把VCI映射为IP地址

![](http://op4fcrj8y.bkt.clouddn.com/18-4-26/79174259.jpg)







### IP -> MAC多播地址映射

-   以太网为 Ethernet和Fiber Distributed Data Interface (FDDI)的MAC地址保留了一个多播地址区间：01-00-5E-00-00-00 到 01-00-5E-7F-FF-FF

![](http://op4fcrj8y.bkt.clouddn.com/18-4-25/5887059.jpg)

为了映射一个IP 多播地址到MAC层的多播地址，IP多播地址的底23位可以直接映射为MAC层多播地址的底23位。因为IP多播地址的前4位是固定的(1110)，另外还有比邻的5位不需要映射到MAC层多播地址，共9bit不需要映射到MAC层多播地址。(一个主机接收到一些不属于自己所属组的MAC层多播包是可能的。然而，这些包会被IP层通过判断IP目标地址而丢弃掉)

e.g. 多播地址224.192.16.1可以映射为01-00-5E-40-10-01(Ethernet)。用低23位，多播地址224.192.16.1的第一个8位是不会用到的，第二个8位中的后7位会被用到，第三个和第四个8位可以直接转换为十六进制字符。第二个8位，192的二进制表示是11000000，丢掉最高位，变成了1000000、64、0x40。第三个8位是16，0x10。第四个8位是1，0x01。故224.192.16.1映射为01-00-5E-40-10-01

```c
//cmd: arp -a
接口: 172.18.33.81 --- 0x5
  Internet 地址         物理地址              类型
  172.18.32.13          f8-ca-b8-07-b8-36     动态
  172.18.33.27          30-b4-9e-7a-19-95     动态
  172.18.35.254         38-22-d6-e5-b2-d4     动态
  172.18.35.255         ff-ff-ff-ff-ff-ff     静态//广播帧
  224.0.0.2             01-00-5e-00-00-02     静态//多播
  224.0.0.5             01-00-5e-00-00-05     静态
  224.0.0.22            01-00-5e-00-00-16     静态
  224.0.0.100           01-00-5e-00-00-64     静态
  224.0.0.251           01-00-5e-00-00-fb     静态
  224.0.0.252           01-00-5e-00-00-fc     静态
  224.0.0.253           01-00-5e-00-00-fd     静态
  224.153.143.111       01-00-5e-19-8f-6f     静态
  224.172.101.58        01-00-5e-2c-65-3a     静态
  224.184.128.111       01-00-5e-38-80-6f     静态
  225.26.0.0            01-00-5e-1a-00-00     静态
  225.95.77.218         01-00-5e-5f-4d-da     静态
  225.101.32.119        01-00-5e-65-20-77     静态
```





---

## ICMP Protocol

>  **因特网控制消息协议** 因特网控制报文协议 **Internet Control Message Protocol**
>
> ping用的就是这个协议

-   用于Host或Router之间发布传递网络级别的控制消息 //错误侦测与回报机制
-   The **Internet Control Message Protocol** (**ICMP**) is a **supporting protocol** in the Internet protocol suite. It is used by network devices, including routers, to **send error messages and operational information** indicating, for example, that a requested service is not available or that a host or router could not be reached. ICMP differs from transport protocols such as TCP and UDP in that it is not typically used to exchange data between systems, nor is it regularly employed by end-user network applications (with the exception(例外) of some diagnostic(诊断的) tools like **ping** and **traceroute**) //https://tools.ietf.org/html/rfc792
-   控制消息是指网络通通、Host是否可达、Router是否可用等网络本身的消息，提供可能发生在通信环境中的各种问题的反馈。这些控制消息不传输用户数据，但对于用户数据的传递起着重要的作用。对网络安全有重要意义
-   **面向无连接**，不可靠的协议，依赖于IP协议，**ICMP报文作为IP数据报的数据**，加上IP数据报的头部，组成IP数据报发送，**IP数据报的头部的协议字段值为1**。






>   IPv4: ICMPv4，IPv6: ICMPv6



### ICMP datagram

-   ICMP报头从IP报头的第160bit(20B)开始(在没有使用IP datagram可选的选项字段时)
-   The ICMP packet is encapsulated in an IPv4 packet. //encapsulate [vt.] 压缩；将…装入胶囊；将…封进内部；概述




```c
//ICMP消息一般格式:
| 0(bit) | 类型 | 8 | 代码 | 16 | 校验和 | 31 |
32 - 数据(格式由类型和代码决定) -...
//以上部分被当作IP数据报的数据部分存在IP数据报中
//封装成IP packet后:
| IP头部(协议号=1) | ICMP消息 |
```

-   任何ICMP差错报文的内容都要包括原来的IP报文首部，用以返回主机时能够令主机的应用进行判断分析。其他的字段依具体情况而定





#### Type & Code

| Type                                            | Code | Description                                                  |
| ----------------------------------------------- | ---- | ------------------------------------------------------------ |
| 0 - Echo reply 回显应答                         | 0    | [Query] Echo reply 回显应答(**Ping应答**)                    |
| 8 - Echo request 回显请求                       | 0    | [Query] Echo request 请求回显(**Ping请求**)                  |
| 3 - Destination Unreachable 目标不可达          | 0    | [Error] Destination network unreachable 网络不可达           |
|                                                 | 1    | [Error] Destination host unreachable目的主机不可达           |
|                                                 | 2    | [Error] Destination protocol unreachable                     |
|                                                 | 3    | [Error] Destination port unreachable                         |
|                                                 | 4    | [Error] Fragmentation required, and DF flag set 需要分组但不可分段 |
|                                                 | 5    | [Error] Source route failed 源站选路失败                     |
| 5 -  Redirect Message 重定向                    | 0    | [Error] Redirect Datagram for the Network                    |
|                                                 | 1    | [Error] Redirect Datagram for the Host 对主机重定位          |
| 11 - Time Exceeded 超时                         | 0    | [Error] TTL expired in transit 传输期间TTL=0                 |
|                                                 | 1    | [Error] Fragment reassembly time exceeded数据报重组超时      |
| 12  – Parameter Problem: Bad IP header 参数问题 | 0    | [Error] Pointer indicates the error                          |
|                                                 | 1    | [Error] Missing a required option 缺少必要的选项             |
|                                                 | 2    | [Error] Bad length                                           |
| 13 – Timestamp                                  | 0    | [Query] Timestamp 时间戳请求                                 |
| 14 – Timestamp Reply                            | 0    | [Query] Timestamp reply 时间戳应答                           |
|                                                 |      |                                                              |



| Type | Code | Description                              | Query | Error |
| ---- | :--- | ---------------------------------------- | ----- | ----- |
| 0    | 0    | **Echo Reply 回显应答(Ping应答)**              | x     |       |
| 3    | 0    | **Network Unreachable 网络不可达**            |       | x     |
| 3    | 1    | **Host Unreachable 主机不可达**               |       | x     |
| 3    | 2    | **Protocol Unreachable 协议不可达**           |       | x     |
| 3    | 3    | **Port Unreachable 端口不可达**               |       | x     |
| 3    | 4    | **Fragmentation needed but no frag. bit set 需要进行分片但设置不分片比特** |       | x     |
| 3    | 5    | **Source routing failed 源站选路失败**         |       | x     |
| 3    | 6    | Destination network unknown 目的网络未知       |       | x     |
| 3    | 7    | Destination host unknown 目的主机未知          |       | x     |
| 3    | 8    | Source host isolated (obsolete) 源主机被隔离(作废) |       | x     |
| 3    | 9    | Destination network administratively prohibited目的网络被强制禁止 |       | x     |
| 3    | 10   | Destination host administratively prohibited 目的主机被强制禁止 |       | x     |
| 3    | 11   | **Network unreachable for TOS 由于服务类型TOS，网络不可达** |       | x     |
| 3    | 12   | Host unreachable for TOS 由于服务类型TOS，主机不可达 |       | x     |
| 3    | 13   | Communication administratively prohibited by filtering 由于过滤，通信被强制禁止 |       | x     |
| 3    | 14   | Host precedence violation 主机越权           |       | x     |
| 3    | 15   | Precedence cutoff in effect 优先中止生效       |       | x     |
| 4    | 0    | **Source quench 源端被关闭(基本流控制)**           |       |       |
| 5    | 0    | Redirect for network 对网络重定向              |       |       |
| 5    | 1    | **Redirect for host 对主机重定向**             |       |       |
| 5    | 2    | Redirect for TOS and network 对服务类型和网络重定向 |       |       |
| 5    | 3    | Redirect for TOS and host 对服务类型和主机重定向    |       |       |
| 8    | 0    | **Echo request 回显请求(Ping请求)**            | x     |       |
| 9    | 0    | Router advertisement 路由器通告               |       |       |
| 10   | 0    | Route solicitation 路由器请求                 |       |       |
| 11   | 0    | TTL equals 0 during transit 传输期间TTL为0    |       | x     |
| 11   | 1    | TTL equals 0 during reassembly 在数据报组装期间生存时间为0 |       | x     |
| 12   | 0    | **IP header bad (catchall error) 坏的IP首部(包括各种差错)** |       | x     |
| 12   | 1    | **Required options missing 缺少必需的选项**     |       | x     |
| 13   | 0    | Timestamp request (obsolete) 时间戳请求(作废)   | x     |       |
| 14   | 0    | Timestamp reply (obsolete) 时间戳应答(作废)     | x     |       |
| 15   | 0    | Information request (obsolete) 信息请求(作废)  | x     |       |
| 16   | 0    | Information reply (obsolete) 信息应答(作废)    | x     |       |
| 17   | 0    | Address mask request 地址掩码请求              | x     |       |
| 18   | 0    | Address mask reply 地址掩码应答                |       |       |
| 30   | 0    | Information Request(deprecated) 信息请求(traceroute)(弃用) |       |       |

>   13 14项存疑

![](http://op4fcrj8y.bkt.clouddn.com/18-5-2/85653836.jpg)



#### Destination Unreachable

> Type=3

-   Destination unreachable is generated by the host or its inbound gateway(Router) to inform the client that the destination is unreachable for some reason. 

```c
//Destination unreachable message
|00           07|08               15|16                23|24             31|
| Type = 3      | Code              |               Header checksum        |
| unused                            |   Next-hop MTU                       |
| IP header and first 8 bytes of original datagram's data
```

-   **Next-hop MTU** field (bits 48-63) contains the MTU of the next-hop network if a code 4 error occurs.
-   **IP header** and additional data is included to allow the client to match the reply with the request that caused the destination unreachable reply.

| Code | Description                              |
| ---- | ---------------------------------------- |
| 0    | Network unreachable error.               |
| 1    | Host unreachable error.                  |
| 2    | Protocol unreachable error (the designated transport protocol is not supported). |
| 3    | Port unreachable error (the designated protocol is unable to inform the host of the incoming message). |
| 4    | The datagram is too big. Packet fragmentation is required but the 'don't fragment' (DF) flag is on. |
| 5    | Source route failed error.               |
| 6    | Destination network unknown error.       |
| 7    | Destination host unknown error.          |
| 8    | Source host isolated error.              |
| 9    | The destination network is administratively prohibited. |
| 10   | The destination host is administratively prohibited. |
| 11   | The network is unreachable for Type Of Service. |
| 12   | The host is unreachable for Type Of Service. |
| 13   | Communication administratively prohibited (administrative filtering prevents packet from being forwarded). |
| 14   | Host precedence violation (indicates the requested precedence is not permitted for the combination of host or network and port). |
| 15   | Precedence cutoff in effect (precedence of datagram is below the level set by the network administrators). |



#### Redirect Message

> Type=5

-   当路由器检测到一台机器使用非优化路由的时候，它会向该主机发送一个ICMP重定向报文，请求主机改变路由。路由器也会把初始数据包向它的目的地转发
-   发送ICMP Redirect Message 后依旧会转发原始IP packet

对于路由器来说，只有当如下条件同时满足的时候，才进行重定向：

1.  数据包的入接口和路由后的指定的出接口是**同一个接口**
2.  数据包的源IP地址和该包应走的下一跳IP地址属于**同一个网段**
3.  数据报非源路由的（这种情况应该比较少见了，源路由多见于Token Ring）
4.  系统开启重定向功能。

```c
|  Byte 0  |  Byte 1  |  Byte 2  |  Byte 3  |
|  Type=5  | Code=0~3 | Check Sum           |
|      重定向网关 IP Redirect Gateway IP     |
|   原包的IP首部(20B ~ 60B)                  |
|   源IP数据报前 8B |
```



### Case: Packet flow in different Network

> 讲述当ping一个不同网段的主机时的整个过程 解析ping在不同网段之间的过程，包括MAC解析，ARP请求应答
>
> https://www.geeksforgeeks.org/packet-flow-in-different-network/

1. 如果目标主机在于同一网段中，则包被直接发送到目标主机
2. 如果目的主机存在于不同的网络中，则包首先被传送到默认网关，而默认网关又依次将包传送到目的主机
3. 如果ARP没有被解析，那么ARP将首先被解析
4. **MAC地址不跨越它的广播域**

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_Packet_flow_in_different_Network_1.jpg)

- A: 10.0.0.10/24
- B: 20.0.0.10/24 : 与A不同网段，是图上右下角的Host，图中标错了

当A ping B时：

1. 判断A.IP和B.IP是不是在同一个网段，发现不在同一个网段，包将被发往默认路由10.0.0.20/24(图中路由器左边端口的IP)
2. A发现默认路由的IP的MAC未知，发送MAC广播帧，ARP请求10.0.0.20的MAC
3. 交换机Switch 0接收到了MAC广播帧，把该帧泛洪flood，从接收端口以外的端口转发出去
4. C收到后发现问的不是自己的IP，忽略掉。Router发现问的是Router上的端口的IP 10.0.0.20，做出响应(ARP reply)
5. Router发送单播MAC帧到A，告诉A: 10.0.0.20对应的MAC
6. A发送ICMP包，封装成单播MAC帧，dst.MAC填的就是刚刚问到的10.0.0.20对应的MAC
7. Router收到ICMP包后，取出IP包
8. Router不知道B的IP的MAC，从Router右边端口发出ARP request
9. D收到后忽略，B收到后返回ARP reply，发送单播MAC帧到Router右边端口
10. Router接收到ARP reply后，把IP包封装成单播MAC帧，dst.MAC就是刚刚问到的B对应的MAC
11. B收到src.MAC为Router右边端口，dst.MAC为B.IP.MAC的帧，取出IP包，发现是ICMP协议
12. B对ICMP协议的Ping请求做出应答，发送IP为A.IP: 10.0.0.10 的ICMP Ping应答



---

## Routing protocol 路由协议

-   A **routing protocol** specifies how routers communicate with each other, distributing information that enables them to select routes between any two nodes on a computer network. //...(with) distributing... 这种是非谓语用法，用来表示目的 或者原因 或者方法 或者让步 这里表达方式 "通过分发消息这种方式 去specifies"
-   路由协议通过分发使路由器能够在计算机网络上任意两个节点之间选择路由的消息，指定路由器彼此的通信方式。
-   动态路由协议：让路由器自动学习到其他路由器的网络，并且网络拓扑发生改变后自动更新路由表。网络管理员只需要配置动态路由协议即可，相比人工指定转发策略，工作量大大减少

Although there are many types of routing protocols, three major classes are in widespread use on IP networks:

-   (**IGP**) Interior gateway protocols type 1, link-state routing protocols(链路状态路由协议), such as OSPF and IS-IS
-   (IGP) Interior gateway protocols type 2, distance-vector routing protocols(距离向量路由协议), such as Routing Information Protocol, RIPv2, IGRP.
-   (**EGP**) **Exterior gateway protocols**(外部网关协议) are routing protocols used on the Internet for exchanging routing information between Autonomous Systems(AS 自治系统), such as Border Gateway Protocol (BGP), Path Vector Routing Protocol. Exterior gateway protocols should not be confused with Exterior Gateway Protocol (EGP), an obsolete(废弃/老式的) routing protocol.//EGP也是一个已被淘汰的外部网关协议的协议名


如果IP分组的目的地址就在路由器的直连的以太网，则需要用ARP通过该目的地址获得其对应的MAC地址

一个IP分组在转发之前总是要封装成帧

```c
//cmd: route print 查看路由表
===========================================================================
接口列表
  5...d8 cb 8a f1 d0 e9 ......Qualcomm Atheros AR8171/8175 PCI-E Gigabit Ethernet Controller (NDIS 6.30)
 12...ae c9 64 b0 f9 2e ......Intel(R) Dual Band Wireless-AC 3165
  6...08 d4 0c f1 9c 4f ......Microsoft Wi-Fi Direct Virtual Adapter
 16...00 50 56 c0 00 01 ......VMware Virtual Ethernet Adapter for VMnet1
 15...00 50 56 c0 00 08 ......VMware Virtual Ethernet Adapter for VMnet8
 10...0a d4 0c f1 9c 4e ......Microsoft Wi-Fi Direct Virtual Adapter #2
 11...08 d4 0c f1 9c 52 ......Bluetooth Device (Personal Area Network)
  1...........................Software Loopback Interface 1
  2...00 00 00 00 00 00 00 e0 Microsoft Teredo Tunneling Adapter
===========================================================================

IPv4 路由表
===========================================================================
活动路由:
网络目标            网络掩码             网关             接口          跃点数
          0.0.0.0          0.0.0.0    172.18.35.254     172.18.33.81     25
        127.0.0.0        255.0.0.0         在链路上         127.0.0.1    331
        127.0.0.1  255.255.255.255         在链路上         127.0.0.1    331
  127.255.255.255  255.255.255.255         在链路上         127.0.0.1    331
      169.254.0.0      255.255.0.0         在链路上    169.254.81.146    291
      169.254.0.0      255.255.0.0         在链路上   169.254.162.235    291
   169.254.81.146  255.255.255.255         在链路上    169.254.81.146    291
  169.254.162.235  255.255.255.255         在链路上   169.254.162.235    291
  169.254.255.255  255.255.255.255         在链路上    169.254.81.146    291
  169.254.255.255  255.255.255.255         在链路上   169.254.162.235    291
      172.18.32.0    255.255.252.0         在链路上      172.18.33.81    281
     172.18.33.81  255.255.255.255         在链路上      172.18.33.81    281
    172.18.35.255  255.255.255.255         在链路上      172.18.33.81    281
    192.168.137.0    255.255.255.0         在链路上     192.168.137.1    311
    192.168.137.1  255.255.255.255         在链路上     192.168.137.1    311
  192.168.137.255  255.255.255.255         在链路上     192.168.137.1    311
    202.116.64.87  255.255.255.255    172.18.35.254     172.18.33.81     26
        224.0.0.0        240.0.0.0         在链路上         127.0.0.1    331
        224.0.0.0        240.0.0.0         在链路上      172.18.33.81    281
        224.0.0.0        240.0.0.0         在链路上     192.168.137.1    311
        224.0.0.0        240.0.0.0         在链路上    169.254.81.146    291
        224.0.0.0        240.0.0.0         在链路上   169.254.162.235    291
  255.255.255.255  255.255.255.255         在链路上         127.0.0.1    331
  255.255.255.255  255.255.255.255         在链路上      172.18.33.81    281
  255.255.255.255  255.255.255.255         在链路上     192.168.137.1    311
  255.255.255.255  255.255.255.255         在链路上    169.254.81.146    291
  255.255.255.255  255.255.255.255         在链路上   169.254.162.235    291
===========================================================================
永久路由:
  无

IPv6 路由表
===========================================================================
活动路由:
 接口跃点数网络目标                网关
  5    281 ::/0                     fe80::3a22:d6ff:fee5:b2d4
  1    331 ::1/128                  在链路上
  2    331 fe80::38c0:2661:8713:5158/128
                                    在链路上
  1    331 ff00::/8                 在链路上
  5    281 ff00::/8                 在链路上
  2    331 ff00::/8                 在链路上
 10    311 ff00::/8                 在链路上
 16    291 ff00::/8                 在链路上
 15    291 ff00::/8                 在链路上
===========================================================================
永久路由:
  无
```



---


### AS & stub & transit 

> 自治系统 Autonomous system (AS)

-   一个自治系统是指在一个(或多个)实体管辖下的所有IP网络和路由器的全体，它们对互联网执行共同的路由策略 //最初要求一个AS由一个单一实体管辖，通常是一个ISP或一个拥有到多个网络的独立连接的大型组织，其遵循一个单一且明确的路由策略
-   整个因特网实际上有很多机构管理，每个机构管理自己的网络。它们有权决定采用什么协议和网络控制策略。这样在同一个机构管理下的网络称为一个自治系统(autonomous systems, AS)。也就是说因特网实际上是由很多自治系统构成的。



1.  内部网关协议(Interior Gateway Protocols，IGP): 用于在AS内(Intra-AS)建立动态路由的路由协议。//e.g.RIP协议，OSPF协议。**一个AS通常运行单一IGP**
2.  外部网关协议(Exterior Gateway Protocol, EGP): 用于在AS之间(Inter-AS)建立动态路由的路由协议称。//e.g.EGP协议，BGP协议。这里网关是Router的旧称




**路由选择域(routing domain)**: 运行同一个IGP协议的连通区域也称为路由选择域(routing domain)。一个AS可以运行多个IGP协议，形成多个路由选择域


**自治系统编号(ASN)**: 用于BGP路由中的每个自治系统都被分配一个唯一的自治系统编号。互联网地址分派机构(IANA)将64512到65535的ASN编号保留给（私有）专用网络使用

自治系统可根据其连接和运作方式分为三类：

1.  **多出口的自治系统**(multihomed AS)是指与其它的自治系统具有多于一个连接的自治系统。一旦那些连接中的某一个完全失效，这个多出口的自治系统也仍然能保持和互联网络的联系。但是，这类自治系统不允许它连接的其它自治系统中的一个穿过它来访问其相连的另一个自治系统。
2.  **末端自治系统(stub AS)**是指仅与一个其它自治系统相连的自治系统。如果该AS的路由策略与其上游的AS完全相同，这说明该AS其实浪费了一个ASN。这种情况更常发生在互联网路由环境中：表面上的末端自治系统可能实际上与其它未被公共路由显示服务器反映出来的AS之间存在着对等互联关系。具体的例子如（美国）财政和交通部门的专用互联网络
3.  **中转自治系统(transit AS)**是指一个自治系统通过自己来为几个隔离开的网络提供连通服务。即，网络A可通过作为中转AS的网络B来连接到网络C。所有的ISP都是这类的中转自治系统，因为这本是就是它们的根本业务目的。因为我们认为ISP是在向客户网络“贩售中转服务”，所以使用**中转自治系统**这个术语来表示

>   每个中转AS(transit AS)都需要由IANA分配一个AS号，而末端AS(stub AS)不需要AS号。连入多个中转AS的末端AS 称为多穴AS(multi-homed AS)

末端网 **Stub Network**(桩网络): 仅有一单个通路通过路由器连接到其他子网，或者仅有一个通路连接到其他网络。判断方法:

1. 一个仅能够通过一个路径接入的网络
2. 单个，没有外部路由器的OSPF区域(尽管它可能有域间/或域内路由)
3. 

---

### RIP protocol 

> 路由信息协议 Routing Information Protocol(RIP) 采用距离向量算法//Floyd算法

-   一种内部网关协议(IGP)，最早出现的距离向量路由协定
-   主要应用于规模较小的、可靠性要求较低的网络，可以通过不断的交换信息让Router动态的适应网络连接的变化，这些信息包括每个Router可以到达哪些网络，这些网络有多远等
-   距离表示：到目的网络的距离以跳为单位[0, 15]。16表示无穷大，即目的网络不可达
-   RIP路由表初始：只有到直连网的路由，距离为1。实际运行时**直连网开销为0**
-   更新周期：每30秒RIP路由器把它的整个路由表发送给邻居。具体实现时每个邻居会错开发送，30秒的时间也会随机变化一点


当收到邻居发来的路由表(update packet),路由器将更新它的路由表<目的网络, 开销,下一跳>:

1.  收到的路由的距离全部加1 (即一跳的距离)，实际运行时是发送的路由表把距离加1
2.  利用上述路由修改路由表:
    -   把路由表中不存在的路由加入路由表
    -   如果比路由表中的路由的距离更小，则更新该路由的距离为新距离，把下一跳改为邻居
    -   如果路由存在，就要重置失效定时器

-   rip 接收到同一网络号 router发来的 跳数更高的路由信息 会更新成新收到的 跳数更高的

```c
0                   1                   2                   3
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| command (1)   | version (1)   |      must be zero (2)         |
+---------------+---------------+-------------------------------+
| address family identifier (2) |      must be zero (2)         |
+-------------------------------+-------------------------------+
|                         IP address (4)                        |
+---------------------------------------------------------------+
|                        must be zero (4)                       |
+---------------------------------------------------------------+
|                        must be zero (4)                       |
+---------------------------------------------------------------+
|                          metric (4)                           |
+---------------------------------------------------------------+
```

相关问题：

- 慢收敛 Slow Convergence：当一个新的网络加入时，需要比较长的时间才能到达较远的路由器路由表上(触发更新 triggered update解决)
- 计数到无穷问题Count to Infinity：一个网络失效后，路由器互发路由表更新距离逐步到16(抑制定时器实现的抑制hold down技术可以解决)

#### RIP 定时器

更新和维护路由信息时主要使用以下4个定时器：

1. 更新定时器Update Timer (缺省=30s/次)：此超时器超时时，立即发送路由更新报文。
2. 失效定时器，老化定时器, invalid timer, expiration Timer(缺省180s)：RIP设备在失效时间内没有收到邻居发来的路由更新报文，则认为该路由不可达(距离改为16)。每次更新该路由时其失效定时器都会被复位
3. 清除定时器 Flush Timer(default = 240s): 到期时将从路由表中删除(更新该路由时复位)
4. 抑制定时器 Hold-down Timer：在路由的距离变为无穷大(包括收到毒化路由)时启动并在其到期之前不允许修改该路由的距离。抑制超时器超时后可重新接受对**端**发送的路由更新报文

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/RIP_Timer.png)

#### 防止网络环路等问题

- 水平分割 split horizon: 从一个接口学来的路由不会从该接口发回去
- 毒性反转 poison reverse: 当一条路由变为无效之后，路由器并不立即将它从路由表中删除，而是将其距离改为用16后广播给邻居，使邻居所拥有的该路由立即失效，而不是等待TTL到期后删除，以迅速消除路由环路。距离为16的路由称为毒化路由poisoned route
- 抑制 hold down: 距离被改为16无穷大的路由在一段短时间(default = 180s)内其距离不允许被修改(解决Count to Infinity)
- 触发更新 triggered update: 一旦出现路由变化将立即把变化的路由发送给邻居。原有的30秒发一次完整的路由表依然不变(解决Slow Convergence)



---


### OSPF protocols  

> OSPF协议(Open Shortest Path First) 开放式最短路径优先协议，采用Dijkstra最短路经算法 是对链路状态路由协议的一种实现，其Open是指路由选择协议是公众可用的
> 可能是在大型企业中使用最广泛的内部网关协议(IGP)
>
> 真正loop-free无环路路由协议

-   一种内部网关协议IGP，用于在单一自治系统AS内决策路由
-   链路状态通告 Link State Advertisement (**LSA**): 点到点网络如果没有配置IP则不需要Network LSA。路由器收集到LSA之后，用新LSA替换链路状态数据库中旧LSA。如果一个LSA在60min(max age)没有被更新，它将从链路状态数据库移除。
-   链路状态数据库 Link Stata Data Base (**LSDB**): 链路状态数据库形成AS拓扑结构图的邻接矩阵，实际上就是全网的拓扑结构图，在全网范围内一致，称为链路状态数据库的同步。
-   区域area: 一个OSPF AS可以配置成多个区域，每个区域都运行自己的OSPF链路状态路由选择算法

每隔一段时间(default 30min)刷新一次数据库中的链路状态，

完全相邻：在发现邻居之后，OSPF路由器将与邻居交换链路状态数据库中的LSA，请求得到更新的或者没有的LSA。在与邻居的链路状态数据库变得完全一样时，它们就处于完全相邻状态（fully adjacency）

生成LSA：每**30min**(为保证健壮性)或链路变化时，每个OSPF路由器会生成router LSA，中转网的DR会生成network LSA

扩散LSA：产生的LSA立即封装为Update分组，被可靠地扩散出去(需要确认)。每次产生的LSA的序号会加1。序列号越大表示越新。若通过收到多个LSA，由发出此LSA的路由器ID(发通告路由器), 链路状态和序列号唯一确定。通过序号，也可以防止扩散形成回路，第二次收到来自相同的发通告路由器、相同LSA类型和相同序号的LSA将丢弃它。

#### OSPF messages

- 问候 Hello(多播发送): 发现邻居的过程: OSPF路由器每10秒(Hello interval)向邻居发送Hello分组。如果40秒(Dead Interval, 4 times hello interval)都收不到邻居发来的Hello分组，则把到邻居的链路标记为失效。多路访问网络采用**多播**(224.0.0.5, all OSPF routers) 发送Hello分组。一个Hello分组包含优先权、已知的邻居（收到过Hello ）、DR和BDR
- 数据库描述 Database Description (DBD, DD) : 包括AS的拓扑结构描述。
- 链路状态请求 Link State Request (LSR) : 路由器向另一个路由器请求更新一部分LSDB
- 链路状态更新 Link State Update (LSU，最核心) : 只要一个路由器的链路状态发生变化就使用LSU，用**可靠**泛洪对全网更新链路状态，其他路由器在收到更新分组后要发送确认分组。
- 链路状态确认 Link State Acknowledgment (LSAck) : 

DD: Database Description Packet

#### Special Router & RID

- 指定路由器 Designated Router (**DR**): 每个中转网(Transit Network)都要选举一个直连路由器作为指定路由
- 备份指定路由 Backup Designated Router (BDR)，BDR在DR不可用时，代替DR的工作。DR与BDR并没有任何本质与功能的区别。只有在多路访问的网络环境，才需要DR和BDR，DR与BDR的选举是在一个二层网段内选举的，即在多个路由器互连的接口范围内，与OSPF area没有任何关系，一个区域可能有多个多路访问网段，那么就会存在多个DR和BDR，但一个多路访问网段，只能有一个DR和BDR 
- Drother: 既不是DR，也不是BDR的路由器。Dother除了和DR互换LSA之外，同时还会和BDR互换LSA
- 自治系统边界路由器 Autonomous System Border Router (**ASBR**): ASBR位于OSPF自主系统和非OSPF网络之间
- 区域边界路由器 Area Border Router (**ABR**)：位于一个或多个OSPF area边界上、将这些区域连接到主干网络的路由器。ABR被认为同时是OSPF主干和相连区域的成员。因此，它们同时维护着描述主干拓扑和其他区域拓扑的路由选择表
- 发布通告路由器 Advertisement Router(AR)



- OSPF协议采用路由器ID(Router ID，RID)标识每一个路由器
- 路由器ID由以下方法得到：

  1. 使用直接配置的RID (#router-id id)
  2. 所有活动环回接口 loop back 中最大的IP地址
  3. 所有活动物理接口中最大的IP地址
- 除非路由器重启、所选接口故障或关闭或IP地址改变、重新执行了router-id命令，RID将保持不变

#### OSPF LSA type

- type1\~4都被限制在本区扩散

1. Type-1**Router LSA**: **每个路由器**都将产生Router LSA，这种LSA只在本区域内传播，描述了路由器所有的链路和接口，状态和开销 
2. Type-2 **Network LSA**: 每个多路访问网络的**DR**都会产生Network LSA(且只由DR产生)，内容包括该网络的与DR完全相邻的所有Router。只在产生这条Network LSA的区域泛洪描述了所有和它相连的路由器（包括DR本身）。中转的多路访问网络有一个Network LSA
3. Type-3 **Network Summary LSA**: 由ABR路由器始发，用于通告该区域外部的目的地址.当其他的路由器收到来自ABR的Network Summary LSA以后，它不会运行SPF算法，它只简单的加上到达那个ABR的开销和Network Summary LSA中包含的开销,通过ABR，到达目标地址的路由和开销一起被加进路由表里，这种依赖中间路由器来确定到达目标地址的完全路由（full route）实际上是距离矢量路由协议的行为 
4. Type-4 **ASBR Summary LSA**: 由ABR发出，ASBR汇总LSA除了所通告的目的地是一个ASBR而不是一个网络外，其他同NetworkSummary LSA.





#### OSPF一般过程



---

### BGP protocol 

-   **边界网关协议** Border Gateway Protocol (BGP)
-   核心的去中心化自治路由协议
-   通过维护IP路由表或‘前缀’表来实现自治系统(AS)之间的可达性，属于矢量路由协议
-   BGP不使用传统的内部网关协议(IGP)的指标，而使用基于路径、网络策略或规则集来决定路由。因此，它更适合被称为矢量性协议，而不是路由协议
-   BGP使用TCP作为传输协议，端口号179。ospf、igrp、eigrp运行于ip层。Is-is在网络层，rip用udp协议 











---

# Transport Layer 传输层

> transport layer, 传输层，运输层

-   传输层协议称为**端到端**或**进程到进程**的协议。因特网的传输层可以为两个进程在不可靠的网络层上建立一条可靠的逻辑链路通信Logic Communication，可以提供字节流传输服务，并且可以进行流控制和拥塞控制
-   通过逻辑通信，运行不同进程的主机好像直接相连。运输层协议在端系统中实现，路由器中不涉及运输层
-   运输层分组(数据单元、报文) 叫做 **数据段、报文段、segment**
-   即使底层网络协议无法提供某些服务，运输层也能提供：可靠的数据传输，加密确保报文段机密性

| TCP                                                       | UDP                            |
| --------------------------------------------------------- | ------------------------------ |
| Reliable                                                  | Unreliable                     |
| Connection-oriented                                       | Connectionless                 |
| Segment retransmission and flow control through windowing | No windowing or retransmission |
| Segment sequencing                                        | No sequencing                  |
| Acknowledges segments                                     | No acknowledgement             |









### Port Numbers 端口号

位于数据段segment中，属于传输层的数据。

- 知名端口 well-known ports : 0~1023。为提供知名网络服务的系统进程所用。e.g. 80-HTTP，21-ftp Control，20-ftp Data，23-telnet，25-SMTP，110-POP3，53-DNS
- 注册端口 registered ports : 1024~49151。在IANA注册的专用端口号，为企业软件所用
- 动态端口 private ports : 49152~65535 (2^15^ + 2^14^ to 2^16^ − 1), 私用、暂用端口号。没有规定用途的端口号，一般用户可以随意使用, dynamic or private ports that cannot be registered with IANA 。

**TCP Port**

| TCP Port | Description          |
| -------- | -------------------- |
| 21       | FTP                  |
| 22       | ssh                  |
| 23       | telnet               |
| 25       | SMTP简单邮件传输服务 |
| 80       | HTTP                 |
| 110      | POP3                 |
| 443      | HTTPS                |
| 1521     | Oracle数据库服务     |
| 3389     | 微软远程桌面         |
| 5000     | MS SQL Server        |

**UDP Port**

| UDP Port  | Description     |
| --------- | --------------- |
| 53        | DNS域名解析服务 |
| 4000/8000 | 腾讯QQ          |
|           |                 |
|           |                 |
|           |                 |
|           |                 |
|           |                 |
|           |                 |
|           |                 |



### Error Control in Transport Layer

- Transport layer protocol (e.g. TCP) sends segments across network and performs end-to-end error checking & retransmission

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_Error%20control%20in%20Data%20Link%20Layer.png)





---

## TCP

> 协议号: 6(在IP packet中) OS将TCP连接抽象为 Socket 表示的本地端点 local end-point，作为编程接口给程序使用 

- **传输控制协议** Transmission Control Protocol
- 面向连接的、可靠的、基于**字节流**、**全双工**通信的运输层传输层通信协议。提供**流控制**机制，即控制发送方的发送速度，使发送的数据不会淹没接收方。作为因特网的主要数据发源地，TCP还提供**拥塞控制**功能
- 一个TCP连接提供无比特错的数据传送 
- 由于IP层只提供无连接的不可靠的尽力服务，所以TCP必须采取措施使通信变为可靠的
- 字节流服务表示没有消息边界。e.g. 多次发送的数据可以放在一个数据段中传送且不标识边界
- 最大分段大小 **MSS (Maximum Segment Size)** : 每个数据段的**数据部分的最大长度**(Byte)

TCP在网络中的大致过程:

1. 应用层向TCP层(运输层)发送用于网间传输的、用8位字节表示的数据字节流
2. TCP把数据流分区成适当长度的报文段（通常受该计算机连接的网络的**数据链路层**的**最大传输单元 MTU** 的限制） 
3. TCP把结果包传给IP层，由IP层通过网络将包传送给接收端实体的TCP层 

TCP协议的运行阶段:

1. 连接创建 connection establishment: 三次握手
2. 数据传送 data transfer
3. 连接终止 connection termination: 四次挥手

> 习题助解：https://blog.csdn.net/Zyj061/article/details/50513198



---

### TCP segment

字节流中的每个字节均被编号。初始序号采用基于时间的方案，一般采用随机数。数据部分的第一个字节的编号为初始序号加1

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_TCP_header_format.png)

> 伪IP头用于计算Check Sum
>
> TCP校验和也包括了96bit的伪头部，其中有源地址、目的地址、协议以及TCP的长度。这可以避免报文被错误地路由
>
> 初始序列号：ISN，Initial Sequence Number

```python
# TCP segment header
 B|0  1  2  3  4  5  6  7 |8  9  10 11 12 13 14 15|16 17 18 19 20 21 22 23|24 25 26 27 28 29 30 31|
 0|                     Source Port               |                Destination Port               |
 4|                                Sequence number (if SYN=1, its initial number)                 |
 8|                      确认号 Acknowledgment number (if ACK set)                                 |
12|Data offset|Reserved|  Flags    (9b)           |                   Window size                 |
16|                    Check Sum                  |            Urgent Pointer(if URG set)         |
20|       Options(if data offset > 5. Padded at the end with "0" bytes if necessary)MAX:40 B      | 
```

- 序号 Sequence number(以字节流为单位): [0, 2^32^-1] **字节序号**。若SYN = 1, 数据部分的第一个字节的编号为**ISN+1**。如果SYN != 1，则此为第一个数据比特的序列码 
- Acknowledgment number 确认号: 确认号为期待接收的下一个数据段的开始序号，也即已经收到的数据的字节长度加1 。ACK = 1时，确认号才有效
- **Data offset** 头部长度: 以32bit(**4B**)为单位，**头部长度的实际大小为[20, 60] Bytes, 选项字段最大40B**。Data Offset最小值为5
- 保留 Reserved 0:  For future use and should be set to zero.应置为0
- Flags: 标志 (aka Control bits) 6 bits, wiki写的是9 bit(有3bit实际未使用)
- Window size 通知窗口大小: 接收窗口的大小(Byte)。接收方用通知窗口大小(advertised window)告知发送方接收窗口的大小，发送方会据此修改发送窗口大小。即空闲块的大小，若接收方尚未将数据交付上层，数据还在缓冲区中，窗口大小变小。（包含错序到达的数据段）
- 校验和 Check Sum: 伪IP头、TCP头和TCP数据部分形成。
- 紧急指针 Urgent Pointer: 指出**带外数据** out-of-band data(OOB)的边界。标志**URG**为1时有效
- 选项: MSS(Maximum Segment Size)、窗口比例(Scale) ；是否使用选择性确认(SACK-Permitted)。数据传送时的选项：选择性确认的序号范围(Selective ACK,SACK)，时间戳等。// Unix 默认值: MSS=536，SACK-Permitted=False。Windows 默认值: MSS=1460，SACK-Permitted=True

| Flags | Content When set to 1 |
| --- | --- |
| NS | ECN-nonce - concealment protection |
| CWR | Congestion Window Reduced |
| ECE | ECN-Echo |
|URG | 高优先级数据包，紧急指针字段有效。表示本数据段**包含紧急数据**(带外数据，不属字节流) |
| ACK | 确认号字段(Acknowledgment number)有效 |
| PSH | 是带有PUSH标志的数据，指示接收方应该**尽快**将这个报文段**交给应用层**而不用等待缓冲区装满 |
| RST| 重置连接。出现严重差错。通知对方立即中止连接并释放相关资源。还可拒绝非法的报文段 / 拒绝连接请求 |
| SYN| 同步(Synchronize)序号标志，用来发起一个TCP连接。这是**连接请求**或是**连接接受请求**，用于创建连接和使顺序号同步 |
| FIN| 结束(Finish)标志，发送方没有数据要传输了，要求释放连接 |

带外数据out-of-band data(OOB)是指对紧急数据，中断或放弃排队中的数据流；接收方应立即处理紧急数据。完成后，TCP通知应用程序恢复流队列的正常处理。OOB并不影响网络，“紧急”仅影响远程端的处理。这一协议很少被实现。**紧急数据(urgent data)是带外数据，不属于字节流** 



### TCP Timer 定时器

- **超时定时器 重传定时器 retransmission timer retransmit timer**：每个连接只针对第一个未确认数据段启动重传定时器。每收到一个确认帧都重置。所有数据段都已确认则关闭。超时重传或发送窗口移动时要重启该定时器。(This means that the retransmit timer fires only when the sender has received *no* acknowledgement for a long time.)
- **持续定时器 坚持定时器 persist timer**: 用于保持窗口大小信息流动即使连接的另一端关闭了接收窗口。
- **保活定时器 keep alive timer:** 在长时间没有交换数据段之后，用于检测连接的另一端是否出了问题。



---

### 数据传输 Data transfer

保证TCP的可靠性和强壮性：使用序号，对收到的TCP报文段进行排序以及检测重复的数据；使用校验和检测报文段的错误，即无错传输；使用确认和计时器来检测和纠正丢包或延时；流控制（Flow control）；拥塞控制（Congestion control）；丢失包的重传。

- TCP协议使用选择性确认，不使用NAK
- 只有一个超时定时器
- 采用字节流方式，每个数据段使用其第一个字节的编号作为序号。确认号为期待接收的下一个字节(下一个数据段)的序号
- TCP协议没有说明如何处理错序到达的数据段，要取决于具体实现

---

#### 可靠传输

> Reliable transmission 保证数据传输的可靠性

- **延迟确认** delayed ACK：接收方并不在收到数据段立即进行确认，而是延迟一段时间再确认。如果这个期间收到多个数据段，则只需要发送一个确认。大部分的系统(Windows, Unix)的延迟确认时间为200毫秒
- 选择性确认 Selective Acknowledgement ：选择性确认允许接收方把收到的数据块通过数据段的**选项**告知发送方，使发送方不会重传这些数据块。选择确认使得TCP接收者可以对乱序到达的数据块进行确认。每一个字节传输过后，ISN号都会递增1。 
- 捎带确认 piggybacking ：在接收数据期间接收方有数据帧要发往发送方，可以在数据帧中确认目前已收到的帧。
- **超时重传 Retransmission TimeOut (RTO)**：在超时定时器超时前，发送出去的Segment未被确认，则对该Segment重传
- 重复累计确认 duplicate cumulative acknowledgements(DupAcks)：



##### 超时重传&超时计算

TCP超时重传机制: 



- **重传超时时间 Retransmission TimeOut (RTO)**:  超时定时器启动时的时间。(过大: 使发送端经过较长时间的等待才能发现报文段丢失，降低了连接数据传输的吞吐量; 过小: 发送端尽管可以很快地检测出报文段的丢失，可能将延迟大的报文段误认为是丢失，造成不必要的重传，浪费网络资源 )

> Estimated: 估计的

- TCP超时计算–初始公式: 

EstimatedRTT = (1-α) ×EstimatedRTT_old + α×SampleRTT

- 0<α≤1, α越小过去样本的影响越大。
- 一般取值: α=0.9。这会使过去影响指数减少。
- 这个公式也称为指数加权移动平均方法(Exponentially Weighted Moving Average).
- 超时时间设置的值 timeout = 2xEstimatedRTT
- 公式的另一种表示方法：：EstimatedRTT= EstimatedRTT_old+ α×(SampleRTT-EstimatedRTT_old)

TCP目前使用的超时重传时间间隔计算算法：**Jacobson Algorithm** 

修改上一公式的参数：α=1/8。

- Jacobson/Karels提议timeout计算还要加上一个合适的安全边际(safety margin)，使得在样本变化较大时timeout会很快变得更大。

平滑的平均偏差：

DevRTT = (1-β)×DevRTT_old + β×| SampleRTT - EstimatedRTT_old |     (typically, β= 1/4)

**TimeoutInterval = EstimatedRTT+ 4×DevRTT**

- **TCP超时计算—Karn算法:** 

Phil Karn提议: 在重传时不要计算estimates。在每次重传时直接把timeout加倍直到数据段首次得到确认。这个修正称为Karn算法(Karnand Partridge,1987)。(有点类似指数退避)

在12次重传后TCP协议发送rst数据段并关闭连接

karn算法：每次超时重传，timeoutInterval重传时间加倍；后续发送的数据段都采用当前的timeoutInterval，重传的数据段的ACK不用来计算timeoutInterval。

---

#### 流量控制-滑动窗口协议

> Flow control 
>
> 避免主机分组发送得过快而使接收方来不及完全收下，一般由接收方通告给发送方进行调控

TCP使用滑动窗口协议实现流量控制。接收方在“接收窗口”域指出还可接收的字节数量。发送方在没有新的确认包的情况下至多发送“接收窗口”允许的字节数量。接收方可修改“接收窗口”的值 

![](http://op4fcrj8y.bkt.clouddn.com/18-7-13/46828798.jpg)

> 图中紫色的范围：接收窗口大小 = 接收已确认但未交付 + 接收但未确认 + 空缓存

接收窗口变为0的处理过程(防止死锁)：在发送窗口为0之后, ，定期从要发送的数据中取一个字节发送出去(Window Probe)，直到收到不为0的通知窗口为止

1. 接收方宣布Window Size = 0，发送方如果有数据要发送，则启动坚持定时器**Persist Timer**(保持定时器)
2. 坚持定时器到期，发送方从要发送的数据中取一个字节发送出去(ZWP包 **Zero Window Probe**)
3. 接收方回复一个带着新的接收窗口大小的确认包则恢复发送，否则重置**Persist Timer**继续尝试发送ZWP包。(一般ZWP包会设置成3次，若3次过后还是0的话，有的TCP实现就会发RST把链接断了)



##### 愚蠢窗口综合症 & Nagle & Clark

> 傻瓜窗口症候 愚蠢窗口综合症 Silly Window Syndrome

如果接收方以很小的增量来处理到来的数据，它会发布一系列小的接收窗口。这被称作**愚蠢窗口综合症**，因为它在TCP的数据包中发送很少的一些字节，相对于TCP包头是很大的开销。解决这个问题，就要避免对小的window size做出响应，直到有足够大的window size再响应：

- 接收端使用David D Clark算法
- 发送端使用Nagle算法延时处理

**Clark算法**：如果收到的数据导致window size小于某个值，可以直接ack置 Window Size=0 把window关闭，阻止发送端再发数据。直到接收方向上交付一些数据后满足下列条件之一，才把window打开(Window Size>0)让发送端再发数据过来:

1. Windows Size大于等于MSS
2. 接收方buffer有一半为空



**Nagle算法**(启发式算法)：自动连接许多的小缓冲器消息，合并 coalescing 一定数量的输出数据后一次提交。这一过程（称为nagling）通过减少必须发送包的个数来增加网络软件系统的效率。**任意时刻，最多只能有一个未被确认的小段**(小于MSS)。

1. Window Size>=MSS 且 Data Size >=MSS
2. 该包含有FIN 
3. 设置了 TCP_NODELAY 则允许发送
4. 未设置TCP_CORK选项时，若所有发出去的小数据包（包长度小于MSS）均被确认，则允许发送
5. 发生超时(typically **200ms**)

 以上条件有一个满足则发送数据，否则就是在积累数据。Nagle算法默认是打开的，对于需要小包场景的程序需要通过TCP_NODELAY关闭这个算法(e.g. telnet ssh等交互性程序)

1. 立即发送一个数据段，即使发送缓冲区只有一个字节。
2. 只有收到上一个数据段的确认或者发送缓冲区中数据超过MSS，才可以发送下一个数据段
3. 对于即时性要求高的地方，如，Window方式的鼠标操作，要关闭Nagle算法



---

#### 拥塞控制

> Congestion control 
>
> wiki https://en.wikipedia.org/wiki/TCP_congestion_control#Congestion_window

TCP的现代实现包含四种相互影响的拥塞控制算法

1. 慢开始(慢启动)
2. 拥塞避免
3. **快速重传 Fast retransmit** : 
4. 快速恢复 



**快速恢复 Fast Recovery** :

**快速重传 fast retransmit**：如果发送方收到一个数据段的**3次重复的ACK**，它就认为其后的数据段（由确认号指出）已经丢失，在超时之前会重传该数据段，这种方法称为快速重传

1. 发送方收到3个重复ACK(即共收到4个)。If a TCP sender receives a specified number of acknowledgements which is usually set to three duplicate acknowledgements with the same acknowledge number (that is, a total of four acknowledgements with the same acknowledgement number) 
2. 发送方会认为该ACK号对应的Segment丢失，会不等待超时，而是立即重传该Segment。the sender can be reasonably confident that the segment with the next higher sequence number was dropped, and will not arrive out of order. The sender will then retransmit the packet that was presumed dropped before waiting for its timeout. 



**AIMD** 加性乘，乘性减 Additive Increase Multiplicative Decrease: 加性增(additive increase):每个RTT, 拥塞窗口 CongWin增加1MSS，直到丢包。 乘性减(multiplicative decrease): 在丢包后CongWin减半



##### Congestion Window

> 拥塞窗口 Congestion Window。拥塞窗口由发送方维护。滑动窗口由接收方维护。
>
> **congestion window size** (cwnd)

In TCP, the **congestion window** is one of the factors that determines the number of bytes that can be outstanding at any time. 



##### Slow Start 慢启动

> **Slow-start** is part of the **congestion control** strategy used by TCP 

Slow-start begins initially with a **congestion window size** (cwnd) of 1, 2, 4 or 10 MSS. 

##### Tahoe & Reno

> 两者算法大致一致，对于丢包事件判断都是以重传超时（retransmission timeout，RTO）和重复确认为条件，但是对于重复确认的处理，两者有所不同 

对于RTO，两个算法都是将拥塞窗口降为1个MSS，然后进入慢启动阶段 

Tahoe：如果收到三次重复确认——即第四次收到相同确认号的分段确认，并且分段对应包无负载分段和无改变接收窗口——的话，Tahoe算法则进入快速重传，将慢启动阈值改为当前拥塞窗口的一半，将拥塞窗口降为1个MSS，并重新进入慢启动阶段 

Reno：如果收到三次重复确认，Reno算法则进入快速重传，只将拥塞窗口减半来跳过慢启动阶段，将慢启动阈值设为当前新的拥塞窗口值，进入一个称为“快速恢复”的新设计阶段 



---

### Establishment 三次握手

> three-way handshake, 非对称 初始序号(initial sequence number,ISN) 

- 每个TCP连接可以由四元组唯一标识：源IP地址, 源端口号,目的IP地址,目的端口号
- TCP uses a three-way handshake(三次握手). Before a client attempts to connect with a server, the server must first bind to and listen at a port to open it up for connections: this is called a **passive open**. Once the passive open is established, a client may initiate an active open. 
- ACK报文用来应答的，SYN报文用来同步的

三次握手过程：

1. SYN: Client 根据已知的IP和端口号向 Server 发送连接请求，seq = **a** (一般为随机数), 称为Client initial sequence number (ISN), **SYN=1, ACK=0**
2. SYN-ACK: Server 为合法 SYN 回送 SYN-ACK。ack值: **a+1**，seq = **b** (一般为随机数) 称为Server ISN, **SYN=1, ACK=1**
3. ACK: Client 再发送一个ack = **b+1**, seq = **a+1**, **ACK=1** . 完成三次握手

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_TCP_Establishment_3times.png)

每一步均采用超时重传，多次重发后将放弃。重发次数与间隔时间依系统不同而不同。头两个数据段确定的选项：Scale，MSS ，SACK-Permited

> 在Google Groups的TopLanguage中看到一帖讨论TCP“三次握手”觉得很有意思。贴主提出“TCP建立连接为什么是三次握手？”的问题，在众多回复中，有一条回复写道：“这个问题的本质是, 信道不可靠, 但是通信双发需要就某个问题达成一致. 而要解决这个问题, 无论你在消息中包含什么信息, 三次通信是理论上的最小值. 所以三次握手不是TCP本身的要求, 而是为了满足"在不可靠信道上可靠地传输信息"这一需求所导致的. 请注意这里的本质需求,信道不可靠, 数据传输要可靠. 三次达到了, 那后面你想接着握手也好, 发数据也好, 跟进行可靠信息传输的需求就没关系了. 因此,如果信道是可靠的, 即无论什么时候发出消息, 对方一定能收到, 或者你不关心是否要保证对方收到你的消息, 那就能像UDP那样直接发送消息就可以了.”。这可视为对“三次握手”目的的另一种解答思路。
>
> 三次通信是理论上在不可靠信道上进行可靠通信的最小值
>
> 三次握手解释（没有第三次握手时的情况）：已经失效的连接请求（A到B的连接请求）报文由于在链路中长时间滞留后，突然又传送到了B，B误以为是A新发送的连接请求，而返回第二次握手给A，并误以为连接已经建立，给A发送数据并等待A发送的数据。B的资源会因此被浪费。
>
> 三次握手解释（协商ISN版）：A通知B：A的ISN（第一次握手）；B确认(ack)收到A的ISN，顺便发送B的ISN（第二次握手）；A确认收到了B的ISN





---

### Termination 四次挥手

> four-way handshake 四路握手过程 

连接的每一侧都独立地被终止。当一个端点要停止它这一侧的连接，就向对侧发送FIN，对侧回复ACK表示确认。连接双方都可以首先发送FIN，主动发起关闭TCP连接的一方在关闭连接之前等待2MSL。

四次挥手具体过程以及双方动作：

1. A 发送连接释放报文，`FIN=1, seq=u`.  (`FIN`报文采用超时自动重发。若干次重发后仍未确认，则发送RST报文后强行关闭连接。重发方法与系统有关)
2. B 收到后发出确认, `ACK=1, ack=u+1, seq=v`. 此时 TCP 属于**半关闭**状态，B 能向 A 发数据但是 A 不能向 B 发数据(TCP半开状态)
3. B 发送连接释放报文，`FIN=1, ACK=1, ack=u+1, seq=w`. 注意`ack`与前相同，因为不再有A向B的报文了
4. A 收到后发出确认,`ACK=1, ack=w+1, seq=u+1`(注意这里`seq`比之前+1). 进入 TIME-WAIT 状态，等待 2 MSL（最大报文存活时间）后释放连接。B 收到 A 的确认后释放连接。

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_Termination_4_wave_handshake.jpg)

- 连接可以工作在**TCP半开**状态。即一侧关闭了连接，**不再发送数据**；但另一侧没有关闭连接，仍可以发送数据。已关闭的一侧仍然应**接收数据**，直至对侧也关闭了连接
- 先发送FIN报文的一方在ACK发送完毕后需要等待 2MSL(**Maximum Segment Lifetime**, 最大报文存活时间) 才完全关闭连接。TCP标准中MSL采用60秒，Unix采用30秒

> 其实挥手也可以是三次，只是大部分时候是四次。三次挥手的情况(相当于第2、3次挥手合并)：A发送FIN给B，B在ACK报文中同时也发送FIN，亦即B在A表示A没有更多数据要发送时，B收到后在确认收到的同时也表示B没有更多数据要发送了。

**CLOSE-WAIT**

- A发送 FIN 连接释放报文后，B收到后进入 **CLOSE-WAIT** 状态。这个状态是为了让B继续发送还未传送完毕的数据。传送完毕之后，B发送 FIN 连接释放报文给A，表明B给A的数据已经发送完了

**TIME-WAIT**

- A收到B的 FIN 报文后进入**TIME-WAIT**状态，并不是直接进入 CLOSED 状态，还需要等待一个时间计时器设置的时间 **2MSL**。

A在TIME-WAIT状态等待2MSL的理由：

1. 为了保证A发送的最后一个ACK报文段能够到达B。A发送的这个ACK报文段有可能丢失，如果 B 没收到 A 发送来的确认报文，那么A就会重新发送连接释放请求报文，A 等待一段时间就是为了处理这种情况的发生
2. 防止“已经失效的连接请求报文段”出现在本链接中。A在发送完最后一个ACK报文段后，再经过时间2MSL，就可以使本连接的时间内所产生的所有报文段都从网络中消失。这样下一个新的连接中就不会出现这种旧的连接请求报文段



---
## UDP

> 协议号: 17(在IP packet中)

-   用户数据报协议 
-   不可靠，无连接。可能丢失、错序
-   接收进程每次接收一个完整的数据报，如果进程设置的接收缓冲区不够大，收到的数据报将被截断

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_TCP_UDP_diff_animate.jpg)



### UDP segment

```python
# UDP datagram header
 B|0  1  2  3  4  5  6  7 |8  9  10 11 12 13 14 15|16 17 18 19 20 21 22 23|24 25 26 27 28 29 30 31|
 0|                  Source Port                  |                Destination Port               |
 4|                     Length                    |                   Checksum                    |
```

- UDP报头长度: **8** Bytes

### IPv4 pseudo header

- 伪IP头：前96 Bytes为**伪IP头**，加入校验和中做加法用。UDP运行在IPv4之上时，为了能够计算校验和，需要在UDP数据包前添加一个“伪头部”。伪头部包括了IPv4头部中的一些信息，但它并不是发送IP数据包时使用的IP数据包的头部，而只是一个用来计算校验和而已。在传输时会去掉
- When UDP runs over IPv4, the checksum is computed using a "pseudo header" that contains some of the same information from the real IPv4 header. The pseudo header is not the real IPv4 header used to send an IP packet, it is **used only for the checksum calculation**.

```python
# UDP IPv4 pseudo header
 B|0  1  2  3  4  5  6  7 |8  9  10 11 12 13 14 15|16 17 18 19 20 21 22 23|24 25 26 27 28 29 30 31|
 0|                                       Source IPv4 Address                                     |
 4|                                     Destination IPv4 Address                                  |
 8|         Zeroes        |       Protocol        |                  UDP Length                   | #以上为伪UDP头
12|                   Source Port                 |               Destination Port                |
16|                     Length                    |                   Checksum                    |
20|                                             Data                                              | 
```





- 总长度、报文长度：整个UDP报文的长度，[8, 65535] Bytes。实际上通过IPv4协议传输时，由于IPv4的头部信息要占用20字节，因此数据长度不可能超过65507字节（65,535 − 8字节UDP报头 − 20字节IP头部） 
- 源端口号和目的端口号：用于关联发送进程和接收进程
- 校验和 Check Sum：由伪IP头、UDP头(校验和为0)和UDP数据形成。其中，伪IP头的协议号为17。如果发送方把校验和设置为0，接收方会忽略校验和。UDP长度就是UDP头部的总长度。UDP数据段的校验和含：UDP header(checksum filled with 0), UDP data, Source IP address, Dest IP address, 0(1B)and protocol(1B) in IP Header, UDP Length(2B) 

在IPv4中，“来源连接端口”和“校验和”是可选字段 





## TLS(Transport Layer Security)

> 传输层安全性协议, Transport Layer Security, TLS
>
> https://en.wikipedia.org/wiki/Transport_Layer_Security

- 传输层安全性协议及其前身安全套接层（Secure Sockets Layer, SSL）是一种安全协议，目的是为互联网通信提供安全及数据完整性保障
- 工作在4，5层之间，为第5层的协议提供服务，但基于可靠传输协议(e.g. TCP)



---

# Application Layer 应用层





| 应用                     | 应用层协议                             | 所使用的传输协议      |
| ---------------------- | --------------------------------- | ------------- |
| e-mail                 | SMTP [RFC 2821]                   | TCP           |
| remote terminal access | Telnet [RFC 854]                  | TCP           |
| Web                    | HTTP [RFC 2616]                   | TCP           |
| file transfer          | FTP [RFC 959]                     | TCP           |
| streaming multimedia   | proprietary (e.g. RealNetworks)   | TCP or UDP    |
| Internet telephony     | proprietary(e.g., Vonage,Dialpad) | typically UDP |





## HTTP

> HTTP 超文本传送协议 hypertext transfer protocol

- HTTP functions as a request–response protocol in the client–server computing model. CS模式下，请求-应答协议
- The client submits an HTTP request message to the server. The server, which provides *resources* such as HTML files and other content, or performs other functions on behalf of the client, returns a response message to the client. 应答服务器(源服务器 origin server)存储HTML文件等资源，向客户端返回响应报文
- A web browser is an example of a **user agent (UA)**. Other types of user agent include the indexing software used by search providers (web crawlers), voice browsers, mobile apps, and other software that accesses, consumes, or displays web content. 网页浏览器是**用户代理程序**的一种
- High-traffic websites often benefit from web cache servers that deliver content on behalf of upstream servers to improve response time. web缓存服务器代表上游服务器交付内容，以提高响应时间。Web browsers cache previously accessed web resources and reuse them, when possible, to reduce network traffic. web浏览器缓存以前访问过的web资源，并在可能的时候重用他们，以减少网络流量。HTTP proxy servers at private network boundaries can facilitate communication for clients without a globally routable address, by relaying messages with external servers. 通过与外部服务器中继消息，私有网络边界上的HTTP代理服务器可以在没有全局可路由地址的情况下促进客户机之间的通信
- 在用户代理和源服务器中间可能存在多个“中间层”，比如代理服务器、网关或者隧道(tunnel)
- 假定底层使用可靠的传输层协议，通常使用TCP。 However, HTTP can be adapted to use unreliable protocols such as the User Datagram Protocol (UDP), for example in HTTPU and Simple Service Discovery Protocol (SSDP).
- **challenge-response mechanism质询-响应机制**



-   无状态的(stateless): server不保留过往客户端的任何信息
-   HTTP 连接: 持久的(Persistent)，非持久的(Nonpersistent)
-   网页(Web page)是由对象(objects)构成的，这些对象可以是HTML文件、JPEG图像文件、MP4视频文件等
-   网页的HTML文件中指出了所需的其他对象

#### URI

HTTP resources are identified and located on the network by **Uniform Resource Locators** (**URL**s)(统一资源定位器), using the **Uniform Resource Identifiers** (**URI**'s)(统一资源标识符) schemes http and https. For example, including all optional components:

```http
            userinfo          host        port
        ┌───────┴───────┐ ┌────┴────────┐ ┌┴┐
 http://john.doe:password@www.example.com:123/forum/questions/?tag=networking&order=newest#top
 └─┬─┘ └───────────┬────────────────────────┘└─┬─────────────┘└────────┬──────────────────┘└┬─┘
 scheme         authority                      path                  query             fragment
```

URIs are encoded as hyperlinks in HTML documents, so as to form interlinked hypertext documents. URL在HTML文档中被编码为超链接，从而形成相互链接的超文本文档。

-   每个对象采用URL指明存放地址
-   HTTP使用统一资源标识符（Uniform Resource Identifiers, URI）URL来传输数据和建立连接

```c
//URL的例子
www.someschool.edu/someDept/pic.gif
|     主机域名     |     路径名     |
//请求网页
GET /2012/cn/zjzd/zjzd02/index.htm HTTP/1.1
connection: close
Host: www.sysu.edu.cn

//请求图片
GET /2012/images/logo-bottom.jpg HTTP/1.1
connection: close
Host: www.sysu.edu.cn
If-Modified-Since: Wed, 16 May 2018 14:12:17 GMT
//注意星期几的缩写问题，空格数量问题(没有连续两个空格)

//流水式持久连接HTTP //connection: keep-alive
GET /2012/cn/zjzd/zjzd02/index.htm HTTP/1.0
connection: keep-alive
Host: www.sysu.edu.cn


GET /2012/images/logo-bottom.jpg HTTP/1.1
connection: keep-alive
Host: www.sysu.edu.cn


//
```



### History

HTTP/1.1是原始HTTP (HTTP/1.0)的修订版。在HTTP/1.0中，对每个资源请求都建立到同一服务器的单独连接。HTTP/1.1可以在页面交付后多次重用连接来下载图像、脚本、样式表等。因此，HTTP/1.1通信的延迟更小，因为TCP连接的建立带来了相当大的开销。

| Year |                HTTP Version                 | Description                                   |
| :--: | :-----------------------------------------: | --------------------------------------------- |
| 1991 |                     0.9                     | 已过时，只接受GET，不指定版本号，不支持请求头 |
| 1996 |                     1.0                     |                                               |
| 1997 |                     1.1                     | keep-alive-mechanism, 管线化                  |
| 2015 | [2.0](https://en.wikipedia.org/wiki/HTTP/2) |                                               |
| 2018 | [3.0](https://en.wikipedia.org/wiki/HTTP/3) |                                               |



### HTTP Session

- An HTTP session is a sequence of network request-response transactions. 网络请求-响应事务
- An HTTP client initiates a request by establishing a Transmission Control Protocol (TCP) connection to a particular port on a server (typically port 80, occasionally port 8080). HTTP客户端通过建立到服务器上特定端口(80, 8080, 8008)的TCP连接来发起请求
- An HTTP server listening on that port waits for a client's request message. HTTP服务器监听对应端口以等待客户端请求报文
- HTTP服务端接收请求后，服务端返回状态行(e.g. HTTP/1.1 200 OK)以及对应消息。消息主体通常是请求的资源
- HTTP是无状态协议，无状态协议不需要HTTP服务器在多个请求间保存用户的信息或者状态
- 一些web应用使用HTTP cookie或web表单中的隐藏变量实现状态或服务器端会话



### HTTP 消息结构

- 一旦建立连接后，数据消息就通过类似Internet邮件所使用的格式[RFC5322]和多用途Internet邮件扩展（MIME）[RFC2045]来传送

#### 客户端请求消息

**客户端发送一个HTTP请求到服务器的请求消息包括以下格式：请求行（request line）、请求头部（header）、空行和请求数据四个部分组成**

![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/Net_HTTP_Client_packet_content.png)



### HTTP 请求方法

- 根据 HTTP 标准，HTTP 请求可以使用多种请求方法
- HTTP1.0 定义了三种请求方法： GET, POST 和 HEAD
- HTTP1.1 新增了六种请求方法：OPTIONS、PUT、PATCH、DELETE、TRACE 和 CONNECT 



### Request Message

> 客户端请求消息

请求报文包含四个部分：

1. 请求行 request line(e.g. `GET /images/logo.png HTTP/1.1`, 从服务器请求`/images/logo.png`)
2. 请求头域 request header fields (e.g., Accept-Language: en).在HTTP/1.1, 除了`Host`外所有请求头域都是可选的。In the HTTP/1.1 protocol, all header fields except Host are optional.
3. 空行 an empty line. 仅包含`<CR><LF>`，无其他空白
4. 可选的报文体 an optional message body; (即请求数据)

请求行与别的头部域必须以回车换行结束The request line and other header fields must each end with `<CR><LF> `(that is, a **carriage return** character followed by a **line feed** character).

#### Request Methods

- HTTP定义方法(有时称为谓词，但在规范中没有提到谓词verb，OPTIONS或HEAD也没有提到谓词)来指示要在标识的资源上执行的所需操作

HTTP1.0 定义了三种请求方法：GET, POST, HEAD

HTTP1.1 新增了六种请求方法：OPTIONS, PUT, PATCH, DELETE, TRACE, CONNECT



| Method  | Description                                                  |
| ------- | ------------------------------------------------------------ |
| GET     | **请求指定的页面信息**，并返回实体主体                       |
| HEAD    | 类似于 GET 请求，只不过**返回的响应中没有具体的内容**，用于获取报头 |
| POST    | **向指定资源提交数据进行处理请求**（例如提交表单或者上传文件）。数据被包含在请求体中。POST 请求可能会导致**新的资源的建立和/或已有资源的修改** |
| PUT     | 从客户端向服务器传送的数据**取代指定的文档的内容**           |
| DELETE  | 请求服务器**删除指定的页面**                                 |
| CONNECT | HTTP/1.1 协议中预留给能够将连接改为**管道**方式的**代理服务器** |
| OPTIONS | 允许客户端查看服务器的性能                                   |
| TRACE   | 回显服务器收到的请求，主要用于**测试或诊断**                 |
| PATCH   | 是对 PUT 方法的补充，用来对已知资源进行**局部更新**          |

##### Safe Methods



### Response Message

> 服务器响应消息



HTTP响应也由四个部分组成：

1. 状态行
2. 消息报头
3. 空行
4. 响应正文



| 应答头           | 说明                                                         |
| :--------------- | :----------------------------------------------------------- |
| Allow            | 服务器支持哪些请求方法（GET、POST等）                        |
| Content-Encoding | 文档的编码（Encode）方法。只有在解码之后才可以得到Content-Type头指定的内容类型。利用gzip压缩文档能够显著地减少HTML文档的下载时间。Java的GZIPOutputStream可以很方便地进行gzip压缩，但只有Unix上的Netscape和Windows上的IE 4、IE 5才支持它。因此，Servlet应该通过查看Accept-Encoding头（即request.getHeader("Accept-Encoding")）检查浏览器是否支持gzip，为支持gzip的浏览器返回经gzip压缩的HTML页面，为其他浏览器返回普通页面 |
| Content-Length   | 表示内容长度。只有当浏览器使用持久HTTP连接时才需要这个数据。如果你想要利用持久连接的优势，可以把输出文档写入 ByteArrayOutputStream，完成后查看其大小，然后把该值放入Content-Length头，最后通过byteArrayStream.writeTo(response.getOutputStream()发送内容 |
| Content-Type     | 表示后面的文档属于什么MIME类型。Servlet默认为text/plain，但通常需要显式地指定为text/html。由于经常要设置Content-Type，因此HttpServletResponse提供了一个专用的方法setContentType |
| Date             | 当前的GMT时间。你可以用setDateHeader来设置这个头以避免转换时间格式的麻烦 |
| Expires          | 应该在什么时候认为文档已经过期，从而不再缓存它？             |
| Last-Modified    | 文档的最后改动时间。客户可以通过If-Modified-Since请求头提供一个日期，该请求将被视为一个条件GET，只有改动时间迟于指定时间的文档才会返回，否则返回一个304（Not Modified）状态。Last-Modified也可用setDateHeader方法来设置 |
| Location         | 表示客户应当到哪里去提取文档。Location通常不是直接设置的，而是通过HttpServletResponse的sendRedirect方法，该方法同时设置状态代码为302 |
| Refresh          | 表示浏览器应该在多少时间之后刷新文档，以秒计。除了刷新当前文档之外，你还可以通过setHeader("Refresh", "5; URL=http://host/path")让浏览器读取指定的页面。 注意这种功能通常是通过设置HTML页面HEAD区的＜META HTTP-EQUIV="Refresh" CONTENT="5;URL=http://host/path"＞实现，这是因为，自动刷新或重定向对于那些不能使用CGI或Servlet的HTML编写者十分重要。但是，对于Servlet来说，直接设置Refresh头更加方便。  注意Refresh的意义是"N秒之后刷新本页面或访问指定页面"，而不是"每隔N秒刷新本页面或访问指定页面"。因此，连续刷新要求每次都发送一个Refresh头，而发送204状态代码则可以阻止浏览器继续刷新，不管是使用Refresh头还是＜META HTTP-EQUIV="Refresh" ...＞。  注意Refresh头不属于HTTP 1.1正式规范的一部分，而是一个扩展，但Netscape和IE都支持它 |
| Server           | 服务器名字。Servlet一般不设置这个值，而是由Web服务器自己设置 |
| Set-Cookie       | 设置和页面关联的Cookie。Servlet不应使用response.setHeader("Set-Cookie", ...)，而是应使用HttpServletResponse提供的专用方法addCookie。参见下文有关Cookie设置的讨论 |
| WWW-Authenticate | 客户应该在Authorization头中提供什么类型的授权信息？在包含401（Unauthorized）状态行的应答中这个头是必需的。例如，response.setHeader("WWW-Authenticate", "BASIC realm=＼"executives＼"")。 注意Servlet一般不进行这方面的处理，而是让Web服务器的专门机制来控制受密码保护页面的访问（例如.htaccess） |







### HTTP状态码

- HTTP状态码由三个十进制数字组成，第一个十进制数字定义了状态码的类型，后两个数字没有分类的作用

| 分类 | 分类描述                                       |
| :--- | :--------------------------------------------- |
| 1**  | 信息，服务器收到请求，需要请求者继续执行操作   |
| 2**  | 成功，操作被成功接收并处理                     |
| 3**  | 重定向，需要进一步的操作以完成请求             |
| 4**  | 客户端错误，请求包含语法错误或无法完成请求     |
| 5**  | 服务器错误，服务器在处理请求的过程中发生了错误 |



- 100 Continue - 继续，客户端应继续其请求
- 200 Accepted - 请求成功
- 301 Moved Permanently - 资源（网页等）被永久转移到其它URL
- 404 Not Found - 请求的资源（网页等）不存在
- 500 Internal Server Error - 内部服务器错误



### Persistent Connections

> 持久连接

- In HTTP/0.9 and 1.0, the connection is closed after a single request/response pair. 在HTTP 0.9, 1.0 每次请求-响应对结束后，连接关闭
- In HTTP/1.1 a **keep-alive-mechanism** was introduced, where a connection could be reused for more than one request. HTTP 1.1 提出**保活机制**(持久连接)，连接可被重用，进行多次请求
- 持久连接明显减少了请求延迟。第一次请求后，客户端不需要重新协商TCP三次握手连接(TCP 3-Way-Handshake connection)。
- 另一积极副作用：由于TCP慢启动机制(TCP's slow-start-mechanism)，连接通常会随着时间变快。

HTTP 1.1 比1.0还进行了带宽优化：

- HTTP/1.1 introduced **chunked transfer encoding**(分块传输编码) to allow content on persistent connections to be streamed rather than buffered. 允许持久连接中的内容可以进行流处理而非缓冲
- HTTP pipelining further reduces lag time, allowing clients to send multiple requests before waiting for each response. Another addition to the protocol was byte serving, where a server transmits just the portion of a resource explicitly requested by a client.

#### Chunked Transfer Encoding

> **分块传输编码** Chunked transfer encoding 是超文本传输协议 HTTP 中的一种数据传输机制

- 允许HTTP由网页服务器发送给客户端应用（ 通常是网页浏览器）的数据可以分成多个部分。分块传输编码只在HTTP协议1.1版本（HTTP/1.1）中提供
- 如果一个HTTP消息（请求消息或应答消息）的`Transfer-Encoding`消息头的值为`chunked`，那么，消息体由数量未定的块组成，并以最后一个大小为0的块为结束





## FTP

> FTP 文件传输协议 **F**ile **T**ransfer **P**rotocol

-   用于在网络上进行文件传输的一套标准协议，使用客户/服务器模式 (C/S)
-   FTP server 使用 2 个端口，数据端口和命令端口(控制端口)
-   the FTP server command port : 21 命令端口
-   the FTP server data port: 20 数据端口
-   FTP 命令都有由 3 or 4 个字母组成，命令后面跟参数，用空格分开。每个命令都以 "\r\n"结束
-   FTP uses TCP because the file transfer has to be correct.

FTP实现的目标:

1.  促进文件的共享（计算机程序或数据）
2.  鼓励间接或者隐式的使用远程计算机
3.  向用户屏蔽不同主机中各种文件存储系统（File system）的细节
4.  可靠和高效的传输数据

缺点:

1.  密码和文件内容都使用明文传输，可能发生窃听
2.  因为必须开放一个随机的端口以创建连接，当防火墙存在时，客户端很难过滤处于主动模式下的FTP流量。这个问题，通过使用被动模式的FTP，得到了很大解决
3.  服务器可能会被告知连接一个第三方计算机的保留端口
4.  此方式在需要传输文件数量很多的小文件时，性能不好



### FTP commands

-   FTP Client commands



```c
telnet 172.18.187.11 21//控制连接
220 Microsoft FTP Service//return codes: 220

user usr_id //身份验证 用户名
331 Password required for user.//

pass 123456//身份验证 密码
230 User user logged in.

type i //指定以binary模式传输  

pasv
227 Entering Passive Mode (172,18,186,1,12,26).

//此时应打开另一个连接，作为数据传输端口连接  the FTP server data port
telnet 202.116.76.22 3098//3098 = 12*256 + 26

  

 
list
125 Data connection already open; Transfer starting.
226 Transfer complete.

quit
221
```






| Command  | Description                              |
| -------- | ---------------------------------------- |
| **ABOR** | Abort an active file transfer.           |
| ACCT     | Account information.                     |
| ADAT     | Authentication/Security Data             |
| ALLO     | Allocate sufficient disk space to receive a file. |
| APPE     | Append (with create)                     |
| **AUTH** | Authentication/Security Mechanism        |
| CCC      | Clear Command Channel                    |
| CDUP     | Change to Parent Directory.              |
| CONF     | Confidentiality Protection Command       |
| **CWD**  | Change working directory.                |
| **DELE** | Delete file.                             |
| ENC      | Privacy Protected Channel                |
| EPRT     | Specifies an extended address and port to which the server should connect. |
| EPSV     | Enter extended passive mode.             |
| FEAT     | Get the feature list implemented by the server. |
| HELP     | Returns usage documentation on a command if specified, else a general help document is returned. |
| HOST     | Identify desired virtual host on server, by name. |
| LANG     | Language Negotiation                     |
| **LIST** | Returns information of a file or directory if specified, else information of the current working directory is returned. |
| LPRT     | Specifies a long address and port to which the server should connect. |
| LPSV     | Enter long passive mode.                 |
| MDTM     | Return the last-modified time of a specified file. |
| MFCT     | Modify the creation time of a file.      |
| MFF      | Modify fact (the last modification time, creation time, UNIX group/owner/mode of a file). |
| MFMT     | Modify the last modification time of a file. |
| MIC      | Integrity Protected Command              |
| **MKD**  | Make directory. 创建文件夹                    |
| MLSD     | Lists the contents of a directory if a directory is named. |
| MLST     | Provides data about exactly the object named on its command line, and no others. |
| MODE     | Sets the transfer mode (Stream, Block, or Compressed). |
| NLST     | Returns a list of file names in a specified directory. |
| NOOP     | No operation (dummy packet; used mostly on keepalives). |
| OPTS     | Select options for a feature (for example `OPTS UTF8 ON`). |
| **PASS** | Authentication password. 身份验证 密码         |
| PASV     | Enter passive mode.                      |
| PBSZ     | Protection Buffer Size                   |
| **PORT** | Specifies an address and port to which the server should connect. |
| PROT     | Data Channel Protection Level.           |
| **PWD**  | Print working directory. Returns the current directory of the host. |
| **QUIT** | Disconnect. 结束FTP连接                      |
| REIN     | Re initializes the connection.           |
| REST     | Restart transfer from the specified point. |
| RETR     | Retrieve a copy of the file              |
| RMD      | Remove a directory.                      |
| RNFR     | Rename from.                             |
| RNTO     | Rename to.                               |
| SITE     | Sends site specific commands to remote server (like `SITE IDLE 60` or `SITE UMASK 002`). Inspect `SITE HELP` output for complete list of supported commands. |
| **SIZE** | Return the size of a file.               |
| SMNT     | Mount file structure.                    |
| SPSV     | Use single port passive mode (only one TCP port number for both control connections and passive-mode data connections) |
| STAT     | Returns the current status.              |
| **STOR** | Accept the data and to store the data as a file at the server site |
| STOU     | Store file uniquely.                     |
| STRU     | Set file transfer structure.             |
| SYST     | Return system type.                      |
| **TYPE** | Sets the transfer mode (ASCII/Binary)    |
| **USER** | Authentication username. 身份验证 用户名        |
| XCUP     | Change to the parent of the current working directory |
| XMKD     | Make a directory                         |
| XPWD     | Print the current working directory      |
| XRCP     |                                          |
| XRMD     | Remove the directory                     |
| XRSQ     |                                          |
| XSEM     | Send, mail if cannot                     |
| XSEN     | Send to terminal                         |

>   Authentication 身份验证



### FTP server return codes

-   client发送FTP命令后，server返回响应码，return codes由三维数字编码表示

>   https://en.wikipedia.org/wiki/List_of_FTP_server_return_codes

1.  第一个数字表示命令状态的一般性指示，比如响应成功、失败、不完整
2.  第二个数字表示响应类型的分类
3.  第三个数字提供更加详细的信息



第一个数字代表的含义:

1.  服务器正确接收信息，还未处理
2.  服务器已经正确处理信息
3.  服务器正确接收信息，正在处理
4.  信息暂时错误
5.  信息永久错误



第二个数字的含义:

0.  语法
1.  系统状态和信息
2.  连接状态
3.  与用户认证有关的信息
4.  未定义
5.  与文件系统有关的信息



-   FTP may run in *active* or *passive* mode, which determines how the data connection is established. In both cases, the client creates a TCP control connection from a random, usually an unprivileged(非特定的), port N to the FTP server command port 21.

### Active Mode (PORT)

-   active mode 主动模式 //相关指令: PORT

主动模式下，Client随机打开一个大于 1024 的端口向Server的命令端口 P，即 21 端口，发起连接，同时开放N +1 端口监听，并向服务器发出 “port N+1” 命令，由服务器从它自己的数据端口(20) 主动连接到客户端指定的数据端口 (N+1)。FTP 的客户端只是告诉服务器自己的端口号，让服务器来连接客户端指定的端口。对于客户端的防火墙来说，这是从外部到内部的连接，可能会被阻塞





### Passive Mode (PASV)

-   Passive Mode 被动模式 //相关指令: PASV
-   命令连接和数据连接都由Client发起
-   Client向Server请求被动连接后，会获得端口号，由Client主动连接
-   解决了从Server到Client的数据端口的连接被防火墙过滤的题。被动模式下，当开启一个 FTP 连接时，Client打开两个任意的本地端口 (N > 1024 和 N+1) 

第一个端口连接服务器的 21 端口，提交 PASV 命令。然后，服务器会开启一个任意的端口 (P > 1024 )，返回如“**227 entering passive mode (127,0,0,1,4,18)**”。 它返回了 227 开头的信息，在括号中有以逗号隔开的六个数字，前四个指服务器的地址，最后两个，将倒数第二个乘 256 再加上最后一个数字，这就是 FTP 服务器开放的用来进行数据传输的端口。如得到 227 entering passive mode (h1,h2,h3,h4,p1,p2)，那么端口号是 p1*256+p2，ip 地址为h1.h2.h3.h4。这意味着在服务器上有一个端口被开放。客户端收到命令取得端口号之后, 会通过 N+1 号端口连接服务器的端口 P，然后在两个端口之间进行数据传输





## DHCP Protocol

-   动态主机设置协议(Dynamic Host Configuration Protocol)//Configuration [n.]配置 结构 外形
-   用于主机在加入网络时动态租用IP地址 
-   **LAN的网络协议**，**使用UDP协议工作**，用途：
    1.  用于内部网络或ISP自动分配IP address给用户
    2.  用于内部网络管理员作为对所有电脑做中央管理的手段




-   DHCP运行分为四个基本过程，1.请求IP租约;2.提供IP租约;3.选择IP租约;4.确认IP租约;
-   客户在获得了一个IP地址以后，就可以发送一个ARP请求来避免由于DHCP服务器地址池重叠而引发的IP冲突


![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/DHCP_process.png)

>   DHCP使用了租约的概念，或称为计算机IP地址的有效期。租用时间是不定的，主要取决于用户在某地连接Internet需要多久，这对于教育行业和其它用户频繁改变的环境是很实用的。通过较短的租期，DHCP能够在一个计算机比可用IP地址多的环境中动态地重新配置网络。DHCP支持为计算机分配静态地址，如需要永久性IP地址的Web服务器

-   DHCP数据报采用UDP分组进行传送，DHCP Server和DHCP Client的端口号分别为67和68
-   DHCP服务器可以给主机自动分配一个有租期的或者永久使用的IP地址
-   DHCP Message Type(Options): 1-discover,2-offer,3-request,5-ack





---





# ATM参考模型

-   **Asynchronous transfer mode** (ATM) 是建立在**电路交换**和**分组交换**的基础上的一种新的交换技术//数据传输技术 异步传输模式
-   实现B-ISDN的业务的核心技术之一。ATM是以信元cell为基础的一种分组交换和复用技术，它是一种为了多种业务设计的通用的面向连接的传输模式。它适用于LAN和WAN，它具有高速数据传输率和支持许多种类型的通信
-   ATM信元为基本单位，长度为53个字节
-   虚电路：由于ATM网络面向连接，故当初始分组经过子网时，该路径上所有的路由器都在他们的内部表中建立一个表项，用来标明该虚电路(virtual circuit)的存在
-   ATM参考模型，不同于OSI、TCP/IP模型。包括三层：物理层、ATM层、ATM适配层





使用异步时分复用， 摒弃了电路交换中采用的同步时分复用，收发双方的时钟可以不同，可以更有效地利用带宽

面向连接：在通信双方向建立连接,通信结束后再由信令拆除连接



CELL 信元：53Byte

1.  信元头 5B: 承载该cell控制信息。包含了选择路由用的VPI(Virtual Path Identifier虚通道标识符)/VCI(Virtual Circuit Identifier虚通路标示符)信息
2.  信元体 48B: 承载用户要分发的信息



# Error Detection差错检验



>   参照张永民老师的ppt

### Parity 奇偶校验

>   parity 奇偶性

-   奇偶校验位parity bit或校验比特check bit是一个表示给定位数的二进制数中1的个数是奇数还是偶数的二进制数
-   奇偶校验位是最简单的错误检测码
-   奇偶校验位有两种类型：**偶校验位**与**奇校验位**
-   



Single Bit Parity

| 7位数据（1的个数） | 偶校验位          | 奇校验位          |
| ---------- | ------------- | ------------- |
| 0000000（0） | 0000000 **0** | 0000000 **1** |
| 1010001（3） | 1010001 **1** | 1010001 **0** |
| 1101001（4） | 1101001 **0** | 1101001 **1** |
| 1111111（7） | 1111111 **1** | 1111111 **0** |

Two Dimensional Bit Parity 二维奇偶校验

- 二位奇偶校验码对所有两位错误都可以检测出来，但是纠正不了。



### Check Sum 检验和

-   检验和 校验和 checksum 
-   冗余校验的一种形式
-   通常是以十六进制为数制表示的形式。范围:0-255
-   通常用来在通信中，尤其是远距离通信中保证数据的完整性和准确性


计算过程：

1.  将**校验和部分先置为0x00 00**
2.  把字节流按照两字节为一单元**分割**(16bit)
3.  将所有两字节进行二进制**求和**
4.  若求和结果大于16bit，将**高于16bit的内容加回低16bit**，重复此步骤至结果为16bit内
5.  对计算结果**按位取反**得check sum



```cpp
//二进制表示的计算
//数据部分
  10011100 00011010
  11011010 10001000
  10101101 00110101
//计算check sum过程
1000100011 11010111//求和//注意进位
  00100011 11011001//高于16bit的部分>>16后，加回低16bit
  11011100 00100110//按位取反 得到check sum
```

```cpp
//16进制表示的计算
  8A E4
  B5 78
  E0 E6
  EE 03
//计算check sum过程
3 0F 45//求和//注意进位
  0F 48//高于16bit的部分加回低16bit
  F0 B7//按位取反 得到check sum
```

![](http://op4fcrj8y.bkt.clouddn.com/18-7-18/63687626.jpg)





### CRC 循环冗余校验码

> 循环冗余校验 Cyclic Redundancy Check, CRC

-   简短固定位数校验码的一种散列函数
-   采用**模2除法** 做减法时没有借位，类似于按位异或
-   采用二进制除法(没有进位，用**XOR**代替减法)相除得到余数
-   如果传输过程中没有出现比特错，接收方用相同的除数去除数据加CRC校验码，余数应该为0


计算过程：

1.  生成除数: 将X的最高次幂为R的生成多项式Generator转换成对应的R+1位二进制数生成除数
2.  生成被除数: 将信息码(传输的数据Data)左移R位//相当于 \*2^R^
3.  计算 (**XOR**): 模2除法得出余数Remainder，即为CRC校验码//使用
4.  将CRC校验码拼接到被除数左移填补的0的位置(被除数最右侧)得完整CRC码

![](http://op4fcrj8y.bkt.clouddn.com/18-3-25/87998656.jpg)

-   上图为模2除法

![](http://op4fcrj8y.bkt.clouddn.com/18-3-25/71945054.jpg)





---

# 可靠数据传输原理

-   




-   分组的数据（比特）在传输过程中发生了损坏，即部分比特从0变成了1或者从1变成了0。
-   分组在传送过程中丢失了，比如当分组到达一个中转的路由器时，路由器的输入队列已经满了，此时分组就会溢出，即被丢弃。
-   分组没有按照发送的顺序到达接收方




-   选择性确认 Selective Acknowledgement: 接收方把已收到的帧的序号告诉发送方
-   捎带确认 Piggybacking: 通信双方其实是全双工方式工作。接收方在发数据给对方时顺便把确认号也告诉对方
-   延迟确认 Delayed Acknowledgement: 接收方收到一帧后并不立即发送确认帧，而是等待一段时间再发送。







## ARQ 自动重传请求

>   **自动重传请求**(**Automatic Repeat-reQuest**，ARQ)
>
>   repeat 重复 复制 背诵 副本
>
>   request 请求 需要 要求

-   是OSI模型中**数据链路层**和**传输层**的错误纠正协议之一
-   通过使用确认和超时这两个机制，在不可靠服务的基础上实现可靠的信息传输
-   **超时重传**：如果发送方在发送后一段时间之内没有收到确认帧，它通常会重新发送
-   ARQ可能包括**停止等待ARQ协议**和**连续ARQ协议**，错误检测（Error Detection）、正面确认（Positive Acknowledgment）、超时重传（Retransmission after Timeout）和 负面确认及重传（Negative Acknowledgment and Retransmission）等机制



Basic elements of ARQ:

- Error-detecting code with high error coverage
- ACKs (positive acknowledgments): 肯定确认
- NAKs (negative acknowledgments): 否定确认
- Timeout mechanism: 超时机制



由于发送方使用了计时器，所以当发送方收到了当前分组的上一个分组的ACK的时候（即当前分组传输损坏）或者回馈分组损坏的时候（这两个操作都不会重置计时器），并不会立即发送当前分组，而是等到计时器超时才重新发送当前分组???



### Stop-and-Wait ARQ

> 停止等待协议

-   停等协议的接收、发送双方仅需设置一个帧的缓冲存储空间和帧序号只取0或1的两个状态标志位，便可有效地实现数据重发并确保接收方接受的数据不会重份







### 连续ARQ & Sliding Window Protocol

-   滑动窗口协议 Sliding Window Protocol
-   回退n帧ARQ和选择性重传ARQ协议是滑动窗口技术与ARQ请求重发技术的结合








-   发送窗口 Sending Window: 是个连续发送数据帧的可用序号范围，主要用于流控制flow control
-   发送窗口大小Sending Window Size (SWS)表示发送窗口的大小，也是发送缓冲区的大小
-   接收窗口: 确定应该保存哪些帧，用序号范围表示
-   接收窗口大小Receiving Window Size (RWS): 表示接收窗口的大小，也是接收缓冲区的大小
-   **确认帧 Acknowledgement Frame** ：**确认号为ACK的帧**，用于接收方通知发送方其发送的序号为ACK的数据帧以及更早发送的数据帧已经全部收到并已交给上层协议(**累积确认**)。通过延迟确认，可以少发送确认帧。如果前面的确认帧丢失，后面到达的确认帧也可以对前面帧的确认，提高了可靠性。











### Go-Back N ARQ (GBN)

-   **Go-Back-N ARQ** is a specific instance of the automatic repeat request(ARQ) protocol
-   发送多个帧，若其中一个帧丢失，则返回到丢失帧重传丢失帧及其后面的所有帧。
-   It is a special case of the general sliding window protocol with the transmit window size of N and receive window size of 1



回退N协议可能会收到落在发送窗口之外的确认帧：如果因确认帧迟到而出现超时重传，就可能收到一个帧的两个确认帧。第二个确认帧就会落在发送窗口之外。

选择性重传协议丢失了NAK并非致命错误：因为还有超时重传机制确保可靠性



### Selective Repeat ARQ 选择性重传

> Selective-Repeat 选择性重传

-   

理论上选择重传协议要为每个packet使用一个计时器.当某个计时器超时后,只有相应的分组被重传.换而言之,返回N协议将所有的packet当做一个整体对待,而选择重传协议则分别对待每一个packet.但是大多数SR的运输层仅使用了一个计时器. 注意只使用一个计时器而做到跟踪所有发出去的分组的情况的做法是:标记发出分组,当ACK=Sf 时,将窗口滑过所有连续的已确认的分组,如果还有未确认的分组,则重发所有检测到的未被确认的分组并重启计时器,如果所有分组都被确认了则停止计时器

在GBN中确认值(ACK) 是累计的,它定义了下一个希望接收的分组序号,同时也证实了此前所有的分组都已经被完好的接收了.在SR中,确认号(ACK)之定义完好接收的那一个分组的序号,并不反馈任何其他分组的信息

否定性确认帧 Negative Acknowledgement,NAK：用于表示这一帧之前的数据帧全部收到并已交给上层协议，要求发送方重传这一帧。每个帧只发送一次NAK。



![](http://op4fcrj8y.bkt.clouddn.com/18-3-30/50613295.jpg)



选择性重传协议需要的最少序号个数与SWS和RWS的关系 ：序号个数>=SWS+RWS。如果接收方收到新的SWS个帧，发回的确认全部丢失，在这种情况下，序号少了就会出现重复错误。

选择性重传协议可能会收到落在接收窗口之外的数据帧：因确认帧丢失而重传的帧都会落在接收窗口之外





---

# Windows Network CMD

```c
ip config /all

```



### route

-   metric: 跃点数 跳数 匹配到两项掩码等长时 会选择跃点数更低的

```c
route print//print route table
  
//add route table item: 到192.168.1.0/24 网段的数据包，都通过2号(网卡)接口走192.168.2.1的网关(Router连接该Host的ip地址)，优先级为3
route add 192.168.1.0 mask 255.255.255.0 192.168.2.1 metric 3 if 2
//添加-p: 永久路由，不会因重启Host而丢失
route add -p 192.168.1.0 mask 255.255.255.0 192.168.2.1 metric 3 if 2
 
//删除一条路由匹配项
route delete 192.168.100.0
//ps: 如果有两条路由记录有着相同的“目的网络号”，则会将两条记录同时删除。如果只想删除其中某一条的话，请在删除后用route add命令再添加上其中一条
  
//修改一条路由记录
route change 157.0.0.0 mask 255.0.0.0 157.55.80.5 metric 2 if 2
//CHANGE参数只能修改“网关”和“跳数”

//使用netsh看看metric设置，总metic指等于interface metric +gateway metric
netsh interface ip show address
```

>   跃点数是为用于特殊网络接口的 IP 路由分配的值，用来标识与使用该路由有关的成本。 例如，可以根据链接速度、跃点计数或时间延迟来计算跃点数。 “自动跃点计数”是 Windows 中的一个新增功能，它可以自动为基于链接速度的本地路由配置跃点数。 默认情况下，将启用“自动跃点计数”功能，也可以进行手动配置，为其赋予一个具体的跃点数
>
>   当路由表中包含用于同一目的地的多个路由时，“自动跃点计数”功能便非常有用。 例如，如果您的计算机具有一个 10 兆位 (Mb) 的网络接口和一个 100 Mb 的网络接口，并且该计算机具有一个在两个网络接口上均已配置的默认网关，那么“自动跃点计数”功能就会为较慢的网络接口分配较高的跃点数。 该功能会强制流向 Internet 的所有流量，例如，使用可用的最快网络接口



---

# 搜索引擎指令

关键词+空格+site:+网址   仅在某个域名下搜索

关键词+空格+减号(-)+关键词   不包含减号后的内容

关键词+空格+filetype:+格式    搜索某个格式的文件





---

# POSIX

**可移植操作系统接口**（Portable Operating System Interface，缩写为**POSIX**），是[IEEE](https://zh.wikipedia.org/wiki/IEEE)为要在各种UNIX操作系统上运行软件，而定义API的一系列互相关联的标准的总称，其正式称呼为IEEE Std 1003，而国际标准名称为ISO/IEC 9945。此标准源于一个大约开始于1985年的项目。POSIX这个名称是由理查德·斯托曼应IEEE的要求而提议的一个易于记忆的名称。它基本上是Portable Operating System Interface（可移植操作系统接口）的缩写，而**X**则表明其对Unix API的传承

Linux基本上逐步实现了POSIX兼容，但并没有参加正式的POSIX认证。微软的[Windows NT](https://zh.wikipedia.org/wiki/Windows_NT)声称部分实现了POSIX标准。

当前的POSIX主要分为四个部分：Base Definitions、System Interfaces、Shell and Utilities和Rationale。







---

# 改Host

> https://github.com/lennylxx/ipv6-hosts

```c
tracert www.google.com
tracert bt.byr.com
ipconfig -flushdns //刷新dns
```

### pixiv

```
##
210.129.120.41 www.pixiv.net
210.140.131.144 source.pixiv.net
210.129.120.41 accounts.pixiv.net
210.140.131.147 imgaz.pixiv.net
210.140.131.145 comic.pixiv.net
210.140.131.145 novel.pixiv.net
210.129.120.41 factory.pixiv.net
210.129.120.41 oauth.secure.pixiv.net
210.129.120.44 en-dic.pixiv.net
203.210.8.42 sketch.pixiv.net
210.129.120.40 sensei.pixiv.net
210.129.120.40 recruit.pixiv.net 
##以上是后来添加的
```



---

# Shadowsocks



```bash
//打开shadowsocks
cat  shadowsocks

//开放端口8388的防火墙
firewall-cmd --permanent --add-port=8388/tcp

//重新加载防火墙
firewall-cmd --reload

//查看shadowsocks的状态
systemctl status shadowsocks

//重启shadowsocks
systemctl restart shadowsocks

//vi打开/etc/shadowsocks.json
vi /etc/shadowsocks.json

//查看文件类型
file 文件

esc后
:wq	//write and quit

//一键安装shadowsocks
bash <(curl -s http://morning.work/examples/2015-12/install-shadowsocks.sh)

//安装vim
yum install vim

-------
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py
pip install --upgrade pip
pip install shadowsocks
-------

systemctl enable shadowsocks

systemctl start shadowsocks

systemctl status shadowsocks

mv config.json shadowsocks.json


cd /etc ;ls

//写入服务
vi /etc/systemd/system/shadowsocks.service

[Unit] 

Description=Shadowsocks 


[Service] 

TimeoutStartSec=0 
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json 

[Install] 

WantedBy=multi-user.target
```





---

# ShadowsocksR



SSR订阅: 

```shell
https://fatpipe.work/subscribe/v1/7091/474c70a47ee0eaf95b55cad00d0f3e49
https://raw.githubusercontent.com/AmazingDM/sub/master/ssrshare.com
```



- How2Ues: 

```
1. 解压
2. 双击 ShadowsocksR-dotnet4.0.exe 允许通过防火墙等
3. 在桌面右下角图标处找到SSR的小飞机，右键找到服务器订阅 -> 订阅设置
4. 在订阅设置的弹出框，点击添加，在订阅网址输入 https://fatpipe.work/subscribe/v1/7091/474c70a47ee0eaf95b55cad00d0f3e49   。然后点击确定
5. 右键小飞机 -> 服务器订阅 -> 更新订阅节点，一般第二个会失败，选择第三个绕过代理更新节点会成功。如果失败，右键小飞机 -> 模式 -> 不允许系统代理 （第一个）
6. 更新成功后，右键小飞机 -> 服务器 -> WB-7091 选择服务器，一般地域较近的网速较快，也有国内服务器，在所需网站可以上的情况下优先选择近的，如果上不了，换一个服务器。双击小飞机也可以查看并更换服务器。
```



