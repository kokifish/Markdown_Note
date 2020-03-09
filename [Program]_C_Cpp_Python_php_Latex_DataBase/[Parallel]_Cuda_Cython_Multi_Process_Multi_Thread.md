[TOC]





---

# OpenMP

> **Open Multi-Processing**

- an application programming interface (API) that supports multi-platform shared memory multiprocessing programming in C, C++, and Fortran
- OpenMP is an implementation of multithreading, a method of parallelizing whereby a master thread (a series of instructions executed consecutively) forks a specified number of slave threads and the system divides a task among them. The threads then run concurrently, with the runtime environment allocating threads to different processors.

- **多线程**编程API
    - 编译器指令```#pragma``` 、库函数、环境变量
    - 极大地简化了C/C++/Fortran多线程编程
    - 并不是全自动并行编程语言：其并行行为仍需由用户定义及控制
- 支持**共享内存**的多和系统

> 
>
> 32 OpenMP traps for C++ developers:  <https://software.intel.com/en-us/articles/32-openmp-traps-for-c-developers>

## pragma & Quick Find

- 编译器如果不支持相应指令则将直接忽略
- 当```#pragma```指令无法为编译器理解时，**不会报错**

```cpp
#pragma GCC poison printf //编译屏蔽不安全函数printf
#pragma warning (disable : 4996)
//omp预编译指令模板
#pragma omp construct [clause [clause]...]{structured block}
#pragma omp parallel //指明并行区域
#pragma omp (parallel) for //其作用范围通常为一个代码区块
omp_set_nested(1) //允许嵌套
omp_get_thread_num(); //获取线程号
num_threads(int); //设置默认线程数
#pragma omp critical/atomic/barrier、nowait //同步
//变量作用域
default(none/shared/private)
shared()
private()
firstprivate()
lastprivate()
//调度
schedule(static/dynamic/guided, [chunk_size])
```



### 环境配置

Windows VS Studio

项目属性 -> C/C++ -> Language -> Open MP Support

macOS/Linux:

对于支持OpenMP的编译器: gcc: 在编译时增加-fopenmp 标记

```cpp
#include <omp.h> //使用库函数
```

##### 查看OpenMP版本

```cpp
#include <unordered_map>
#include <string>
#include <cstdio>
#include <omp.h>
int main(int argc, char *argv[]) {
    std::unordered_map<unsigned,std::string> map{
    {200505, "2.5"}, {200805, "3.0"}, {201107, "3.1"},
    {201307, "4.0"}, {201511, "4.5"}};
    printf("OpenMP version: %s.\n", map.at(_OPENMP).c_str());
}
//g++ -fopenmp openmp.cpp -o openmp_example
```





### OpenMP运行机制



使用分叉fork与交汇join模型

- fork: 由主线程master thread 创建一组从线程slave threads
    - 主线程编号永远为0; thread 0
    - 不保证执行顺序
- join: 同步终止所有线程并将控制权转移回主线程

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_master_slave.png>)

## OpenMP语法

```cpp
#pragma omp construct [clause [clause]...]{structured block}
```

- 指明并行区域及并行方式
- clause子句: 指明详细的并行参数
    - 控制变量在线程间的作用域
    - 显式指明线程数目
    - 条件并行

```cpp
#pragma omp parallel num_threads(16)
```

num_threads(int)

- 用于指明线程数目
- 当没有指明时，将默认使用OMP_NUM_THREADS环境变量，其值为系统运算核心数目（或超线程数目）
    - 可以使用omp_set_num_threads(int)修改全局默认线程数
    - 可使用omp_get_num_threads()获取当前设定的默认线程数
    - num_threads(int)优先级高于环境变量
- num_threads(int)不保证创建指定数目的线程
    - 系统资源限制



### 并行for循环

```cpp
//风格1: 在并行区域内加入#pragma omp for
//在并行区域内，for循环外还可以加入其他并行代码
#pragma omp parallel
{
	int n;
	#pragma omp for
	for (n = 0; n < 4; n++) {
		int thread = omp_get_thread_num();
		printf("thread %d \n", thread);
	}
}//Possible output: thread 0 thread 3 thread 1 thread 2
```

```cpp
//风格2: 合并为#pragma omp parallel for //写法更简洁
int n;
#pragma omp parallel for
for (n = 0; n < 4; n++) {
	int thread = omp_get_thread_num();
	printf("thread %d \n", thread);
}
```



#### 嵌套并行

OpenMP中的每个线程同样可以被并行化为一组线程

OpenMP默认关闭嵌套，需要使用omp_set_nested(1) 打开

```cpp
omp_set_nested(1);
#pragma omp parallel for
for (int i = 0; i < 2; i++){
    int outer_thread = omp_get_thread_num();
    #pragma omp parallel for
    for (int j = 0; j < 4; j++){
        int inner_thread = omp_get_thread_num();
        printf("Hello World (i = %d j = %d)\n", outer_thread, inner_thread);
    }
}
```

![](<https://github.com/pureteap/pictures/blob/master/Code_pic/Multi_Core_fork_join_nested.png>)



#### 不能并行的循环

- 不能使用!=作为判断条件
- 循环必须为单入口单出口
    - 不能使用break、goto等跳转语句
- 数据依赖性
    - 循环迭代相关 loop-carried dependence: 依赖性与循环相关，去除循环则依赖性不存在
    - 肺循环迭代相关 loop-independent dependence: 依赖性与循环无关，去除循环依赖性仍然存在

```cpp
for (i = 1; i < n; i++){
    a[i] = a[i - 1] + 1;//循环相关
    b[i] = a[i];//循环无关
}
for (i = 1; i < n; i++)
    for (j = 1; j < n; j++)
		a[i][j] = a[i][j - 1] + 1;//i循环无关，j循环有关
for (i = 1; i < n; i++)
	for (j = 1; j < n; j++)
		a[i][j] = a[i - 1][j] + 1;//i循环相关，j循环无关
```



## 同步机制

OpenMP是多线程共享地址架构：线程可通过共享变量通信

线程及其语句执行具有不确定性：

- 共享数据可能造成竞争条件race condition
- 竞争条件：程序运行的结果依赖于不可控的执行顺序

必须使用同步机制避免竞争条件的出现：

- 同步机制将带来巨大开销
- 尽可能改变数据的访问方式减少必须的同步次数



### 临界区 critical section

```#pragma omp critical```

- 指的是一个访问公共资源的程序片段，而这些公共资源又无法同时被多个线程访问的特性
- 同一时间内只有一个线程能执行临界区代码
- 其他线程必须等待临界区内线程执行完毕后才能进入临界区
- 常用来保证对共享数据的访问之间互斥

### 原子操作 atomic

```#pragma omp atomic```

- 保证下一语句在同一时间只能被一个线程执行。常用来做计数器、求和等
- 原子操作通常比临界区执行更快
- 临界区的作用范围更广，能够实现的功能更复杂

```cpp
#pragma omp parallel for
for(int i=0; i<1000; ++i){
    int value = rand()%20;
    #pragma omp atomic //下一语句同一时间只能被一个线程执行
    histogram[value]++;
}
```



### 栅障 barrier

```#pragma omp barrier```

- 在栅障点处同步所有线程
- 先运行至栅障点处的线程必须等待其他线程
- 常用来等待某部分任务完成再开始下一部分任务
- 每个并行区域的结束点默认自动同步线程

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_omp_barrier.png>)



