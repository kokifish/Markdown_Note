# Android



## Kotlin

静态类型

main为入口点

默认情况下，如果不指定函数的返回值类型，默认返回值类型是 `Unit`。`Unit` 表示函数并不会返回值。`Unit` 相当于其他语言中的 void 返回值类型（在 Java 和 C 中为 `void`；在 Python 中为 `None` 等）。任何不返回值的函数都会隐式返回 `Unit`

```kotlin
// 变量和常量：Kotlin 中使用 var 关键字声明变量，使用 val 关键字声明常量
var a = 1  // 变量
val b = 2  // 常量
// 类型推断：支持类型推断，不需要显式指定变量的类型，编译器可以自动推断出来。显式指定类型:
var a: Int = 1
val b: String = "Hello"
// 函数：Kotlin 中的函数使用 fun 关键字定义
fun sum(a: Int, b: Int): Int {
    println("$a and $b")
    return a + b
}
// 控制流：Kotlin 的控制流语法（如 if、when、for、while）与 C++ 类似，但更加强大。e.g. when 语句可以替代 C++ 中的 switch 语句
when (x) {
    1 -> print("x == 1")
    2 -> print("x == 2")
    else -> print("x is neither 1 nor 2")
}
// 空安全：Kotlin 设计了一套完善的空安全机制，可以避免空指针异常。在类型后面加上 ? 表示该类型的变量可以为 null：
var a: String? = null
// 类和对象：Kotlin 中的类和对象的概念与 C++ 类似，但语法更加简洁。e.g. 定义一个类：
class Person(val name: String, var age: Int)
// 扩展函数：Kotlin 支持扩展函数，你可以为已有的类添加新的方法，而不需要修改原来的类：
fun String.lastChar(): Char = this[this.length - 1] // 为已有的 String 类添加新的 lastChar 方法
// Lambda 表达式：支持 Lambda 表达式和高阶函数，更加简洁和灵活：
val sum = { x: Int, y: Int -> x + y }
```



## Android App Develop

- `onCreate()`是安卓app的入口点，相当于kotlin的main
- `@Composable`: 告诉kotlin编译器，Jetpack Compose使用此函数来生成UI 。标有 `@Composable` 注释的函数可以被 `setContent()` 或其他Composable functions调用。`@Composable`函数无返回值
- `Surface`: a Composable that has a background color and can contain other Composables
- `setContent()`: a function that is used to define a layout in your app using Composable functions.



## System Services



### SuefaceFlinger



### IMS: Input Method Service

> https://wizzie.top/android/android_ime_StartShowHide_Tips 很全面，有调试命令行方法
>
> https://blog.csdn.net/Android_machong/article/details/132758063 比较简略的修改系统默认输入法的方法（a12-gsi不适用）





## Signature Spoofing

Signature Spoofing（签名欺骗）是一种安卓系统中的安全漏洞，它允许恶意应用伪造另一个应用的签名，从而绕过系统对应用签名的验证。在安卓系统中，应用签名用于确保应用的完整性和来源，以防止恶意篡改和冒充。当一个应用试图访问另一个应用的数据或使用其特定功能时，系统会检查两者的签名是否匹配。如果签名匹配，系统会允许访问；否则，访问将被拒绝。通过利用 Signature Spoofing 漏洞，恶意应用可以伪造其他应用的签名，从而绕过这种安全检查。

以下是一些 Signature Spoofing 的例子：

1. 恶意应用伪造 Google Play 服务的签名，以便访问其他应用使用 Google Play 服务的数据。这可能导致用户数据泄露或被篡改。
2. 恶意应用伪造支付应用的签名，以便在不被用户察觉的情况下执行支付操作。这可能导致用户财产损失。
3. 恶意应用伪造系统应用的签名，以便获取系统级别的权限。这可能导致设备被完全控制。

实现 Signature Spoofing 的方式有以下几种：

1. 修改系统源代码：在安卓系统源代码中，修改 PackageManagerService 或其他相关组件，使其在验证签名时返回伪造的签名。这种方法需要重新编译和安装定制的安卓系统。
2. 使用 Xposed 框架：Xposed 是一个用于安卓系统的强大框架，允许用户在运行时修改系统和应用的行为。通过编写一个 Xposed 模块，可以在运行时修改系统的签名验证逻辑，实现 Signature Spoofing。
3. 使用 Magisk 模块：Magisk 是一个用于安卓系统的根管理和模块化框架。通过编写一个 Magisk 模块，可以在系统启动时修改系统组件，实现 Signature Spoofing。

