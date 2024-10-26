# OpenGL



# GLES

> https://learnopengl-cn.github.io/01%20Getting%20started/06%20Textures/  
>
> https://registry.khronos.org/OpenGL-Refpages/es3/
>
> http://geekfaner.com/shineengine/blog3_OpenGLESv2_2.html
>
> https://windrunnerlihuan.com/2018/01/09/Android-SurfaceFlinger-%E5%AD%A6%E4%B9%A0%E4%B9%8B%E8%B7%AF-%E5%8D%81%E4%BA%8C-%E5%90%88%E6%88%90Layer/ Android SurfaceFlinger 学习之路(十二)----合成Layer

```bash
cat /proc/pid_qemu/maps | less
apt install mesa-utils-extra
eglinfo
glxinfo -display :0 -B
glxinfo -l
glxinfo -display :0 -l
```

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/GLES_programmable_pipepline_example.png)



# EGL

>  https://opengles-android.blogspot.com/2012/10/opengl-es-2x-phan-23.html  pipeline



##### EGL configs info

包括: EGL_RED_SIZE EGL_GREEN_SIZE EGL_BLUE_SIZE EGL_ALPHA_SIZE EGL_DEPTH_SIZE EGL_STENCIL_SIZE EGL_RENDERABLE_TYPE

```bash
eglinfo
glxinfo -l
glxinfo -display :0 -l
```

> 用程序获取

```c++
// https://registry.khronos.org/EGL/sdk/docs/man/html/eglChooseConfig.xhtml
EGLint numConfigs;
EGLConfig* configs;
eglChooseConfig(display, NULL, NULL, 0, &numConfigs); // 获得 configs 的数量 numConfigs
configs = (EGLConfig*)malloc(sizeof(EGLConfig)*numConfigs);
eglChooseConfig(display, NULL, configs, numConfigs, &numConfigs); // 获得支持的 configs

for (int i = 0; i < numConfigs; i++) {
    EGLint redSize, stencilSize;
    eglGetConfigAttrib(display, configs[i], EGL_RED_SIZE, &redSize); // 获取红色分量的尺寸
    eglGetConfigAttrib(display, configs[i], EGL_STENCIL_SIZE, &stencilSize); // 模板分量的尺寸
    printf("Config %d: red size = %d, stencil size = %d\n", i, redSize, stencilSize);
}
free(configs);
```



# Vulkan

> vkspec.pdf
>
> https://vulkan-tutorial.com/Overview
>
> http://geekfaner.com/shineengine/blog15_Vulkanv1.2_1.html
>
> https://gpuopen.com/learn/understanding-vulkan-objects/ Understanding Vulkan® Objects
>
> https://www.zhihu.com/question/424430509/answer/1632072443 入门Vulkan，Overview部分笔记直接出自于这
>
> https://glumes.com/vulkan-tutorial-instance-device-queue/
>
> https://developer.nvidia.com/engaging-voyage-vulkan Nvidia的不涉及代码的Vulkan流程介绍
>
> https://developer.nvidia.com/Vulkan Vulkan Articles里面的文章可以看看

Mentle(Vulkan前身)演变而来的api讲图形绘制命令分成了Record和Submit，Vulkan对应command buffer和queue

- Record: `vkCmd\*` 录制。
- Submit: `vkQueue\*` 提交。`vkQueuePresentKHR`可以理解为特殊的提交