### single & master

```#pragma omp single {}```

- 用于保证{}内的代码有一个线程完成
- 常用于输入输出或初始化
- 由第一个执行至此的线程执行
- 同样会产生一个隐式栅障。可由#pragma omp single nowait 去除

```#pragma omp master {}```

- 与single相似，但指明由主线程执行
- 与使用IF的条件并行等价
- 默认不产生隐式栅障

```cpp
#pragma omp master {} //等价于↓
#pragma omp parallel IF(omp_get_thread_num() == 0) nowait
```



### 并行Reduction

指明如何将线程局部结果汇总

```cpp
#pragma omp for reduction(+: total) //e.g.
```

- 支持的操作：```+, -, *, & , |, && and ||```

```cpp
int total = 0;
#pragma omp parallel num_threads(20)
{
    for(int i=0; i<50; ++i){
        int value = rand()%20;
        #pragma omp atomic //原子操作
        histogram[value]++;
    } 
    #pragma omp barrier //栅障
    int thread = omp_get_thread_num();
    #pragma omp atomic //原子操作
    total += histogram[thread];
}
```

- 上下两个例子等价


```cpp
int total = 0;
#pragma omp parallel
{
    #pragma omp for
    for(int i=0; i<1000; ++i){
        int value = rand()%20;
        #pragma omp atomic //原子操作
        histogram[value]++;
    }
    #pragma omp for reduction(+: total) //reduction
    for(int i=0; i<20; ++i){
    	total += histogram[i];
    }
}
```





## 变量作用域

OpenMP与串行程序的作用域不同

OpenMP中必须指明变量为shared或private

- shared：变量为所有线程所共享
    - 并行区域外定义的变量默认为shared
- private：变量为线程私有，其他线程无法访问
    - 并行区域内定义的变量默认为jprivate
    - 循环计数器默认为private

```cpp
int histogram[20]; //shared
init_histogram(histogram);
int total = 0; //shared
#pragma omp parallel
{
    int i; //循环计数器为private
    #pragma omp for
    for(i=0; i<1000; ++i){
        int value = rand()%20;//private
        #pragma omp atomic
        histogram[value]++;
    }
}
```



### 显示作用域定义

```shared(var)```

- 指明变量var为shared

```default(none/shared/private)```

- 指明变量的默认作用域
- 如果为none则必须指明并行区域内每一变量的作用域

```private(var)``` 指明变量var为private

```cpp
int i = 10;
#pragma omp parallel for private(i)//显式指明变量i为private
for (int j=0; j<4; ++j) {
	printf("Thread %d: i = %d\n", omp_get_thread_num(), i);
}
printf("i = %d\n", i);
```

```firstprivate(var)``` 指明变量var为private，同时表明该变量使用master thread中变量值初始化

```lastprivate(var)``` 指明变量var为private，同时表明结束后一层迭代将结果赋予该变量



## 数据并行 & 任务并行

数据并行：

- 数据并行：同样指令作用在不同数据上
- 前述例子均为数据并行

任务并行：

- 线程可能执行不同任务
- ```#pragma omp sections```
- 每个section由一个线程完成
- 同样有隐式栅障，可使用nowait去除





## Demo

```cpp
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

void transpose(double* A, double* B, int n)
{
    int i, j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            B[j * n + i] = A[i * n + j];
        }
    }
}

void gemm(double* A, double* B, double* C, int n)
{
    int i, j, k;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            double dot = 0;
            for (k = 0; k < n; k++) {
                dot += A[i * n + k] * B[k * n + j];
            }
            C[i * n + j] = dot;
        }
    }
}

void gemm_omp(double* A, double* B, double* C, int n)
{
	#pragma omp parallel
    {
        int i, j, k;
		#pragma omp for
        for (i = 0; i < n; i++) {
            for (j = 0; j < n; j++) {
                double dot = 0;
                for (k = 0; k < n; k++) {
                    dot += A[i * n + k] * B[k * n + j];
                }
                C[i * n + j] = dot;
            }
        }
    }
}

void gemmT(double* A, double* B, double* C, int n)
{
    int i, j, k;
    double* B2;
    B2 = (double*)malloc(sizeof(double) * n * n);
    transpose(B, B2, n);
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            double dot = 0;
            for (k = 0; k < n; k++) {
                dot += A[i * n + k] * B2[j * n + k];
            }
            C[i * n + j] = dot;
        }
    }
    free(B2);
}

void gemmT_omp(double* A, double* B, double* C, int n)
{
    double* B2;
    B2 = (double*)malloc(sizeof(double) * n * n);
    transpose(B, B2, n);
	#pragma omp parallel
    {
        int i, j, k;
		#pragma omp for
        for (i = 0; i < n; i++) {
            for (j = 0; j < n; j++) {
                double dot = 0;
                for (k = 0; k < n; k++) {
                    dot += A[i * n + k] * B2[j * n + k];
                }
                C[i * n + j] = dot;
            }
        }
    }
    free(B2);
}

int main()
{
    int i, n;
    double *A, *B, *C, dtime;

    n = 512;
    A = (double*)malloc(sizeof(double) * n * n);
    B = (double*)malloc(sizeof(double) * n * n);
    C = (double*)malloc(sizeof(double) * n * n);
    for (i = 0; i < n * n; i++) {
        A[i] = rand() / RAND_MAX;
        B[i] = rand() / RAND_MAX;
    }

    dtime = omp_get_wtime();
    gemm(A, B, C, n);
    dtime = omp_get_wtime() - dtime;
    printf("%f\n", dtime);

    dtime = omp_get_wtime();
    gemm_omp(A, B, C, n);
    dtime = omp_get_wtime() - dtime;
    printf("%f\n", dtime);

    dtime = omp_get_wtime();
    gemmT(A, B, C, n);
    dtime = omp_get_wtime() - dtime;
    printf("%f\n", dtime);

    dtime = omp_get_wtime();
    gemmT_omp(A, B, C, n);
    dtime = omp_get_wtime() - dtime;
    printf("%f\n", dtime);

    return 0;
}
```



---

# CUDA

> SM: Streaming Multiprocessor 流处理器组
>
> SP: Stream Processor 流处理器

串行速度提升已经结束

- 无法继续提升频率
- 无法继续提升功耗

当前计算机性能提升趋势

- 计算机没有变得更快，而是变得更款：多核CPU，GPU，超级计算机
- 数据级别的并行：同样的指令作用于多个数据
- 线程界别的并行：

### Why CUDA & GPGPU

