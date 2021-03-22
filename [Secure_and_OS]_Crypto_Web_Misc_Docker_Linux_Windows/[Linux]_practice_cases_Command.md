[TOC]



---





# Cases





### Big Endian / Little Endian

```bash
$ lscpu | grep -i byte
Byte Order:                      Little Endian    # 这个输出说明是小端序
$ echo -n I | od -o | head -n1 | cut -f2 -d" " | cut -c6 # 1为小端模式，0为大端模式
```





### 配置快捷键

- 终端快捷键设置：命令如下，名称随意

```shell
/usr/bin/gnome-terminal  # gnome-terminal
```





### 无sudo配置conda

下载Anaconda3-2018.12-Linux-x86_64.sh    https://repo.continuum.io/archive/index.html

wget URL

安装：

1. bash Anaconda3-2018.12-Linux-x86_64.sh
2. Do you accept the license terms?  yes
3. 是否添加到环境变量 yes

conda --version 检查是否安装成功，如果command not found: export PATH="/home/hyhuang/anaconda3/bin/:$PATH"











### 创建和删除软、硬链接

> https://www.ibm.com/developerworks/cn/linux/l-cn-hardandsymb-links/index.html

文件都有文件名与数据，这在Linux上被分成两个部分：用户数据 (user data) 与元数据 (metadata)。用户数据，即文件数据块 (data block)，数据块是记录文件真实内容的地方；而元数据则是文件的附加属性，如文件大小、创建时间、所有者等信息。

在 Linux 中，元数据中的 inode 号（inode 是文件元数据的一部分但其并不包含文件名，inode 号即索引节点号）才是文件的唯一标识而非文件名。

通过文件名打开文件的过程：filename -> inode ->(from metadata to user data)->data blocks

> Linux中查看inode号：stat或ls -i

为解决文件的共享使用，Linux 系统引入了两种链接

1. 硬链接 hard link
2. 软链接 符号链接 soft link symbolic link

链接好处：解决文件的共享使用，隐藏文件路径，增加权限安全，节省存储

若一个 inode 号对应多个文件名，则称这些文件为硬链接。换言之，硬链接就是同一个文件使用了多个别名。硬链接可由命令 link 或 ln 创建

```bash
link oldfile newfile 
ln oldfile newfile
```

由于硬链接是有着相同 inode 号仅文件名不同的文件，因此硬链接存在以下几点特性：

1. 文件有相同的 inode 及 data block
2. 只能对已存在的文件进行创建
3. 不能交叉文件系统进行硬链接的创建
4. 不能对目录进行创建，只可对文件创建
5. 删除一个硬链接文件并不影响其他有相同 inode 号的文件

若文件用户数据块中存放的内容是另一文件的路径名的指向，则该文件就是软连接。软链接就是一个普通文件，只是数据块内容有点特殊。软链接有着自己的 inode 号以及用户数据块。因此软链接的创建与使用没有类似硬链接的诸多限制：

1. 软链接有自己的文件属性及权限等
2. 可对不存在的文件或目录创建软链接
3. 软链接可交叉文件系统
4. 软链接可对文件或目录创建
5. 创建软链接时，链接计数 i_nlink 不会增加
6. 删除软链接并不影响被指向的文件，但若被指向的原文件被删除，则相关软连接被称为死链接（即 dangling link，若被指向路径文件被重新创建，死链接可恢复为正常的软链接）

软链接访问：filename(soft link) -> inode -> datablock -> filename(ref file) -> inode -> data block

软链接可以指向软链接，解析过程是递归的。软链接尽量使用绝对路径，使用相对路径的话，文件移动后很可能成为dangling(悬挂的) link







# Linux Basis



## Linux发行版

一般著名的Linux分为两大类：

1. RedHat Series: RedHat, CentOS, Fedora
2. Debian Series: Debian, Ubuntu

> https://blog.51cto.com/494981/1383655

RedHat Series: RHEL(Redhat Enterprise Linux), CentOS, Fedora, Oracle Linux

1. 常见的安装包格式: rpm包,安装rpm包的命令是“rpm -参数” 
2. 包管理工具 yum 
3. 支持tar包

