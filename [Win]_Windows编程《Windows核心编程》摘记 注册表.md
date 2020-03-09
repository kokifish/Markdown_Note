



摘记自《Windows核心编程(第五版)》

[TOC]





-   每次写WINAPI程序时，用管理员身份运行Visual Studio, 否则很多函数因为没有权限而运行失败
-   注意ANSI与UTF8格式的通用问题




笔记根据电子书《Windows核心编程(第五版)》中文版.pdf编写笔记

- 进度记录：p55 7.18

---

# **内核对象**[^摘录位置]

---

[^摘录位置]: Windows核心编程 第五版





## 何为内核对象



- 系统会创建和处理几种类型的内核对象。e.g. 访问令牌(access token)对象、事件对象、文件对象、文件映射对象、I/O完成端口对象、作业对象、邮件槽对象(mailslot)对象、互斥量(mutex)对象、管道(pipe)对象、进程对象、信号量(semaphore)对象、线程对象、可等待的计时器(waitable timer)对象、线程池工厂(thread pool worker factory)对象等[^页码]: p32
- 由于内核对象的数据结构只能由操作系统内核访问，所以应用程序不能在内存中定位这些数据结构并直接更改其内容。
- 利用Windows提供的一组函数来操纵内核对象。调用一个会创建内核对象的函数后，函数会返回一个**句柄(handle)**,标识所创建的对象及向操作系统标识我们要操作的内核对象。句柄可由进程中的任何线程使用，可将句柄想象成不透明(opaque)的值。32位系统中句柄为32bit，64位系统中为64bit
- 句柄值是进程相关的，这增强了操作系统的可靠性。



### 使用计数

- 内核对象所有者是操作系统内核。因此进程调用函数创建一个内核对象后，进程终止时内核对象不一定会销毁。但大多数情况下是会被销毁的。
- 内核对象都包含一个使用**计数(usage count)**，初次创建被设为1，其它进程获得对该内核对象的访问后递增，进程终止运行后内核自动递减此进程仍然打开的所有内核的使用计数。一旦使用计数变成0操作系统就会销毁该内核对象。



### 内核对象的安全性

- 内核对象可用**安全描述符(security descriptor, SD)**来保护。用于创建内核对象的所有函数几乎都有指向一个 SECURITY_ATTRIBUTES 结构的指针作为参数(PSECURITY_ATTRIBUTES)。传入NULL时创建的内核对象具有默认的安全性，具体包括哪些默认的安全性取决于当前进程的**安全令牌(security token)**

```c++
SECURITY_ATTRIBUTES的结构
typedef struct _SECURITY_ATTRIBUTES{
	DWORD nLength;
	LPVOID lpSecurityDescriptor;//a pointer point to security descriptor(SD)
	BOOL bInheritHandle;
}
```

- SECURITY_ATTRIBUTES包含一个和安全性有关的成员lpSecurityDescriptor。如果需要对创建的内核对象加以访问限制，就必须创建一个安全描述符(SD)。用于创建用户对象或GDI对象的函数都没有PSECURITY_ATTRIBUTES参数。









---

## 进程内核对象句柄表

- 进程在初始化时，系统将为它分配一个句柄表(handle table)，这个句柄表仅供内核对象使用，不适用于用户对象或GDI对象。
- 句柄表是一个由数据结构组成的数组，每个结构都包含指向一个内核对象的指针，一个访问掩码(access mask)和一些标识。

| 索引   | 指向内核对象内存块的指针 | 访问掩码(包含标志位的一个DWORD) | 标志         |
| ---- | ------------ | ------------------- | ---------- |
| 1    | 0xF000 0000  | 0x????????          | 0x00000000 |
| 2    | 0x0000 0000  | (不可用)               | (不可用)      |
| 3    | 0x????????   | 0x????????          | 0x???????? |
| ...  |              |                     |            |

### 创建一个内核对象

- 一个进程首次初始化的时候，句柄表为空，当进程内以线程调用一个会创建内核对象的函数时，内核会为这个对象分配并初始化一个内存块，然后内核扫描进程的句柄表，查找一个空白的记录项(empty entry)并对其进行初始化(如上例索引3)。然后指针成员被设置成内核对象的数据结构的内部内存地址，访问掩码将被设置成拥有完全访问权限，标志也会被设置。