> General Purpose Computing for GPU

GPU特征：****

- 高度并行化：同样指令应用于大量数据上
- 大量运算核心

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_CPU_n_GPU.png>)



CUDA vs OpenMP vs MPI

CUDA
- 创建线程开销低
- 可创建大量线程
- 同一warp内共享指令
- 控制流简单

OpenMP
- 创建线程开销高
- 线程数目有限
- 线程互相间可以完全独立
- 控制流复杂

MPI

- 进程互相间可以完全独立
- 通信成本高
- 价格昂贵

##### CUDA vs OpenCL

- OpenCL: 跨平台的开放标准
- 生态环境：
    - CUDA: 用户友好、应用广泛。目前NVIDIA投入更大
    - OpenCL: 使用稍显复杂、目前应用范围较窄
- 支持硬件：
    - CUDA: NVIDIA显卡。硬件针对性更强、效率更高、对学习多核编程更有利
    - OpenCL: AMD、NVIDIA、Intel、ARM等硬件。支持硬件更多，效率因硬件而异、优化因硬件而异

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_Amdaho's_Law.png>)

```cpp
//运行CUDA Samples: deviceQuery
C:\ProgramData\NVIDIA Corporation\CUDA Samples\v10.1\1_Utilities\deviceQuery\../../bin/win64/Debug/deviceQuery.exe Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce GTX 950M"
  CUDA Driver Version / Runtime Version          10.1 / 10.1
  CUDA Capability Major/Minor version number:    5.0
  Total amount of global memory:                 2048 MBytes (2147483648 bytes)
  ( 5) Multiprocessors, (128) CUDA Cores/MP:     640 CUDA Cores
  GPU Max Clock rate:                            1124 MHz (1.12 GHz)
  Memory Clock rate:                             1001 Mhz
  Memory Bus Width:                              128-bit
  L2 Cache Size:                                 2097152 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 4 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  CUDA Device Driver Mode (TCC or WDDM):         WDDM (Windows Display Driver Model)
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            No
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.1, CUDA Runtime Version = 10.1, NumDevs = 1
Result = PASS
```



##### CPU vs GPU

CPU:

- 大缓存：掩盖较长的存储器延迟
- 强大的运算器：降低运算延迟
- 复杂的控制机制：分支预测等
- 线程上下文切换开销大：降低一个或两个线程运行延迟

GPU:

- 小缓存：但通过更快的存储提高吞吐量
- 更节能的运算器：延迟长但吞吐量更大
- 简单的控制流机制：无分支预测
- 线程高度轻量级：大量并发

异构架构：CPU+GPU

- 利用CPU处理复杂控制流
- 利用GPU处理大规模运算
- CPU与GPU之间通过PCIe总线通信(最新显卡支持NVLink 提供5-12倍于PCIe 3.0总线带宽)



#### 计算机架构分类

- SISD: Single Instruction Single Data
    - 经典冯诺依曼架构。
    - PU：处理单元
- SIMD: Single Instruction Multiple Data
    - 多个处理单元使用同样指令处理不同数据
- MISD: Multiple Instruction Single Data
    - 流水线架构
- MIMD: Multiple Instruction Multiple Data
    - 多个处理单元使用不同指令处理不同数据
        - 处理单元之间可完全独立
        - 从2006年起，top 10的超级计算机以及top 500榜单上大多数超级计算机都采用此架构
        - OpenMP编程模型也基于此架构
    - SPMD与MPMD也属于此分类。P for Program

## NVIDIA GPU架构

> GPU -> SM -> CUDA

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_GPU_struct.png)

2级架构

- 每个GPU拥有多个**Streaming Multiprocessor(SM)**
    - 具体数目因产品而异
    - SM共用显存
- 每个SM拥有多个CUDA core
    - 数目因产品而异
    - core共用调度器和指令缓存

线程网格grid、线程块block、线程束wrap：

1. Grid: GPU(GPC) 级别的基本调度单位。共享同样的kernel和context
2. Block(Compute Thread Array, CTA): SM 级别的基本调度单位。同一CTA的线程运行在同一个SM，因此同一CTA中的不同线程可以通过共享内存通信，并共享L1缓存(只读)
3. Wrap: **ALU级别的基本调度单位**。对应一条指令流，32宽度的SIMD，占用同一块向量寄存器，线程间可以通过特殊指令交换寄存器中的数据





##### 线程束 warp

线程束以SIMD方式执行，相当于同时操作32个数据的thread。是一个包含32个线程的集合，以Lockstep(步调一致)的形式执行

- CUDA线程以32个为一组在GPU上执行
    - 线程束以**单指令多线程**的方式运行(SIMT)
    - 所有线程**在不同数据上执行相同的指令**
- SM负责调度并执行线程束
    - 线程束调度时会产生上下文切换
    - 调度方式因架构而异

#### 计算能力

> compute capability

- 不同架构的NVIDIA GPU拥有不同计算能力
- 由硬件决定，不同于CUDA版本
- 计算能力不是运算性能



## CUDA编程模型



#### Host与Device

- Host(CPU related): 运行在CPU上的代码及主机内存
- Device(GPU related): 运行在GPU上的代码及现存(设备内存)
- 通过在主机上调用核函数(kernel)执行并行代码

> 核函数是GPU每个thread上运行的程序。必须通过```__gloabl__```函数类型限定符定义

- ```__host__``` 从主机端调用，在主机端执行
- ```__global__``` 从主机端调用，在设备端执行(kernel function)
- ```__device__``` 从设备端调用，在设备端执行
- ```__host__``` 与 ```__device__```限定符可以一起使用：函数可以从主机端和设备端调用

```cpp
__global__ void hello_d(){//从主机端调用，在设备端执行 //核函数必须返回void
	printf("Hello World from GPU!");
}
__host__ void hello_h(){//从主机端调用，在主机端执行
	printf("Hello World from CPU!")
	hello_d<<<1,4>>>();//执行配置 //主机端调用
	cudaDeviceSynchronize();
}
```

> ```<<<1,4>>>```为执行配置：指明网格中有1个块，每块中有4个线程
>
> cudaDeviceSynchronize();

- 与OpenMP不同，CUDA核函数为异步执行
- 调用完成后，控制权立即返回给CPU

##### 核函数限制

核函数限制条件(```__global__```函数)

- 只能访问设备内存
- 必须返回void
- 不支持可变数量的参数
- 参数不可为引用类型
- 不支持静态变量

### 执行配置, grid and block

> GPU > grid > block > 

- 指明网格及块的维度
- 形式： ```<<< grid, block >>>```; ```<<<Dg,Db, Ns, S>>>```
- 网格与块均可为1维、2维、或3维
- grid与block为dim3类型，三个分量为x, y, z
- grid与block的大小受到计算能力的限制

一个CUDA core执行一个线程，一个SM执行一个block中的线程，GPU执行grid中的所有线程

确定线程编号：

