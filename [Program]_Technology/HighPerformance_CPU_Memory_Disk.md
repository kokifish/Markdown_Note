# High Performance



## Cmdline

```bash
 # Bottleneck Check
 ps auxw # D: 一般在IO R: 一般在cpu S: 一般是sleep操作导致未及时唤醒
 vmstat/sar # 查看cpu消耗是在内核态还是用户态
 top # 综合查看各个方面
 strace/ltrace # 侵入式跟踪 # 大量系统调用和库函数，起始时间、返回值、花费的时间 # 会使进程变慢，每次调用话费的时间较实际情况大很多
 google perftools # 查看函数耗时
 perf # 查看用户/内核态函数热点
```

```bash
# 关键内存防止交换到磁盘
swapoff -a
mmap
int mlock(const void *addr, size_t len);
int mlockall(int flags);
Free 命令
```



## CPU & Memory

NUMA( Non-Uniform Memory Access )节点：

- 本地内存
- 远程内存

Uniform Memory Acces: 传统的经过北桥访问内存



提升上层存储的命中率

Cache line：不同NUMA节点之间修改访问同一个cache line的数据，导致耗时增加。优化方法：在相邻变量之间添加padding，使得原本相邻的变量不再跨NUMA节点，分布到不同cacheline上，然后不同NUMA节点的CPU分别访问两个变量时，就不会因为两个变量在相同cache line上而耗时增加。

## 优化函数调用

对于结果不变的函数(e.g. strlen)，尽量不写在循环里面，避免多次调用

避免不必要的内存操作和清0。可以用memset，memcpy等函数，大致推断出机器的磁盘吞吐量()

- 使用宏和inline函数减少函数调用：以CPU运算为主且函数体短小的函数，如果调用频繁，建议用宏或inline避免压栈开销
- 64bit下，函数参数最好在6个以内
- 不要传大对象
- inline优化
- -O2
- 一次操作多个字节。例如用`(uint64_t*)`来代替`(char*)`操作，一次操作64bit，对应64bit OS最小操作单元

## 浮点运算

- 尽量用整数不用浮点
- printf函数族需要扫描格式字符串，效率相对较低
- gettimeofday()系统调用
- time()系统调用



- 使用tcmalloc替代ptmalloc
- 关闭大部分不需要的log



C++内存模型：memory order(理论) 内存屏障(实际)

## 协程

- 不适合CPU密集型计算
- 适合阻塞较多的，disk等操作可以在coroutine级并发