### 关闭内核对象

- 无论什么方式创建内核对象，都应调用CloseHandle表明已结束使用对象。一旦调用CloseHandle关闭了对一个内核对象的使用，就不能访问该内核对象。如果内核对象的usage count未递减至0，该内核对象将不会被销毁。
- 编程习惯：调用CloseHandle后应同时将保存句柄的变量zhiwei置为NULL
- 内存泄漏：进程运行期间，若忘记调用CloseHandle可能发生资源泄露的情况，但进程终止操作系统将确保此进程所使用的所有资源都被正确释放/清除(这适用于所有内核对象、资源(包括GDI对戏那个在内)、内存块)






## 跨进程边界共享对象



-   为健壮性(可靠性)，安全性，句柄被设计成"与进程相关的"(process-relative)，内核对象是受安全性保护的，进程视图操纵一个对象前须申请操作它的权限。
-   允许进程共享内核对象的三种方式：使用对象句柄继承，为对象命名，复制对象句柄。



### 使用对象句柄继承

- 对象句柄继承发生在进程间有父-子关系时。windows支持对象句柄继承，没有对象继承一说。





- 所有进程都共享内核地址空间


- 32位系统内核地址空间：0x80000000 ~ 0xFFFFFFFF 
- 64位系统内核地址空间：0x00000400 00000000 ~ 0xFFFFFFFF FFFFFFFF [^疑]








>   为使用对象句柄继承，下一步由父进程生成子进程，通过CreateProcess来完成。其中BOOL bInheritHandles 设为FALSE时，子进程不继承父进程进程句柄表中的“可继承句柄”。设为TRUE子进程会继承父进程的“可继承句柄”的值。
>
>   >   若传递的bInheritHandles为TRUE，系统遍历父进程的句柄表，凡是包含一个有效的“可继承的句柄”的项，都会被完整地复制到子进程的句柄表中，而且复制项的位置与它父进程句柄表中的位置完全一样。



### 改变句柄的标志

-   如果想控制那些子进程能继承内核对象句柄，可以调用SetHandleInformation改变内核对象句柄的继承标志。
-   用GetHandleInformation获取继承标志



### 为对象命名

-   许多内核对象可以进行命名(e.g. CreateEvent...)。PCTSTR pzsName 若传入Null相当于想系统表明要创建一个未命名(匿名)的内核对象，此时可以通过上一节的继承技术或下一节的DuplicateHandle事项进程间对象共享。

- 若传入一个以0为终止符的名字字符串的地址，该名称可以长达MAX_PATH个字符(定义为260)

    >   注意没有任何机制来保证不创建一个同名对象。






### 终端服务命名空间



-   终端服务(Terminal Service)
-   在正在运行终端服务的计算机中，有多个用于内核对象的命名空间。其中一个是全局命名空间。所有客户端服务都能访问的内核对象要放在全局命名空间中。这个命名空间主要由服务使用。
-   每个客户端会话(client session)都有个自己的命名空间。
-   Remote Desktop 和 Fast User Switching 利用终端服务会话来实现。
-   默认情况下，在终端服务中，应用程序自己的命名内核对象在会话的命名空间内。但是可以在命名对象名称前加上"Global\"前缀强制把一个命名对象放入全局命名空间。也可以在名称前加上"Local\"前缀显式指出将一个内核对象放入当前会话的命名空间

```c++
HANDLE h = CreateEvent(NULL, FALSE, FALSE, TEXT("Global\\Myname"));	//放入全局命名空间
HANDLE h = CreateEvent(NULL, FALSE, FALSE, TEXT("Local\\Myname"));	//放入当前会话的命名空间
```



```c++
了解进程在哪个Terminal Services会话中运行： 使用 ProcessIdToSessionId
 BOOL ProcessIdToSessionId(
	_In_ DWORD dwProcessId,		//传入当前进程Id(GerCurrentProcessId())
  	-Out_ DWORD *pSessionId		//传入DWORD指针用于保存SessionId
);
```





