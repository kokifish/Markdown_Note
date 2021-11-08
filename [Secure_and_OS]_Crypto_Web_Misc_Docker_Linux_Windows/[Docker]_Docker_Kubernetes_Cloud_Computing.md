- writer: www.github.com/hex-16   data: from 2019   contact: hexhex16@outlook.com  recommended viewer/editor: Typora
- 主要记录docker相关知识以及基于docker的一些东西，后附上部分云计算的基础知识

---

# Docker Basis

> https://docker-curriculum.com/ 英语Docker beginner
>
> https://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html  Docker 入门教程 作者： 阮一峰   日期 2018年2月9日
>
> https://www.ruanyifeng.com/blog/2018/02/docker-wordpress-tutorial.html Docker 微服务教程 阮一峰 2018年2月13日

由于虚拟机一些缺点，Linux 发展出了另一种虚拟化技术：Linux 容器（Linux Containers， LXC）

**Linux 容器不是模拟一个完整的操作系统，而是对进程进行隔离。**或者说，在正常进程的外面套了一个保护层。对于容器里面的进程来说，它接触到的各种资源都是虚拟的，从而实现与底层系统的隔离。

**Docker 属于 Linux 容器的一种封装，提供简单易用的容器使用接口。**它是目前最流行的 Linux 容器解决方案。

Docker 将应用程序与该程序的依赖，打包在一个文件里面。运行这个文件，就会生成一个虚拟容器。程序在这个虚拟容器里运行，就好像在真实的物理机上运行一样。有了 Docker，就不用担心环境问题。

1. 提供一次性的环境。本地测试他人的软件、持续集成的时候提供单元测试和构建的环境。
2. 提供弹性的云服务。因为 Docker 容器可以随开随关，很适合动态扩容和缩容。
3. 组建微服务架构。通过多个容器，一台机器可以跑多个服务，因此在本机就可以模拟出微服务架构。





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





## Installation


- centos 7
```bash
sudo yum update # 更新yum
curl -fsSL https://get.docker.com -o get-docker.sh # 执行Docker安装脚本
bash get-docker.sh

sudo systemctl start docker #开启docker的daemon
```
- kali

> https://www.kali.org/docs/containers/installing-docker-on-kali/
>
> https://blog.csdn.net/Huangshanyoumu/article/details/115037413 kali2021安装docker 换aliyun加速

验证安装是否成功：

```bash
docker version
docker info
sudo usermod -aG docker $USER # Docker 需要用户具有 sudo 权限，为了避免每次命令都输入sudo，可以把用户加入 Docker 用户组
```



## Proxy

> 让Docker使用socks5代理
>
> 真正操作docker的是运行在后台的docker daemon，也就是我们需要通过systemctl start docker来启动docker daemon。所以说即使我们设置了环境变量http_proxy，那么也只是针对前台docker console使用，而真正访问pull镜像的确是后台的daemon，因此，需要设置daemon访问proxy

```bash
sudo mkdir -p /etc/systemd/system/docker.service.d # 创建docker服务插件目录
sudo touch /etc/systemd/system/docker.service.d/http-proxy.conf # 创建一个名为http-proxy.conf的文件
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf # 编辑http-proxy.conf的文件
# 写入内容 # 这里的ip是宿主机(win10运行着v2ray)的ip
[Service]
Environment="HTTP_PROXY=socks5://172.18.34.8:10808"
Environment="HTTPS_PROXY=socks5://172.18.34.8:10808"
### 
sudo systemctl daemon-reload # 重新加载服务程序的配置文件
sudo systemctl restart docker # 重启docker
systemctl show --property=Environment docker # 验证是否配置成功 Environment= 后面会显示代理配置信息(如果配置成功)
```



## Images

