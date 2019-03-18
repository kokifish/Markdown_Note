[TOC]

---

# Dcker Basis

> https://docker-curriculum.com/ 英语Docker beginner

- C/S架构模式，使用远程API来管理和创建Docker容器
- Docker容器通过Docker镜像来创建。容器相当于面向对象编程语言(e.g. C++)得对象，镜像相当于类

| Component | Function |
| ---------------------- | ------------------------------------------------------------ |
| Docker 镜像(Images)    | Docker 镜像是用于创建 Docker 容器的模板。                    |
| Docker 容器(Container) | 容器是独立运行的一个或一组应用。        |
| Docker 客户端(Client)  | Docker 客户端通过命令行或者其他工具使用 Docker API (<https://docs.docker.com/reference/api/docker_remote_api>) 与 Docker 的守护进程通信。 |
| Docker 主机(Host)      | 一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。       |
| Docker 仓库(Registry)  | Docker 仓库用来保存镜像，可以理解为代码控制中的代码仓库。Docker Hub([https://hub.docker.com](https://hub.docker.com/)) 提供了庞大的镜像集合供使用。 |
| Docker Machine         | Docker Machine是一个简化Docker安装的命令行工具，通过一个简单的命令行即可在相应的平台上安装Docker，比如VirtualBox、 Digital Ocean、Microsoft Azure。 |



In simpler words, Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox沙盒 (called containers) to run on the host operating system i.e. Linux. The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development. Unlike virtual machines, containers do not have the high overhead and hence enable more efficient usage of the underlying system and resources. 

# Installation



### CentOS

```cmd
sudo yum update # 更新yum
curl -fsSL https://get.docker.com -o get-docker.sh # 执行Docker安装脚本
```





# Container

```cmd
docker pull training/webapp  # 载入镜像 拉取镜像
docker run -d -P training/webapp python app.py # -d:后台运行 -P:容器内部使用的网络端口映射到我们使用的主机上
docker run -d -p 5000:5000 training/webapp python app.py # 指定端口映射
docker port bf08b7f2cd89 #查看容器的端口号
```





### docker run

```cmd
-d # 后台运行
-P # 容器内部使用的网络端口映射到我们使用的主机上
-p port1:prot2# 指定端口映射
docker run busybox echo "hello from busybox" #Output: hello from busybox
```







# Images

- https://hub.docker.com/ Docker Hub 可以在此搜索镜像

​		

```cmd
docker images #列出本地主机上的镜像
docker pull ubuntu:13.10 # 下载镜像ubuntu, 并且指定版本号为13.10
docker search httpd # 搜索镜像
#NAME:镜像仓库源的名称 #DESCRIPTION:镜像的描述 #OFFICIAL:是否docker官方发布
docker pull httpd # Using default tag: latest
docker run httpd # 使用镜像
```





## Images Creation and Update

> http://www.runoob.com/docker/docker-image-usage.html 2019.3.14 15.53 等待继续学习



```dockerfile
# 利用已有镜像创新新的镜像
docker run -t -i ubuntu:15.10 /bin/bash
# 在运行的容器内使用 apt-get update 命令进行更新
# 完成操作之后，输入 exit命令来退出这个容器
# 此时该容器是按需求更改的容器。可以通过命令 docker commit来提交容器副本
docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2
# 然后可用docker images查看创建的新镜像在不在
```

> **-m:**提交的描述信息
>
> **-a:**指定镜像作者
>
> **e218edb10161：**容器ID
>
> **runoob/ubuntu:v2:**指定要创建的目标镜像名



构建镜像：使用 docker build 从零开始创建一个新的镜像。

```cmd
vim Dockerfile # 创建编辑Dockerfile
cat Dockerfile # 查看Dockerfile内容
FROM    centos:6.7 #指定使用哪个镜像源
MAINTAINER      Fisher "fisher@sudops.com"

RUN     /bin/echo 'root:123456' |chpasswd #RUN 指令告诉docker 在镜像内执行命令，安装什么
RUN     useradd runoob
RUN     /bin/echo 'runoob:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE  22
EXPOSE  80
CMD     /usr/sbin/sshd -D
```



```cmd
docker build . # 在当前目录查找Dockerfile创建新的镜像
docker build -t runoob/centos:6.7 . # -t ：指定要创建的目标镜像名；. ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径

docker tag 860c279d2fec runoob/centos:dev # 为镜像添加新标签
```





# Command Quick Find

```cmd
docker ps # 查看docker进程 查看我们正在运行的容器
docker ps -l # 查看最后一次创建的容器
docker stop NAMES/CONTAINER_ID 
docker command --help #更深入的了解指定的 Docker 命令使用方法
docker images #列出本地主机上的镜像 #see a list of all images on your system
docker run -t -i ubuntu:15.10 /bin/bash#使用版本为15.10的ubuntu系统镜像来运行容器 # 不适用TAG指明版本则默认使用latest
docker port CONTAINER_ID # 查看容器的端口映射
docker logs NAMES/CONTAINER_ID #查看日志
docker start NAMES/CONTAINER_ID #已经停止的容器，可以使用命令 docker start 来启动
docker rm NAMES/CONTAINER_ID # 删除不需要的容器，但容器必须处于停止状态

docker pull ubuntu:13.10 #下载镜像 拖取镜像
docker search httpd #搜索镜像
```