Vulkan的多线程渲染基本可以理解为多线程录制，多线程提交不太常见。[Multi-Threading in Vulkan](https://community.arm.com/arm-community-blogs/b/graphics-gaming-and-vr-blog/posts/multi-threading-in-vulkan)

- 强调开发者控制一切
- 多线程友好，抛弃基于单线程的context，利用多核CPU
- 强调复用





## Overview

1. Instance and physical device selection: 创建`VkInstance`，选择物理设备(`VkPhysicalDevice,` 对应GPU)
1. Logical device and queue families: 创建`VkDevice`(逻辑设备)；指定要使用的Queue families，
1. Window surface and swap chain: 
1. Image view and framebuffers:
1. Render passes: 
1. Graphics pipeline: 
1. Command pools and command buffers: 
1. Main loop: 



![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/Vulkan_Compoments.png)

- Layer/Validation Layers: 错误校验，调试输出的，Application之下Vulkan API之上的一层。
- Queue: 应用程序和物理设备之间的桥梁，Command-buffer提交给Queue，Queue提交给Device执行。一个设备可以暴露多个Queue，单个Queue上的操作通常按顺序处理，多个Queue可以并行(multiple queues can overlap in parallel.)

## Command Buffer and Command Pool

OpenGL的状态和绘制命令是即时的，而Vulkan大多是延迟的。Vulkan中，cmd会record到cmd buffer（每个线程都可以record cmd），然后submit到Queue。因此Vulkan可以在交给GPU前进行小规模翻译和优化。

OpenGL的即时命令模式导致对多线程不友好，无法控制CPU给GPU提交命令的时间点。OpenGL中context和单一线程绑定，所有作用于context的操作都只在一个线程上完成。

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/Vulkan_Intro_SecondaryCommandBuffers.png)

- **Command-pool**: cmd-buffer从cmd-pool创建，同一个cmd-pool分配的cmd-buffer必须提交到同一个Queue
- **Primary CommandBuffer**: 命令缓冲区是命令的集合，向Queue提交cmd-buffer后，命令交由GPU处理。始终负责 RenderPass 设置(RenderPass Begin/End)，其他典型的渲染操作都可以直接记录或由二级 CommandBuffer 提供
- **Secondary CommandBuffer**: 可以编码commands的一部分

vkBeginCommandBuffer/vkEndCommandBuffer可以让cmd-buffer开始/结束 recored cmd

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/Vulkan_Compoments.png)

### Lifecycle of a Command Buffer 

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/Vulkan_lifecycle_of_a_command_buffer.png)



## Objects for Rendering

用于渲染的对象：

- Image: 相当于OpenGL的texture
- FrameBuffer: 正在渲染的Image附件集合。必须与在使用的RenderPass的配置相匹配
- RenderPass: 描述一次渲染需要绘制的目标长什么样，
- Buffer: 表示用于vertex, index, uniform data…的线性原始内存。相当于 OpenGL Buffer
- Pipeline: 编码渲染状态，如shaders being used, depth-testing, blending operations，全部整合到单个整体对象中。
- DescriptorSet: 一组着色器输入的绑定。

![what objects are used for the various commands](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/Vulkan_IntroObjects_CommandBuffer.png)



### RenderPass





### FrameBuffer

### Pipeline



### Descriptor





## Allocation Management

Vulkan中各种API对象是从其他资源生成的，见上图

- **CommandBufferPool**: CommandBuffers和其内容从这里分配
- **DescriptorPool**: 可以分配出多个DescriptorSets
- **Heap**: The device comes with fixed amount of limited heaps, which memory is allocated from.
- **Memory**: Buffers 和 Images 根据需求和开发者偏好绑定至 memory，允许从更大内存块中手动重新分配资源，aliasing the memory with different resources?

这些pools简化了分配多个资源后的删除操作。可以每个线程一个pool，以实现lock-free allocations

> encourage developers to sub-allocate resources from larger chunks of memory.



![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/Vulkan_Understanding_Vulkan_Objects.png)





## Synchronization

> https://wenxiaoming.github.io/2019/03/09/Synchronization-in-Vulkan/



## Vulkan Loader

> https://github.com/KhronosGroup/Vulkan-Loader/blob/main/docs/LoaderInterfaceArchitecture.md