Debian Series: Debian, Ubuntu, Mint

1. 常见的安装包格式 deb包,安装deb包的命令是“dpkg -参数” 
2. 包管理工具 apt-get / dpkg
3. 支持tar包



# Command Quick Find

```cmd
# 环境变量
export PATH=$PATH:/ssr-n #临时添加环境变量

uname -r #显示操作系统的发行编号/--release


bc #计算器(scale=3 显示小数点后3位，否则默认显示整数)
cal [month] [year] #显示日历(calendar)
date #显示日期
locale #显示目前所支持的语系
ls #列出文件 -a 包括隐藏文件 -l 详情
LANG=en_US.utf8 #修改语系为英文语系(当次登录有效)
ca[tab][tab] #命令补全(指令串的第一个字后):连按两次tab后，ca开头的命令被列出


```





## Software Manager



### apt/dpkg

```bash
# apt-get等安装更新卸载相关
apt-get update # 列举本地更新
apt-get upgrade # 安装可用更新
apt-cache search package_name # 查询软件包
apt-get install package_name # 安装一个软件包
apt-get remove package # 删除一个软件包
dpkg -i package_file.deb ,sudo dpkg -r package_filename # install/unstall .deb files
sudo alien package # convert .rpm to .deb files
```



### yum/rpm

```bash
# yum rpm (CentOS)
yum check-update #检查可更新的rpm包
yum update #更新所有的rpm包
yum upgrade #大规模的版本升级,与yum update不同的是,连旧的淘汰的包也升级
yum list installed #列出已经安装的所有的rpm包
yum list extras #列出已经安装的但是不包含在资源库中的rpm包

yum whatprovides libstdc++.so.6 # 查找哪个安装包有这个库文件
yum check-update
yum install code # or code-insiders
yum install yum-utils

rpm -i name.rpm #安装某个rpm包
yum list installed |grep glibc # 查看安装了的 并且显示包含glibc的

rpm -ql PKG_NAME # find the installation path for a software
```



### snap

- Snap是一个全新的软件包架构,它与其它包管理器的区别在于snap安装的app互相之间是高度隔离的,减少了互相引用. 避免了很多冲突问题. 不过这也导致了其占用的磁盘比较多.

```sh
sudo dnf install snapd # install
sudo ln -s /var/lib/snapd/snap /snap # to enable classic snap support #  create a symbolic link between
sudo snap install hello-world # test # after install, ex cmd: hello-world
```

```bash
snap search abc
snap install abc
snap list
snap remove
```








## Device

```shell
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
#    24  Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz    #核心数 型号名 版本名 主频
cat /proc/cpuinfo      # 查看CPU信息 # 输出信息十分详细
top #查看 CPU 使用状况 q退出 # 输出信息实时刷新
top -u usr #查看usr用户的进程CPU内存等使用信息
```





### Device Info: lscpu lsblk lspci

- dmidecode以一种可读的方式dump出机器的DMI(Desktop Management Interface)信息。这些信息包括了硬件以及BIOS，既可以得到当前的配置，也可以得到系统支持的最大配置，比如说支持的最大内存数等

```cmd
lscpu #cpu的统计信息
cat /proc/cpuinfo #每个cpu信息，如每个CPU的型号，主频等
free -m #概要查看内存情况
cat /proc/meminfo #查看内存详细使用
dmidecode -t memory #查看内存硬件信息
lsblk #查看硬盘和分区分布
fdisk -l #硬盘和分区的详细信息
lspci #查看pci信息
lspci -v / lspci -vv #更详细的PCI信息
lscpi -t #设备树
dmidecode -t bios #查看bios信息
dmidecode -q #查看所有有用信息
```



### Disk Related

```python
df -h #df命令是linux系统以磁盘分区为单位查看文件系统，可以加上参数查看磁盘剩余空间信息
fdisk -l # 查看硬盘的分区
hdparm -i /dev/hda #查看IDE硬盘(hda)信息
pidstat -d 1 #展示I/O统计，每秒更新一次
iostat -xdm 1 #系统级IO监控
iotop #io版的top
```





## File





### cat / head / tail / wc

