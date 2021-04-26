[TOC]

基于有效载荷的方法 payload-based methods = deep packet inspection 深度包检测



# 名词解释







## flow

> https://en.wikipedia.org/wiki/Traffic_flow_(computer_networking)

- Applied to Internet routers, a flow may be a host-to-host communication path, or a socket-to-socket communication identified by a unique combination of source and destination addresses and port numbers, together with transport protocol (for example, UDP or TCP). In the TCP case, a flow may be a virtual circuit, also known as a virtual connection or a byte stream.
- 应用于Internet路由器，流可以是host-to-host的通信路径，也可以是socket-to-socket的通信，它是由**源地址**、**目标地址**、**端口号**以及**传输协议**（e.g. UDP, TCP）。 在TCP情况下，流可以是虚拟电路，也称为虚拟连接或字节流。
- In packet switches, the flow may be identified by IEEE 802.1Q **Virtual LAN tagging** in Ethernet networks, or by a **Label Switched Path** in MPLS tag switching
- A session is a traffic unit divided based on 5-tuple, i.e. source IP, source port, destination IP, destination port and transport-level protocol. A flow is very similar to a session, and the difference is that it **contains traffic of only one direction**, i.e. the source and destination IP / port are not interchangeable. flow是单向的五元组决定的traffic     //《End-To-end encrypted traffic classification with one-dimensional convolution neural networks》中的解释
- A **flow** is mostly defined as set of packets sharing common characteristics: Source-IP, Destination-IP, Source-Port, Destination-Port and Protocol
- 激活的流：It is considered as **active-flow** when time-interval between packets belonging to a particular flow is below certain threshold value, which depends upon the purpose of analysis or study. Claffy et al. [28] identified that threshold value of **64 s** is good compromise considering the size of flow and initializing & terminating flows. 64秒比较合适，在流的大小和开始/结束流之间平衡。流也可以定义为单向或双向的



## DPI payload-based

> Deep Packet Inspection 深度包检测
>
> 基于有效载荷

DPI检测应用层协议的协议数据，即有效载荷(payload)部分。



## flow-based

> 基于流的

- packet flow: 包流，包含了ARP，TCP/UDP等包的所有数据，包含报头（猜测，未确定



## port-independent protocol identification

与端口无关的协议识别





## application classification

应用识别，





# Peer to Peer Protocol

> P2P



- 集中方式在很多情况下不再适用这种大规模数据存储的要求，这就需要一个新的体系来管理系统中的数据。P2P分布式存储系统就是解决这样的问题。这些研究包括全分布式存储系统：Oceanstore，Past和FreeHaven等。其中，基于超级点结构的半分布式P2P应用如KaZaa、Edonkey、Morpheus、Bit Torrent等也属于P2P共享存储的范畴，并且用户数量急剧增加
- 





- 基于P2P技术的文件共享软件：Napster、KaZaa、BT、eMule





## Topology

- 拓扑结构是P2P设计过程的核心问题，直接决定了整个网络的基本形态，并且影响着系统中大量对等节点的命名、组织管理、节点加入/退出方式、容错机制和资源定位机制的设计。
- 由于P2P网络的拓扑维护和路由是叠加于IP层之上的应用层进行的，因此也被称为覆盖网络(Overlay Network)

1. 中心式P2P网络：服务器对用户共享的资源建立索引并提供查询服务。e.g. Napser, BitTorrent, eDonkey2000, FS2You
2. 无结构P2P网络：去掉了中心索引服务器，将资源文件的索引信息分散到所有网络节点上，网络中所有节点在功能和访问权限上是完全对等的，当一个节点需要查询所需要的资源时，会向所有邻居节点发送查询请求，收到的请求会以泛洪、BFS或随机漫步的方式将消息向下转发。e.g. Gnutella, Freenet
3. 结构化P2P网络：分布式散列表（DHT, Distributed Hash Table）应用到了P2P网络拓扑设计中。e.g. CAN(Content-Addressable Network), Chord, Pastry, Tapestry, P-Grid, Kademlia(Kad)
4. 混合式P2P网络：结合中心式与分布式拓扑特点的折中选择，通过在完全分布式P2P网络中引入超级节点(super node)来实现。e.g. KaZaA, Skype, eMule



