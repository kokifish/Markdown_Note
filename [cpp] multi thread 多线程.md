

[TOC]













# Windows





## Multi Thread





### CRT

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