1. 一次显示整个文件:cat filename
2. 从键盘创建一个文件:cat > filename 只能创建新文件,不能编辑已有文件.
3. 将几个文件合并为一个文件:cat file1 file2 > file

```cmd
cat afile.log # 显示文件内容
cat -n a.log b.log #把 a.log 的文件内容加上行号后输入 b.log 这个文件里
```

> http://www.cnblogs.com/peida/archive/2012/10/30/2746968.html

```bash
head -n 20 fname # 显示文件 fname 的前面20行
```



```bash
tail -f a # 显示文件 a 的最后10行 # 默认10行，相当于增加参数 -n 10
tail -n 20 a # 显示文件 a 的最后20行
tail -n +20 a # 显示文件 a 的前面20行
tail -r -n 10 a # 逆序显示 a 最后10行
```

```bash
wc -l fname # 查看文本文件 fname 行数
```

```bash
cat log.txt | tail -n +1000 | head -n 20 # 显示中间20行，从1000行开始
```





### File Operation: rm cp

```cmd
rm -r /path/* # 删除文件夹/path/下所有文件
rm -rf /path/* # 删除文件夹/path/下所有文件 并且不用确认
cp -r /path1/. /path2/  # 将文件夹/path1/下所有文件复制到/path2/ 注意中间有个 ‘.’ # 如果指定文件夹中有同名文件需要先删除，否则会一个个文件提示进行确认，使用cp -rf 也一样提示
```



### find / grep / ls 

- `lsof`(list open files)是一个列出当前系统打开文件的工具




```cmd
find / -amin -10 # 查找在系统中最后10分钟访问的文件
find / -atime -2 # 查找在系统中最后48小时访问的文件
find / -empty # 查找在系统中为空的文件或者文件夹
find / -group cat # 查找在系统中属于 groupcat的文件
find / -mmin -5 # 查找在系统中最后5分钟里修改过的文件
find / -mtime -1 #查找在系统中最后24小时里修改过的文件
find / -nouser #查找在系统中属于作废用户的文件
find / -user fred #查找在系统中属于FRED这个用户的文件

find / -name docker #全盘按照文件名搜索docker


```

> https://blog.csdn.net/ydfok/article/details/1486451

```cmd
grep -r "test"  /path # 在路径 /path 下查找文件内容包含 test 的文件
grep -rn --exclude-dir=build_* --exclude-dir=kernel --exclude-dir=drivers --exclude=*.out 'abcdefg' / # 在根目录/下查找所有“abcdefg”的字符串，但不在以build_开头的目录、kernel和dirvers中查找，同时忽略所有以out为后缀的文件 
grep -r --exclude-dir=sys --exclude-dir=proc --exclude-dir=dev "nf_conntrack" / # 根目录下除sys proc目录外查找含nf_conntrack的文件
```

```bash
ls -al ~/.bash[tab][tab] #//文件补全(指令串第二个字以后):列出该目录下以.bash开头的文件名
```

```bash
ll # ls -l # On many systems, ll is an alias of ls -l # type ll 输出：ll is an alias for ls -l
```





### File Zip: tar unzip

```cmd
tar -cvf a.tar a # 把文件a打包为a.tar
tar -xvf file.tar # 解压 tar包
tar -xzvf file.tar.gz # 解压tar.gz
tar -xjvf file.tar.bz2 # 解压 tar.bz2
tar -xZvf file.tar.Z # 解压tar.Z
tar -xf file.tar.xz
unrar e file.rar # 解压rar
unzip file.zip # 解压zip
```

>  <https://www.tecmint.com/18-tar-command-examples-in-linux/>

| Option | Description                                |
| ------ | ------------------------------------------ |
| -v     | 显示打/解包文件过程                        |
| -c     | 打包                                       |
| -x     | 解打包                                     |
| -f     | 指定压缩包的文件名                         |
| -z     | 压缩和解压缩 ".tar.gz"格式                 |
| -j     | 压缩和街压缩 ".tar.bz2"格式                |
| -t     | 测试，就是不解打包，只是査看包中有哪些文件 |
| -C     | 目录：指定解打包位置                       |



### File Info: stat

```cmd
stat FILENAME # file: size, Device, Access, Modify, Change 
```