- 



## List of P2P protocols



| Protocol                                |               | Used by                                                      | Defunct(不再使用) clients                                    |
| --------------------------------------- | ------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Advanced Peer-to-Peer Networking (APPN) |               | Systems Network Architecture                                 |                                                              |
| Bitcoin                                 |               | Bitcoin, Alt-Coins                                           |                                                              |
| Freenet                                 | Decentralized | Freenet, Frost                                               |                                                              |
| Gnutella2                               | Decentralized | Envy, FileScope, gtk-gnutella, MLDonkey, Shareaza            |                                                              |
| Libp2p                                  |               | IPFS, Orbit (chat application)                               |                                                              |
| IRC (XDCC)                              |               | BitchX, Colloquy, Konversation, Kvirc, mIRC, Pidgin, Weechat, Xchat |                                                              |
| OpenFT                                  | Decentralized | giFT, MLDonkey                                               |                                                              |
| WebTorrent                              | Decentralized | WebTorrent Desktop                                           |                                                              |
| WinMX Peer Networking Protocol          | Decentralized | OurMX, WinMX, WinPY, WinZO                                   |                                                              |
| Gnutella                                | Decentralized | Cabos, Envy, FileScope, Gnucleus, gtk-gnutella, iphex, Phex, Shareaza, WireShare | Acquisition, BearShare, iMesh, LimeWire, Morpheus, Trustyfiles |
| Overnet                                 |               | XNap                                                         | edonkey2000, Overnet                                         |
| eDonkey                                 | Decentralized | aMule, Bitcomet, eMule, FileScope, Flashget, imule, MLDonkey, Neoloader, Shareaza, Xunlei | edonkey2000, Vagaa                                           |
| FastTrack                               | Decentralized | MLDonkey, XNap                                               | Grokster, Kazaa, Kazaa Lite, Trustyfiles                     |
| OpenNap                                 | Centralized   | Audiognome, FileScope, Lopster, SunshineUN,[3] TekNap, Utatane, XNap, Winlop, WinMX | Morpheus, Napigator                                          |
| Direct Connect                          | Centralized   | ApexDC++, BCDC++, DC++, MLDonkey, Shareaza                   | NeoModus Direct Connect                                      |
| BitTorrent (BT)                         | Decentralized | Ares Galaxy, BitComet, Bitlord, BitTorrent, Flashget, FrostWire, Getright, i2psnark, libtorrent, μTorrent, Miro, MLDonkey, Popcorn Time, qBittorrent, Shareaza, Tixati, Transmission, Tribler, Xunlei, Vuze, etc. | Trustyfiles, Vagaa                                           |
| Ares                                    | Decentralized | Ares Galaxy                                                  | Warez P2P                                                    |
| DAT                                     | Decentralized |                                                              |                                                              |
| GNUnet                                  | Decentralized |                                                              |                                                              |
| I2P                                     | Decentralized |                                                              |                                                              |
| IPFS                                    | Decentralized |                                                              |                                                              |
| Kad                                     | Decentralized |                                                              |                                                              |
| Perfect Dark                            | Decentralized |                                                              |                                                              |
| Retroshare                              | Decentralized |                                                              |                                                              |
| Share                                   | Decentralized |                                                              |                                                              |
| Tribler                                 | Decentralized |                                                              |                                                              |
| Winny                                   | Decentralized |                                                              |                                                              |
| ZeroNet                                 | Decentralized |                                                              |                                                              |
| Soribada                                | Centralized   |                                                              |                                                              |
| Soulseek                                | Centralized   |                                                              |                                                              |













# Datasets



