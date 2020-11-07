8

基于有效载荷的方法 payload-based methods = deep packet inspection 深度包检测



# 名词解释







## flow

> https://en.wikipedia.org/wiki/Traffic_flow_(computer_networking)

- Applied to Internet routers, a flow may be a host-to-host communication path, or a socket-to-socket communication identified by a unique combination of source and destination addresses and port numbers, together with transport protocol (for example, UDP or TCP). In the TCP case, a flow may be a virtual circuit, also known as a virtual connection or a byte stream.
- 应用于Internet路由器，流可以是host-to-host的通信路径，也可以是socket-to-socket的通信，它是由**源地址**、**目标地址**、**端口号**以及**传输协议**（e.g. UDP, TCP）。 在TCP情况下，流可以是虚拟电路，也称为虚拟连接或字节流。
- In packet switches, the flow may be identified by IEEE 802.1Q **Virtual LAN tagging** in Ethernet networks, or by a **Label Switched Path** in MPLS tag switching
- A session is a traffic unit divided based on 5-tuple, i.e. source IP, source port, destination IP, destination port and transport-level protocol. A flow is very similar to a session, and the difference is that it **contains traffic of only one direction**, i.e. the source and destination IP / port are not interchangeable. flow是单向的五元组决定的traffic     //《End-To-end encrypted traffic classification with one-dimensional convolution neural networks》中的解释



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





## List of P2P protocols



| Protol                                  |               | Used by                                                      | Defunct(不再使用) clients                                    |
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
| BitTorrent                              | Decentralized | Ares Galaxy, BitComet, Bitlord, BitTorrent, Flashget, FrostWire, Getright, i2psnark, libtorrent, μTorrent, Miro, MLDonkey, Popcorn Time, qBittorrent, Shareaza, Tixati, Transmission, Tribler, Xunlei, Vuze, etc. | Trustyfiles, Vagaa                                           |
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