## Process and Service



### ln

- ln: link files. 为某一个文件在另外一个位置建立一个同步的链接
- 当需要在不同目录用到相同文件

1. 软链接：symbolic link 符号链接
   1. 以路径的形式存在。类似Win的快捷方式
   2. 可跨文件系统 ，硬链接不可以
   3. 可对一个不存在的文件名进行链接
   4. 可对目录进行链接
2. 硬链接：hard link
   1. 以文件副本的形式存在。但不占用实际空间
   2. 不允许给目录创建硬链接
   3. 只有在同一个文件系统中才能创建

```bash
ln [参数][源文件或目录][目标文件或目录] # 语法结构
[-bdfinsvF] [-S backup-suffix] [-V {numbered,existing,simple}][--help] [--version] [--]  # 参数格式
ln -s a.log a_ln # 为 a.log 创建软链接 a_ln # 若 a.log 丢失，a_ln 失效 # ll 输出：lrwxrwxrwx 1 root root   ... a_ln -> a.log
rm -rf ./a_ln # 删除软链接a_ln # 不可使用 rm -rf ./a_ln/ 如果后面加了/ 就会删除a_ln链接到的文件夹下的所有文件
unlink a_ln # 删除软链接a_ln
```



### Process Info: ps

```cmd
ps aux | grep nginx # 进程中有nginx字样的
```





### & / nohup

**&**: Terminal运行程序时会被运行的作业占据，可以在命令后面加上&实现后台运行。e.g. sh a.sh &

使用&后，作业被提交到后台运行，当前terminal没有被占用，但是一旦把当前terminal断开后，比如远程连接时掉线，作业就会停止。

> no hang up  不挂起

nohup命令使得退出账户后，相应作业继续执行，不会被挂起通常形式如下

```cmd
nohup command
nohup command &
nohup command > out.file 2>&1 & #最后一个& 让该命令在后台执行
# command>out.file 将command的输出重定向到out.file文件，即不输出到terminal，而输出到out.file
# 2>&1 将标准出错重定向到标准输出。标准输出已经重定向到了out.file文件，即将标准出错也输出到out.file文件中
# 2>: 2与>结合代表错误重定向，&1: &与1结合代表标准输出. 2>&1就变成错误重定向到标准输出
```

nohup --help 部分信息

```cmd
$ nohup --help
Usage: nohup COMMAND [ARG]...
  or:  nohup OPTION
Run COMMAND, ignoring hangup signals.   # 忽略hangup信号，实现后台运行，不挂断地运行命令

      --help     display this help and exit
      --version  output version information and exit

If standard input is a terminal, redirect it from /dev/null.
If standard output is a terminal, append output to 'nohup.out' if possible,
'$HOME/nohup.out' otherwise.
If standard error is a terminal, redirect it to standard output.
To save output to FILE, use 'nohup COMMAND > FILE'.  # 保存输出至文件

NOTE: your shell may have its own version of nohup, which usually supersedes
the version described here.  Please refer to your shell's documentation
for details about the options it supports.
```

setsid  disown  screen让进程在后台可靠运行，其中disown可以让已经运行了的作业免受hup信号影响

https://www.ibm.com/developerworks/cn/linux/l-cn-nohup/index.html



### kill / fuser

> https://blog.csdn.net/andy572633/article/details/7211546

```cmd
# kill
kill -s 9 pid #传递信号9：强制、尽快终止进程
pkill -9 firefox #pgrep+kill
```

- pkill或者pgrep只要给出进程名的一部分就可以终止进程

```cmd
fuser -k 443/tcp # 关闭占用443端口的程序
fuser -k 80/tcp #
```



### service / systemctl

```cmd
service nginx status # 查看nginx运行情况
systemctl status nginx # 查看nginx运行情况
systemctl restart nginx # 重启nginx

systemctl stop firewalld.service # fedora 关闭防火墙
systemctl start firewalld.service
systemctl restart  firewalld.service
```





## Network



### Network Info: netstat ifconfig

```cmd
netstat -rn # Ketnel IP routing table # 可以查看网关
lspci | grep -i 'eth' #查看网卡硬件信息
ifconfig -a #查看系统的所有网络接口
ip link show
ethtool eth0 #查看某个网络接口的详细信息，例如eth0的详细参数和指标
ip r # routing info
ip addr # 查看网路ip
```