> - https://sites.google.com/site/dspham/downloads    KB to 4MB数据集 多个zip。zd.zip, bnp.zip dynamic.zip lp.zip 等
> - https://sites.google.com/site/dspham/downloads/network-traffic-datasets   Dr Sonny Pham 两个7z，多个csv，处理过的数据，只有三四列数据。 
> - https://www.caida.org/data/overview/    **CAIDA Data** 有很多数据集 但是目测暂无合适的 而且目测也要因非DHS-Approved Locations 而被拒绝提供数据
> - https://ant.isi.edu/datasets/requests.html   Datasets are available through the participation of the LACREND project in the DHS **IMPACT**( https://www.impactcybertrust.org/ ) program, or on request to usc-lander-host@isi.edu   以非美国国土安全部支持的区域为由，拒绝提供





# bt

- bt是BitTorrent协议的简称，bt协议是最流行的p2p下载协议
- BT协议是一个协议簇：有点像tcp/ip协议一样，bt协议不是一个简单的协议，而是一系列相关的协议组成的，而且这个协议簇一直在进化。



- Mainline DHT协议：基于结构化P2P，为BT共享网络提供了结构化拓扑，减轻Tracker负担的一种扩展协议，大致基于Kademlia协议开发
- PEX(Peer Exchange)协议：广泛应用于BT系统，减轻Tracker服务器压力的扩展协议。多数BT客户端和95%以上的节点均支持PEX扩展协议。主要有三种典型实现：AZ PEX, UT PEX, BC PEX



## Entities Consisted and Steps

1. An ordinary web server. 传统的文件服务器
2. A static 'metainfo' file. 种子文件(.torrent文件)
3. A BitTorrent tracker. bt tracker服务器
4. An 'original' downloader. 原始下载者，文件分享者
5. The end user web browsers. web浏览器
6. The end user downloaders. 下载者(多个)



一个服务器按照下面的步骤开始文件分享过程

1. 启动一个bt tracker服务器
2. 启动一个普通的web服务器，如apache
3. 在web服务器上配置多媒体类型‘application/x-bittorrent’关联到.torrent文件
4. 生成一个.torrent文件，在文件中添加bt tracker服务器的地址
5. 上传torrent文件到web服务器
6. 发布torrent文件下载页面
7. 等待用户下载

一个用户按照下面的步骤开始文件下载

1. 安装bt客户端
2. 浏览web页面
3. 下载torrent文件
4. 保存torrent文件到本地
5. 使用bt客户端打开torrent文件，开始下载
6. 等待文件下载完成



## bencoding 编码

> Bencode (pronounced like B-encode) is the encoding used by the peer-to-peer file sharing system BitTorrent for storing and transmitting loosely structured data.



## metainfo files(.torrent)

metainfo files(俗称torrent文件)使用bencoding进行编码的一个dictionaries数据类型，有两个key

1. announce ： bt tracker服务器地址
2. info ： info又是一个dictionaries（bencoding支持数据类型的嵌套），info里面的字符串都是使用utf-8编码
   1. name: 文件名，通常用作torrent文件的文件名
   2. piece length: 每一个文件块的byte长度。bt协议将文件分成等大的piece，除最后一块，通常是2的指数。最常见为2^18^ = 262144 bytes = 256KB. ver3.2前默认为 2^20^=1MB. 
   3. pieces: 是一个字符串，长度为20的倍数，每一段20个字符对应文件块的SHA1的hash值
   4. files: 一个dictionaries数据类型，有两个key
      1. length: 文件长度，总字节数. The length of the file, in bytes.
      2. path: 一个utf-8编码的字符串list，最后一个字符串保存真实的文件名，前面的字符串保存文件路径。长度为0表示path字段不合法。 A list of UTF-8 encoded strings corresponding to subdirectory names, the last of which is the actual file name (a zero length list is an error case).

length和files 两个中有且只有一个会出现。当存在length key时，表示torrent种子文件只包含一个单一的文件，length表示这个文件的字节数，俗称文件长度

## trackers

tracker服务器接收get请求，一个get请求由下列字段组成