### 专有命名空间

-   创建内核对象可以传递指向一个SECURITY_ATTRIBUTES结构的指针从而保护对该对象的访问。

###### Dos攻击

-   Windows Vista发布之前，不可能防止一个共享对象的名称被“劫持”。任何进程(包括最低权限的进程)都能用任何指定的名称来创建一个对象。(例如用另外的应用程序创建一个同名的内核对象)如果这一对象先于单实例应用程序启动，“单实例”应用程序就变成了一个“无实例”的应用程序(因为一启动就错误地认为自己的另一个实例已在运行，就会退出)。

    >   这就是几种拒绝服务(DoS)攻击的基本机制。需注意未命名的内核对象不会遭受DoS攻击。此外应用程序使用未命名对象是相当普遍的，即使这些对象不能在进程间共享。

### 复制对象句柄



























---

# 第四章 进程



进程通常被定义为一个正在运行的程序的实例，它由两个部分组成：

- 一个是操作系统用来管理进程的内核对象。内核对象也是系统用来存放关于进程的统计信息的地方
- 另一个是地址空间，它包含所有可执行模块或D L L模块的代码和数据。它还包含动态内存分配的空间。如线程堆栈和堆分配空间



- 进程可用的虚拟地址范围称为该进程的“虚拟地址空间”。每个用户模式进程都有其各自的专用虚拟地址空间。 对于 32 位进程，虚拟地址空间通常为 2 GB，范围从 0x0000'0000 至 0x7FFF'FFFF。对于 64 位进程，虚拟地址空间为 8 TB，范围从 0x000'0000'0000 至 0x7FF'FFFF'FFFF。一系列虚拟地址有时称为一系列“虚拟内存”


Windows支持基于图形用户界面(GUI)和基于控制台用户界面(CUI)的应用程序