需要注意的是，Signature Spoofing 是一种安全漏洞，利用它可能导致安全风险。在实际应用中，应尽量避免使用这种技术，或者在充分了解风险的情况下谨慎使用。



#  Android Kernel

> https://linux-kernel-labs.github.io/refs/heads/master/labs/kernel_modules.html Kernel modules
>
> https://source.android.com/docs/core/architecture/kernel/android-common Android Common Kernel (Compatibility Matrix Included)
>
> common/Documentation/arm64/memory.rst
>
> https://blog.csdn.net/dog250/article/details/112058189. trace points CREATE_TRACE_POINTS



## eBPF

> https://ebpf.io/what-is-ebpf/



## Update abi xml

> `common/android/abi_gki_aarch64.xml`

```bash
BUILD_CONFIG=common-modules/virtual-device/build.config.goldfish.aarch64  ABI_DEFINITION=android/abi_gki_aarch64.xml  build/build_abi.sh # 会生成 out_abi/android11-5.4/dist/abi.report abi.report.short
# 解决 ERROR: modpost: "_mcount" [***.ko] undefined!
common/android/abi_gki_aarch64.xml add: # crc 不影响编译，可用前面生成的 abi.report 查看到 # 猜测被export的符号才会进入 abi*.xml
      <elf-symbol name='_mcount' type='func-type' binding='global-binding' visibility='default-visibility' is-defined='yes' crc='0x1fdc7df2'/>
common/android/abi_gki_aarch64_goldfish add:
+   _mcount


```

会导致 abi.report.short 出现func/var符号的原因：

- kernel config: 例如debug fs配置
- 



## pstore & ramoops



- PSTORE_FLAGS_PMSG: 用户空间信息
- PSTORE_FLAGS_FTRACE: 函数调用序列
- PSTORE_FLAGS_CONSOLE: 控制台输出
- PSTORE_FLAGS_DMESG: 内核日志

> ```bash
> # cause a kernel panic with a single command line
> echo c > /proc/sysrq-trigger
> ```

```assembly
common/fs/pstore# tree
.
|-- Kconfig
|-- Makefile
|-- ftrace.c    # CONFIG_PSTORE_FTRACE
|-- inode.c     # 文件系统核心操作 # allpstore: 记录 pstore_private pstore_record 的链表头
|-- internal.h  # 接口声明
|-- platform.c  # 驱动接口层，记录pstore后端与文件系统的中间层
|-- pmsg.c      # PSTORE_FLAGS_PMSG
|-- ram.c       # CONFIG_PSTORE_RAM: ramoops的配置、实现、加载。为pstore提供底层存储接口
`-- ram_core.c  # persistent_ram_zone 环形缓冲区的实现

common/include/linux/pstore_ram.h
```

```bash
# 注册 ramoops driver
ramoops_driver.probe=ramoops_probe(platform_device)  # ram.c
    > pstore_register(pstore_info)  # platform.c
        > pstore_register_kmsg
        > pstore_register_console
        > pstore_register_ftrace
        > pstore_register_pmsg

static struct ramoops_context oops_cxt # 初始化pstore后端 pstore_info pstore 的orw函数指针等

# create pstore file
pstore_get_backend_records # 对psi中的每一个记录，在 /sys/fs/pstore/* 创建对应的文件
    > pstore_record_init(record, psi) # 从psi读取需要dump的记录
    > pstore_mkfile # inode.c # 创建inode

##### 4 front end

# dump dmesg
pstore_dump # callback from kmsg_dump # pstore_register_kmsg: 注册到kmsg的dumper list里 
    > pstore_record_init(&record, psinfo) # 后指定 record.type = PSTORE_TYPE_DMESG
    > kmsg_dump_get_buffer # 从kmsg buf中copy内容到psinfo->buf
    > psinfo->write(&record); # 将record.buf copy到psinfo->buf

# dump console
pstore_console_write # 作为pstore_console的console.write成员
    > psinfo->write(&record); # 将record.buf copy到psinfo->buf
    
# dump kmsg
copy_kmsg_to_buffer
```

```cpp
struct pstore_record {
	struct pstore_info	*psi; // pstore backend driver information
	enum pstore_type_id	type; // pstore record type
	u64			id;
	struct timespec64	time;
	char			*buf;           // pointer to record contents
	ssize_t			size;         // size of char* buf
	ssize_t			ecc_notice_size;