| key        | description                                                  |
| ---------- | ------------------------------------------------------------ |
| info_hash  | The 20 byte sha1 hash of the bencoded form of the info value from the metainfo file. This value will almost certainly have to be escaped. |
| peer_id    | 下载者的id，20bytes的字符串。每个下载者再开始下载前会随机生成自己的id |
| ip         | [optional]                                                   |
| port       | 文件下载者监听的端口，默认从6881开始，最大的6889             |
| uploaded   | The total amount uploaded so far, encoded in base ten ascii. |
| downloaded | The total amount downloaded so far, encoded in base ten ascii. |
| left       | The number of bytes this peer still has to download, encoded in base ten ascii. 十进制表示的剩余字节总数 Note that this can't be computed from downloaded and the file length since it might be a resume, and there's a chance that some of the downloaded data failed an integrity check and had to be re-downloaded. 重传，或文件块数据完整性校验失败导致需重新下载。 |
| event      | [optional] 有4种可能值：started, completed, stopped, empty(same as not being present). If not present, this is one of the announcements done at regular intervals. An announcement using started is sent when a download first begins, and one using completed is sent when the download is complete. No completed is sent if the file was complete when started. Downloaders send an announcement using stopped when they cease downloading. |





# eMule

> 开源免费的P2P文件共享软件，基于eDonkey2000的eDonkey网络

- eMule作为eDonkey的继承者，对eDonkey进行了大量的改进，其中最大的改进是增加了DHT网络的支持，即加入了对Kad网络的支持，是一个基于Kademlia协议全新的DHT网络
- 由于DHT网络是将所有的节点连接在一起的，所以这使eMule系统能够获取的资源数目大大增加，同时增强了eMule系统的稳定性。技师没有eD2k服务器，eMule系统也能正常运行。通常现在的eMule客户端加入了两个覆盖网络：eD2k覆盖网络和Kad覆盖网络





# Kademlia

> 简称Kad，结构化P2P网络拓扑，基于DHT技术

实现了4种操作的报文：

1. PING: 主要用于检测一个节点是否在线，当以PONG消息回复PING消息时，证明在线
2. STORE: 通知节点需要存储的资料信息，一般为<key, value>对
3. FIND\_NODE: 
4. FIND\_VALUE: 





# Gnutella

> 努特拉 G不发音



---

# Papers





## paper: Transport layer identification of P2P traffic

> 2004 Proceedings of the 2004 ACM SIGCOMM Internet Measurement Conference, IMC 2004
>
> Karagiannis, Thomas
> Broido, Andre
> Faloutsos, Michalis
> Claffy, Kc

每个(IP, port) pair 会关联以下信息:

1. IPset: 连接到的IP
2. PortSet: 连接到的port
3. avg_pktssizesSet: (每个flow里的)平均包大小
4. transfer_sizesSet: 流(flow)大小

