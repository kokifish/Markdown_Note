web容器(中间件): IIS, apache, tomcat, nginx

前端页面：html, css, javascript编写的前端页面的文件

chrome插件wappalyzer可以查看网页的架构

域名解析

win: nslookup www.baidu.com   ping www.baidu.com

wiresharks: bootp/dhcp 过滤出DHCP包

ipconfig -release 释放ip ipconfig -renew 重新获取ip

telnet 服务器：12.0.1.28

# Wiresharks

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

1. 请求包：以太网层广播包，谁有xxxip的mac？告诉 me.ip
2. 回复包：以太网层单播包，发给请求包中给出的srcMAC Addr，xxxip的mac为XX.XX... 

```bash
arp -a # 查看arp表
arp -d # 清除arp
```

# Task

- 