- 使用内置变量threadIdx, blockIdx, blockDim: dim3类型，只可用于设备代码上

```cpp
__global__ void hello_d(){
	int bid = blockIdx.x;
	int tid = threadIdx.x;
	printf("Hello World from thread (%d, %d)", bid, tid);
}
__host__void hello_h(){
	hello_d<<<2,4>>>();
	cudaDeviceSynchronize();
}
```



## GPU内存模型与管理

CUDA内存模型

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_CUDA_mem_structure.png>)

每个线程：

- 寄存器 register
- 本地内存 local memory

线程块：

- **共享内存 shared memory** (GPU DRAM)

所有线程：

- 全局内存 global memory (GPU DRAM)
- 常量内存 constant memory (GPU DRAM)
- 只读/纹理内存 read-only/texture memory (GPU DRAM)

##### GPU DRAM访问模式

- 全局内存
    - 动态、静态全局内存，统一内存寻址
    - 通过二级缓存或配置共享内存
- 常量内存
    - 片上常量缓存、适合统一读取，如广播访问
    - 通过二级缓存或线程块的常量缓存
- 只读/纹理内存：
    - 片上只读缓存、适合分散读取
    - 通过二级缓存或线程块的只读缓存
- 共享内存：
    - 片上、可编程、适合分散读取，存储体冲突

> 内存选择：取决于程序对数据的访问模式

##### CUDA类型修饰符表

- 没有修饰符的变量将被置于寄存器
- 超过寄存器限制的变量将被置于本地内存，极大地降低程序效率
- 没有修饰符的数组将被置于寄存器/本地内存

| 变量声明                        | 存储器      | 作用域     | 生存周期 | Chip | Cache | 访问开销      |
| ------------------------------- | ----------- | ---------- | -------- | ---- | ----- | ------------- |
| ```int v;```                    | 寄存器      | 线程       | 线程     | 片上 | NA    | 1             |
| ```in arr_v[100];```            | 本地/寄存器 | 线程       | 线程     | 片外 | 是    | 1(L1) 200-800 |
| ```__shared__ int shared_v;```  | **共享**    | **线程块** | 线程块   | 片上 | NA    | ~1            |
| ```__device__ int global_v;```  | 全局        | 全局       | 应用程序 | 片外 | 是    | 200~800       |
| ```__constant__ int const_v;``` | **常量**    | 全局       | 应用程序 | 片外 | 是    | ~1(缓存)      |

> 片上 on-chip

- 创建: cudaMalloc
- 拷贝: cudaMemcpy
    - 使用cudaMemcpyHostToDevice, cudaMemcpyDeviceToHost指明拷贝方向
- 释放: cudaFree

```cpp
int *a_h, *b_h, *c_h; //_h常用来表明主机内存
int *a_d, *b_d, *c_d; //_d常用来表明设备内存
int n_bytes = sizeof(int)*n;
cudaMalloc((void**)&a_d, sizeof(int)*n); //创建
cudaMemcpy(a_d, a_h, n_bytes, cudaMemcpyHostToDevice);//拷贝
//... same for b and c
vector_add<<< 1, n >>>(a_d, b_d, c_d);
cudaDeviceSynchronize();
cudaMemcpy(c_h, c_d, n_bytes, cudaMemcpyDeviceToHost);
cudaFree(a_d); //释放
//... same for b and c
```



###### 处理错误

- 使用宏定义

```cpp
#define CHECK(call)
{
    const cudaError_t error = call;
    if (error != cudaSuccess){
        printf(“Error: %s:%d, ”, __FILE__, __LINE__);
        printf(“code:%d, reason: %s \n”,
        error, cudaGetErrorString(error));
        exit(1);
    }
}
```

```cpp
CHECK(cudaMalloc((void**)&a, n_bytes));
```



### 全局内存

```__device__```修饰。全局作用域，生存周期为整个应用程序。片外，需要缓存，访问开销200-800

- 动态全局内存管理：
    - cudaMalloc()
    - cudaMemcpy()
    - cudaFree()
- 静态全局内存
    - 通过```__device__```修饰符声明
    - 使用cudaMemcpyToSymbol()与cudaMemcpyFromSymbol()在主机端与设备端之间拷贝

```cpp
//静态全局内存demo
#define N 1024
__device__ int d_a[N];//空间已经分配
__global__ void kernel(){
    int tid = ...
    d_a[tid] ...
}
int main(){
    int size = sizeof(int)*N;
    int *h_a = (int*)malloc(size);
    init_data(h_a);
    cudaMemcpyToSymbol(d_a, h_a, size);//从主机端拷贝到静态全局内存
    kernel<<<...>>>();//主机端调用核函数
    cudaMemcpyFromSymbol(h_a, d_a, size);//从设备端静态全局内存拷贝到主机端
    free(h_a);
}
```



#### 动态全局内存分配

> Dynamic Global Memory Allocation and Operations

动态与静态全局内存与C中静态/动态数组的关系类似

- ```int a[N]; int *a = (int*)malloc(sizeof(int)*N);```

```cpp
//动态全局内存
int *h_a = (int*)malloc(size);//申请host端空间
init_data(h_a);
int *d_a;
cudaMalloc((void*)&d_a, size);//申请device端空间
cudaMemcpy(d_a, h_a, size, cudaMemcpyHostToDevice);//从主机端到设备端
kernel<<<...>>>(d_a);
cudaMemcpy(h_a, d_a, size, cudaMemcpyDeviceToHost);//从设备端到主机端
cudaFree(d_a);//释放device端申请了的空间
free(h_a);//释放host端申请了的空间
```



### 常量内存

> 全局，用于少量只读数据

- 存储于GPU DRAM中，与全局内存一样
- **每个SM上有专用的片上缓存**
- 在运行时设置
- 对常量内存的单次读操作可以**广播**到其他的“邻近(nearby)”线程，这将节约15次读取操作；
- 高速缓存。常量内存的数据将缓存起来，因此对于相同地址的连续操作将不会产生额外的内存通信量。常量缓存中读取的延迟比常量内存中低得多

使用：

- 变量定义：使用``__constant__``修饰词
- 值拷贝：使用```cudaMemcpyToSymbol```(与**静态全局变量**一致)
    - 用于少量**只读数据**

访问行为：

- 线程束中线程访问不同地址，则访问需要串行
- 常量内存读取成本与线程束中线程读取唯一地址数量呈线性关系

![](<https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_constant_mem.png>)

> 同一个block内的所有threads都将访问同一个const_car[i%16], 无串行访问，只需一次内存读取

常量内存 vs 宏定义

- 宏定义由宏处理器进行文字替换
    - 不占用寄存器
    - 存在于指令空间中
- 何时使用常量内存/宏定义？
    - 宏定义中的值成为应用程序的一部分适用于编译后不再修改的值
    - 常量内存适用于再执行中可能更改的值，但**在GPU代码执行过程中不变**



### 只读/纹理内存

只读内存与纹理内存