```python
# Algorithm 1: Nonpayload algorithm for P2P flow identification #named: PTP
# Rejected: nonP2P的Pair(IP, Port)
# P2PPairs: P2P的Pair(IP, Port)
FT = FlowTable # 依据 (srcIP, dstIP, srcPort, dstPort, prt) 建立
for all (srcIP, dstIP) in FT:
	if (srcIP, dstIP) 同时用TCP, UDP: 
		P2PIP += srcIP += dstIP # set P2PIP记录了同时用TCP,UDP的所有IP
for all flows in FT: # (srcIP, dstIP, srcPort, dstPort, prt)
    if srcIP/dstIP in P2PIP:
        P2PIP += srcIP += dstIP # put both IPs in P2P list (P2PIP)
    else if (srcPort == dstPort and srcPort < 501): # src dst端口相等且小于501
        Rejected += {srcIP, srcPort} += {dstIP, dstPort}
    else if srcIP and dstIP not in MailServers:
    	for (srcIP, srcPort) and (dstIP, dstPort):
            if pair in P2PPairs:
                P2PPairs += (srcIP, srcPort)
                P2PIP += (srcIP, srcPort)
            else if pair not in Rejected:
            	Update sets for pair
                IPPort += (srcIP, srcPort) += (dstIP, dstPort)
            else if pair in Rejected:
                Rejected += (srcIP, srcPort) += (dstIP, dstPort) # 把srcPair dstPair 都并入 Rejected
for all pair in IPPort:
# examine pairs that were added during previous intervals and have not been yet classified  # 检测在之前时间段中添加的、尚未分类的pair
    if IP not in MailServers and pair not in Rejected:
    # IP不在邮箱服务器 且 pair 暂未 Rejected
        if IP in P2PIP or pair(IP, port) in P2Ppairs: # 
            P2PPairs += pair
        else
        	diff = | len(pair.IPSet) - len(pair.PortSet) | # 所连接的IP与Port的数量差
        	if diff < 2 or (diff < 10 and port in KnownP2PPorts):
            # 如果所连接的IP数与Port数 差距小于2；或 差距小于10且port在已知P2P端口集合中(pairs with port in the knownP2PPortSet are more likely to be P2P) # 进一步判断是否归为P2P
                if Check_if_Mailserver == True: 
                # 监测每个出现了{IP,25}的IP 的 dstPort, 如果set(dstPorts)也出现了port 25, 则认为该IP为MailServer，并将其所有的流视作nonP2P
                	MailServer += IP
                else if  Check_if_Malware == True:
                # 恶意软件：有很多到不同IP/Port的连接 且带有相同的 包数量/字节数/包大小
                	Rejected += pair
    			else if  Check_if_scan == True:
                # 端口扫描：拒绝出现在大量(IP, Port)中，同时目标IP较少的 所有IP
                	Rejected += pair
                else if Port_History heuristic == True:
                # 端口历史：对于(IP, Port)Pair，检查曾用于连接该Pair的所有Port，如果超过10个flow中，所有端口都是知名服务的端口，则判定为nonP2P
                    Rejected += pair
                else
                	P2PPairs += pair
			else if diff > 10: # 该pair的IP数量和Port数量差距过大，归为nonP2P
                Rejected += pair
```



## Identifying P2P traffic: A survey

> 2017 专注p2p识别的综述

[62]有数据集 [63]有提取方法

[64]没有用难懂的统计特征或机器学习，就能TP 97%识别p2p应用 e.g.BitComet BitTorrent eMule，可以实时分类加密流量



### 4. Verification of ground truth of traffic

> 流量的事实验证 指流量属于哪个app/protocol
>
> ground truth可以考虑翻译为参考标准

由于隐私问题，流的信8息可能只有头部信息可用

1. 数据集公开前预先打标签
2. 人工打标签
3. 端口匹配
4. payload检测/DPI

3,4两种方法在验证新的分类方法的时候，会导致结果的不一致。因此很多研究者选择自己采集带有ground truth的流量作为数据集，验证算法的准确度。同样存在问题：用别人的方法来做对比的时候，由于用的数据集不同，导致结果不一致。

因此有种解决方案为：在受控的小型网络中，运行预定义的app，进行流量采集。但是这种方法可能不包含人类行为。

[41]用DPI原理和多种启发式方法，提出了GTVS框架，用于提高、简化参考标准的验证过程

[42]提出GT工具集，包含在每个客户端上运行的deamon守护进程，用以返回启动网络连接的进程的信息。[43]也提出了一个类似的，基于客户端的方法

没有一种验证ground truth的方法是完美的。而新的分类技术的性能也取决于参考的分类模型的准确性（验证事实的分类方法）。

### 6. P2P traffic classification techniques

1. 基于端口
2. 基于payload
3. Classification of traffic in the dark, 不依赖端口号和payload
4. Classification of encrypted traffic, 加密流量的识别



#### 6.3 Classification of traffic in the dark



##### a) Statistical or behavioural signatures

> 统计或行为特征

依赖于包/流级别的属性，比如 包大小，发送/接受的总字节数，流持续时间，流大小，包抵达的间隔时间，TCP/UDP使用的端口。可以单独使用也可以合起来使用，如均值、方差、概率密度函数。用这一方法分类，需要一个提前学习的步骤，用于建立一个参考模型。