- https://hub.docker.com/ Docker Hub 可以在此搜索镜像
- image 文件是通用的，一台机器的 image 文件拷贝到另一台机器，照样可以使用。一般来说，为了节省时间，我们应该尽量使用别人制作好的 image 文件，而不是自己制作。即使要定制，也应该基于别人的 image 文件进行加工，而不是从零开始制作
- 为了方便共享，image 文件制作完成后，可以上传到网上的仓库。Docker 的官方仓库 [Docker Hub](https://hub.docker.com/) 是最重要、最常用的 image 仓库。此外，出售自己制作的 image 文件也是可以的



```cmd
docker images # 列出本地主机上的镜像
docker image ls # 列出本机的所有 image 文件
docker image rm [imageName] # 删除 image 文件

docker pull training/webapp  # 载入镜像 拉取镜像
docker pull ubuntu:13.10 # 下载镜像ubuntu, 并且指定版本号为13.10 # 
docker search httpd # 搜索镜像
#NAME:镜像仓库源的名称 #DESCRIPTION:镜像的描述 #OFFICIAL:是否docker官方发布
docker pull httpd # Using default tag: latest
docker run httpd # 使用镜像
docker run -d -P training/webapp python app.py # -d:后台运行 -P:容器内部使用的网络端口映射到我们使用的主机上
docker run -d -p 5000:5000 training/webapp python app.py # 指定端口映射

docker port bf08b7f2cd89 #查看容器的端口号
```

- 参数解释: 

```cmd
-d # 后台运行
-P # 容器内部使用的网络端口映射到我们使用的主机上
-p port1:prot2 # 指定端口映射
-p IP:HOSTPORT:CONTAINERPORT # 宿主机Port:容器端口Port
```





### hello world demo

```bash
docker image pull library/hello-world # 将 image 文件从仓库抓取到本地 # docker image pull hello-world
```

- `docker image pull`是抓取 image 文件的命令。`library/hello-world`是 image 文件在仓库里面的位置，其中`library`是 image 文件所在的组，`hello-world`是 image 文件的名字。由于 Docker 官方提供的 image 文件，都放在`library`组，可以省略。因此，上面的命令可以写成`docker image pull hello-world`

```bash
docker image ls # 抓取成功以后，就可以在本机看到这个 image 文件了
docker container run hello-world # 运行这个 image 文件
```

- `docker container run`命令具有自动抓取 image 文件的功能。如果发现本地没有指定的 image 文件，就会从仓库自动抓取。因此，前面的`docker image pull`命令并不是必需的步骤
- 输出`Hello from Docker! ......` 提示以后，`hello world`就会停止运行，容器自动终止。
- 有些容器不会自动终止，因为提供的是服务。比如，安装运行 Ubuntu 的 image，就可以在命令行体验 Ubuntu 系统

```bash
docker container run -it ubuntu bash
docker container kill [containID] # 对于那些不会自动终止的容器，必须使用docker container kill 命令手动终止
```



```dockerfile
# 利用已有镜像创新新的镜像
docker run -t -i ubuntu:15.10 /bin/bash 
# -t, --tty Allocate a pseudo-TTY 
# -i, --interactive Keep STDIN open even if not attached
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



## Container File

**image 文件生成的容器实例，本身也是一个文件，称为容器文件。**i.e. 一旦容器生成，就会同时存在两个文件： 

1. image 文件
2. 容器文件
- 关闭容器并不会删除容器文件，只是容器停止运行而已

```bash
docker container ls # 列出本机正在运行的容器
docker container ls --all # 列出本机所有容器，包括终止运行的容器 
# CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                       PORTS     NAMES
docker container rm [containerID] # 终止运行的容器文件，依然会占据硬盘空间，可以使用docker container rm命令删除
```

- 运行上面的命令之后，再使用`docker container ls --all`命令，就会发现被删除的容器文件已经消失了



## Dockerfile: Self-Defiened Container

### Dockerfile File

Dockerfile: 文本文件，用来配置 image。Docker 根据该文件生成二进制的 image 文件

- `.dockerignore`保存要排除的路径，不要打包进入 image 文件。如果没有路径要排除，这个文件可以不新建

```.dockerignore
.git
dir_need2ignore
```

- 项目的根目录下，文本文件 `Dockerfile`内容：

```dockerfile
FROM node:8.4 # FROM node:8.4：该 image 文件继承官方的 node image，冒号表示标签，这里标签是8.4，即8.4版本的 node
COPY . /app # 将当前目录下的所有文件(除 .dockerignore 排除的路径，都拷贝进入 image 文件的/app目录
WORKDIR /app # 指定接下来的工作路径为/app
RUN npm install --registry=https://registry.npm.taobao.org # 在/app目录下，运行npm install命令安装依赖。注意，安装后所有的依赖，都将打包进入 image 文件
EXPOSE 3000 # 将容器 3000 端口暴露出来，允许外部连接这个端口
# CMD node demos/01.js # CMD 启动容器后自动执行这条命令  CMD some_cmd
```

- `RUN`命令在 image 文件的构建阶段执行，执行结果都会打包进入 image 文件
- `CMD`命令在容器启动后执行。另外，一个 Dockerfile 可以包含多个`RUN`命令，但是只能有一个`CMD`命令。指定了`CMD`命令以后，`docker container run`命令就不能附加命令了（e.g. `/bin/bash`），否则会覆盖`CMD`命令

### Build Container

> 创建image文件

- 有了 Dockerfile 文件以后，就可以使用`docker image build`命令创建 image 文件:

```bash
docker image build -t koa-demo . # -t 指定 image 文件名字 名字为koa-demo # 用的是pwd的Dockerfile
docker image build -t koa-demo \path\to\Dockerfile # 指定Dockerfile的路径为 \path\to\Dockerfile
docker image build -t koa-demo:0.0.1 . # 用冒号指定标签，如果不指定，默认的标签是latest # . 表示Dockerfile在当前路径
```

- 如果运行成功，则可以使用`docker image ls`看到刚刚创建好的image文件
- `docker container run`命令会从 image 文件生成容器

```bash
docker container run -p 8000:3000 -it koa-demo /bin/bash # container 可省略 # 容器的 3000 端口映射到本机的 8000 端口
docker container run -p 8000:3000 -it koa-demo:0.0.1 /bin/bash # :0.0.1 指定版本
```



### Release Image File

首先，去 hub.docker.com 或 cloud.docker.com 注册一个账户。然后：

```bash
docker login # 登录
docker image tag [imageName] [username]/[repository]:[tag] # 为本地的 image 标注用户名和版本
docker image tag koa-demos:0.0.1 urname/koa-demos:0.0.1 # 上面语句的一个实例
docker image build -t [username]/[repository]:[tag] . # 也可以不标注用户名，重新构建一下 image 文件
docker image push [username]/[repository]:[tag] # 发布 image 文件 # 登录 hub.docker.com，就可以看到已经发布的 image 文件
```



## Run/Stop Container

`docker container run`命令会从 image 文件生成容器 container 可省略 

```cmd
docker container run -p 8000:3000 -it koa-demo /bin/bash # 容器的 3000 端口映射到本机的 8000 端口
docker container run -p 8000:3000 -it koa-demo:0.0.1 /bin/bash # :0.0.1 指定版本
docker container run --rm -p 8000:3000 -it koa-demo /bin/bash # --rm 在容器终止运行后自动删除容器文件
docker run -d -p 127.0.0.1:5001:5000 training/webapp python app.py #指定容器绑定的网络地址
docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py #绑定UDP端口
docker run -p 80:80 --name mynginx -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf
```

- `-p 81:80`: 将容器的80端口映射到主机的81端口，默认绑定的是TCP端口
- `--name mynginx`: 将容器命名为`mynginx`
- `-v $PWD/www:/www`: 将主机中当前目录下的`www`挂载到容器的`/www`
- `-v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf`: 将主机中当前目录下的`nginx.conf`挂载到容器的`/etc/nginx/nginx.conf`
- `-v $PWD/logs:/wwwlogs`: 将主机中当前目录下的`logs`挂载到容器的`/wwwlogs`
- `-it`: 容器的 Shell 映射到当前的 Shell，然后在本机窗口输入的命令，就会传入容器

容器停止运行之后，并不会消失，可用下面的命令删除容器文件。或用`--rm` 在容器终止运行后自动删除容器文件

```bash
docker container ls --all # 查出容器的 ID
docker container rm [containerID] # 删除指定的容器文件
docker container run --rm -it koa-demo /bin/bash # --rm 在容器终止运行后自动删除容器文件
```

- 前面的`docker container run`命令是新建容器，每运行一次，就会新建一个容器。同样的命令运行两次，就会生成两个一模一样的容器文件。如果希望重复使用容器，就要使用`docker container start`命令，它用来启动已经生成、已经停止运行的容器文件

```bash
docker container start [containerID] # 启动已经生成、已经停止运行的容器文件
```

- 前面的`docker container kill`命令终止容器运行，相当于向容器里面的主进程发出 SIGKILL 信号。而`docker container stop`命令也是用来终止容器运行，相当于向容器里面的主进程发出 SIGTERM 信号，然后过一段时间再发出 SIGKILL 信号

```bash
docker container stop [containerID] # 发出 SIGTERM 信号，然后过一段时间再发出 SIGKILL 信号
```

- 这两个信号的差别是，应用程序收到 SIGTERM 信号以后，可以自行进行收尾清理工作，但也可以不理会这个信号。如果收到 SIGKILL 信号，就会强行立即终止，那些正在进行中的操作会全部丢失

- `docker container logs`命令用来查看 docker 容器的输出，即容器里面 Shell 的标准输出。如果`docker run`命令运行容器的时候，没有使用`-it`参数，就要用这个命令查看输出

```bash
docker container logs [containerID] # 查看 docker 容器的输出 # 如果docker run命令运行容器的时候，没有使用-it参数
```

- `docker container exec`命令用于进入一个正在运行的 docker 容器。如果`docker run`命令运行容器的时候，没有使用`-it`参数，就要用这个命令进入容器。一旦进入了容器，就可以在容器的 Shell 执行命令了

```bash
docker container exec -it [containerID] /bin/bash # 进入一个正在运行的 docker 容器
```

- `docker container cp`命令用于从正在运行的 Docker 容器里面，将文件拷贝到本机。下面是拷贝到当前目录的写法

```bash
docker container cp [containID]:[/path/to/file] . # 从Docker容器里拷贝某个文件到当前目录
```





---

# Docker CMD Lookup Table

```bash
sudo systemctl start docker
sudo systemctl restart docker
sudo systemctl stop docker
service docker stop

docker command --help #更深入的了解指定的 Docker 命令使用方法
docker container --help #更深入的了解指定的 Docker 命令使用方法
docker images # 列出本地主机上的镜像 # see a list of all images on your system
docker images -a  # 显示此机器上的所有镜像
docker pull ubuntu:13.10 #下载镜像 拖取镜像
docker search httpd #搜索镜像
docker inspect ubuntu # 查看ubuntu latest版本的信息
```

```bash
docker build -t friendlyname .# 使用此目录的 Dockerfile 创建镜像
docker login      # 使用您的 Docker 凭证登录此 CLI 会话
docker tag <image> username/repository:tag  # 标记 <image> 以上传到镜像库
docker push username/repository:tag   # 将已标记的镜像上传到镜像库
```

- 貌似`docker container`命令中的`container`都可以省略

```bash
docker container ps # 查看docker进程 查看我们正在运行的容器
docker container ls # 与上一句等效
docker container ps -a # 查看所有docker进程 包括结束了的 # 列出本机所有容器，包括终止运行的容器 
docker container ls --all # 与上一句等效 # 可查出容器的 ID
docker container ps -l # 查看最后一次创建的容器

docker port CONTAINER_ID # 查看容器的端口映射
docker container logs [containerID] # 查看 docker 容器的输出 # 如果docker run命令运行容器的时候，没有使用-it参数

docker container rm [containerID] # 删除指定的容器文件 # rm: Remove one or more containers
docker container rm $(docker ps -a -q) # 从此机器中删除所有容器
docker container rmi imageA # 删除iamge # rmi: Remove one or more images # -f 强制删除
```

## run, start, exec, stop

- 貌似`docker container`命令中的`container`都可以省略

```bash
docker run -it ubuntu:18.04 bash
docker container run -t -i ubuntu:15.10 /bin/bash # docker container run 具有自动抓取 image 文件的功能
docker container run -p 8000:3000 -it imageA /bin/bash # 容器的 3000 端口映射到本机的 8000 端口 # i 交互; t tty;
docker container run -d -p 4000:80 imageA    # -d : 在分离模式下 
docker container run -p 8000:3000 -it imageA:1.0.1 /bin/bash # :1.0.1 指定版本
docker container run --rm -it imageA /bin/bash # --rm 在容器终止运行后自动删除容器文件
docker run -d -p 127.0.0.1:5000:5000/udp imageA python app.py #绑定UDP端口
docker run -p 80:80 --name imageA -v $PWD/www:/www -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf # 挂载一些目录
docker run username/repository:tag   # 运行镜像库中的镜像

docker container start NAMES/CONTAINER_ID # 已经停止的容器，可以使用命令 docker start 来启动
docker container exec -it [containerID] /bin/bash # 进入一个正在运行的 docker 容器
```
- docker内命令行用exit退出，或`ctrl+d`
```bash
docker kill NAMES/CONTAINER_ID # 强制关闭指定的容器 # 相当于向容器里面的主进程发出 SIGKILL 信号
docker stop NAMES/CONTAINER_ID # 发出 SIGTERM 信号，然后过一段时间再发出 SIGKILL 信号
docker rm NAMES/CONTAINER_ID # 删除不需要的容器，但容器必须处于停止状态
```





## copy/transfer

- 需要注意的是，不管容器有没有启动，拷贝命令都会生效

```bash
docker container cp [containID]:[/path/to/file] . # 从Docker容器里拷贝某个文件到当前目录
docker cp /hostPath/forCopy.file containerID:/some/path #将宿主机的文件拷贝到容器的路径中
docker cp containerID:/path/to/file.txt /host/path/ #将容器的文件拷贝到宿主机中
```





# docker-compose

docker-compose.yml包含:

1. version
2. services
3. networks



## docker-compost CMD Lookup Table

```bash
# -f  指定使用的 Compose 模板文件，默认为 docker-compose.yml，可以多次指定
docker-compose -f docker-compose.yml up -d 
docker-compose up -d  #启动所有容器，-d 将会在后台启动并运行所有的容器

docker-compose down #停用移除所有容器以及网络相关
docker-compose logs #查看服务容器的输出
docker-compose ps #列出项目中目前的所有容器

#构建（重新构建）项目中的服务容器。服务容器一旦构建后，将会带上一个标记名，例如对于 web 项目中的一个 db 容器，可能是 web_db。可以随时在项目目录下运行 docker-compose build 来重新构建服务
docker-compose build
docker-compose pull #拉取服务依赖的镜像
docker-compose restart #重启项目中的服务
docker-compose rm #删除所有（停止状态的）服务容器。推荐先执行 docker-compose stop 命令来停止容器
docker-compose run ubuntu ping docker.com #在指定服务上执行一个命令
docker-compose scale web=3 db=2 #设置指定服务运行的容器个数。通过 service=num 的参数来设置数量
docker-compose start #启动已经存在的服务容器
docker-compose stop #停止已经处于运行状态的容器但不删除。通过 docker-compose start 可以再次启动
```







---

# Kubernetes









## Basis

- Borg：谷歌内部使用的大规模集群管理系统，基于容器技术，目的是实现资源管理的自动化，以及跨多个数据中心的资源利用率的最大化
- Endpoint（IP+Port） ：标识服务进程的访问点
- Master：集群控制节点，负责整个集群的管理和控制，基本上Kubernetes所有的控制命令都是发给它，它来负责具体的执行过程，执行的命令基本都是在Master节点上运行的

  - Kubernetes API Server（kube-apiserver），提供Http Rest接口的关键服务进程，是Kubernetes里所有资源的增、删、改、查等操作的唯一入口，也是集群控制的入口进程
  - Kubernetes Controller Manager（kube-controller-manager），Kubernetes里所有资源对象的自动化控制中心，可以理解为资源对象的“大总管”
  - Kubernetes Scheduler（kube-scheduler），负责资源调度（Pod调度）的进程，相当于公交公司的“调度室”
  - etcd Server，Kubernetes里所有的资源对象的数据全部是保存在etcd中
- Node：除了Master，Kubernetes集群中的其他机器被称为Node节点，Node节点才是Kubernetes集群中的工作负载节点，每个Node都会被Master分配一些工作负载（Docker容器），当某个Node宕机，其上的工作负载会被Master自动转移到其他节点上去

  - kubelet，负责Pod对应的容器的创建、启停等任务，同时与Master节点密切协作，实现集群管理的基本功能。一旦Node被纳入集群管理范围，kubelet进程就会想Master几点汇报自身的情报，这样Master可以获知每个Node的资源使用情况，并实现高效均衡的资源调度策略。而某个Node超过指定时间不上报信息，会被Master判定为“失联”，Node状态被标记为不可用（**Not Ready**），随后Master会触发“工作负载大转移”的自动流程
  - kube-proxy，实现Kubernetes Service的通信与负载均衡机制的重要组件
  - Docker Engine（docker），Docker引擎，负责本机的容器创建和管理工作
- pod
- 每个Pod都有一个特殊的被称为“根容器”的**Pause**容器，还包含一个或多个紧密相关的用户业务容器
  - 一个Pod里的容器与另外主机上的Pod容器能够直接通信
  - 如果Pod所在的Node宕机，会将这个Node上的所有Pod重新调度到其他节点上
  - 普通Pod及静态Pod，前者存放在etcd中，后者存放在具体Node上的一个具体文件中，并且只能在此Node上启动运行
  - Docker Volume对应Kubernetes中的Pod Volume
  - 每个Pod可以设置限额的计算机资源有CPU和Memory
    - Requests：资源的最小申请量
  - Limits，资源最大允许使用的量
- Event ：是一个事件记录，记录了事件最早产生的时间、最后重复时间、重复次数、发起者、类型，以及导致此事件的原因等信息。Event通常关联到具体资源对象上，是排查故障的重要参考信息
- Label ：Label可以附加到各种资源对象上，**一个资源对象可以定义任意数量的Label**。给某个资源定义一个Label，相当于给他打一个标签，随后可以通过**Label Selector**（标签选择器）查询和筛选拥有某些Label的资源对象。我们可以通过给指定的资源对象捆绑一个或多个Label来实现多维度的资源分组管理功能，以便于灵活、方便的进行资源分配、调度、配置、部署等管理工作； 
Label Selector示例：select * from pod where pod’s name=’XXX’,env=’YYY’，支持操作符有=、!=、in、not in；
- Replication Controller（RC） ：部署和升级Pod，声明某种Pod的副本数量在任意时刻都符合某个预期值

  - Pod期待的副本数

  - 用于筛选目标Pod的Label Selector

  - 当Pod副本数量小于预期数量的时候，用于创建新Pod的Pod模板（template）
- Replica Set ：下一代的Replication Controlle，Replication Controlle只支持基于等式的selector（env=dev或environment!=qa）但Replica Set还支持新的、基于集合的selector（version in (v1.0, v2.0)或env notin (dev, qa)），这对复杂的运维管理带来很大方便
- Deployment ：拥有更加灵活强大的升级、回滚功能。在新的版本中，官方推荐使用Replica Set和Deployment来代替RC，两者相似度>90%，相对于RC一个最大升级是我们随时指导当前Pod“部署”的进度。Deployment使用了Replica Set，除非需要自定义升级功能或根本不需要升级Pod，一般情况下，我们推荐使用Deployment而不直接使用Replica Set； 典型使用场景： 
  - 创建一个Deployment对象来生成对应的Replica Set并完成Pod副本的创建过程；
  - 检查更新Deployment的状态来查看部署动作是否完成（Pod副本的数量是否达到预期的值）；
  - 更新Deployment以创建新的Pod；（比如镜像升级）
  - 如果当前Deployment不稳定，则回滚到一个早先的Deployment版本；
  - 挂起或者回复一个Deployment
- Horizontal Pod Autoscaler（HPA） ：意思是Pod横向自动扩容，目标是实现自动化、智能化扩容或缩容。 
  Pod负载度量指标： 
  - CPUUtilizationPercentage 
    通常使用一分钟内的平均值，可以通过Heapster扩展组件获取这个值。一个Pod自身的CPU利用率是该Pod当前CPU的使用量除以它的Pod Request的值。例如Pod Request定义值为0.4，当前Pod使用量为0.2，则它的CPU使用率为50%。但如果没有定义Pod Request值，则无法使用CPUUtilizationPercentage来实现Pod横向自动扩容的能力
  - 应用程序自定义的度量指标，比如服务在每秒内的相应的请求书（TPS或QPS）





----

# 云计算

> 这里主要讲的是理论部分

**云计算 = 数据 x (软件+平台+基础设施) x 服务**

数据（Data）：爆炸增长（传感器、物联网）。各个领域各个层面。

软件（Software）：检索、发现、关联、处理和创造数据

平台（Platform）：云计算时代也会诞生自己的通用平台

基础设施（Infrastructure）：存储资源、计算资源等

服务（Service）：IT服务化：产品 -> 服务 XaaS



五个基本特征，三种服务模型，四种部署模型

**可扩展性**

- 水平扩展：向外扩展、向内扩展。分配和释放IT资源
- 垂直扩展：向上扩展、向下扩展。一个现有的IT资源被具有更大或更小容量的资源所代替。

**云服务**

- 云服务 Cloud Service：任何可以**通过云远程访问的IT资源**。云计算背后的推动力是以服务的形式提供IT资源，这些服务封装了其他IT资源，并向客户端提供远程使用功能。
- 并非云中所有IT资源都可以被远程访问，其中由公开发布的API的软件程序可以专门部署为允许远程客户访问
- 现在出现了多种通用云服务类型的模型，大部分以as-a-service作为后缀



- 可用性更改好的IT资源具有更长的可访问时间。云提供者通常提供可恢复的IT资源，一边能够保证高水平的可用性
- 具有更强可靠性的IT资源能更好地避免意外情况，或是从中更快恢复。云环境的模块化架构为故障转移提供了广泛的支持，从而增强了可靠性。



**商业驱动力**

1. 容量规划：是确定和满足一个组织未来对IT资源、产品和服务需求的过程。这里的容量（capacity）是指在一段给定的时间内，一个IT资源能够提供的最大工作量。IT资源容量与起需求之间的差异会导致：系统效率低下（过度配置）；无法满足用户需求（配置不足）。规划的重点是将这个差异最小化，以便系统获得预期的效率和性能。容量规划策略分为：
   - 领先策略 Lead Strategy
   - 滞后策略 Lag Strategy
   - 匹配策略 Match Strategy
2. 降低成本：**IT成本**和**业务性能**之间的恰好平衡难以保持。给定的自动化解决方案的使用潜力 总是受限于 底层基础设施的处理能力。成本分为两种：①获得新基础设备的成本；②保有其所有权的成本。运营开销在IT预算中占了相当大一部分，往往超过前期投资成本
3. 组织灵活性：组织对变化的响应程度的衡量。



**技术创新**

这里介绍对云计算产生主要影响的前期技术

1. **集群**化：集群是一组互联的独立IT资源，以整体形式工作。集群由一组基本相同的硬件和操作系统构成、彼此互联。固有的冗余和容错特性。
2. **网格计算**：计算网格为计算资源提供了一个平台，使其能组织成一个或多个逻辑池。这些逻辑池统一协调为一个高性能分布式网络，超级虚拟计算机。以**中间件层**为基础，这个中间件层是在计算资源上部署的。这些IT资源构成一个网格池，实现一系列负载分配和协调功能。中间件层可以包含负载均衡逻辑、故障转移控制、自动配置管理。（有些观点认为云计算是早期网格计算的衍生品）
3. **(传统)虚拟化技术**：虚拟化是一个技术平台，用于创建IT资源的虚拟实例。虚拟化软件层允许物理IT资源提供自身的多个虚拟映像，这样多个用户就可以共享它们的底层处理能力。虚拟化技术出现前，软件只能被绑定在静态硬件环境中，二虚拟化则**打断**了这种**软硬件之间的依赖性**。
4. 技术创新和使能技术：**云使能技术（Cloud-Enabling Technology）**
   - 贷款网络和Internet架构
   - 数据中心技术
   - （现代）虚拟化技术
   - Web技术
   - 多租户技术
   - 服务技术

两大技术流派

| 互联网云   | IT云       |
| ---------- | ---------- |
| 分布式架构 | 虚拟化架构 |
| 公有云     | 私有云     |



## 基本概念与术语

云（Cloud）：一个独特的IT环境其设计目的是为了远程供给可扩展和可测量的IT资源。云可以基于任何允许远程访问其IT资源的协议。

IT资源（IT Resource）：一个与IT相关的物理的或虚拟的事物。既可以是基于软件的，比如虚拟服务器或定制软件程序，也可以是基于硬件的，比如物理服务器或网络设备。

物理服务器有时也被称为物理主机（physical host）或简称为主机，因为它们负责承载虚拟服务器。

企业内部的：处于一个组织边界（并不特指云）中的传统IT企业内部承载的IT资源被认为是位于IT企业内部的，简称为内部的（on-premise）。术语 内部的 是指 在一个不基于云的可控的IT环境内部的，它和基于云的是对等的，用来对IT资源进行限制。一个内部的IT资源不可能是基于云的，反之亦然。



**角色与边界**

1. **云提供者** Cloud Provider：**提供**基于云的IT资源的组织或个人。IT资源可以是云提供者自有或者租赁的。是指拥有云中的 IT 资源的实体。云提供者需要
   购置、部署、运维 IT 资源，包括计算、网络、软件等各类资源
   。这些资源可以以物理资源或者虚拟资源的形式提供给云用户
2. **云用户** Cloud Consumer：**使用**基于云的IT资源的一方。通过合约协定使用云的IT资源的人或者组织。可以通过云服务中的**用户**角色来访问云服务。组织机构（或者个人），他们与云提供者签订正式的合同或者约定来使用云提供者提供的可用的 IT 资源
3. **云服务拥有者** Cloud Service Owner：在法律上拥有云服务的个人或者组织。云服务拥有者可以是云用户或者是拥有该云服务所在云的云提供者本身。云服务拥有者 $\neq$ 云资源拥有者。在法律上部署和拥有云服务的个人或者组织称为云服务拥有者。可以是云用户，或者是拥有该云服务所在的云的云提供者。
4. **云资源管理者** Cloud Resource Administrator：负责管理基于云的IT资源（包括云服务）的人或者组织。可以是：这个云的用户；云提供者；受委托的第三方组织。可以是云服务所属的云的云用户或者云提供者，也可以是签订了合约来管理基于云的 IT 资源的第三方组织。

> **云服务用户** Cloud Service Consumer：一个临时的运行时角色，由访问云服务的软件程序担任。这些软件可以远程访问被定位为云服务的其他IT资源。云服务用户常见类型。
>
> - 能够通过已发布的服务合同远程访问云服务的软件程序和服务
> - 运行某些软件的工作站、便携电脑和移动设备

**组织边界** Organizational Boundary：一个**物理范围**，一家组织拥有和管理的IT资源的集合。不表示组织实际的编辑，只是该组织的**IT资产和IT资源**。例如云用户的组织边界，云提供者的组织边界。

**信任边界**：一个**逻辑范围**，通常会跨越物理边界，表明IT资源受信任的程度



**云特性**

- **按需使用**：云用户不需要拥有 IT 资源，而是以服务的形式，需要的时候可以使用资源，不需要的时候就停止使用。
- **随处访问（泛在接入）**：一个云服务可以被广泛访问的能力。拥有 IT 基础资源的云服务提供者可以通过网络线路来让大范围云用户访问到云资源，只要云用户与 IT资源有线路链接
- **多租户**：多租户是指不同的租户（团体/机构）可以共享应用软件，这些应用部署在云端。通过多租户，云服务供应商可以通过相同的应用程序为不同的租户（组织/团体）的用户提供服务。多租户可以减少软件版本，降低软件开发、维护成本
- **弹性**：弹性即是能够根据用户的需求自动的扩展提供给用户的资源。与上面的按需使用不同，按需使用是体现在用户层面的，而弹性则是体现在云服务提供者层面的 
- **可测量的使用**：云平台对云用户使用的 IT 资源使用情况的记录能力，方便对用户进行收费，并且还可用于对 IT 资源的监控
- **可恢复性**：是一种故障转移的形式。会在多个物理位置提供冗余的 IT 资源，并存放 IT 资源的备份。当前使用的 IT 资源出现故障的时候，就可以快速转换到备份资源进行处理，增加云服务的**可靠性**和**可用性**



## 云交付模型

**云交付模型**：是云提供者提供的具体的、事先打包好的IT资源组合

- **基础设施作为服务 IaaS**：对创建的基于云环境需要有更高管理控制权的用户使用这种模型。硬件资源作为服务提供给用户。虚拟化技术，资源动态管理与调度技术。
- **平台作为服务 PaaS**：预先定义好的“就绪可用”（ready to use）的环境，一般由已经部署好和配置好的IT资源组成。相对IaaS。使用PaaS的云用户只被给予了较低等级的控制权。提供应用软件的开发、测试、部署和运行环境。关键技术：分布式文件系统，分布式数据库，并行计算技术
- **软件作为服务 SaaS**：把软件程序定位成共享的云服务，作为产品或通用的工具进行提供。云用户对SaaS实现的管理权限非常有限。将运行于云中的应用软件的功能交付给用户。关键技术：呈现技术，多租户技术。



## 云部署模型

1. 公有云
2. 社区云
3. 私有云
4. 混合云