- Kepler架构中相互独立
- 在此后架构中占用同一块内存空间 GPU DRAM
- 数据均为只读
    - 不能再设备端代码中修改
- 满足空间局部性的读取更有效率
    - 图形学代码访问纹理的特性
- 使用：
    - 通过绑定到第层内存的纹理引用读取
    - 通过修饰词指示编译器使用只读内存

**只读缓存**：

使用内部函数```__ldg()```：用于代替标准指针解引用，并且强制通过只读数据缓存加载

```cpp
__global__ void kernel(int *buffer) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int x = __ldg(&buffer[i]);//代替标准指针解引用，强制通过只读数据缓存加载
}
int main() {
    int *buffer;
    cudaMalloc(&buffer, sizeof(int)*N);
    kernel <<<grid, block >>>(buffer);
    cudaFree(buffer);
}
```

- 使用全局内存的限定指针
- 使用```const __restrict__```表明数据应该通过只读缓存被访问

```cpp
__global__ void kernel(const int* __restrict__ buffer){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int x = buffer[i];
}
int main() {
    int *buffer;
    cudaMalloc(&buffer, sizeof(int)*N);
    kernel <<<grid, block >>>(buffer);
    cudaFree(buffer);
}
```



##### 常量缓存 vs 只读缓存

- 常量缓存与只读缓存都是只读的
- 在SM上为互相独立的硬件
- **常量缓存**更适用于**统一读取**
    - 线程束中的每一个线程都**访问相同的地址**
- **只读缓存**更适用于**分散读取**
    - 线程束中的每一个线程**访问不同地址**



### 共享内存

> shared memory

- 可编程的缓存：可以显示控制载入/同步数据
- 片上存储
- 读写速度非常快：带宽 > 1TB/s
- 基于线程块
    - 允许同一线程块中的线程共享部分数据
    - 无法同步不同线程块中的线程

```cpp
//估计一阶偏导，使用共享内存
__global__ void stencil(float *in, float *out){
    __shared__ float smem[BDIM+2*RADIUS];
    //thread index to global memory
    int tid = blockIdx.x*blockDim.x + threadIdx.x;
    //index to shared memory
    int sid = threadIdx.x + RADIUS;
    //copy to shared memory
    smem[sid] = in[tid];
    if (threadIdx.x < RADIUS) {
        smem[sid-RADIUS] = in[tid-RADIUS];
        smem[sid+BDIM] = in[tid+BDIM];
    }
    __syncthreads();
    float tmp = 0.0f;
    for(int i = 1; i <=RADIUS; ++i){
        tmp += c[i]*(smem[sid+i]-smem[sid-i]);
    }
    out[tid] = tmp;
}
```



## 流与并发

内核级并发（此前使用的）：

- 单一任务（内核）被多个GPU线程执行
- 性能提升：使单一内核中的不同任务/资源同时执行/利用
  - 提高占用率：利用线程执行掩盖全局内存访问演示
  - waves and tails, 消除分支分流：提高线程利用率
  - 合并与对齐访问：提高全局内存带宽利用率
  - 消除存储体冲突：提高共享内存带宽利用率

流与并发：多个内核同时执行

- 是多个内核中的不同任务并发，进一步提高利用率
  - 例1：并行归约中，后期使用的线程数量越来越小，空置线程越来越多
    - 是否可以利用空闲线程执行其他内核？
  - 例2：CUDA典型的编程模式：
    - 1. 将输入数据从主机拷贝至设备
      2. 在设备上执行内核
      3. 将结果从设备拷贝回主机
    - 拷贝与内核执行是否可以同时进行？

### 同步与并发

阻塞(blocking)与非阻塞(non-blocking)函数调用

- 阻塞调用：
  - 同步
  - 函数执行完成后控制权交还主线程(调用线程)
  - 函数以串行方式调用
- **非阻塞**调用
  - **异步**
  - 函数调用后控制权即交还主线程

异步执行的优势：

- 使不同设备上的执行及数据拷贝可以同时进行
  - 不仅仅是GPU与CPU，也可以是更耗时的硬盘访问及网络访问

异步执行举例：

- CPU超线程
  - 编写单线程程序时，我们认为代码是同步操作
  - 编译器在编译时可能产生重叠执行的操作以提高资源利用率
  - 与非重叠代码产生同样的结果
- CPU多线程
  - 由多个处理器同时执行多个线程
  - 需要自行运用同步机制解决竞争条件。例如在OpenMP中使用临界区critical section
- CUDA线程束执行
  - 束内线程指令同步执行
  - 多个线程束之间为异步执行：在同一个SM上交替执行
  - 使用```__syncthreads()```同步以解决竞争条件

CUDA主机端与设备端

- 大多数CUDA主机端函数为同步（阻塞）
- 主机端的异步调用
  - 核函数调用
  - 设备内的cudaMemcpy(cudaMemcpyDeviceToDevice)
  - 从主机到内存小于64KB的cudaMemcpy
  - 异步内存拷贝与流
- 异步执行将被阻塞的情况：
  - 调用```deviceSynchronize()```同步
  - 新的核函数调用：隐式同步
  - 主机与内存间的内存拷贝：隐式同步



## Quick Find

```cpp
nvidia-smi // 查看nvidia GPU使用情况 包括使用率 功耗 现存占用等
```



```cpp
cudaMemcpyToSymbol(&d_v, &h_v, size);//将数据复制到GPU上任何以全局符号命名的内存区域，无论该符号是全局内存还是常量内存
cudaSetDevice();
```





## CUDA Demo



### 向量相加

数据依赖性：非循环迭代相关

```cpp
//串行代码（循环）
void vector_add(int *a, int* b, int* c, int n){
    for(int i = 0; i < n; ++i) {
    	c[i] = a[i] + b[i];
    }
}
```

```cpp
//CUDA: 使用1个block //需要注意GPU无法访问主存地址
__global__ void vector_add(int *a, int* b, int* c){
int tid = threadIdx.x;
	c[i] = a[i] + b[i];//存在问题，访问主机内存
}
vector_add<<< 1, n >>>(a, b, c);
```

```cpp
__global__ void vector_add(int *a, int* b, int* c){
    int tid = blockDim.x * blockIdx.x + threadIdx.x;
    c[tid] = a[tid] + b[tid];
}//存在问题：需对n/m向上取整，需判断tid是否超过n
vector_add<<< n/m, m>>>(a, b, c);
```

```cpp
__global__ void vector_add(int *a, int* b, int* c, int n){
    int tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid < n){//判断tid是否超过n
    	c[tid] = a[tid] + b[tid];
    }
}
int divup(int n, int m){//向上取整
	return (if(n%m)?(n/m+1):(n/m));
}
vector_add<<< divup(n,m), m>>>(a, b, c);
```



### 矩阵相加

- 直接将一维grid与block扩展至2维
- 每个线程负责一个位置上的数字相加
- x, y方向上分别求全局坐标