58 59：分析web请求响应的大小、每个页面的请求数量、请求与页面回传的的间隔时间，将隐藏在web流量中的VoIP流量识别出来。

60：分析几种P2P和non-P2P的应用，P2P的包大小更加异质/不均匀(heterogeneity)，异质程度用熵表示，熵的值通过一个包含有一定包数量的滑动窗口来计算。

61：C4.5决策树，用两种特征：ACK-Len ab, ACK-Len ba ..... 可以分类: www, ftp, e-mail, P2P，分析的是通信双方的发送的数据量。用了三个数据集，分别为[62]，工作环境，用[63]从工作环境中提取的。可实时在线分类，只使用一开始几个包的数据长度

64: 在受控的被监视的网络下，基于host，对flow进行聚类，

65: 识别P2P直播，基于从行为特性分析得出的联合特征

66: CUFTI( Core Users Finding and Traffic Identification ) 用于识别和管理核心用户 (long-lived peers长存在的peer) 的P2P流量。研究peer在PPlive系统的存在时间life-time，识别核心用户from the overlay(???)。模型利用不用P2P应用的payload长度，一开始的几个控制用的包的方向，用longest common subsequence(LCS)和流识别。

67: component(连通子图) based, 利用UDP连接识别P2P流量。<IP, Port>作为一个节点，两个节点之间有双向流量，则有连边，在短周期内，基本可以确定相连的点的应用类型相同，因此连通子图有相同的应用类型。

##### b) Heuristic-based methods

68: 6个启发式方法：UDP，TCP的同时使用，知名P2P端口，两个对等点之间存在的连续连接数，具有相同流标识的几个流，流持续时间超10分钟或者流大小大于1MB，在测量周期内使用相同端口号超过5次的IP地址。

69: 重定义了[68] [54] 中用的启发式方法，改成：UDP，TCP的同时使用，知名P2P协议的端口数量，经常使用的端口数量，端口数与IP地址数的关系，流持续时间大于10分钟或流大小大于1MB

70: 利用UDP协议识别P2P流量，揭示和验证了三个不会出现在non-P2P应用的TCP/UDP流量。a.几乎所有本地主机通过固定端口号传输的UDP流量 b.几乎所有远程对等端都使用单个端口号与本地主机进行通信 c.P2P应用产生的UDP数据包大小相对固定

71: 基于连接模式，不需要payload signatures。实时识别，只识别广义P2P协议，不识别不同P2P应用

72: 使用Netflow记录，

##### c) Machine Learning methods

76: 贝叶斯网络，用知名端口号，每条流的IP包分布，包大小分布，octets-per-flow distribution，流时间分布。在校园网上验证

77: Classification And Regression Tree (CART) 分类回归树，实时识别应用层协议，在flow-level and host-level

47: 网络层包属性，识别P2P流量，概念自适应快速决策树 Concept-adapting Very Fast Decision Tree (CVFDT)

78: 分类Skype的TCP和UDP流，C4.5决策树和AdaBoost算法。带标签的大学的网络

79: 识别多种P2P协议的流量，使用基于分类器的叫随机森林的决策树，在校园网，住宅区网验证

80: 基于隐马尔可夫模型分类，用包大小、包间间隔时间，在真实网络上分类 HTTP, SMTP, eDonkey, P2P-TV, MSN messenger, PPlive & two multi-player games，用DPI验证

81: 用SVM，短周期内peers之间交换的包的数量，识别P2P-TV应用

82: 使用有监督机器学习算法 用每分钟上传 下载量的比例 作为识别模式

83: 用神经网络识别，Fuzzy Predictive Adaptive Resonance Theory模糊预测自适应谐振理论，利用IP头信息，用带标签数据集，accuracy 78-92%

84,85: 关联规则挖掘association rule mining，5元组，Apriori algorithm，校园网，DPI手动验证

86: P2PTIAL, 不需要完全标记的样本集，用主动学习active learning识别P2P：SVM，uncertainty selection policy. 

