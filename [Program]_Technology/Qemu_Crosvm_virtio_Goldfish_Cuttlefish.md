# Qemu

> http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physical-ram.html QEMU Internals: How guest physical RAM works
>
> https://qemu-project.gitlab.io/qemu/system/monitor.html



## Memory

> https://martins3.github.io/qemu/memory.html#memoryregion QEMU 的 memory model  详细



# crosvm

> 为Chrome OS设计，ARM Linux上cuttlefish默认使用crosvm
>
> https://github.com/google/crosvm
>
> https://crosvm.dev/book/architecture/overview.html

- 安全性：用沙箱技术隔离虚拟机中的进程。Each process is sandboxed using [minijail](https://crosvm.dev/book/appendix/minijail.html). Written in Rust for security and safety
- 轻量级：只关注虚拟机基本功能，不包含qemu的复杂的设备模拟功能



## The VM Control Sockets

- 允许设备在初始化时获取所需的控制套接字，并在沙箱化时保留这些套接字。Crosvm 还通过命令行参数提供了一种 VM 控制套接字(`--socket`)，以便用户通过命令行或编程方式控制虚拟机

VM Control Sockets: crosvm使用虚拟机控制套接字VM Control Sockets来处理与全局虚拟机状态相关的操作。这些套接字根据处理的请求和响应类型进行分类。



# VirtIO

> VirtIO, virtual input & output. the communication framework between the host and guest for I/O devices.
>
> https://blogs.oracle.com/linux/post/introduction-to-virtio 一篇给第一次知道VirtIO的科普文

标准化的虚拟化接口，用于提高虚拟机(guest)和主机(host)之间的IO性能，提供通用高效可移植的虚拟化接口。只包含发送/接受数据所需的基本功能，可以让host在物理硬件上处理大部分工作，VirtIO设备从实际物理硬件中获取数据。

- 基于“环形缓冲区”（ring buffer）模型。主机和虚拟机共享一块内存区域，这块内存区域被组织成一个环形的数据结构。虚拟机通过这个环形缓冲区向主机发送请求，主机则通过同一个环形缓冲区向虚拟机发送响应。避免了传统的 I/O 操作中的数据拷贝，提高了 I/O 性能
- 支持多种类型的设备，包括网络设备（virtio-net）、块设备（virtio-blk）、控制台设备（virtio-console）
- 定义了一套设备发现和配置的机制。虚拟机可以通过这套机制发现主机上的 virtio 设备，并对这些设备进行配置。这套机制使得 virtio 设备可以在不同的虚拟化平台上移植和使用



![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Android_IOS_Virtual_Hook/virtio_virtio_net_example.avif)

https://blogs.oracle.com/linux/post/introduction-to-virtio

1. **VM:** I want to go to google.com. Hey virtio-net, can you tell the host to retrieve this webpage for me?
2. **Virtio-net:** Ok. Hey host, can you pull up this webpage for us?
3. **Host:** Ok. I’m grabbing the webpage data now.
4. **Host:** Here’s the requested webpage data.
5. **Virtio-net:** Thanks. Hey VM, here’s that webpage you requested.

尽可能让host硬件做更多的工作，让VirtIO处理数据收发。

> ### Virtualizaion vs. Emulation
>
> 虚拟化将一部分硬件共享给虚拟机使用，使得该虚拟机认为它拥有自己的硬件
>
> Emulation: 主机硬件不具备或不支持，纯软件模拟





## VirtIO Architecture

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Android_IOS_Virtual_Hook/virtio_virtio_architecture.avif)

- front-end drivers:
- back-end devices:
- VirtQueues & VRings:

# Goldfish



## GPU: GLES & Vulkan

> https://source.android.com/docs/automotive/virtualization/architecture

 On the host side, `virglrenderer` (for Mesa) and `vulkan-cereal` (for `goldfish-opengl`) replay the decoded command stream on top of the existing GPU driver. 主机端virglrenderer和vulkan-cereal在现有GPU驱动上重放解码后的命令流