### port info

```shell
lsof -i:port_num # 查看某个端口的占用情况
```





### Firewall: iptables

**iptables命令**是Linux上常用的防火墙软件，是netfilter项目的一部分。可以直接配置，也可以通过许多前端和图形界面配置

选项：`-short option, --long option`

```
-t<表>：指定要操纵的表
-A：向规则链中添加条目 --append
-C：检查特定规则是否存在 --check
-D：从规则链中删除条目 --delete
-i：向规则链中插入条目
-R：替换规则链中的条目
-L：显示规则链中已有的条目
-F：清除规则链中已有的条目
-Z：清空规则链中的数据包计算器和字节计数器
-N：创建新的用户自定义规则链
-P：定义规则链中的默认目标
-p：指定要匹配的数据包协议类型
-s：指定要匹配的数据包源ip地址
-j<目标>：指定要跳转的目标
-i<网络接口>：指定数据包进入本机的网络接口
-o<网络接口>：指定数据包要离开本机所使用的网络接口
-X [chain] : Delete a user-defined chain 
```

iptables命令选项输入顺序：

```cmd
iptables -t 表名 <-A/I/D/R> 规则链名 [规则号] <-i/o 网卡名> -p 协议名 <-s 源IP/源子网> --sport 源端口 <-d 目标IP/目标子网> --dport 目标端口 -j 动作
```

表名包括：

- **raw**：高级功能，如：网址过滤
- **mangle**：数据包修改（QOS），用于实现服务质量
- **net**：地址转换，用于网关路由器
- **filter**：包过滤，用于防火墙规则

规则链名包括：

- **INPUT链**：处理输入数据包
- **OUTPUT链**：处理输出数据包
- **PORWARD链**：处理转发数据包
- **PREROUTING链**：用于目标地址转换（DNAT）
- **POSTOUTING链**：用于源地址转换（SNAT）

动作包括：

- **accept**：接收数据包
- **DROP**：丢弃数据包
- **REDIRECT**：重定向、映射、透明代理
- **SNAT**：源地址转换
- **DNAT**：目标地址转换
- **MASQUERADE**：IP伪装（NAT），用于ADSL
- **LOG**：日志记录


```cmd
iptables -L -n --line-numbers # 将所有iptables以序号标记显示
iptables -D INPUT 8 # 删除INPUT里序号为8的规则
iptables  -A FORWARD -s ! 192.168.0.1 -j  QUEUE # -A FORWARD: 向FORWARD规则链中添加条目 
```


### ssh

```cmd
# 配置ssh服务以实现远程访问
yum install openssh # ssh软件包安装
service start sshd  # 开启ssh服务，ssh服务一般叫做 SSHD
/etc/init.d/sshd start # 与上句等效
PermitRootLogin yes# /etc/ssh/sshd_config中设置为允许root用户远程登录 
# 关闭防火墙，或者设置22端口例外
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
# 同网段下，即可使用ssh远程访问
```



### brctl

>  https://www.thegeekstuff.com/2017/06/brctl-bridge/ 

- ` yum install bridge-utils `
- brctl stands for Bridge Control. In Linux, this command is used to create and manipulate ethernet bridge.
- This is typically used when you have multiple ethernet networks on your servers, and you want to combine them and present it as one logical network. 
- 当服务器上有多个以太网时，brctl 可用于将这些以太网结合成同一个逻辑网络

```cmd
brctl show # 查看当前网桥 view all available ethernet bridges
```



```cmd
brctl addbr br0 # 增加网桥br0
brctl addif br0 eth0 # add an interface to an existing ethernet bridge
brctl showmacs br0 # see all the learned MAC addresses of a bridge
brctl setaging br0 120 # set the mac address ageing time to 120 seconds on “br0” ethernet bridge


```

```cmd
# Spanning Tree # STP stands for Spanning Tree Protocol
brctl stp br0 on # enable spanning tree
brctl stp br0 yes # enable spanning tree
brctl stp br0 off # turn off spanning tree
brctl showstp br0 # display the stp parameter and its current value
```