	int			count;            // Oops count since boot
	enum kmsg_dump_reason	reason;
	unsigned int		part;
	bool			compressed;
};
```



# Linux Graphics



在Linux上显示东西可以选择的方法，由不同子系统提供：

- FBDEV: Framebuffer Device
- DRM/KMS: Direct Rendering Manager / Kernel Mode Setting
- V4L2: Video For Linux 2



## DRM, DRI

Linux DRM 层包含旨在支持复杂图形设备需求的代码，通常包含非常适合 3D 图形加速的可编程流水线。内核中的图形驱动程序可以使用 DRM 函数来简化内存管理、中断处理和 DMA 等任务，并为应用程序提供统一的接口。

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/Render/OpenGL_LinuxGraphicStack.webp)

> https://blog.mecheye.net/2012/06/the-linux-graphics-stack/ DRM Mesa及相关名词串讲
>
> https://studiopixl.com/2017-05-13/linux-graphic-stack-an-overview 年代更新(2017.5)
>
> https://bootlin.com/doc/training/graphics/graphics-slides.pdf Bootlin(2022) 从十分基础的绘制原理、图形接口、MESA调试变量GPU驱动，很全

**DRM**: Direct Rendering Manager

**KMS**: Kernel Mode Setting,  a sub-part of the DRM API

**DRM Framebuffer**: virtual object, 其实现取决于使用的 memory manager (GEM or TTM)

**Framebuffer**: a buffer in memory, designed to store pixels

**CRTC**: CRT Controller, though it’s not only related to CRT displays.  Implemented through struct `drm_crtc_funcs` and struct `drm_crtc_helper_funcs`

**gallium**: 一个让驱动实现更简单的组件。原理：状态跟踪器(实现某种API的，如OpenGL, GLSL, Direct3D)将状态转换为一种中间表示([Tungsten Graphics Shader Infrastructure, or TGSI](http://people.freedesktop.org/~csimpson/gallium-docs/tgsi.html))，后端采用中间表示并将其转换为硬件使用的形式。

**Mesa**: OpenGL, GLES等的开源实现库，包含几种基于CPU的实现，swrast (outdated and old, do not use it), softpipe (slow), llvmpipe (potentially fast). 基于gallium支持 radeon 和 nouveau 驱动

**EGL**: Khronos 开发的一种新的平台无关 API，提供在平台上启动和运行 OpenGL 的设施。EGL 由供应商实现；是 WGL/GLX 等绑定程序的替代品，而不仅仅是它们之上的一个库(e.g. GLUT)

**DIX、DDX**: The X graphics parts of Xorg is made up of two major parts, `DIX`, the “Driver Independent X” subsystem, and `DDX`, the “Driver Dependent X” subsystem. 当我们谈论 Xorg 驱动程序时，更准确的说法是 DDX 驱动程序

![](https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Linux_kernel_and_OpenGL_video_games.svg/1600px-Linux_kernel_and_OpenGL_video_games.svg.png)

Two types of DRM devices exist: 

- Primary nodes at /dev/dri/card* with minor < 128 Used for display operations with the KMS (mode) interface 
- Render nodes at /dev/dri/renderD* with minor ≥ 128 Used for render operations with a driver-specific interface

Debug message using the `drm.debug` kernel cmdline argument: 

- Detailed in the include/drm/drm_print.h header 
- `drm.debug=0x17` for core, KMS, driver and atomic debug messages



### DRM Internals

> https://www.kernel.org/doc/html/latest/gpu/drm-internals.html#drm-internals

#### Driver Initialization

初始化 [`struct drm_driver`](https://www.kernel.org/doc/html/latest/gpu/drm-internals.html#c.drm_driver), 传递给 [`drm_dev_alloc()`](https://www.kernel.org/doc/html/latest/gpu/drm-internals.html#c.drm_dev_alloc) 分配设备实例，然后使用 [`drm_dev_register()`](https://www.kernel.org/doc/html/latest/gpu/drm-internals.html#c.drm_dev_register) 进行注册，使其可以从用户空间使用。struct `drm_driver` 包含描述驱动程序及features的静态信息，以及指向 DRM core 实现 DRM API 的方法的指针。

#### Module Initialization

```cpp
struct pci_driver my_pci_drv = {
};
drm_module_pci_driver(my_pci_drv);
```

对于更复杂的模块初始化，仍可在驱动程序中使用 `module_init()` 和 `module_exit()`



### DRM Memory Management

#### The Translation Table Manager (TTM)





#### The Graphics Execution Manager (GEM)