![](http://op4fcrj8y.bkt.clouddn.com/17-7-18/68731452.jpg)



### 4.1.1 进程的实例句柄

加载到进程地址空间的每个可执行文件或DLL都有一个独一无二的实例句柄，可执行文件的实例作为( w ) WinMain的第一个参数hinstExe来传递

实际情况说明，HMODULE与HINSTANCE是完全相同的对象。如果函数的文档指明需要一个HMODULE，那么可以传递一个HINSTANCE，反过来，如果需要一个HINSTANCE，也可以传递一个HMODULE。之所以存在两个数据类型，原因是在16位Windows中，HMODULE和HINSTANCE用于标识不同的东西



> 的' GetModuleHandle '函数返回可执行文件或D L L文件加载到进程的地址空间时所用的句柄/基地址
>
> HMODULE GetModuleHandle(PCTSTR pszModule);
>
> 传递一个以/0结尾的字符串，设定加载到调用进程的地址空间的可执行文件或DLL文件的名字，如果找到了指定的可执行文件或DLL的文件名，便返回可执行文件或DLL文件映像加载到的基地址。若没找到，则返回NULL
>
> GetModuleHandle之查看调用进程的地址空间，如果传参为NULL则返回进程地址空间中可执行文件的基地址(而不是DLL)



调用SetErrorMode函数告诉系统如何处理一些严重错误，包括磁盘介质故障，未处理的异常情况，文件查找失败和数据没有对齐...

默认情况子进程继承父进程的错误模式标志





### 4.2 CreateProcess函数

> p58

```c++
BOOL WINAPI CreateProcess(
  _In_opt_    LPCTSTR               lpApplicationName,
  _Inout_opt_ LPTSTR                lpCommandLine,
  _In_opt_    LPSECURITY_ATTRIBUTES lpProcessAttributes,
  _In_opt_    LPSECURITY_ATTRIBUTES lpThreadAttributes,
  _In_        BOOL                  bInheritHandles,
  _In_        DWORD                 dwCreationFlags,
  _In_opt_    LPVOID                lpEnvironment,
  _In_opt_    LPCTSTR               lpCurrentDirectory,
  _In_        LPSTARTUPINFO         lpStartupInfo,
  _Out_       LPPROCESS_INFORMATION lpProcessInformation
);
```

CreateProcess函数用于创建一个进程，一个线程调用CreateProcess时

1. 系统会创建一个进程内核对象，并初始使用计数是1，该进程内核对象不是进程本身，而是操作系统管理进程时使用的一个较小的数据结构
2. 然后，系统为新进程创建一个虚拟地址空间，并将可执行文件或任何必要的D L L文件的代码和数据加载到该进程的地址空间中
3. 系统为新进程的主线程创建一个线程内核对象(其使用计数为1)。线程内核对象也是操作系统用来管理线程的小型数据结构。通过执行C / C + +运行期启动代码，该主线程便开始运行，它最终调用WinMain、wWinMain、main或wmain函数
4. 如果系统成功地创建了新进程和主线程，CreateProcess便返回TRUE

> 在进程被完全初始化之前，CreateProcess返回TRUE。这意味着操作系统加载程序尚未试图找出所有需要的DLL。如果一个DLL无法找到，或者未能正确地初始化，那么该进程就终止运行。由于CreateProcess返回TRUE，因此父进程不知道出现的任何初始化问题



### 创建远程线程



-   创建远程线程需要保证线程函数的可执行代码位于目标进程的虚拟地址空间中(故恶意代码需写入目标进程的虚拟地址空间)



-   CreateRemoteThread对目标进程需要有权限: PROCESS_CREATE_THREAD**, **PROCESS_QUERY_INFORMATION**, **PROCESS_VM_OPERATION**, **PROCESS_VM_WRITE,  PROCESS_VM_READ

```c++
HANDLE WINAPI CreateRemoteThread(//返回新创建线程的句柄 //handle to the new thread
	_In_  HANDLE                 hProcess,//需要为其创建线程的目标进程句柄
	_In_  LPSECURITY_ATTRIBUTES  lpThreadAttributes,//
	_In_  SIZE_T                 dwStackSize,
	_In_  LPTHREAD_START_ROUTINE lpStartAddress,
	_In_  LPVOID                 lpParameter,
	_In_  DWORD                  dwCreationFlags,
	_Out_ LPDWORD                lpThreadId
);
```



```c++
BOOL WINAPI WriteProcessMemory(//将数据写入到目标进程的虚拟地址空间中//失败则调用GetLastError()
	_In_  HANDLE  hProcess,//目标进程句柄
	_In_  LPVOID  lpBaseAddress,//写入数据的地址
	_In_  LPCVOID lpBuffer,//指向需要写入的数据
	_In_  SIZE_T  nSize,//写入数据的大小(字节)
	_Out_ SIZE_T  *lpNumberOfBytesWritten//输出参数，指向SIZE_T类型的变量，用于保存实际写入的数据的大小
);
```









###### 注释管理

[^疑]: 此数字范围摘抄自书上，但具体数字有待考证。

















---

# Windows 网络通信与配置



TCP/IP协议簇指的是当前计算机网络中通用的网络协议簇

Socket是系统提供的一种使用传输层的网络协议进行数据传输的程序设计接口规范

Socket套接字使用传输程序协议(TCP/UDP等)进行网络通信的程序设计接口

Socket程序分为服务端与客户端，客户端需要知道服务端程序程序的IP地址和监听端口

所有Windows Sockets 2接口函数都由Ws2\_32.dll导出，相关数据类型，结构定义，函数声明等位于头文件winsock2.h中，编译时需要包含，编译时需要链接到库Ws2\_32.lib





---

# 注册表编辑

-   打开Windows注册表编辑器:
-   1.  Win + R 打开Run，输入regedit，回车
    2.  找到对应key后编辑
-   





Run key: 每次登陆时按顺序自动启动

-   [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]
-   [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run]



RunOnce key: 系统加载时自动启动执行一次

-   [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce]
-   [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce]



### 常用注册表位置

- 设备与驱动器上的文件夹: HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\ 
- 设备与驱动器之上的置顶文件夹: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions 





### CPU禁止降频

进注册表，把下面的

HKEY\_LOCAL\_MACHINESYSTEMCurrentControlSetServicesProcessor

HKEY\_LOCAL\_MACHINESYSTEMCurrentControlSetServicesIntelppm

把这2个下的Start值从3改成4





