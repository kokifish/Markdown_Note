[TOC]





---

# Intel Pin

- 由Intel公司开发、维护的功能强大的动态二进制插桩平台
- Pin将平台的内部开发与外部开发相分离
  Intel内部人员进行Pin本身框架的开发
  同时提供API供外部人员开发插件
  Pin平台的插件统一称为Pintool
  Pin平台有异常丰富的API供Pintool调用
  提供了100多个Pintool实例演示Pin API的使用
  通过调用API完成诸如空间寻址、CPU二级缓存命中分析、内存追踪、性能分析、并行计算分析等功能
- [Pin](http://software.intel.com/en-us/articles/pin-a-dynamic-binary-instrumentation-tool): a C++ dynamic binary instrumentation framework (without IR) written by Intel.
- The best way to think about Pin is as a **"just in time" (JIT) compiler**. The input to this compiler is not bytecode, however, but a regular executable.



- Pin是在操作系统上运行的，因此只能捕获用户层代码进行分析，无法分析操作系统内核代码
- Pin是核心部分，负责对该二进制程序进行即时编译和插桩
- Pintool包含插桩程序和分析程序，并在库连接之后与Pin进行交互
- Pin和Pintool是共享一样的地址空间，但是不共享任何一个库

## Pin插桩模式

目前插桩方法分为两种：

1. 源码插桩：对程序源代码进行插桩分析

2. 二进制插桩：直接对二进制程序进行插桩分析

相比于源码插桩，二进制插桩的优势在于：语言独立性；计算机层次的角度；可对闭源软件进行插桩。

其中，二进制插桩又分为两种：

1. 静态二进制插桩：程序运行前插桩
2. 动态二进制插桩：程序运行时插桩

相比于静态二进制插桩，动态二进制插桩的优势在于：不需要重新编译和链接；在运行时发现代码；能处理动态生成的代码；可连接到正在运行的进程。由此看出，动态二进制插桩是当前研究与发展的主流趋势，而Pin采用的就是动态二进制插桩。
Pin的插桩模式分为JIT（Just In Time）模式和Probe模式。这两个模式各有优缺点

### JIT模式

1. Pin会将二进制程序编译成顺序执行的指令序列——Trace序列，且执行路径必须与该二进制程序相符合
2. 该二进制程序的原始代码不会被执行。JIT模式灵活性大，有很多API可用，因此是Pin默认的插桩模式。但其缺点是系统开销大，耗时长



### Probe模式

1. Pin可以直接修改二进制程序的原始指令，但仅限于函数调用
2. 通过往插桩代码中插入Jump指令实现。Probe模式系统开销小，耗时短，但其缺点是缺乏灵活性，少数API可用。因其涉及到对原始指令的直接修改，所以还需要插件开发人员具有高超技术和经验，否则会导致Pin和二进制程序崩溃。



## Intel Pin的插件Pintool

Pintool是基于Pin平台开发的插件。其可以在监控的二进制程序的任意位置插入任意使用C或C++编写的代码，完成开发人员对二进制程序进行特定分析的需求

当使用Pin来获取二进制程序运行时相关信息时，都需要以来插件Pintool。一般有两种方法：

1. 运行二进制程序并对其插桩`pin -t pintool -application`
2. 直接链接到正在运行的进程，并对其插桩 `pin -pid 123 -t pintool`

```cmd
pin -t obj-intel64/MyPinTool.so -- nginx -c ~/nginx.conf # 运行二进制程序(cmd:nginx -c ~/nginx.conf)并使用obj-intel64/MyPinTool.so对其插桩
pin -pid 123 -t obj-intel64/MyPinTool.so # 对进程id为123的进程使用obj-intel64/MyPinTool.so对其插桩
```









### Simple Taint a Memory Area



the **LOAD** / **STORE** instruction. e.g. Load: **mov rax, [rbx]**. Store: **mov [rbx], rax**.

```cpp
// 回调函数 callback function 原型
// 供 PIN_AddSyscallEntryFunction 调用
typedef VOID(* LEVEL_PINCLIENT::SYSCALL_ENTRY_CALLBACK)(
    THREADID threadIndex, // 线程id
	CONTEXT *ctxt, 
	SYSCALL_STANDARD std, 
	VOID *v);

// 供 PIN_AddSyscallExitFunction 调用
typedef VOID(* LEVEL_PINCLIENT::SYSCALL_EXIT_CALLBACK)
    (THREADID threadIndex, // 线程id
	CONTEXT *ctxt,  // 
	SYSCALL_STANDARD std, 
	VOID *v);

VOID LEVEL_PINCLIENT::PIN_AddSyscallEntryFunction(SYSCALL_ENTRY_CALLBACK fun, VOID *val);
VOID LEVEL_PINCLIENT::PIN_AddSyscallExitFunction(SYSCALL_EXIT_CALLBACK fun, VOID *val);
```





```cpp
VOID LEVEL_PINCLIENT::INS_InsertCall (INS ins,
IPOINT action,
AFUNPTR funptr,
    ...
)//Insert a call to funptr relative to instruction ins.
```

Insert a call to funptr relative to instruction ins.

- **Parameters:**

  insInstruction to instrumentactionSpecifies before, after, etc.  IPOINT_BEFORE is always valid for all instructions.  IPOINT_AFTER is valid only when a fall-through exists (i.e. Calls and unconditional branches will fail). It is only allowed when INS_IsValidForIpointAfter(ins) is true.  IPOINT_TAKEN_BRANCH is invalid for non-branches. It is only allowed when INS_IsValidForIpointTakenBranch is true.funptrInsert a call to funptr...List of arguments to pass funptr. See [IARG_TYPE](https://software.intel.com/sites/landingpage/pintool/docs/97971/Pin/html/group__INST__ARGS.html#ga089c27ca15e9ff139dd3a3f8a6f8451d), terminated with IARG_END

If more than one call is inserted for the same instruction, the order is determined by [IARG_CALL_ORDER](https://software.intel.com/sites/landingpage/pintool/docs/97971/Pin/html/group__INST__ARGS.html#gga089c27ca15e9ff139dd3a3f8a6f8451da45b6bfd69845ada4a0875967995ad7c6). For more information, see [CALL_ORDER](https://software.intel.com/sites/landingpage/pintool/docs/97971/Pin/html/group__INST__ARGS.html#ga3d1d5f6805cb16d00bce441290ca2212).

- **Availability:**

  **Mode:** JIT **O/S**: Linux, Windows & macOS* **CPU:** All

```cpp
void syscallEntryCallback(THREADID threadIndex,
                          CONTEXT* ctxt,
                          SYSCALL_STANDARD std,
                          void* v) {
    ADDRINT scnum = PIN_GetSyscallNumber(ctxt, std);
    if(scnum == __NR_read){
        fprintf(stdout, "[DEBUG] __NR_read %u\n\n", scnum);
    }
    else if (scnum == __NR_write) {
        fprintf(stdout, "[DEBUG] __NR_write %u\n\n", scnum);
    } 
    else if (scnum == __NR_open) {
        fprintf(stdout, "[DEBUG] __NR_open %u\n\n", scnum);
    }
    else if (scnum == __NR_close) {
        fprintf(stdout, "[DEBUG] __NR_close %u\n\n", scnum);
    }
    else if (scnum == __NR_sendfile) {
        fprintf(stdout, "[DEBUG] __NR_sendfile %u\n\n", scnum);
    }
    else if (scnum == __NR_socket) {
        fprintf(stdout, "[DEBUG] __NR_socket %u\n\n", scnum);
    }
    else if (scnum == __NR_connect) {
        fprintf(stdout, "[DEBUG] __NR_connect %u\n\n", scnum);
    }
    else if (scnum == __NR_accept) {
        fprintf(stdout, "[DEBUG] __NR_accept %u\n\n", scnum);
    }
    else if (scnum == __NR_recvfrom) {
        fprintf(stdout, "[DEBUG] __NR_recvfrom %u\n\n", scnum);
    }
    else if (scnum == __NR_sendmsg) {
        fprintf(stdout, "[DEBUG] __NR_sendmsg %u\n\n", scnum);
    }
    else if (scnum == __NR_recvmsg) {
        fprintf(stdout, "[DEBUG] __NR_recvmsg %u\n\n", scnum);
    }
    else{
		fprintf(stdout, "[DEBUG] NOT DEFINE \n\n");
    }
}
```





```cpp
objdump --syms /usr/bin/evolution
```



# API



```cpp

PIN_CALLBACK LEVEL_PINCLIENT::INS_AddInstrumentFunction(INS_INSTRUMENT_CALLBACK  fun,  VOID * val)
```