```cmd
# 关闭网桥步骤
brctl delif br0 eth0 # 先删除网桥br0的接口eth0
brctl delif br0 eth1 # 先删除网桥br0的接口eth1
ifconfig br0 down # 
brctl delbr br0 # 删除网桥
```



## Privilege and Account

### su / passwd



```cmd
#fedora 30/31/32: # 修改root密码使得可以使用root登录GUI
sudo su # 然后回要求输入当前用户的密码
sudo passwd root # 修改root的密码
```

```shell
# Ubuntu # 启用root
sudo -i #sudo whoami
sudo passwd #change the default blank root password and set root password
su #Once the root password is set, you can login as root by using the su command
```



### chmod

```bash
chmod +x a # 赋予可执行权限
```





---

# Shortcuts

- Ctrl+Shift+C: console下copy 
- Ctrl+Shift+V: console下paste
- Ctrl+Insert: console下复制 或 鼠标选中即为复制
- Shift+Insert: console下粘贴 或 鼠标中键即为粘贴

- ctrl + c 中断目前正在执行的指令串
- ctrl + d EOF键盘输入结束，输入时离开命令行，相当于输入exit
- shift + page up/down 文本页面翻页
- ctrl+alt+F1~6切换控制台



# Development



- `/linux/in.h` 和`/netinet/in.h`所定义的内容有所重复，会导致重定义错误，用户空间层程序建议使用`/netinet/in.h`
- 将会包含`/linux/in.h`的头文件：`linux/types.h`
- 将会包含`/netinet/in.h`的头文件：`arpa/inet.h`





## Autotools



Autotools 工作步骤：

1. 首先，在 `./configure` 步骤中，Autotools 扫描宿主机系统（即当前正在运行的计算机）以发现默认设置。默认设置包括支持库所在的位置，以及新软件应放在系统上的位置。
2. 接下来，在 `make` 步骤中，Autotools 通常通过将人类可读的源代码转换为机器语言来构建应用程序。
3. 最后，在 `make install` 步骤中，Autotools 将其构建好的文件复制到计算机上（在配置阶段检测到）的相应位置。



