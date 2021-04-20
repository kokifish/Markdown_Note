

# Penetration Test

> A penetration test, colloquially known as a pen test, pentest or ethical hacking, is an authorized simulated cyberattack on a computer system, performed to evaluate the security of the system;this is not to be confused with a vulnerability assessment.



- 多级域名(news.a.com)如果和顶级域名(www.a.com)相同IP，那可以通过多级域名突破
- hosts文件：重定向解析的IP地址，先找hosts，没有才通过DNS解析
- CDN: 内容分发网络。缓存节点技术。超级ping
- CDN解析的IP地址与DNS服务器无关。`ipconfig /flushdns` 清空DNS缓存





- POC测试，Proof of Concept，概念验证。常指一段漏洞证明的代码。
- EXP，全称”Exploit”，中文“利用”，指利用系统漏洞进行攻击的动作
- Payload，中文“有效载荷”，指成功exploit之后，真正在目标系统执行的代码或指令
- Shellcode，简单翻译“shell代码”，是Payload的一种，由于其建立正向/反向shell而得名



## nmap

> https://blog.csdn.net/smli_ng/article/details/105964486

- 主机发现和端口扫描工具，运用自带的脚本还能完成漏洞检测，同时支持多平台

```bash
nmap -T4 -sC -sV 192.168.102.101 # -sV 探测服务/版本信息 # -T <0-5> 设置时间模板,值越小，IDS报警几率越低 # -sC: 等效于 --script=default
```





## Thinkphp

> https://blog.csdn.net/qq_37865996/article/details/107468816    [框架漏洞]Thinkphp系列漏洞【截至2020-07-20】





## AntSword 蚁剑

> https://www.yuque.com/antswordproject/antsword/srruro
>
> 获取加载器 https://github.com/AntSwordProject/AntSword-Loader
>
> 源码 https://github.com/AntSwordProject/antSword
>
> 解压完加载器，首次打开时，选择空目录初始化会下载源码，或者可以选择已经有源码的目录





## Metasploit Framework

> offensive-security的msf教程 https://www.offensive-security.com/metasploit-unleashed/Msfconsole/
>
> 