- The Vulkan Application : 
- [The Vulkan Loader](https://github.com/KhronosGroup/Vulkan-Loader/blob/main/docs/LoaderInterfaceArchitecture.md#the-loader) : 支持多个vulkan驱动，支持Vulkan Layer可选模块
- [Vulkan Layers](https://github.com/KhronosGroup/Vulkan-Loader/blob/main/docs/LoaderInterfaceArchitecture.md#layers) : 
- [Drivers](https://github.com/KhronosGroup/Vulkan-Loader/blob/main/docs/LoaderInterfaceArchitecture.md#drivers)
- [VkConfig](https://github.com/KhronosGroup/Vulkan-Loader/blob/main/docs/LoaderInterfaceArchitecture.md#vkconfig)



Vulkan Loader的顶层交互图，Layer部分的数据流与实际的数据流并非对应。

![](https://raw.githubusercontent.com/KhronosGroup/Vulkan-Loader/main/docs/images/high_level_loader.png)

## case

```cpp
```



# mesa

> https://gitlab.freedesktop.org/mesa/mesa
>
> https://docs.mesa3d.org/install.html#building-opengl-programs-with-pkg-config 

## pre-require & build

```bash
alternatives --config python3
alternatives --config python
yum install python39
```

- gcc

```bash
# gcc support c++17
# 以gcc 12.3.0 为例
# 在 https://gcc.gnu.org/mirrors.html 下载 gcc-12.3.0.tar.gz
tar xf gcc-12.3.0.tar.gz
cd gcc-12.3.0/
./contrib/download_prerequisites # gun官网没有提到的步骤，会下载依赖
mkdir objdir
cd objdir
../configure  # https://gcc.gnu.org/install/configure.html #  --prefix=/data2/usr
make -j$(nproc)
sudo make install # /usr/local/lib/../lib64 # /usr/local/bin/gcc /usr/local/bin/g++
```

- glslang: glslangValidator. https://github.com/KhronosGroup/glslang

```bash
git clone https://github.com/KhronosGroup/glslang.git
cd glslang
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=/usr/local/bin/gcc -DCMAKE_CXX_COMPILER=/usr/local/bin/g++ -DCMAKE_EXE_LINKER_FLAGS="-lstdc++fs" ..
# cmake -DCMAKE_INSTALL_PREFIX=/usr -B . ..
make -j$(nproc) # install
sudo make install
```

- drm

```bash
# https://gitlab.freedesktop.org/mesa/drm
meson setup builddir/
ninja -C builddir/ install
mv /usr/lib64/pkgconfig/libdrm_amdgpu.pc /usr/lib64/pkgconfig/libdrm_amdgpu.pc_bk
/usr/local/lib64/pkgconfig/libdrm_amdgpu.pc
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig/:$PKG_CONFIG_PATH
pkg-config --modversion libdrm_amdgpu # 用于验证版本
```

- rustc, bindgen

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo install bindgen-cli
```

- mesa

```bash
zypper source-install --build-deps-only Mesa # openSUSE/SLED/SLES
yum-builddep mesa # yum Fedora, OpenSuse(?)
dnf builddep mesa # dnf Fedora
apt-get build-dep mesa # Debian and derivatives

yum install llvm-devel
yum install wayland-devel libxshmfence-devel
pip3 install meson
export PATH=/usr/local/bin/:$PATH # new installed meson
pip3 install mako
```

```bash
# Downloading and Unpacking https://docs.mesa3d.org/download.html
tar xf mesa-Y.N.P.tar.xz

meson setup build/ # meson --reconfigure build/
meson setup --reconfigure build/ -Dvulkan-drivers=all # meson setup build/ -Dvulkan-drivers=all
meson setup build/ -Dbuildtype=debug -Dvulkan-drivers=amd,virtio -Dgallium-drivers=radeonsi -Dglx=dri -Degl=enabled -Dplatforms=x11,wayland -Dgbm=enabled
# CURRENT USED:  # ,virtio # buildtype=debug会导致依赖库报no .debuf_infor section错误
meson setup --reconfigure build/ -D buildtype=release -D platforms=x11,wayland -D vulkan-drivers=amd,virtio -D gbm=enabled -D egl=enabled -D gles1=enabled -D gles2=enabled -D dri3=enabled -D llvm=enabled -D tools=all -D gallium-drivers=radeonsi

meson setup --reconfigure build/ -D buildtype=debug -D platforms=x11 -D vulkan-drivers=amd,virtio -D gbm=enabled -D egl=enabled -D gles1=enabled -D gles2=enabled -D dri3=enabled -D llvm=enabled -D tools=all -D gallium-drivers=radeonsi

meson setup --reconfigure build/ -D buildtype=debug -D platforms=x11,wayland -D vulkan-drivers=amd,virtio -D gbm=enabled -D egl=enabled -D gles1=enabled -D gles2=enabled -D dri3=enabled -D llvm=enabled -D tools=all -D gallium-drivers=radeonsi,nouveau,virgl,etnaviv,freedreno,lima,swrast,v3d,vc4,tegra,lima,iris,panfrost,svga

export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH # ~/.bashrc
meson configure build/ # review the options which Meson chose
meson compile -C build/ -j$(nproc) # ninja -C build/
meson install -C build/ # ninja -C build/ install
```

> https://docs.mesa3d.org/meson.html 配置编译安装指令参考
>
> 由于缓存原因，如果修改pkg-config和python版本，可能需要`rm -rf build/`
>
> `/lib64/libstdc++.so.6`是系统的旧的，`/usr/local/lib64/libstdc++.so.6`是前面安装gcc安装的新的so
>
> 

```bash
export DISPLAY=:0; VK_ICD_FILENAMES="/usr/local/share/vulkan/icd.d/radeon_icd.aarch64.json" vulkaninfo
```

- automake https://www.gnu.org/software/automake/manual/automake.html#Basic-Installation

```bash
./configure
make
make check
make install
```

- libxml  https://gitlab.gnome.org/GNOME/libxml2  2.10.2开始要求 Automake 1.16.3

```bash
# libxml
cp /usr/share/aclocal/*.m4 /usr/local/share/aclocal/ # possibly undefined macro: m4_ifdef
./autogen.sh
./configure # ./configure --prefix=/usr # 将覆盖系统原本的 libxml2
make
make check
make install
```

> /usr/lib64/libxml2.so: fcntl64: symbol not found

- libz. zlib https://www.zlib.net/

```bash
tar xvf zlib-1.3.tar.gz
cd zlib-1.3
./configure --prefix=/usr
make
make install
```



- glibc https://www.gnu.org/software/libc/

```bash
# glibc
tar xf glibc-x.x.x.tar.gz
cd glibc-x.x.x/
mkdir build-glibc
cd build-glibc
../configure --prefix=/usr/local/glibc
make
sudo make install
sudo /usr/local/glibc/bin/ldconfig # 配置动态链接器
```

###### meson setup result

```bash
mesa 24.1.0-devel

  Directories
    prefix                       : /usr/local
    libdir                       : lib64
    includedir                   : include

  Common C and C++ arguments
    c_cpp_args                   :

  OpenGL
    OpenGL                       : YES
    ES1                          : YES
    ES2                          : YES
    Shared glapi                 : YES
    GLVND                        : NO

  DRI
    Platform                     : drm
    Driver dir                   : /usr/local/lib64/dri

  GLX
    Enabled                      : YES
    Provider                     : dri

  EGL
    Enabled                      : YES
    Drivers                      : builtin:egl_dri2 builtin:egl_dri3
    Platforms                    : x11 wayland surfaceless drm xcb

  GBM
    Enabled                      : YES
    Backends path                : /usr/local/lib64/gbm

  Vulkan
    Drivers                      : amd
    Platforms                    : x11 wayland surfaceless drm xcb
    ICD dir                      : share/vulkan/icd.d
    Intel Ray tracing            : NO

  Video
    Codecs                       : av1dec av1enc vp9dec
    APIs                         : vdpau va vulkan

  LLVM
    Enabled                      : YES
    Version                      : 15.0.7

  Gallium
    Enabled                      : YES
    Drivers                      : radeonsi
    Platforms                    : x11 wayland surfaceless drm xcb
    Frontends                    : mesa vdpau va
    Off-screen rendering (OSMesa): NO
    HUD lm-sensors               : NO

  Perfetto
    Enabled                      : NO

  Subprojects
    wayland-protocols            : YES

  User defined options
    buildtype                    : debug
    dri3                         : enabled
    egl                          : enabled
    gallium-drivers              : radeonsi
    gbm                          : enabled
    gles1                        : enabled
    gles2                        : enabled
    llvm                         : enabled
    platforms                    : x11,wayland
    tools                        : all
    vulkan-drivers               : amd
```



