# Basis

web容器(中间件): IIS, apache, tomcat, nginx

前端页面：html, css, javascript编写的前端页面的文件

chrome插件wappalyzer可以查看网页的架构

域名解析

win: nslookup www.baidu.com   ping www.baidu.com

wiresharks: bootp/dhcp 过滤出DHCP包

ipconfig -release 释放ip ipconfig -renew 重新获取ip

telnet 服务器：12.0.1.28

## Wiresharks

抓包过滤器语法

类型Type：host、net、port
方向Dir：src、dst
协议proto：ether、ip、tcp、udp、http、ftp等
逻辑运算符：与&&、||或、！非

显示过滤器语法

比较操作符：==、！=、>、<、>=、<=
逻辑操作符：and、or、not、xor(有且仅有一个条件被满足)
ip地址：ip.addr、ip.src、ip.dst
端口过滤：tcp.port、tcp.srcport、tcpdstport、tcp.flag.syn、tcp.flag.ack
协议过滤：arp、ip、icmp、udp、tcp、bootp、dns



## ARP

> ARP可以说是网络层协议，因为封装在数据链路层以上(在以太网协议上)，但实际上工作在局域网

ARP包含4

1. 请求包：以太网层广播包(48bit全1, ff:ff:ff:ff:ff:ff)，谁有dst.ip的mac？告诉 src.ip, src.MAC
2. 回复包：以太网层单播包，发给请求包中给出的srcMAC Addr，xxxip的mac为XX.XX... 

```bash
arp -a # win: 查看arp表 
arp -nv # linux
arp -d # 清除arp(要有管理员权限)
```



### RARP: 翻转ARP

无盘工作站（如网吧电脑）- 无盘服务器

1. RARP req: src.MAC=xxx, src.IP是多少？
2. RARP rep: 你的MAC是xxx, IP是192.168.0.1



### 代理ARP

HostA - 网关 - HostB

如果网关连接HostA的接口开启代理ARP功能，则网关可以代替B给A回复，回复内容是B.MAC=网关连接A的接口的MAC（欺骗，不是B.MAC）。如果没有开启代理ARP功能，AB无法通信

> 例如同公司不同部门之间的通信，可能跨路由器，为在同局域网下通信，可开启代理ARP

### 免费ARP

1. A发送：免费ARP req: src.IP=1.1.1.1, src.MAC=aaa，谁的IP是1.1.1.1 （谁有和我一样的IP）
2. B回复：免费ARP rep: src.IP=1.1.1.1, src.MAC=bbb
3. A再回复：免费ARP rep: src.IP=1.1.1.1, src.MAC=aaa
4. ....不断重复，导致AB都无法上网

### IARP: 逆向ARP

> frame relay switch 帧中继交换机：用的是DLC地址（以太网用MAC）

R1 - 帧中继交换机(frS) - R1

1. R1 发 IARP req: R1.IP的DLCI为111
2. R2 发 IARP rep: R2.IP的DLCI为222



### ARP防御

静态IP地址和MAC的绑定：A绑定网关IP-MAC；网关绑定A的IP-MAC。需双端绑定

```bash
arp -s ip mac
```

DAI动态ARP检测。用在企业级交换机上

ARP防火墙。e.g. 彩影防火墙



```bash
netstat -aon # windows查看端口占用
tasklist | findstr "123"
netstat -noab | findstr WeChat # 但只显示了进程名 没有显示IP Port
lsof -i tcp # linus 查看tcp端口占用
```