```cpp
__global__ void matrix_add(int **A, int **B, int **C, int n, int m){
    int x = blockDim.x * blockIdx.x + threadIdx.x;
    int y = blockDim.y * blockIdx.y + threadIdx.y;
    if (y<n && x<m ){//Matrix Shape: (m, n)
    	C[y][x] = A[y][x] + B[y][x];
    }
}
dim3 block(w, h, 1);
dim3 grid(divup(m, w), divup(n, h), 1);
matrix_add<<< grid, block >>>(A, B, C);
```

- 需要二级指针结构创建二维数组

```cpp
//创建并初始化二维数组
__global__ void init_matrix(int **A, int *A_data, int n, int m){
    int tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid<n){
    	A[tid] = &A_data[tid*m];
    }
}
int *A_data, **A;
cudaMalloc((void*)&A_data, sizeof(int)*n*m);
cudaMalloc((void*)&A, sizeof(int*)*n);
```

- 内存访问次数问题： ```int **A```只提供访问数据的方式，```A[y][x]```增加内存访问次数

```cpp
//用一维数组存访矩阵
__global__ void matrix_add(int *A, int *B, int *C, int n, int m){
    int x = blockDim.x * blockIdx.x + threadIdx.x;
    int y = blockDim.y * blockIdx.y + threadIdx.y;
    if (y<n && x<m ){//判断是否在内存内
    	C[y*m+x] = A[y*m+x] + B[y*m+x];
    }
}
dim3 block(w, h, 1);//block size, dim3类型, 第三维恒为1
dim3 grid(divup(m, w), divup(n, h), 1);
matrix_add<<< grid, block >>>(A, B, C);
//存在问题：block中线程访问的内存空间不连续，内存访问的局部性差
//在x, y维度上都可能出现余数//可使用一维grid与block
```

存在问题：

- block中线程访问的内存空间不连续，内存访问的局部性差
- 在x, y维度上都可能出现余数，线程利用率低

```cpp
//与向量加法vector_add(A, B, C, n*m)等价
__global__ void matrix_add(int *A, int *B, int *C, int n, int m){
int tid = blockDim.x * blockIdx.x + threadIdx.x;
    if ( tid<n*m ){
    	C[tid] = A[tid] + B[tid];
    }
}
matrix_add<<< divup(n*m, block_size), block_size >>>(A, B, C);//一维grid与block
```



### 排序

稳定的排序算法中具有相同值的元素的相对顺序不会发生改变。

稳定的排序：冒泡排序、插入排序、基数排序、桶排序

不稳定的排序：快速排序、希尔排序、选择排序

**数据驱动**：排序算法所采取的每一步都依赖于此前进行的步骤。高度串行。

**数据无关**：插入排序、冒泡排序

- 排序算法采取固定的步骤不根据数据改变而改变
- 适用于并行算法
- 通常可以表示为排序网络
- 其他数据无关的排序举例：Bogo排序，Bozo排序。

#### 排序网络

由一系列比较器组成的网络，对元素进行比较及交换，从而达到有序状态。

具有固定的执行过程。现有的的数据无关排序算法多可表示为排序网络。

