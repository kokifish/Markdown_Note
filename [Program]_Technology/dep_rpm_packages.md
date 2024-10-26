# debian deb package

> https://feeding.cloud.geek.nz/posts/whats-in-a-debian-directory/ **What's in a debian/ directory?**
>
> https://www.debian.org/doc/debian-policy/ch-source.html Source packages

debian发行版所有软件包都以`.deb`文件格式提供

```bash
apt install dpkg-dev
apt install devscripts
```



### Structure

`.deb`包包含两组文件：

1. 安装软件包需要安装到系统上的文件
2. *control information files*: 附加的元数据文件，和安装卸载要执行的文件





#### Source Packages

Debian源码包包含构建一个或多个二进制包的源材料。二进制包由源码包通过 debian/rules 和debian目录下其他文件定义的构建过程构建而成。

Debian源码包分类：

1. native:
2. non-native: 





##### debian/rules

> As can be gathered from the first two lines of this file, this is a [Makefile](https://www.gnu.org/software/make/manual/make.html#Introduction). This is what controls how the package is built.
>
> https://www.debian.org/doc/debian-policy/ch-source.html

- debian/rules 必须为一个可执行的makefile
- dh 是 Debian 最常用的 deb 辅助工具，会自动实现许多规则

```bash
#!/usr/bin/make -f

# Start build by executing:
# $ debuild --no-tgz-check -us -uc

# Uncomment this line out to make installation process more chatty.
# Keep it on until we know there's no outstanding problems with installation.
# export DH_VERBOSE=1

# There's a bug here
export DEB_BUILD_MAINT_OPTIONS=hardening=-format

include /usr/share/dpkg/buildflags.mk


%:
	dh $@ --with=config-package

override_dh_installinit: # 改变 dh_installinit 行为.dh_installinit: debhelper 提供的命令，在安装过程中处理初始化脚本。它会根据规则文件中的指示，将初始化脚本复制到正确的位置，并设置相应的启动链接
	dh_installinit --name=cuttlefish-host-resources # 安装的初始化脚本 cuttlefish-host-resources
	dh_installinit

```

构建规则，debhelper version 7的`dh`命令使其较为简单



##### debian/substvars

> variable substitutions

- debian/substvars 通常由 debian/rules 动态生成和修改，此时须在 clean 目标中被删除

##### debian/files

用于记录正在生成的文件，包括`*.deb`



##### DEBIAN/conffiles

- 记录了被认为是配置文件的路径
- 可由debuild生成



#### Binary Packages



##### debian/control files



```bash
# 第一节描述 
Source 源码包名字
Maintainer
Priority
Build-Depends

# 后面的描述由此 source package 构建出来的所有 binary packages
Package  二进制包名字
Architecture
  any  可以构建为任何架构，但是每个架构都需要分别构建
  all  可以在任何架构上运行，不需要分别构建
Depends
Description
```

> https://www.debian.org/doc/debian-policy/ch-relationships.html

- Depends: 只在配置软件包时生效的绝对依赖关系，不阻止软件包在未配置状态下安装进系统。若无法满足，则包处于未配置状态。`postinst`,`prerm`脚本需要被依赖的包时，
- Recommends: 强烈建议但不强制要求的依赖
- Suggests
- Pre-Depends: 解包时，如果: 1. 被依赖包完全配置; 或 2. 被依赖包已解包或半配置，且在过去某一时刻正确配置；且版本号满足要求，则满足Pre-Depends。在包要被配置时，Pre-Depends视为Depends。不同的是，Pre-Depends 不允许破坏循环依赖关系。
- Build-Depends
- Build-Depends-Indep
- Build-Depends-Arch
- Breaks: 声明这个包会破坏某个包，满足条件时，dpkg将拒绝配置处于解包状态的包
- Conflicts: 冲突时，dpkg拒绝同时在系统上解包
- 





package.install / 

##### Maintainer Scripts: preinst/postinst/prerm/postrm

> https://www.debian.org/doc/debian-policy/ch-files.html#s-scripts 
>
> https://www.debian.org/doc/debian-policy/ch-binary.html
>
> https://www.debian.org/doc/debian-policy/ch-maintainerscripts.html

- 软件包想要向用户传递重要信息时，应在postinst脚本中显示

例如 cuttlefish-base 的 `base/debian/cuttlefish-base.postinst` 就是一个debuild前postinst脚本，在debuild之后会由 dh_installinit/13.6ubuntu1 添加一部分脚本，成为最终的 postinst 脚本 `base/debian/cuttlefish-base/DEBIAN/postinst`

```bash

```



# Cuttlefish

> cf for short 
>
> https://linaro.atlassian.net/wiki/spaces/ORKO/pages/28985622530/Building+QEMU+with+virtio-gpu+and+rutabaga+gfx 
>
> https://gitlab.archlinux.org/archlinux/packaging/packages/qemu/-/issues/4 Add support for virtio-gpu-rutabaga
>
> https://crosvm.dev/book/appendix/rutabaga_gfx.html Rutabaga Virtual Graphics Interface
>
> https://2net.co.uk/blog/cuttlefish-android12.html The Android Cuttlefish emulator aosp12



### Build

```bash
# cuttlefish debuild, build in `base` and `frontend` dir
# debuild -i -us -uc -b -d # -us 不对包进行签名 # -b 值构建binary包



```



### cuttlefish deb

> https://sites.google.com/junsun.net/how-to-run-cuttlefish/home  Cuttlefish on arm64

- `cuttlefish-base_*_*64.deb`          本地运行需要安装的唯二的包 # 创建静态资源
- `cuttlefish-user_*_*64.deb`         本地运行需要安装的唯二的包 # local web server, 支持浏览器控制
- `cuttlefish-common_*_*64.deb`        Depends: cuttlefish-base, cuttlefish-user # DEPRECATED
- `cuttlefish-integration_*_*64.deb`   Depends: cuttlefish-base # Installs additional utilities to run Cuttlefish in Google Compute Engine
- `cuttlefish-orchestratio_*_*64.deb`  Depends: cuttlefish-user # Replaces cuttlefish-user https://github.com/google/cloud-android-orchestration

```bash
base
|-- debian  # 存储与debian软件包相关的所有信息，该目录以外的任何内容为上游代码，即开发者发布的原始代码
|   |-- changelog  # 变更日志
|   |-- control    # 控制文件，包的依赖关系，架构，版本，名称，描述
|   |-- copyright  # 版权，许可证
|   |-- cuttlefish-base
|   |-- cuttlefish-base.cuttlefish-host-resources.default #cuttlefish-host-resources 服务的默认配置文件
|   |-- cuttlefish-base.cuttlefish-host-resources.init # cuttlefish-host-resources 服务的初始化脚本，需要改写为centos的服务
|   |-- cuttlefish-base.debhelper.log
|   |-- cuttlefish-base.install  # cuttlefish-base 安装文件列表
|   |-- cuttlefish-base.postinst # cuttlefish-base 安装后脚本
|   |-- cuttlefish-base.substvars
|   |-- cuttlefish-base.udev
|   |-- cuttlefish-common
|   |-- cuttlefish-common.debhelper.log
|   |-- cuttlefish-common.substvars
|   |-- cuttlefish-integration
|   |-- cuttlefish-integration.debhelper.log
|   |-- cuttlefish-integration.displace
|   |-- cuttlefish-integration.install
|   |-- cuttlefish-integration.postinst
|   |-- cuttlefish-integration.postinst.debhelper
|   |-- cuttlefish-integration.prerm.debhelper
|   |-- cuttlefish-integration.substvars
|   |-- cuttlefish-integration.udev
|   |-- debhelper-build-stamp
|   |-- files
|   |-- rules      # 构建规则，运行以构建软件包
|   `-- source
|-- host
|   |-- deploy # 有两个py脚本一个sh脚本
|       |-- capability_query.py  # 包括兼容性检查
|       |-- install_zip.sh       # 安装img到目标目录
|       `-- unpack_boot_image.py # 解压 boot.img 等包
|   `-- packages
|       |-- cuttlefish-base
|           `-- etc  # 总计三个文件在后面会分别描述其功能
|-- install-nodejs.sh
`-- setup-nodejs-env.sh
```

```bash
ls /lib/modules/$(uname -r) 
tree /lib/modules/$(uname -r) # *.ko 的为内核模块
lsmod # 当前已加载的内核模块
modprobe --list # centos 不适用
```





#### cuttlefish-base

主要功能：

- 检查系统是否安装有依赖包。e.g. qemu, f2fs, libusb, libx11, dnsmasq, bridge-utils, binfmt, libwayland …
- 放置静态文件，主要是一些`*.conf`，以及一个bash两个py脚本
- 开启一个`cuttlefish-host-resources`服务，用于创建有线/无线网，其中有需要用到RSA认证的地方，在cuttlefish-user中实现



- f2fs-tools: 包不存在 https://rpmfind.net/linux/rpm2html/search.php?query=f2fs-tools TODO
- vhost-vsock: 该kernel module不存在，影响 cuttlefish-base.udev 的启动配置 TODO
- qemu-user-static: centos不存在，暂用qemu-kvm代替
- `rh_status`在centos中不存在，改用`systemctl status cuttlefish-host-resources`







##### cuttlefish-base: /etc static fiels

对应的原始文件存放在 `android-cuttlefish/base/host/packages/cuttlefish-base/etc/*`

> 目前因centos/ubuntu差异需要注意的文件暂时只有 cuttlefish-common.conf 中加载的模块名

- /etc/modules-load.d/cuttlefish-common.conf. 指定debian系统引导时自动加载内核模块

```bash
vhci-hcd # 虚拟 USB 控制器的内核模块，允许在虚拟环境中模拟 USB 设备 # dummy_hcd(不存在)？ uio?
vhost_net # 虚拟网络设备的内核模块，允许在虚拟环境中创建和管理虚拟网络接口 # centos 有同名模块
vhost_vsock # 虚拟套接字设备的内核模块，允许在虚拟环境中进行套接字通信 # 不存在同名模块，pending
```

- /etc/NetworkManager/conf.d/99-cuttlefish.conf. 配置 NetworkManager 网络管理器的行为

```bash
[keyfile]
unmanaged-devices=interface-name:cvd-* # 不要管理以 cvd- 开头的接口，不对其进行网络配置和管理
```

- /etc/security/limits.d/1_cuttlefish.conf. 指定cvdnetwork用户组的软限制(soft limit)为4096个文件描述符。允许进程同时打开更多文件和套接字，支持GPU透传时的Gralloc缓冲区操作

```bash
# Cuttlefish with GPU passthrough will use additional file descriptors on the
# host for Gralloc buffers.
@cvdnetwork soft nofile 4096
```

##### cuttlefish-host-resources Service

- `base/debian/cuttlefish-base.cuttlefish-host-resources.init` : ubuntu 服务的脚本。安装cuttlefish-base后会放在 `/etc/init.d/cuttlefish-host-resources`
- `base/debian/cuttlefish-base.cuttlefish-host-resources.default` : 参数配置。安装cuttlefish-base后会放在 `/etc/default/cuttlefish-host-resources`

主要功能：

1. 设置网络桥接器 cvd-wbr cvd-ebr
2. 配置并启动 dnsmasq 服务，为cvd提供DHCP DNS服务
3. 创建并配置 TAP 设备，用于模拟器与主机之间的网络通信

在centos上运行增加了一个用于声明服务的`cuttlefish-host-resources.service`文件，其中会调用略加修改的改为`*.sh`的服务脚本

```bash
# ExecStart=/usr/lib/cuttlefish-common/bin/cuttlefish-host-resources.sh start # in cuttlefish-host-resources.service
systemctl start cuttlefish-host-resources

```



#### cuttlefish-user





### lunch-cvd

```bash
tar -xvf /path/to/cvd-host_package.tar.gz

yum install epel-release
yum install meson ninja-build gcc-c++ protobuf protobuf-devel protobuf-compiler fmt gflags gflags-devel jsoncpp jsoncpp-devel libcurl libcurl-devel glog glog-devel libxml2 libxml2-devel openssl openssl-devel uuid uuid-devel libuuid-devel zlib zlib-devel openssl-devel
cd cvd
mkdir build
meson build # after 1st time: meson --reconfigure build ; ninja -C build
ninja -C build
# meson会缓存依赖库 # 如果改了 *.pc文件以加载自己编译安装的版本: rm -rf build; mkdir build && meson build && ninja -C build
cd build
./cvd
```

```bash
# enable gcc-toolset-12
dnf search gcc
dnf install gcc-toolset-12-gcc gcc-toolset-12-gcc-c++ gcc-toolset-12-binutils gcc-toolset-12-build
dnf search *scl*
dnf install scl-utils scl-utils-build
scl enable gcc-toolset-12 bash
gcc --version
```

```bash
# 手动安装fmt库
git clone https://github.com/fmtlib/fmt.git
cd fmt
mkdir build && cd build
cmake ..
make
make install
```

```bash
# Google Test（gtest）
git clone https://github.com/google/googletest.git
cd googletest/
cmake .
make
make install
```

```bash
# jsoncpp # error: ‘const class Json::Value’ has no member named ‘as’
jsoncpp/include/json/value.h
class JSON_API Value
template <typename T> T as() const JSONCPP_TEMPLATE_DELETE;

mkdir jsoncpp && cd jsoncpp # jsoncpp的要求，否则报错
git clone https://github.com/open-source-parsers/jsoncpp.git
mkdir jsoncpp-build && cd jsoncpp-build
cmake ../jsoncpp
make
make install
```

```bash
# curl # 
git clone https://github.com/curl/curl.git
cd curl
git checkout curl-7_80_0 # curl_url_strerror 最低版本为 curl-7_80_0
autoreconf -fi
./configure --with-openssl [--with-gnutls --with-wolfssl]
make
make test (optional)
make install
```

```bash
# openssl # error: ‘ERR_print_errors_cb’ was not declared in this scope # 在openssl新版本中定义
git clone https://github.com/openssl/openssl.git
cd openssl
git checkout OpenSSL_1_1_1w # latest release tag of 1.1.1
# DECLARE_ASN1_DUP_FUNCTION does not have a number assigned # if checkout from 3.x.x to 1.x.x will cause this error, rm whole openssl folder
./config
make
make install
```

```bash
# gflags # cannot find gflags: No such file or directory
git clone https://github.com/gflags/gflags.git
cd gflags
cmake .
make
make install
```



```bash
pkg-config --list-all
strerror_r # '-D_XOPEN_SOURCE=600'
```



### Cuttlefish Docker

```bash
# 如果服务器默认登陆用户为root，则需要创建一个非root用户（用户名以Auser为例），也可以切换到别的非root用户
useradd -m -s /bin/bash Auser # -m 自动为新用户创建一个home目录 # -s /bin/bash 将用户的默认 shell 设置为 Bash
passwd Auser
visudo # 然后添加一行：
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
Auser   ALL=(ALL)       ALL # 添加这一行
# 解决 var/run/docker.sock 权限问题 和 docker cp 中出现的权限问题 # android-cuttlefish 中的文件拥有者应为 Auser # chown
sudo usermod -aG docker Auser
newgrp docker Auser
su Auser # switch to a non-root user
```



```bash
# ./build.sh --rebuild_debs_verbose
> build.sh: build_main
  > build.sh: calc_oem
    > build.sh: detect_gpu : compgen -G gpu/*  # 检测GPU厂商，需要修改为centos版本的。
      > gpu/<nvidia/amd>/probe.sh
  > build.sh: do_rebuild_debs
    > debs-builder-docker/build-debs-with-docker.sh
  > build.sh: build_docker_image
```

```bash
# as non-root user
cd android-cuttlefish/docker
./build.sh --rebuild_debs_verbose
docker image ls -a | grep cuttlefish
# cf_docker_rm cf_soft_test # docker rm cf_soft_test
source setup.sh
cf_docker_create cf_soft_test # 调 setup.sh 里面的函数来创建，cf_docker_create -h 看参数
cf_docker_list
cf_login_cf_soft_test
cf_start_cf_soft_test
cf_stop_cf_soft_test
cf_gethome_cf_soft_test
cf_publish_cf_soft_test
# copy cvd binary and aosp img # pre-built cuttlefish image
ssh -p 22 vsoc-01@${ip_cf_soft_test} -- 'tar xzvf -' < cvd-host_package.tar.gz # ip 对应 docker eth0
scp -P 22 *.img vsoc-01@${ip_cf_soft_test}:~/ # copy aosp *.img
scp -P 22 bootloader vsoc-01@${ip_cf_soft_test}:~/
# launch Cuttlefish 
cf_start_cf_soft_test --start_webrtc --cpus 4 --memory_mb 4096
adb connect $ip_cf1:6520
```

```bash
docker tag cuttlefish csighub.tencentyun.com/apksafe-arm/cuttlefish-test:a14_test
docker push csighub.tencentyun.com/apksafe-arm/cuttlefish-test:a14_test
# docker pull csighub.tencentyun.com/apksafe-arm/cuttlefish-test:a14_test 
docker run -itd  --name cf_a14 csighub.tencentyun.com/apksafe-arm/cuttlefish-test:a14_test /bin/bash
docker tag csighub.tencentyun.com/apksafe-arm/cuttlefish-test:a14_test cuttlefish # 让 /android-cuttlefish/docker 的脚本识别
docker rm <container_id>
# docker rmi <image_id> # rm image
```

```bash
# version 'libcrypto.so.10' not found
yum reinstall openssl-libs
yum update openssh-clients
```





### aosp cuttlefish/cvd

```bash
lunch aosp_cf_arm64_phone-userdebug # device/google/cuttlefish/AndroidProducts.mk
make -j$(nproc --all)
out/soong/host/linux_bionic-arm64/cvd-host_package.tar.gz

```



```bash
# aosp cuttlefish img
source build/envsetup.sh 
lunch aosp_cf_arm64_phone-trunk_staging-userdebug
make -j$(nproc --all)
make dist   # out/dist/aosp_cf_arm64_phone-img-root.zip # out/dist/cvd-host_package.tar.gz

```



---

# rpm package

```bash
rpmdev-setuptree
```

```bash
rpmbuild/
├── BUILD  # 编译过程使用，临时文件存储
├── RPMS   # 存放为不同架构构建的rpm包
├── SOURCES# 源代码，可以是脚本，需编译的C，
├── SPECS  # .spec 定义软件包构建方式
└── SRPMS  # 存放 .src.rpm 软件包。源 RPM 软件包不属于任何体系结构或发行版。实际的 .rpm 软件包构建基于 .src.rpm 软件包
```