![](https://raw.githubusercontent.com/hex-16/pictures/master/Code_pic/autotools_autotools_work_flow.jpg)



### configure.ac

```python
AC_PREREQ(2.61)
AC_INIT(l7-filter-userspace, [0.11], [http://sourceforge.net/tracker/?group_id=80085])
AC_CONFIG_SRCDIR([l7-queue.h])

AC_CANONICAL_TARGET

AM_INIT_AUTOMAKE
AC_CONFIG_HEADERS(config.h)

AC_PROG_CXX
# give configure command line options to specify which such external software to use
# software name: pidfile 
# AS_HELP_STRING: 设置帮助信息 (左侧内容，右侧内容)
# 这些将在 ./configure --help 中显示
# AC_ARG_WITH (package, help-string, [action-if-given], [action-if-not-given])
AC_ARG_WITH([pidfile], 
  [AS_HELP_STRING([--with-pidfile],
    [Sets the default pid filename. Set to NULL to disable. @<:@default=/var/run/l7-filter.pid@:>@])],
    [],
    [with_pidfile=/var/run/l7-filter.pid])
# AC_ARG_WITH最后一个参数是默认情况下的操作

# AS_IF (test1, [run-if-true1], ..., [run-if-false])
# 如果 "x$with_pidfile" != xno exits with a zero status, then run shell code run-if-true1
# 逻辑：如果$with_pidfile不是no，而是yes，那么定义 PID_FILENAME 为 /var/run/l7-filter.pid
AS_IF([test "x$with_pidfile" != xno],

  AS_IF([test "x$with_pidfile" = xyes],
    AC_DEFINE([PID_FILENAME], ["/var/run/l7-filter.pid"]),
    AC_DEFINE_UNQUOTED([PID_FILENAME], ["$with_pidfile"],
              [Define when and what filename to use as the PID filename])),

    AC_DEFINE([PID_FILENAME], [NULL], [Do not use a PID filename on this build])  )

PKG_CHECK_MODULES([NFNETLINK], [libnetfilter_conntrack libnetfilter_queue])
AC_CHECK_LIB(pthread, main)

# Checks for header files.
AC_HEADER_DIRENT
AC_HEADER_STDC
AC_CHECK_HEADERS([netinet/in.h stdlib.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_C_CONST

# Checks for library functions.
AC_FUNC_CLOSEDIR_VOID
AC_FUNC_MALLOC
AC_TYPE_SIGNAL
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([regcomp strerror strtol])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```





## CMake

> https://gitlab.kitware.com/cmake/community/-/wikis/Home
>
> https://www.hiroom2.com/2016/09/07/convert-makefile-to-cmakelists-txt-manually/

- CMake是个一个开源的跨平台自动化建构系统，用来管理软件建置的程序，并不相依于某特定编译器
- 支持多层目录、多个应用程序与多个库
- CMake并不直接建构出最终的软件，而是产生标准的建构档（如Unix的Makefile或Windows Visual C++的projects/workspaces），然后再依一般的建构方式使用



- CMAKE_BINARY_DIR: 运行`cmake`命令的根目录/顶层目录，所有二进制文件的根文件夹。CMake支持就地/源外 构建和生成二进制文件。The **root or top level folder** that you run the `cmake` command from is known as your CMAKE_BINARY_DIR and is the root folder for all your binary files. CMake supports building and generating your binary files both in-place and also out-of-source.
  - 1. In-Place Build 就地构建: 指在root目录运行`cmake`指令。生成的所有临时构建文件都与源代码同目录
    2. Out-of-Source Build 源外构建: (外部构建)可以创建一个单独的用于build的文件夹，该文件夹可以位于系统的任何位置。所有临时文件和目标文件都将位于此目录中。如需重新构建，只需删除构建目录并重新运行cmake

```cmake
# Out-of-Source Build example
hello-root-dir$ mkdir build
hello-root-dir$ cd build
A-hello-cmake/build$ cmake .. # 此时运行cmake命令的文件夹不在root目录中，而在其子目录build
```





`CMakeLists.txt`大小写不敏感，可以大小写混用



### Variables

| Variable                 | Info                                                         |
| ------------------------ | ------------------------------------------------------------ |
| CMAKE_SOURCE_DIR         | 根源目录The root source directory                            |
| CMAKE_CURRENT_SOURCE_DIR | 当前源目录 The current source directory if using sub-projects and directories. |
| PROJECT_SOURCE_DIR       | The source directory of the current cmake project.           |
| CMAKE_BINARY_DIR         | The root binary / build directory. This is the directory where you ran the `cmake`command. |
| CMAKE_CURRENT_BINARY_DIR | The build directory you are currently in.                    |
| PROJECT_BINARY_DIR       | The build directory for the current project.                 |



### Cases



```python
# The files in this tutorial are below: 目录树
A-hello-cmake$ tree
.
├── CMakeLists.txt
├── main.cpp
```

- CMakeLists.txt - Contains the CMake commands you wish to run
- main.cpp - A simple "Hello World" cpp file.



```cmake
# Content of CMakeLists.txt
# Set the minimum version of CMake that can be used
# $ cmake --version # To find the cmake version run
cmake_minimum_required(VERSION 3.5) # 指定CMkae最低版本

# Set the project name
project(hello_cmake) # 项目名 # make referencing certain variables easier when using multiple projects. 包含项目名称，以便在使用多个项目时更容易引用某些变量。

# Add an executable # 构建的可执行文件的名字
add_executable(hello_cmake main.cpp) # 把一系列文件编译成 hello_cmake 这个目标文件
```

> 简写：将可执行文件的名字与project name保持一致
>
> ```cmake
> cmake_minimum_required(VERSION 2.6) # 指定CMkae最低版本
> project(hello_cmake) # 项目名
> add_executable(${PROJECT_NAME} main.cpp) # 可执行文件名 与项目名一致
> ```



```console
B-hello-headers$ tree
.
├── CMakeLists.txt
├── include
│   └── Hello.h
└── src
    ├── Hello.cpp
    └── main.cpp
```

```cmake
cmake_minimum_required(VERSION 3.5) # 支持的最低CMake版本 # Set the minimum version of CMake that can be used

project (hello_headers)# Set the project name

# Create a sources variable with a link to all cpp files to compile
set(SOURCES  # 定义一个宏
    src/Hello.cpp
    src/main.cpp
)

add_executable(hello_headers ${SOURCES}) # Add an executable with the above sources

# Set the direcoties that should be included in the build command for this target
# when running g++ these will be included as -I/directory/path/ #在g++命令行的等效
target_include_directories(hello_headers
    PRIVATE 
        ${PROJECT_SOURCE_DIR}/include  # 添加./include 作为需要-I include的文件夹
)
```



#### include dir

> https://github.com/ttroy50/cmake-examples/tree/master/01-basic/C-static-library

- include一个由这个cmake编译的库

```cmake
$ tree
.
├── CMakeLists.txt
├── include
│   └── static
│       └── Hello.h
└── src
    ├── Hello.cpp  # 这个文件 #include "static/Hello.h" 是static/Hello.h的实现
    └── main.cpp # 这个文件 #include "static/Hello.h" 调用了Hello.cpp的函数
```

```cpp
// src/main.cpp
#include "static/Hello.h"
int main(int argc, char *argv[]){
    Hello hi;
    hi.print();
}
```

```cpp
// src/Hello.cpp
#include <iostream>
#include "static/Hello.h"
void Hello::print(){
    std::cout << "Hello Static Library!" << std::endl;
}
```

```cpp
// include/static/Hello.h
#ifndef __HELLO_H__
#define __HELLO_H__

class Hello{
public:
    void print();
};

#endif
```



```cmake
cmake_minimum_required(VERSION 3.5)
project(hello_library) # 注意这里是 library

# Create a library
#Generate the static library from the library sources
add_library(hello_library STATIC # 从 .cpp 源文件创建库library
    src/Hello.cpp
)

target_include_directories(hello_library # include一个文件夹 只能include这个cmake编译的
    PUBLIC 
        ${PROJECT_SOURCE_DIR}/include
)

# Create an executable
add_executable(hello_binary  # Add an executable with the above sources
    src/main.cpp
)

# link the new hello_library target with the hello_binary target
target_link_libraries(hello_binary 
    PRIVATE 
        hello_library
)
```





#### compile flags

- `CACHE STRING "Set C++ Compiler Flags" FORCE`用于强制在该CMakeCache.txt文件中设置该变量

```cmake
cmake_minimum_required(VERSION 3.5)
# Set a default C++ compile flag
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DEX2" CACHE STRING "Set C++ Compiler Flags" FORCE)

# Set the project name
project (compile_flags)

# Add an executable
add_executable(cmake_examples_compile_flags main.cpp)

target_compile_definitions(cmake_examples_compile_flags 
    PRIVATE EX3
)
```



## conan

> ref: http://chu-studio.com/posts/2019/%E4%BB%8E%E9%9B%B6%E5%BC%80%E5%A7%8B%E7%9A%84C++%E5%8C%85%E7%AE%A1%E7%90%86%E5%99%A8CONAN%E4%B8%8A%E6%89%8B%E6%8C%87%E5%8D%97

- 开源的、跨平台的、去中心化的 C++ 包管理器

conan的软件包描述：`名称/版本@用户/渠道`, 渠道 Channel 用来描述是稳定版 Stable 还是测试版 Testing 等信息

Conan 基于 Python 编写，故需要在开始前安装好 Python3。然后使用标准的 *pip* 安装即可

```python
pip install conan # install conan
# 使用 GCC 作编译器时需要手动开启对 C++11 的 ABI 的支持，否则默认位于兼容模式下，将使用老的 ABI
conan profile new default --detect  # Generates default profile detecting GCC and sets old ABI
conan profile update settings.compiler.libcxx=libstdc++11 default  # Sets libcxx to C++11 ABI
conan search boost* -r=conan-center # 搜索软件包
conan remote add my-repo http://my-repo.com/xxx # 添加源
conan remote update my-repo http://my-repo.com/xxx --insert=0 # 或者使用insert来将其作为首个源
conan remote list # 展示所有源
conan remote remove my-repo # 删除一个源
```