38,87: Moore-dataset 包含P2P, www, bulk, database, interactive, mail, services, attack, games&multimedia, 

88: SVM, 可以识别加密流量，1. 数据包大小的均方值的改变； 2. 平均流持续时间; 3. IP, 端口数的比值

89: 改进的SVM，识别P2P流量，节省存储空间

90: ensemble learning model整体学习模型，一体化随机森林，feature weighted Naive Bayes带权特征朴素贝叶斯，包含P2P traffic(BaiDuYingYin, BaoFengYingYin, PPS, PPlive, QQlive, XunLeiKanKan and Thunder)和non-P2P traffic(Web, Youku and Souhu)

91: novel and fine-grained P2P traffic classification approach that relied on count of most frequent and steady flows generated by corresponding P2P applications called **Clustering Flows** 这个方法总觉得是不是和老师说的对流进行聚类有一些相似？ 仅利用流的基本属性(协议，包大小与数量)，SVM分类，用在BitTorrent, eMule, PPTV & Cbox

92: 用了四种监督学习方法((C4.5, Ripper, SVM, Naive Bayes)，Ripper更好，分类P2P应用 BitCommet, uTorrent and BitTorrent



##### d) Methods involving combined approaches

54: 识别FastTrack, eDonkey, Gnutella, BitTorrent, Direct-Connect, MP2P & Ares的流量，用了端口号，payload signatures, 行为模式behavioural patterns。

93: active crawlers，推断某个应用的对等实体的信息，推断网络的拓扑，小波分析，分析网络层信息：每个包和包之间的到达时间，用eDonkey and FTP的流量做验证

94: payload-based method & statistical method，不同的Skype客户端，包含文件传输、直接通话、呼叫电话服务、使用中继节点的电话

95: host heuristics & flow statistics, pattern heuristics (set of rules)





# 中文论文



### [文件传输中P2P协议流量检测](https://kns.cnki.net/KCMS/detail/detail.aspx?filename=2009244330.nh&dbname=CMFD2010&dbcode=cdmd&uid=WEEvREcwSlJHSldSdmVqM1BLVW9SZEtFSm5XVlE4V0I5d2Q0MEtRVGJ6OD0=$9A4hF_YAuvQ5obgVAqNKPCYcEjKensW4IQMovwHtwkF4VYPoHbKxJw!!&v=MTEwNjdhbXoxMVBIYmtxV0EwRnJDVVI3dWZZK1J0Rnkva1U3L1BWMTI3RjdHOEd0TFByNUViUElSK2ZuczR5Ulk=)

> 朱守德

P29/71  2.3.7 基于流量特征的检测技术。提到了启发式流量监测方法，

p44：某一时间窗（T=10s）内某一IP向N=10以上的IP发送TCP SYN包时，判定为P2P。

p45：10s内，某一个IP的一个确定的UDP端口，连接的不同IP(的 UDP)数\>3，判定为P2P

过程特性：保持和许多IP地址的UDP包、TCP交互，而且P2P主机会用不同的端口（进程）监测与不同节点的连接

在时间T=5分钟内，寻找看某一个IP的IP对和端口对数是否相等，如果一直保持相等或接近则认为是P2P。如果在连接过程中，连接的 IP 对数与端口对数有至少有 10 个不同那么我们认为其肯定不是 P2P 的应用。 在其他参考文献也提到了类似的特征，而且给出的实验数据认为这种方法有很好的性能，但我们认为这里需要考虑的情况有：P2P 用户可能同时用 P2P 应用和其它网络应用，这时就会影响识别的准确性，而且这种识别方式比较前几种特征来说实现起来代价相对较高。因此需要实验评测这种方法的具体性能，并对不同的网络环境中具体参数取值进行修正。

在 10 秒内，TCP 长包(大于 1300 字节)的数量不少于 5 个作为判决标准。 首先要排除的是 FTP 和 HTTP 下载，通常采用 21 和 80 端口，但也可能使用其它端口，因此我们需与前面的识别方法组合起来进行识别。