![](https://raw.githubusercontent.com/pureteap/pictures/master/Code_pic/Multi_Core_CUDA_sort_net.png)



##### 奇偶移项排序网络 odd-even transposition sort

- 网络深度为n-1



##### 奇偶归并排序网络 odd-even merge sorting network

- 分治 divide and conquer: $O(\log n)$
- 将两个分别排序的数列合并
- 每次合并需要$\log n$层
- 总工作量为$O(n\log^2 n + \log n )$
- 

##### 双调排序网络

> Bitonic Sort





---

# Cython

- Cython是一个 Python **编译器**。针对python模块的一个优化工具,不使用jit技术,有一定局限性
- 拥有**静态类型**并能嵌入 C 函数的 Python，支持释放 GIL 后的并行
- Cython是python的超集,所以python解释器无法解释cython代码,必须编译才可以

可以做到:

- 将python代码翻译为C语言代码
- 将python代码编译为python可以直接调用的动态链接库
- 通过为python代码指定类型静态化模块,生成python可以直接调用的动态链接库
- 编译python语法的的超集,Cython语法的源文件`.pyx`文件生成python可以直接调用的动态链接库
- 通过Cython语法的头文件`.pxd`申明C/C++语言的库,再通过Cython语法的源文件`.pyx`文件生成python可以直接调用的动态链接库



Cython解释器可以识别`.py`,`.cpp`,`.c`,`.h`,`.pyx`,`.pxd`,`.pxi`,其中

- `.py`是python的源码,一般用在纯净模式下
- `.cpp`,`.c`,`.h`是c/c++的源码和头文件,一般用在包装模式下
- `.pyx`(源码文件),`.pxd`(申明文件),`.pxi`(包含文件)是cython源码和头文件,用在一般模式下.







# CRT

-   C run-time libraries

###### \_beginthread &\_beginthreadex





```cpp
uintptr_t _beginthread( // NATIVE CODE  
   void( __cdecl *start_address )( void * ),  
   unsigned stack_size,  
   void *arglist   
);
uintptr_t _beginthread( // MANAGED CODE  
   void( __clrcall *start_address )( void * ),  
   unsigned stack_size,  
   void *arglist   
);
```

```cpp
//本机代码托管代码区别在于第三个参数的调用约定上
uintptr_t _beginthreadex( // NATIVE CODE  
   void *security,  
   unsigned stack_size,  
   unsigned ( __stdcall *start_address )( void * ),  
   void *arglist,  
   unsigned initflag,  
   unsigned *thrdaddr   
);
uintptr_t _beginthreadex( // MANAGED CODE  
   void *security,//指向 SECURITY_ATTRIBUTES 结构的指针
   unsigned stack_size,//新线程的堆栈大小或 0
   unsigned ( __clrcall *start_address )( void * ),//开始执行新线程的例程的地址
   void *arglist,//要传递到新线程的参数列表或 NULL
   unsigned initflag,//新线程的初始状态：0运行，CREATE_SUSPENDED挂起
   unsigned *thrdaddr//指向接收线程标识符的 32 位变量//若为NULL则不可用
);
//success: 返回新创建的合法handle
//If successful, each of these functions returns a handle to the newly created thread; however, if the newly created thread exits too quickly, _beginthread might not return a valid handle. (See the discussion in the Remarks section.) On an error, _beginthread returns -1L, and errno is set to EAGAIN if there are too many threads, to EINVAL if the argument is invalid or the stack size is incorrect, or to EACCES if there are insufficient resources (such as memory). On an error, _beginthreadex returns 0, and errno and _doserrno are set.
```

-   Security: 指向 SECURITY_ATTRIBUTES结构的指针，此结构确定返回的句柄是否由子进程继承。如果Security为 NULL，则不能继承句柄。对于Windows 95必须为 NULL
-   start\_address: 启动开始执行新线程的例程的地址。 对于 \_beginthread，调用约定是 \_\_cdecl针对本机代码或 \_\_clrcall针对托管代码；对于 \_beginthreadex，它是 \_\_stdcall(针对本机代码）或 \_\_clrcall(针对托管代码)
-   arglist: 要传递到新线程的参数列表或 NULL
-   initflag: 将 `initflag` 设置为 `0` 以立即运行，或设置为 `CREATE_SUSPENDED` 以在挂起状态下创建线程；使用 [ResumeThread](https://msdn.microsoft.com/library/windows/desktop/ms685086.aspx) 来执行此线程。 将 `initflag` 设置为 `STACK_SIZE_PARAM_IS_A_RESERVATION` 标志以将 `stack_size` 用作堆栈的初始保留大小（以字节计）；如果未指定此标志， `stack_size` 将指定提交大小



```cpp
//计网老师张永民 demo
//独立共同求和的两个线程,并利用sumall求两个线程的总和
#include <windows.h>
#include <stdio.h>
#include <process.h>
#include <math.h>

struct struparam{//用于带入参数
	 int threadno;//线程编号
	 int count;//计数值: 每个线程都是从0加到count
};

CRITICAL_SECTION cs;// 临界区: 每个时刻只有一个线程可以进入临界区
double sumone[]={0,0,0};//用于返回各线程最后的和值
double sumall=0;//记录所有线程总和值

//求和1~p->count，结果存在sumone[p->threadno]。每次加数也加入全局共享变量sumall 
unsigned __stdcall SumAll(void * p) {//用结构变量或全局变量带入参数
    struparam * p1 = (struparam *)p;//参数类型转换
	int i;
	double sum=0;

    for(i=0;i<p1->count;i++) {
  	    sum+=i;
		EnterCriticalSection(&cs);//等待进入临界区
		sumall+=i; //临界区，每个时刻只能有一个线程进入临界区。如果不用临界区，就可能出现两个线程分别加数到sumall，实际只加了一个数
		LeaveCriticalSection(&cs);//离开临界区
	    printf("%d'th thread: the sum from 1 to %d is %0.0f. total is %0.0f\n", p1->threadno, i, sum,sumall);
        fflush(stdout);
	}  
	sumone[p1->threadno]=sum;//用全局变量返回和值 
	return 0;//返回时自动结束线程。_endthreadex(0)也可以用于结束线程
}

void main() {
	HANDLE hThread,hThread1;
	unsigned threadID,threadID1;
	struparam  p1, p2;
	struparam *ptr1, *ptr2;

	InitializeCriticalSection(&cs);   // 临界区初始化
    
	p1.threadno  = 1;                 // 线程编号
	p1.count = 80000;

	p2.threadno = 2;
	p2.count= 80000;

	ptr1= &p1;
	ptr2= &p2;

	hThread = (HANDLE)_beginthreadex(NULL, 0,&SumAll, (void *)ptr1, 0, &threadID);
	hThread1 = (HANDLE)_beginthreadex(NULL, 0,&SumAll,(void *)ptr2, 0, &threadID1);

	printf("ThreadID: %d\n", threadID);
	printf("ThreadID1: %d\n", threadID1);
 
	// wait for terminating of thread in order to prevent from the termination of the main thread by runing to the end 
    WaitForSingleObject(hThread1, INFINITE );
    WaitForSingleObject(hThread, INFINITE );
    printf("Finished! sums are %0.0f and %0.0f.the total is %0.0f. \n",sumone[1],sumone[2],sumone[1]+sumone[2]);
    printf("Finished! the shared total is %0.0f.\n",sumall);

    DeleteCriticalSection (&cs);// 删除临界区

    CloseHandle(hThread);// destroy the thread object.
    CloseHandle(hThread1);
}
```

```cpp
//_beginthreadex源码整理By MoreWindows( http://blog.csdn.net/MoreWindows )  
_MCRTIMP uintptr_t __cdecl _beginthreadex(
	void *security,
	unsigned stacksize,
	unsigned (__CLR_OR_STD_CALL * initialcode) (void *),
	void * argument,
	unsigned createflag,
	unsigned *thrdaddr
){
	_ptiddata ptd;          //pointer to per-thread data 见注1  
	uintptr_t thdl;         //thread handle 线程句柄  
	unsigned long err = 0L; //Return from GetLastError()  
	unsigned dummyid;    //dummy returned thread ID 线程ID号  

						 // validation section 检查initialcode是否为NULL  
	_VALIDATE_RETURN(initialcode != NULL, EINVAL, 0);

	//Initialize FlsGetValue function pointer  
	__set_flsgetvalue();

	//Allocate and initialize a per-thread data structure for the to-be-created thread.  
	//相当于new一个_tiddata结构，并赋给_ptiddata指针。  
	if ((ptd = (_ptiddata)_calloc_crt(1, sizeof(struct _tiddata))) == NULL)
		goto error_return;

	// Initialize the per-thread data  
	//初始化线程的_tiddata块即CRT数据区域 见注2  
	_initptd(ptd, _getptd()->ptlocinfo);

	//设置_tiddata结构中的其它数据，这样这块_tiddata块就与线程联系在一起了。  
	ptd->_initaddr = (void *)initialcode; //线程函数地址  
	ptd->_initarg = argument;              //传入的线程参数  
	ptd->_thandle = (uintptr_t)(-1);

#if defined (_M_CEE) || defined (MRTDLL)  
	if (!_getdomain(&(ptd->__initDomain))) //见注3  
	{
		goto error_return;
	}
#endif  // defined (_M_CEE) || defined (MRTDLL)  

	// Make sure non-NULL thrdaddr is passed to CreateThread  
	if (thrdaddr == NULL)//判断是否需要返回线程ID号  
		thrdaddr = &dummyid;

	// Create the new thread using the parameters supplied by the caller.  
	//_beginthreadex()最终还是会调用CreateThread()来向系统申请创建线程  
	if ((thdl = (uintptr_t)CreateThread(
		(LPSECURITY_ATTRIBUTES)security,
		stacksize,
		_threadstartex,
		(LPVOID)ptd,
		createflag,
		(LPDWORD)thrdaddr))
		== (uintptr_t)0)
	{
		err = GetLastError();
		goto error_return;
	}

	//Good return  
	return(thdl); //线程创建成功,返回新线程的句柄.  

				  //Error return  
error_return:
	//Either ptd is NULL, or it points to the no-longer-necessary block  
	//calloc-ed for the _tiddata struct which should now be freed up.  
	//回收由_calloc_crt()申请的_tiddata块  
	_free_crt(ptd);
	// Map the error, if necessary.  
	// Note: this routine returns 0 for failure, just like the Win32  
	// API CreateThread, but _beginthread() returns -1 for failure.  
	//校正错误代号(可以调用GetLastError()得到错误代号)  
	if (err != 0L)
		_dosmaperr(err);
	return((uintptr_t)0); //返回值为NULL的效句柄  
}
```







###### \_endthread & \_endthreadex

-   `_endthread` 终止由 `_beginthread` 创建的线程， `_endthreadex` 终止由 `_beginthreadex`创建的线程

```cpp
//_endthreadex demo     compile with: /MT
#include <windows.h>
#include <stdio.h>
#include <process.h>

unsigned Counter;
unsigned __stdcall SecondThreadFunc(void* pArguments){
	printf("In second thread...\n");
	while (Counter < 1000000)
		Counter++;
	_endthreadex(0);
	return 0;
}

int main(){
	unsigned threadID;
	// Create the second thread.
	HANDLE hThread = (HANDLE)_beginthreadex(NULL, 0, &SecondThreadFunc, NULL, 0, &threadID);

	// Wait until second thread terminates. If you comment out the line below,
	// Counter will not be correct because the thread has not terminated,
	// and Counter most likely has not been incremented to 1000000 yet.
	WaitForSingleObject(hThread, INFINITE);//若注释这句，很可能不到1000000
	printf("Counter should be 1000000; it is-> %d\n", Counter);
	CloseHandle(hThread);// Destroy the thread object.
	getchar();
}
```







###### WaitForSingleObject

-   等待hHandle事件发生，如果hHandle是某个线程的句柄，则其功能是等待该线程结束

```cpp
DWORD WINAPI WaitForSingleObject(//等待对象发生事件
  _In_ HANDLE hHandle,//对象句柄
  _In_ DWORD  dwMilliseconds//等待事件(ms) INFINITE一直等待
);//执行成功时返回值指示引发函数返回的事件
//hHandle: 对象句柄 e.g. Event、Mutex、Process、Semaphore、Thread、Waitable timer
//dwMilliseconds: 等待时间(ms) 在这个时间内一直等待对象句柄的某个事件发生，如果有事件发生则立即返回，超过这个时间没有事件发生也返回
```







##### Critical Section

-   在同步的程序设计中，**临界区块**Critical section指的是一个访问共用资源(e.g. 共用设备或是共用内存)的程序片段，而这些共用资源有无法同时被多个线程访问的特性
-   当有线程进入临界区块时，其他线程或是进程必须等待（e.g. bounded waiting 等待法），有一些同步的机制必须在临界区块的进入点与离开点实现，以确保这些共用资源是被互斥或的使用，e.g. semaphore








###### [Win] Critical Section 


-   在Windows中，CRITICAL_SECTION是一种同步对象类型，用于同一个进程内的多线程同步访问资源。如果是跨进程同步，需要使用互斥锁(mutex)
-   能且只能用在一个进程中的多线程同步。可能陷入死锁，因为我们无法为进入关键段的线程设置最大等待时间



```cpp
//1、首先我们要分配一个CRITICAL_SECTION对象，并进行初始化（使用关键段同步的线程必须调用此函数）  

void InitializeCriticalSection( LPCRITICAL_SECTION lpCriticalSection );

//2、当知道线程将不再需要访问共享资源时，我们应该调用下边的函数来清理CRITICAL_SECTION结构  
void DeleteCriticalSection( LPCRITICAL_SECTION lpCriticalSection );

//3、在对保护的资源进行访问之前，必须调用下面的函数  
void EnterCriticalSection( LPCRITICAL_SECTION lpCriticalSection );
//可以对上边的函数多次调用，表示调用线程被获准访问的次数  

//4、也可以用下边的函数代替EnterCriticalSection  
BOOL TryEnterCriticalSection( LPCRITICAL_SECTION lpCriticalSection );
//通过返回值判断当前线程是否获准访问资源，线程永远不会进入等待状态，如果  
//返回TRUE表示该线程获准并正在访问资源，离开时必须调用LeaveCriticalSection()  

//5、在代码完成对资源的访问后，必须调用以下函数,释放访问权限  
void LeaveCriticalSection( LPCRITICAL_SECTION lpCriticalSection );
```



SRWLock允许我们区分那些想要读取资源的值的线程（读取者线程）和想要更新资源的值的线程（写入者线程）



```cpp
/* 独立共同求和的两个线程,并利用sumall求两个线程的总和 */

#include <windows.h>
#include <stdio.h>
#include <process.h>
#include <math.h>

struct struparam{             /* 用于带入参数 */
	 int threadno;            /* 线程编号 */
	 int count;				  /* 计数值: 每个线程都是从0加到count */
};

CRITICAL_SECTION cs;		           // 临界区。每个时刻只有一个线程可以进入临界区
double sumone[]={0,0,0};               // 用于返回各线程最后的和值
double sumall=0;                       // 记录所有线程总和值。

// 求和1~p->count，结果存在sumone[p->threadno]。每次加数也加入全局共享变量sumall 
unsigned __stdcall SumAll(void * p) {     // 用结构变量或全局变量带入参数

    struparam * p1 = (struparam *)p;   // 参数类型转换
	int i;
	double sum=0;

    for(i=0;i<p1->count;i++) {
	
  	    sum+=i;
		EnterCriticalSection(&cs);     // 等待进入临界区
		sumall+=i;                     //   临界区，每个时刻只能有一个线程进入临界区。如果不用临界区，就可能出现两个线程分别加数到sumall，实际只加了一个数。
		LeaveCriticalSection(&cs);     // 离开临界区
	    printf("%d'th thread: the sum from 1 to %d is %0.0f. total is %0.0f\n", p1->threadno, i, sum,sumall);
        fflush(stdout);
	}  
	sumone[p1->threadno]=sum;         //用全局变量返回和值 
    return 0;                         //返回时自动结束线程。_endthreadex(0)也可以用于结束线程
} 


void main() {
 
    HANDLE hThread,hThread1;
    unsigned threadID,threadID1;
	struparam  p1, p2;
	struparam *ptr1, *ptr2;

	InitializeCriticalSection(&cs);   // 临界区初始化
    
	p1.threadno  = 1;                 // 线程编号
	p1.count = 80000;

    p2.threadno = 2;
	p2.count= 80000;

    ptr1= &p1;
    ptr2= &p2;

    hThread = (HANDLE)_beginthreadex(NULL, 0,&SumAll, (void *)ptr1, 0, &threadID);
    hThread1 = (HANDLE)_beginthreadex(NULL, 0,&SumAll,(void *)ptr2, 0, &threadID1);

    printf("ThreadID: %d\n", threadID);
    printf("ThreadID1: %d\n", threadID1);
 


    // wait for terminating of thread in order to prevent from the termination of the main thread by runing to the end 
    WaitForSingleObject(hThread1, INFINITE );
    WaitForSingleObject(hThread, INFINITE );
    printf("Finished! sums are %0.0f and %0.0f.the total is %0.0f. \n",sumone[1],sumone[2],sumone[1]+sumone[2]);
    printf("Finished! the shared total is %0.0f.\n",sumall);

    DeleteCriticalSection (&cs) ;  // 删除临界区

    // destroy the thread object.
    CloseHandle(hThread);
    CloseHandle(hThread1);
	getchar();
}

```



