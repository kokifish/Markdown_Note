

基于有效载荷的方法 payload-based methods = deep packet inspection 深度包检测



# 名词解释



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





## paper: Transport layer identification of P2P traffic

> 2004 Proceedings of the 2004 ACM SIGCOMM Internet Measurement Conference, IMC 2004
>
> Karagiannis, Thomas
> Broido, Andre
> Faloutsos, Michalis
> Claffy, Kc



```python
# Algorithm 1: Nonpayload algorithm for P2P flow identification #named: PTP
FT = FlowTable
for all (srcIP, dstIP) in FT:
	if (srcIP, dstIP) 同时用TCP, UDP: 
		P2PIP += srcIP += dstIP # set P2PIP记录了同时用TCP,UDP的所有IP
for all flows in FT: # (srcIP, dstIP, srcPort, dstPort, prt)
    if srcIP/dstIP in P2PIP:
        P2PIP += srcIP += dstIP # put both IPs in P2P list (P2PIP)
    else if (srcPort == dstPort and srcPort < 501):
        RejectedPairs += {srcIP, srcPort} += {dstIP, dstPort}
    else if srcIP and dstIP not in MailServers:
    	for (srcIP, srcPort) and (dstIP, dstPort):
            if pair in P2PPairs:
                
            else if pair not in Rejected:
            
            else if pair in Rejected:
for pairs in IPPort: # examine pairs that were added during previous intervals and have not been yet classified  #检测在之前时间段中添加的、尚未分类的pair
    
    
```