![](https://source.android.com/static/docs/automotive/images/trout_graphics_02.png)



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
>
> https://source.android.com/docs/devices/cuttlefish andoird Cuttlefish vs Goldfish



### Build

```bash
# cuttlefish debuild, build in `base` and `frontend` dir
# debuild -i -us -uc -b -d # -us 不对包进行签名 # -b 值构建binary包

```



### cuttlefish deb

> https://sites.google.com/junsun.net/how-to-run-cuttlefish/home  Cuttlefish on arm64
>
> 

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
- vhost-vsock: 该kernel module不存在，影响 cuttlefish-base.udev 的启动配置 TODO ( https://www.kernelconfig.io/config_vhost_vsock  )
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

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Android_IOS_Virtual_Hook/cuttlefish_run_cvd_process_struct.png)

#### build

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



#### cmdline

```bash
# cmdlines for running at physical host # need root / sudo
export DISPLAY=:0; HOME=$PWD ./bin/launch_cvd --daemon
export DISPLAY=:0; HOME=$PWD ./bin/launch_cvd -verbosity -console=true --gpu_mode=guest_swiftshader -report_anonymous_usage_stats=n --start_webrtc=true # swiftshader
clear; export DISPLAY=:0; ./bin/stop_cvd; HOME=$PWD ./bin/launch_cvd -verbosity VERBOSE -file_verbosity VERBOSE -console=true --gpu_mode=auto -report_anonymous_usage_stats=n --start_webrtc=true --gpu_vhost_user_mode=auto
# gfxstream # OpenGL 和 Vulkan API 调用会直接转到主机
# drm_virgl # 不支持 Vulkan
# For example, to use NVIDIA GPUs, you can launch Cuttlefish by pasing the -gpu_mode=drm_virgl command-line option.
cuttlefish/instances/cvd-1/
./bin/stop_cvd
./bin/cvd_status
./bin/cvd display list
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
# ./build.sh --rebuild_debs_verbose # cd docker/
> build.sh: build_main
  > build.sh: calc_oem
    > build.sh: detect_gpu : compgen -G gpu/*  # 检测GPU厂商，需要修改为centos版本的。
      > gpu/<nvidia/amd>/probe.sh
  > build.sh: is_rebuild_debs
    > build.sh: do_rebuild_debs
      > debs-builder-docker/build-debs-with-docker.sh
  > build.sh: build_docker_image
```

```bash
# 修改uid
sudo usermod -u 1001 myuser # 新 UID 为 1001
sudo chown -R myuser:myuser /path/to
```



#### cmdline

```bash
sudo apt install libvulkan-dev libvulkan1 mesa-vulkan-drivers
```

```bash
# as non-root user # apt install vulkan-utils
cd android-cuttlefish/docker
./build.sh --rebuild_debs_verbose --detect_gpu
docker image ls -a | grep cuttlefish
# cf_docker_rm cf1 # docker rm cf1
source setup.sh # 这里会给出一部分的cmdline提示 # setup.sh # 运行前需要执行的脚本，用于生成必要的管理cf docker的函数
cf_docker_create cf1 # 调 setup.sh 里面的函数来创建，cf_docker_create -h 看参数
cf_docker_list
cf_login_cf1
cf_start_cf1
cf_stop_cf1
cf_gethome_cf1
cf_publish_cf1

cf_docker_rm_cf1
cf_docker_rm_all
# copy cvd binary and aosp img # pre-built cuttlefish image
ssh -p 22 vsoc-01@${ip_cf1} -- 'tar xzvf -' < ../../cvd-host_package.tar.gz # ip 对应 docker eth0
scp -P 22 ../../cvd_rolling/*.img vsoc-01@${ip_cf1}:~/ # copy aosp *.img
scp -P 22 ../../cvd_rolling/bootloader vsoc-01@${ip_cf1}:~/
# launch Cuttlefish 
cf_start_cf1 --start_webrtc --cpus 4 --memory_mb 4096
adb connect $ip_cf1:6520
```

```bash
docker tag cuttlefish xxx.com/xxx/cuttlefish-test:latest
docker push xxx.com/xxx/cuttlefish-test:latest
# docker pull xxx.com/xxx/cuttlefish-test:latest 
docker run -itd  --name cf1 xxx.com/xxx/cuttlefish-test:latest /bin/bash
docker tag xxx.com/xxx/cuttlefish-test:latest cuttlefish # 让 /android-cuttlefish/docker 的脚本识别
docker rm <container_id>
# docker rmi <image_id> # rm image
```

```bash
# version 'libcrypto.so.10' not found
yum reinstall openssl-libs
yum update openssh-clients
```





### aosp cuttlefish/cvd

> 主要的binary都是从aosp main分支中得到的，不同系统版本可能无法通用

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



### GLES & Vulkan

- drm_virgl: GLES(gbm). 不支持Vulkan。会将OpenGL调用转换为中间表示形式，host的virglrenderer会将中间表示形式转化为OpenGL调用
- gfxstream: GLES(X11/gbm?)+Vulkan . 直接转到主机
- gfxstream_guest_angle: 
- gfxstream_guest_angle_host_swiftshader: 
- guest_swiftshader: 纯软件实现



```bash
/usr/share/vulkan/icd.d/lvp_icd.aarch64.json
/usr/lib64/libvulkan_lvp.so
rpm2cpio aaa.rpm | cpio -idmv
```



# code: vulkan device type

```cpp
#include <vulkan/vulkan.h>
#include <iostream> // apt install build-essential
#include <vector>   // g++ main.cpp -o main -lvulkan
int main() {
    VkApplicationInfo appInfo = {};
    appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    appInfo.pApplicationName = "Hello Vulkan";
    appInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
    appInfo.pEngineName = "No Engine";
    appInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0);
    appInfo.apiVersion = VK_API_VERSION_1_0;

    VkInstanceCreateInfo createInfo = {};
    createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    createInfo.pApplicationInfo = &appInfo;

    VkInstance instance;
    if (vkCreateInstance(&createInfo, nullptr, &instance) != VK_SUCCESS) {
        std::cerr << "Failed to create Vulkan instance!" << std::endl;
        return -1;
    }

    uint32_t deviceCount = 0;
    vkEnumeratePhysicalDevices(instance, &deviceCount, nullptr);

    if (deviceCount == 0) {
        std::cerr << "Failed to find GPUs with Vulkan support!" << std::endl;
        return -1;
    }

    std::vector<VkPhysicalDevice> devices(deviceCount);
    vkEnumeratePhysicalDevices(instance, &deviceCount, devices.data());

    VkPhysicalDeviceProperties deviceProperties;
    vkGetPhysicalDeviceProperties(devices[0], &deviceProperties);

    std::cout << "Device 0 type: " << deviceProperties.deviceType << std::endl;
    std::cout << "4: CPU, 2: DISCRETE_GPU" << std::endl;

    vkDestroyInstance(instance, nullptr);
    return 0;
}
```



